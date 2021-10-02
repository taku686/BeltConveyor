Shader "Unlit/UVScroll"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Scrollx("scrollx",float) = 0
        _Scrolly("scrolly",float) = 0
        _RotateValue("rotateValue",float) = 0.0
        [KeywordEnum(Vertex, Fragment)] _Target("Calc Target", Float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile _TARGET_VERTEX _TARGET_FRAGMENT

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed _Scrollx, _Scrolly;
            float _RotateValue;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                #ifdef _TARGET_VERTEX
                o.uv = o.uv + fixed2(frac(_Scrollx * _Time.y), frac(_Scrolly * _Time.y));
                #endif
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                half angleCos = cos(_RotateValue);
                half angleSin = sin(_RotateValue);
                half2x2 rotateMatrix = half2x2(angleCos, -angleSin, angleSin, angleCos);
                half2 uv = i.uv;// -0.5;
                i.uv = mul(uv, rotateMatrix);//+ 0.5;
               #ifdef _TARGET_FRAGMENT
              
                i.uv = fixed2(frac(i.uv.x + _Scrollx * _Time.y), frac(i.uv.y + _Scrolly * _Time.y));
                #endif

                return tex2D(_MainTex, i.uv);
            }
            ENDCG
        }
    }
}
