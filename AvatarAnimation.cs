using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AvatarAnimation : MonoBehaviour
{
    Animator animator;
    bool isAnimating = false;

    private void Start()  // Start is called before the first frame update
    {
        animator = GetComponent<Animator>(); //searches through game to find Animator
        Debug.Log(animator);
    }

    public void StateEvaluation(int state)
    {
        if (!isAnimating)
        {
            isAnimating = true;
            StartCoroutine(PlayState(state));
            Debug.Log(state);
        }
    }

    private IEnumerator PlayState(int state)
    {
        if (state == 1)
        {
            animator.SetBool("isPointingR", true);
            Debug.Log("right");
            float waitTime = animator.GetCurrentAnimatorStateInfo(0).length;
            Debug.Log("animating state 1 is up 2 is down " + state);
            yield return new WaitForSeconds(waitTime/2);
            isAnimating = false;
            animator.SetBool("isPointingR", false);
            
        }
        else if (state == 2)
        {
            animator.SetBool("isPointingL", true);
            Debug.Log("left");
            float waitTime = animator.GetCurrentAnimatorStateInfo(0).length;
            Debug.Log("animating state 1 is up 2 is down " + state);
            yield return new WaitForSeconds(waitTime/2);
            isAnimating = false;
            animator.SetBool("isPointingL", false);
        }
    }


    private void OnEnable()
    {
        //get the new data
        LSLReceiver.ReceivedNewDataInt += StateEvaluation;

    }
    private void OnDisable()
    {
        LSLReceiver.ReceivedNewDataInt -= StateEvaluation;
    }
}