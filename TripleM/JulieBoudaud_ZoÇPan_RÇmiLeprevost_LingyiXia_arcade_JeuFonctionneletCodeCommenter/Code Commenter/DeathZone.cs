using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DeathZone : MonoBehaviour
{

    private void OnTriggerExit(Collider other) // detecte les objects qui sort de la zone 
    {
        if (other.CompareTag("meuble")) // regarde si l'object est bien un meuble
        {
            GameObject.FindGameObjectWithTag("GM").GetComponent<GameManager>().AddValue(other.GetComponent<MeubleValue>().Value); // recupére la valeur du meuble sortie et l'ajoute au score
            Destroy(other.gameObject); // détruit l'object sortie
        }
    }
}
