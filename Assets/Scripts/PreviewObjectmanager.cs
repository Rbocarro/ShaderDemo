using UnityEngine;

public class PreviewObjectmanager : MonoBehaviour
{
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    [SerializeField]
    private float rotationSpeed;
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        transform.Rotate(Vector3.up, rotationSpeed);
        transform.Rotate(Vector3.right, rotationSpeed*Mathf.Sin(Time.timeScale));

    }
}
