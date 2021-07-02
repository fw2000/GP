using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
[CustomEditor(typeof(AnimationStateController))]

public class Sample : Editor
{
    AnimationStateController animation;
    private void OnEnable()
    {
        animation = (AnimationStateController)target;

    }
    private void OnDisable()
    {
        
    }
    public override void OnInspectorGUI()
    {
        DrawDefaultInspector();
        if (GUILayout.Button("Hologram active"))
        {
            animation.Visible(true);
            
            Debug.Log("Hologram");
        }
        if (GUILayout.Button("Hologram inactive"))
        {
            // GameObject.SetActive(false);
            animation.Visible(false);
            Debug.Log("Button Pressed");
        }

        if (GUILayout.Button("Hologram point left"))
        {
            animation.animator.SetBool("isPointingL", true);
            Debug.Log("Hologram point left");
        }
        else
        {
            animation.animator.SetBool("isPointingL", false);
            //Debug.Log("STOP Hologram point left");
        }

        if (GUILayout.Button("Hologram point right"))
        {
            animation.animator.SetBool("isPointingR", true);
            Debug.Log("Hologram point right");
        }
        else
        {
            animation.animator.SetBool("isPointingR", false);
            //Debug.Log("STOP Hologram point right");
        }
    }
}
