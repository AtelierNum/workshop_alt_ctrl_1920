using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class House : MonoBehaviour
{
    public float sensibility = 0.1f; // la sensibilité de la rotation 
    public float Diviseur = 2f;
    private float XAccel;//les différentes accélération pour chaque axes
    private float ZAccel;
    private float PXAccel;
    private float PZAccel;
    public bool Xbut = false; // les différentes boolean pour chaque bontons
    public bool Ybut = false;
    public bool Zbut = false;

    public Animator GaucheGrav;
    public Animator DroitGrav;
    public Animator HautGrav;
    public Animator BasGrav;
    public Animator NullGrav;

    // Invoked when a line of data is received from the serial device.
    void OnMessageArrived(string msg)
    {
        ArduinoData2 Accel = JsonUtility.FromJson<ArduinoData2>(msg); // recupére les valeur de Json

        Xbut = Accel.XBut;
        Ybut = Accel.YBut;
        Zbut = Accel.ZBut;

        XAccel = Mathf.Lerp(XAccel, Accel.XAccel, sensibility); // calcule la sensibilité de la rotation de la maison
        ZAccel = Mathf.Lerp(ZAccel, Accel.YAccel, sensibility);

        if (GameObject.FindGameObjectWithTag("GM").GetComponent<GameManager>().end == false) // si c'est la fin du jeu , désactiver les controlleur 
        {
            if (GameObject.FindGameObjectWithTag("GM").GetComponent<GameManager>().intro == false) // si c'est l'intro , donner seulement accés au bouton
            {

                transform.rotation = Quaternion.Euler((XAccel - 20) / Diviseur, 0, (ZAccel - 17) / Diviseur); // donne la rotation de la maison en fonction des valeur de l'acéléromètre
               
                if (Xbut == true)
                {
                    int rand = Random.Range(0, 2); 
                    if (rand == 1)
                    {
                        Physics.gravity = new Vector3(0, -10, 0); // active soit un gravité vers le haut ou le bas avec 1 chance sur 2 quand t'on appuie sur le bon bouton
                        GetComponent<AudioSource>().Play();
                        BasGrav.Play("Bas");
                    }
                    else
                    {
                        Physics.gravity = new Vector3(0, 10, 0);
                        GetComponent<AudioSource>().Play();
                        HautGrav.Play("Haut");
                    }
                }
                if (Ybut == true) // active soit un gravité vers la droite ou la gauche avec 1 chance sur 2 quand t'on appuie sur le bon bouton
                {
                    int rand = Random.Range(0, 2);
                    if (rand == 1)
                    {
                        Physics.gravity = new Vector3(10, 0, 0);
                        GetComponent<AudioSource>().Play();
                        GaucheGrav.Play("Gauche");
                    }
                    else
                    {
                        Physics.gravity = new Vector3(-10, 0, 0);
                        GetComponent<AudioSource>().Play();
                        DroitGrav.Play("Droite");
                    }
                }
                if (Zbut == true) // active la gravité zero quand t'on appuie sur le bon bouton
                {
                    StartCoroutine(StopGravity());
                    GetComponent<AudioSource>().Play();
                    NullGrav.Play("Centre");
                }
            } else // si il appuie sur un bouton alors que l'intro est laisser lance le niveau 1
            {
                if (Xbut == true )
                {
                    GameObject.FindGameObjectWithTag("GM").GetComponent<GameManager>().LvlNmbtoLoad = 1;
                    GameObject.FindGameObjectWithTag("GM").GetComponent<GameManager>().NextLevel();
                }
                if (Ybut == true)
                {
                    GameObject.FindGameObjectWithTag("GM").GetComponent<GameManager>().LvlNmbtoLoad = 1;
                    GameObject.FindGameObjectWithTag("GM").GetComponent<GameManager>().NextLevel();
                }
                if (Zbut == true)
                {
                    GameObject.FindGameObjectWithTag("GM").GetComponent<GameManager>().LvlNmbtoLoad = 1;
                    GameObject.FindGameObjectWithTag("GM").GetComponent<GameManager>().NextLevel();
                }

            }
           
        }
    }

    IEnumerator StopGravity() // stop la gravité pendant 2 sec
    {
        Physics.gravity = new Vector3(0, 0, 0);
        yield return new WaitForSeconds(2f);
        Physics.gravity = new Vector3(0, -10, 0);
    }

    // Invoked when a connect/disconnect event occurs. The parameter 'success'
    // will be 'true' upon connection, and 'false' upon disconnection or
    // failure to connect.
    void OnConnectionEvent(bool success)
    {
        Debug.Log("connected : " + success);
    }
}

public class ArduinoData2 // la classe de mes valeur récupérer par arduino
{
    public float XAccel;
    public float YAccel;
    public float ZAccel;
    public bool XBut;
    public bool YBut;
    public bool ZBut;

}


