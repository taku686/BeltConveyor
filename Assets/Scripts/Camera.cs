using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Camera : MonoBehaviour
{
    [SerializeField]
    Vector3 setoff;
    [SerializeField]
    GameObject player;
    private void Start()
    {
        setoff = this.transform.position - player.transform.position;
    }

    private void Update()
    {
        this.transform.position = player.transform.position + setoff;
    }
}
