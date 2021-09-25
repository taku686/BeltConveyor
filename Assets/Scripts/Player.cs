using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour
{
    Rigidbody rb;
    [SerializeField]
    float moveSpeed;

    private void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    private void FixedUpdate()
    {
        var hori = Input.GetAxis("Horizontal");
        var vert = Input.GetAxis("Vertical");

        rb.velocity = new Vector3(hori, 0, vert) * moveSpeed;
        // transform.position += new Vector3(hori, 0, vert) * moveSpeed * Time.fixedDeltaTime;
    }
}
