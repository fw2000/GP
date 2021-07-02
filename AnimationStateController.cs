using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimationStateController : MonoBehaviour
{
    public Animator animator;
     Renderer[] renderers;

    // Start is called before the first frame update
    void Start()
    {
        renderers = GetComponentsInChildren<Renderer>();
        animator = GetComponent<Animator>(); //searches through game to find Animator
        Debug.Log(animator);
    }

    // Update is called once per frame
    void Update()
    {

    }

    public void Visible(bool boolean)
    {
        foreach (Renderer r in renderers)
        {
            r.enabled = boolean;
        }
    }

}
