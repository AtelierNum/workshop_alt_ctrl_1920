using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    private float time = 60; // le temps de mon timer 

    public TextMeshProUGUI TimerDisplay; // toute mes UI
    public GameObject GameOverDisplay;
    public GameObject WinDisplay;
    public GameObject StartGameDisplay;
    public TextMeshProUGUI ValueDisplay;
    public TextMeshProUGUI LevelValueDisplay;
    public GameObject FinisDisplay;

    public int value = 0; // la valeur des meubles obtenue par le joueur 
    public int LevelValue; // la valeur qu'il doit atteindre pour gagner
    public bool finish = false; // bloquer le timer si vraie
    public bool timerOut = false; // la fin du timer si vraie

    public TextMeshProUGUI LevelDisplay;

    public  bool end = false; // la fin du jeu si vraie

    public AudioClip GameOverClip; // tout mes son
    public AudioClip WinClip;
    public AudioClip StartClip;
    public AudioClip EndClip;
    public AudioClip AmbianceClip;

    public int LvlNmbtoLoad; // le level qu'il doit charger
    public int currentLvl; // le current Level
    public bool intro = false; // si la scene est l'intro 

    public Animator GaucheGrav; // animation de gravité
    public Animator DroitGrav;
    public Animator HautGrav;
    public Animator BasGrav;
    public Animator NullGrav;

    public AudioSource grav; // la source du son de la gravité

    private void Start()
    {
        TimerDisplay.text = "Time : " + Mathf.FloorToInt(time); // Affiche la valeur de mon Lvl, timer et objectifau Start du jeu
        LevelValueDisplay.text = "Objectif : " + LevelValue;
        LevelDisplay.text = "Lvl " + currentLvl;

        GameOverDisplay.SetActive(false); // desactive toute les UI inutile et active les bonne UI
        WinDisplay.SetActive(false);
        StartGameDisplay.SetActive(true);
        finish = true; // bloque le timer

        if (intro == false) // si se n'est pas le scene d'intro jouer le mode jeu
        {
            StartCoroutine(StartGame());
        }
        else
        {
            StartCoroutine(StartGameIntro());
        }   
        
    }

    private void Update()
    {
        TimerDisplay.text = "Time : " + Mathf.FloorToInt(time); // Actualise chacune de mes de temps et de valeur dans les texts
        ValueDisplay.text = "Value : " + value;

        if (finish == false) // mon timer de 60 sec
        {
            if (time <= 1)
            {
                timerOut = true; // si le temps est finis
            }
            else
            {
                time -= Time.deltaTime;
            }
        }

        if (end == false)
        {
            if (timerOut == true) // si le timer est finis GameOver
            {
                StartCoroutine(GameOver());
                end = true;
            }

            if (value >= LevelValue) // si la valeur du joueur est égale ou supérieur a l'objectif avant la fin du temps il gagne 
            {
                finish = true;
                StartCoroutine(Win());
                end = true;
            }
        }
    }

    IEnumerator StartGame() // animations de débuts de jeu
    {
        end = true;
        GetComponent<AudioSource>().clip = StartClip;
        yield return new WaitForSeconds(1f);
        GetComponent<AudioSource>().volume = 0.3f;
        GetComponent<AudioSource>().Play();
        StartGameDisplay.GetComponent<TextMeshProUGUI>().text = "3";
        yield return new WaitForSeconds(1f);
        GetComponent<AudioSource>().Play();
        StartGameDisplay.GetComponent<TextMeshProUGUI>().text = "2";
        yield return new WaitForSeconds(1f);
        GetComponent<AudioSource>().Play();
        StartGameDisplay.GetComponent<TextMeshProUGUI>().text = "1";
        yield return new WaitForSeconds(1f);
        StartGameDisplay.GetComponent<TextMeshProUGUI>().text = "Start";
        GetComponent<AudioSource>().volume = 1f;
        GetComponent<AudioSource>().Play();
        yield return new WaitForSeconds(0.5f);
        GetComponent<AudioSource>().clip = AmbianceClip;
        GetComponent<AudioSource>().Play();
        StartGameDisplay.SetActive(false);
        finish = false;
        end = false;
    }

    IEnumerator StartGameIntro() // animations d'intro
    {
        GetComponent<AudioSource>().clip = AmbianceClip;
        GetComponent<AudioSource>().Play();
        finish = false;
        yield return new WaitForSeconds(11.5f);
        Physics.gravity = new Vector3(0, -10, 0);
        BasGrav.Play("Bas");
        grav.Play();
        yield return new WaitForSeconds(11.5f);
        Physics.gravity = new Vector3(10, 0, 0);
        GaucheGrav.Play("Gauche");
        grav.Play();
        yield return new WaitForSeconds(11.5f);
        Physics.gravity = new Vector3(0, 0, 0);
        NullGrav.Play("Centre");
        grav.Play();
        yield return new WaitForSeconds(3f);
        Physics.gravity = new Vector3(10, 0, 0);
        GaucheGrav.Play("Gauche");
        grav.Play();
        yield return new WaitForSeconds(10f);
        Physics.gravity = new Vector3(0, 10, 0);
        HautGrav.Play("Haut");
        grav.Play();
        yield return new WaitForSeconds(10.5f);
        Physics.gravity = new Vector3(-10, 0, 0);
        DroitGrav.Play("Droite");
        grav.Play();
        yield return new WaitForSeconds(10.5f);
        NextLevel();
    }

        public void AddValue(int add) // rajoute de la valeur au score en fonction de la valeur du meuble
    {
        if (end == false)
        {
            value += add;
        }
    }

    IEnumerator Win() // animation Win
    {
        GetComponent<AudioSource>().clip = EndClip;
        GetComponent<AudioSource>().Play();
        FinisDisplay.SetActive(true);
        yield return new WaitForSeconds(2f);
        WinDisplay.SetActive(true);
        GetComponent<AudioSource>().clip = WinClip;
        GetComponent<AudioSource>().Play();
        yield return new WaitForSeconds(5f);
        NextLevel();
    }

    IEnumerator GameOver() // Animation GameOver
    {
        GetComponent<AudioSource>().clip = EndClip;
        GetComponent<AudioSource>().Play();
        FinisDisplay.SetActive(true);
        yield return new WaitForSeconds(2f);
        GameOverDisplay.SetActive(true);
        GetComponent<AudioSource>().clip = GameOverClip;
        GetComponent<AudioSource>().Play();
        yield return new WaitForSeconds(5f);
        SceneManager.LoadScene(0);
    }

    public void NextLevel() //changer de niveau
    {
        SceneManager.LoadScene(LvlNmbtoLoad);
    }
}
