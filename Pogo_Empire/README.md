[**home**](../README.md)

## Pogo Empire

![Documentation%20Pogo%20Empire/Untitled.png](Documentation%20Pogo%20Empire/Untitled.png)

Robin Exbrayat - Arslan SIfaoui - Axel Bossard - Charles Fouyer

## Contexte

Dans le cadre de notre Workshop Arcade, nous avons travaillé pendant une semaine en groupe de 4, une équipe composé de 2 designers d'interactivité et 2 Game designers. Notre sujet consistait à créer un jeu d'arcade qui prend en compte un moyen d'interaction alternatif, qui sort de l'ordinaire et qui propose un jeu amusant et fun. 

## Jalons

On voulait retrouver à travers ce jeu l'ambiance nostalgique que l'on pouvait ressentir dans les bornes d'arcade. Un jeu compétitif, facile à prendre en main, mais difficile à performer.

## Concept

Suite à nos recherches, nous avons conceptualisé l'idée d'un jeu multijoueurs.3 joueurs se déplacent virtuellement sur un plateau de jeu doivent pousser à la manière d'un pogo les autres joueurs en dehors de l'espace de jeu, tout en évitant les coups des autres pour ne pas tomber. Un quatrième joueur, le GodPlayer vient perturber l'équilibre du jeu en réduisant la taille du plateau grâce à un controller alternatif pour faire tomber les joueurs injustement.

![Documentation%20Pogo%20Empire/IMG_3383](Documentation%20Pogo%20Empire/IMG_3383.jpg)

![Documentation%20Pogo%20Empire/IMG_3427.heic](Documentation%20Pogo%20Empire/IMG_3427.jpg)

## Scénagrophie

Au niveau de la disposition et de la scénographie, on voulait que le rapport GodPlayer et BascicPlayer soit représenté dans la disposition des joueurs ainsi, on a imaginé que le GodPlayer qui se trouve en hauteur (debout) et derrière les trois autres joueurs assis, pour créer un rapport de supériorité.

![Documentation%20Pogo%20Empire/Capture_decran_2020-03-06_a_16.03.48.png](Documentation%20Pogo%20Empire/Capture_decran_2020-03-06_a_16.03.48.png)

![Documentation%20Pogo%20Empire/IMG_6103.heic](Documentation%20Pogo%20Empire/IMG_6103.jpg)

## Réfléxion

Le GodPlayer a un code GodController qui se compose de 16 pièces manipulable et reliées à 2 capteurs capacitifs. 
Pour actionner le capteur, il faut soulever et maintenir les pièces sur le GodController en l'air afin que cela déclenche un piège dans le jeu virtuellement dans lesquelles les joueurs peuvent tomber.
Dans un premier temps, les 3 joueurs font tomber les autres joueurs du plateau tout en évitant les coups des joueurs et les pièges du GodFAther. 
Lorsqu'il ne reste qu'un joueur, celui de survivre au stratagème de Godplayer jusqu'à la fin du temps restant, s'il ne réussit pas le GodPlayer remporte la partie.

## Scénario

Pogo Empire est un Royaume dans lequel règne peur et désaroi. Les différents peuples s'affrontent pour se partager les 16 régions que forment le continent. Le Dieu en qui les habitants de l'Empire ont foi, décide d'arrêter cet excès de violence avec un ultime combat.

## Montage Arduino

### Matériaux

- 1 x Carte Arduino Mega
- 2 x [Capteur capacitif MPR 121](https://www.francerobotique.com/contact/640-capteur-tactile-12-entrees-avec-shield-mpr121-art0716-adafruit.html)
- 3 x Bouton (style arcade)
- 3 x Joystick (style arcade)
- Scotch conducteur
- Prévoir une quantité de fil important, l'idéale en roulant avec 3 couleurs ou plus (noir → ground, rouge → 5V,  couleur x → input)

 

![Documentation%20Pogo%20Empire/IMG_6124.heic](Documentation%20Pogo%20Empire/IMG_6124.jpg)

Joystick et Bouton

![Documentation%20Pogo%20Empire/IMG_6123.heic](Documentation%20Pogo%20Empire/IMG_6123.jpg)

MPR121

### Schéma du circuit électronique

![Documentation%20Pogo%20Empire/schema-arduino.jpg](Documentation%20Pogo%20Empire/schema-arduino.jpg)

## Code arduino

Première étape, il faut télécharger et installer la bibliothèque Adafruit_MPR121

Définir toutes les variables ainsi que les pins qui correspondent à vos branches que vous avez réalisés en recopiant le schéma.
```c
    #include <Wire.h>
    #include "Adafruit_MPR121.h"
    
    #ifndef _BV
    #define _BV(bit) (1 << (bit))
    #endif
    
    // You can have up to 4 on one i2c bus but one is enough for testing!
    Adafruit_MPR121 cap = Adafruit_MPR121();
    Adafruit_MPR121 cap1 = Adafruit_MPR121();
    // Keeps track of the last pins touched
    // so we know when buttons are 'released'
    uint16_t lasttouched = 0;
    uint16_t currtouched = 0;
    uint16_t lasttouched1 = 0;
    uint16_t currtouched1 = 0;
    
    int touches[16];
```
Deuxième étape, mettre en place le void setup.

Le void setup est séparé en 4 pour chaque contrôleur.

Les trois premiers correspondent aux 3 joysticks et aux trois boutons.

Prenons l'exemple du premier contrôleur :

Pour le bouton :

- pinMode 4 - Va faire correspondre le bouton à la pin numéro quatre de la carte arduino.

Pour le joystick :

- pinMode 3 - Est relié au joystick quand il est tourné vers la droite comme indiqué dans le commentaire.

Il vous suffit de répéter la même opération pour tous les autres.

```c
    void setup() {
    
      //---------------------------------------------Controller 01
    
      // Fire button 01
      pinMode(4, INPUT_PULLUP);
      // Joystick 01
      pinMode(3, INPUT_PULLUP); //Joystick Right Switch
      pinMode(2, INPUT_PULLUP); //Joystick Left Switch
      pinMode(5, INPUT_PULLUP); //Joystick Forward Switch
      pinMode(6, INPUT_PULLUP); //Joystick Backward Switch
    
      //---------------------------------------------Controller 02
    
      // Fire button 02
      pinMode(9, INPUT_PULLUP);
      // Joystick 02
      pinMode(8, INPUT_PULLUP); //Joystick Right Switch
      pinMode(7, INPUT_PULLUP); //Joystick Left Switch
      pinMode(10, INPUT_PULLUP); //Joystick Backward Switch
      pinMode(11, INPUT_PULLUP); //Joystick Forward Switch
    
      //---------------------------------------------Controller 03
    
      // Fire button 03
      pinMode(48, INPUT_PULLUP);
      // Joystick 03
      pinMode(44, INPUT_PULLUP); //Joystick Right Switch
      pinMode(46, INPUT_PULLUP); //Joystick Left Switch
      pinMode(52, INPUT_PULLUP); //Joystick Forward Switch
      pinMode(50, INPUT_PULLUP); //Joystick Backward Switch
```
La suite du void setup est en rapport aux 2 capteurs capacitifs MPR 121

Etant donné que pour le montage nous avons besoin de 2 capteurs capacitifs, nous allons devoir les séparer en deux parties.

Les Serial.println, vont nous permettre de voir dans le moniteur si les capteurs sont bien connectés à la carte arduino.

"for (uint8_t i = 0; i < 16; i++) {touches[i] = 1;}"   Cette partie va indiquer le nombre de sorties que nous allons utiliser sur les deux capteurs réunis. Ce qui revient à 16 dans notre cas.

```c
    		  Serial.begin(9600);
        
          while (!Serial) { // needed to keep leonardo/micro from starting too fast!
            delay(10);
          }
        
          Serial.println("Adafruit MPR121 Capacitive Touch sensor test");
    
    
    
          //Partie 1
          // Default address is 0x5A, if tied to 3.3V its 0x5B
          // If tied to SDA its 0x5C and if SCL then 0x5D
          if (!cap.begin(0x5A)) {
            Serial.println("MPR121 not found, check wiring?");
            while (1);
          }
          Serial.println("MPR121 found!");
    
    
          //Partie 2
          // Default address is 0x5A, if tied to 3.3V its 0x5B
          // If tied to SDA its 0x5C and if SCL then 0x5D
          if (!cap1.begin(0x5B)) {
            Serial.println("Cap 1 MPR121 not found, check wiring?");
            while (1);
          }
          Serial.println("Cap 1 MPR121 found!");
          for (uint8_t i = 0; i < 16; i++) {
            touches[i] = 1;
          }
        }
```

Au tour du void loop.

Le void loop sera la partie du "Code" qui va tourner en boucle et qui va nous permettre de récupérer nos données envoyées directement par les capteurs.

Comme précédemment, nous possédons 2 capteurs capacitifs donc nous allons devoir les séparer en deux parties. 

Partie 1

Il va vérifier l'état des capteurs 12 sorties du premier capteur.

Tant que les sorties ne sont pas touchées, les valeurs qu'il va retourné seront 0.

Mais dans le cas où une des sorties serait touchée, il retournera la valeur 1

Partie 2

Même procédé, à la différence que nous avons nommé le capteur différemment pour le différencier.

```c    
        void loop() {
        
          //Partie 1
        
          // Get the currently touched pads
          currtouched = cap.touched();
        
          for (uint8_t i = 0; i < 12; i++) {
            // if it *is* touched and *wasnt* touched before, alert!
            if ((currtouched & _BV(i)) && !(lasttouched & _BV(i)) ) {
              touches[i] = 0;
        
            }
            // if it *was* touched and now *isnt*, alert!
            if (!(currtouched & _BV(i)) && (lasttouched & _BV(i)) ) {
              touches[i] = 1;
            }
          }
        
          // reset our state
          lasttouched = currtouched;
        
        
          //Partie 2
        
          // Get the currently touched pads
          currtouched1 = cap1.touched();
        
          for (uint8_t i = 0; i < 12; i++) {
            if ((currtouched1 & _BV(i)) && !(lasttouched1 & _BV(i)) ) {
              touches[i + 12] = 0;
            }
            if (!(currtouched1 & _BV(i)) && (lasttouched1 & _BV(i)) ) {
              touches[i + 12] = 1;
            }
          }
```

La dernière partie du void loop sera notre JSON

Notre JSON est ce que va compiler nos données et les écrire dans le moniteur pour qu'ensuite, on puisse faire lire les données au logiciel Unity afin qu'il les utilise en tant que contrôleur de jeu.

Le JSON est séparé en 4 parties. 1 pour chaque contrôleur.

Commençons par le Contrôleur 1

Ce qu'il va écrire pour le premier contrôleur dans le moniteur c'est :

    {B01:0, JR01:0, JL01:0, JB01:0, JF01:0}

01 = Le jouer numéro 1

B01 = Le Bouton

JR01 = Le joystick qui tourne vers la droite

JL01 = Le joystick qui tourne vers la gauche

JB01 = Le joystick qui tourne vers le bas

JF01 = Le joystick qui tourne vers l'avant

:0 = Résultat reçu par le digitalRead()

Le fonctionnement reste le même pour les contrôleurs 2 et 3

Pour les deux capteurs capacitifs MPR121, 

on va créer une boucle "for" qui va s'arrêté à 16 et qui va nous retourné la valeur 0 ou 1 en fonction de [i]

Ce qu'il va écrire pour les deux capteurs dans le moniteur c'est :

    {C1:0, C2:0, C3:0 , C4:0, C50, C6:0, C7:0, C8:0, C9:0, C10:0, C11:0, C12:0, C13:0, C14:0, C15:0, C16:0, C:0}

Le 1er au 16ème vont représenté les 16 sorties des deux capteurs MPR121.

"Serial.println(json); "   -    Ce que va tout écrire dans le moniteur.

Nous avons laissé un "delay(100);" commenté à la fin du code. Il va être utile quand vous allez faire des tests pour ralentir la boucle et ainsi mieux voir les données dans le moniteur.

```c    
        // JSON
        
        
          String json;
          
        
        //---------------------------------------------Controller 01
        
        
          // Button 01
          json = "{\"B01\":";
          json = json + digitalRead(4);
        
          // Joystick 01
          json = json + ",\"JR01\":";
          json = json +  digitalRead(3);
          json = json + ",\"JL01\":";
          json = json +  digitalRead(2);
          json = json + ",\"JB01\":";
          json = json +  digitalRead(6);
          json = json + ",\"JF01\":";
          json = json +  digitalRead(5);
        
        
          //---------------------------------------------Controller 02
        
        
          // Button 02
          json = json + ",\"B02\":";
          json = json + digitalRead(9);
        
          // Joystick 02
          json = json + ",\"JL02\":";
          json = json +  digitalRead(8);
          json = json + ",\"JR02\":";
          json = json +  digitalRead(7);
          json = json + ",\"JF02\":";
          json = json +  digitalRead(11);
          json = json + ",\"JB02\":";
          json = json +  digitalRead(10);
        
          //---------------------------------------------Controller 03
        
        
          // Button 03
          json = json + ",\"B03\":";
          json = json + digitalRead(48);
        
          // Joystick 01
          json = json + ",\"JR03\":";
          json = json +  digitalRead(44);
          json = json + ",\"JL03\":";
          json = json +  digitalRead(46);
          json = json + ",\"JB03\":";
          json = json +  digitalRead(50);
          json = json + ",\"JF03\":";
          json = json +  digitalRead(52);
          json = json + ",";
        
          //---------------------------------------------MPR121
        
        
          // MPR121
          for (uint8_t i = 0; i < 16; i++) {
            json = json + "\"C" + i + "\":" ;
            json = json + touches[i] ;
            if (i < 15) {
              json += ",";
            }
          }
        
        
          json = json + "}";
          Serial.println(json);
        
         // reset our state
          lasttouched1 = currtouched1;
        
          //delay(100);
        } 
```

La dernière étape sera de récupérer le fichier Unity qui correspond au jeu POGO EMPIRE.

Il ne reste plus qu'à brancher la carte arduino à l'ordinateur et de lancer notre jeu afin de profiter de la partie avec ses amis.

## Maquettage

Il nous fallait une structure solide est ergonomique pour que le God Controller soit fonctionnel. Dans un premier temps, nous avons imaginé un fonctionnement de contre-poid sur les boutons du controller. Pour activer le bouton, nous devons soulever la pièce, quand on lâche la pièce se remet en place, avec un fil relié à la pièce qui l'attire vers le bas. On peut voir le fonctionnement, du prototype dans l'image ci-dessus. Plus tard, on remplacera par des boulons le scotch sur les photos ci-dessous qui fait office de poids.

Nous voulions que le GodPlayer soit un pouvoir important sur le jeu, mais que le jeu devait pouvoir rester jouable par les autres joueurs sur le plateau. C'est pourquoi nous devions penser des mécaniques d'interaction qui limite l'abus. Nous avons donc pensé à un plateau de jeu, avec des pièces (4*4 = 16) qui représente le plateau virtuel sur lequel les autres joueurs interagissent . L'intérêt de la forme plate et carré des pièces permet de ne retirer uniquement 2 pièces du plateau en même temps, une par main. En revanche, on peut imaginer des contextes de triches, qui pourrait rendre le jeu encore plus drôle et plus challengeant pour les autres joueurs.

![Documentation%20Pogo%20Empire/IMG_9942FC4F118F-1.jpeg](Documentation%20Pogo%20Empire/IMG_9942FC4F118F-1.jpeg)

![Documentation%20Pogo%20Empire/IMG_F939EE47793A-1.jpeg](Documentation%20Pogo%20Empire/IMG_F939EE47793A-1.jpeg)

![Documentation%20Pogo%20Empire/Untitled%201.png](Documentation%20Pogo%20Empire/Untitled%201.png)

![Documentation%20Pogo%20Empire/IMG_1F44DF226C7E-1.jpeg](Documentation%20Pogo%20Empire/IMG_1F44DF226C7E-1.jpeg)

![Documentation%20Pogo%20Empire/IMG_6104.heic](Documentation%20Pogo%20Empire/IMG_6104.jpg)

Nous avons laissé une porte à l'avant de la borne du God controller pour avoir la place de faire tous nos branchements, la carte Arduino et l'ordinateur.

![Documentation%20Pogo%20Empire/IMG_6070.heic](Documentation%20Pogo%20Empire/IMG_6070.jpg)

Pour la construction, rien de compliqué, nous avons fixé des tasseau pour faire quatre pieds, sur lesquels nous avons collé du cartons pour avoir une structure rigide.

## Controller BasicPlayer

Nous avons construit des controller pour chaque joueur sur le plateau, chaque controller comprends un joystick et un bouton. Après avoir construit des prototypes en cartons de la structures des controllers nous les avons découper à la découpe laser, de manière individuelle. Pour ensuite les regrouper sur une structure qui regroupe les 3 controllers.

![Documentation%20Pogo%20Empire/IMG_6080.heic](Documentation%20Pogo%20Empire/IMG_6080.jpg)

![Documentation%20Pogo%20Empire/IMG_6079.heic](Documentation%20Pogo%20Empire/IMG_6079.jpg)

![Documentation%20Pogo%20Empire/IMG_6089.heic](Documentation%20Pogo%20Empire/IMG_6089.jpg)

![Documentation%20Pogo%20Empire/IMG_6088.heic](Documentation%20Pogo%20Empire/IMG_6088.jpg)

![Documentation%20Pogo%20Empire/Scanbot_7_Mar_2020_00.04.jpg](Documentation%20Pogo%20Empire/Scanbot_7_Mar_2020_00.04.jpg)

Après réalisation, on s'est rendu compte que les dispositifs des controllers pour les 3 joueurs, à nécessité beaucoup de fil, rendant notre installation complexe et moins fiable. C'est pourquoi à l'avenir nous souhaitons utiliser un gamepad USB constitué d'un joystick et d'un bouton, pour chaque joueur.

![Documentation%20Pogo%20Empire/Capture_decran_2020-03-06_a_22.49.45.png](Documentation%20Pogo%20Empire/Capture_decran_2020-03-06_a_22.49.45.png)

![Documentation%20Pogo%20Empire/Capture_decran_2020-03-06_a_19.42.07.png](Documentation%20Pogo%20Empire/Capture_decran_2020-03-06_a_19.42.07.png)

![Documentation%20Pogo%20Empire/Untitled%202.png](Documentation%20Pogo%20Empire/Untitled%202.png)

![Documentation%20Pogo%20Empire/Untitled%203.png](Documentation%20Pogo%20Empire/Untitled%203.png)

![Documentation%20Pogo%20Empire/Untitled%204.png](Documentation%20Pogo%20Empire/Untitled%204.png)

D'un poin de vue interface joueur, c'est très simple, chaque joueur à trois vies. Il y aégalement un compte à rebours, pour remporter la partie , il faut survivre jusyq'a la fin du temps. 

- Système de collision

```c#
        using System.Collections;
        using System.Collections.Generic;
        using UnityEngine;
        
        public class KnockbackOnCollision : MonoBehaviour
        {
            public bool dash = false;
            [SerializeField] private float knockbackStrength;
        
            /* Ce script permet assez simplement de permettre pendant le dash d'un joueur
             de multiplier la puissance à laquelle le joueur va entrer en collision avec l'autre
             Ainsi l'ennemi qui se trouve dans la trajectoire du dash est propulsé dans une direction (un vecteur)
             opposé à celle dans laquelle le joueur qui a dash percute le dit joueur. Cette puissance peut
             être changé dans l'inspecteur de Unity*/
        
            private void OnCollisionEnter(Collision collision)
            {
                Rigidbody rb = collision.collider.GetComponent<Rigidbody>();
        
                if (dash == true)
                {
                    if (rb != null)
                    {
                        Vector3 direction = collision.transform.position - transform.position;
                        direction.y = 0;
        
                        rb.AddForce(direction.normalized * knockbackStrength, ForceMode.Impulse);
        
                    }
                }
            }
        }
````

- Animation pièces

```c#
        using System.Collections;
        using System.Collections.Generic;
        using UnityEngine;
        using NaughtyAttributes;
        
        public class PLaneDisable : MonoBehaviour
        {
            public KeyCode key;
          
            void Update()
            {
                /*Ce script permet de lancer une animation à nos pièces de terrain pour qu'elles disparaissent et perdent leur rigidBody
                  Ce script est une alternative jouable au clavier, celui appelé avec de l'arduino ne prend pas la forme d'un "GetKey"
                  mais assigne cette fonctionalité aux données jSon du "God Controler"*/
                /*
                if (Input.GetKey(key))
                {
                    GetComponent<Animator>().Play("FadeOut");
                } else
                {
                    GetComponent<Animator>().Play("Default");
                }
                */
               
            }
        }
```

- Système de vie

```c#
        using System.Collections;
        using System.Collections.Generic;
        using UnityEngine;
        using UnityEngine.UI;
        
        public class Health : MonoBehaviour
        {
            public int health;
            public int numOfHearts;
        
            public Image[] hearts;
            public Sprite fullHeart;
            public Sprite emptyHeart;
        
            /* Ce système de vie est l'essence de notre jeu puisque chacun des joueurs ne possède que 3 points de vie
             que l'on peut retirer à l'aide de ce script. A savoir que ce script n'est est lié à une foncton qui permet 
             aux joueurs de ne plus réaparaître quand la totalité de la vie a été retiré.*/
        
            public void Update()
            {
                if (health > numOfHearts)
                {
                    health = numOfHearts;
                }
                for (int i = 0; i < hearts.Length; i++)
                {
                   
                    if (i < health)
                    {
                        hearts[i].sprite = fullHeart;
                    }
                    else
                    {
                        hearts[i].sprite = emptyHeart;
                    }
        
        
        
                    if (i < numOfHearts)
                    {
                        hearts[i].enabled = true;
                    }
                    else
                    {
                        hearts[i].enabled = false;
                    }
                }
                 
                
            }
        }
```

- Dash limite

```c#
        using System.Collections;
        using System.Collections.Generic;
        using UnityEngine;
        
        public class Player : MonoBehaviour
        {
            public float moveSpeed = 5;
            public float currentSpeed;
            public float dashspeed = 30;
            public float dashtime;
            public bool canDash = false;
        
            public bool buttonDash = false;
            private float time;
            public float waitime;
            PlayerController controller;
            public Vector3 moveInput= new Vector3(0,0,0);
        
            // Start is called before the first frame update
            void Start()
            {
                controller = GetComponent<PlayerController>();
                currentSpeed = moveSpeed;
                receiveArduinoData.Instance.p1 = gameObject;
            }
        
            // Update is called once per frame
        
        
                /* Dans ce void update il est question de limiter le  timming du dash pour que les joueurs ne puissent
                 pas l'utiliser à l'infini et donc être quasiment invincible pour le God Player. Ainsi le script dit
                 si le joueur dash, il doit patienter pendant x secondes avant de pouvoir dasher à nouveau.*/
        
            void Update()
            {
                //POUR ARDUINO METTRE UN DOUBLE// 
                //Vector3 moveInput = new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical"));
                Vector3 moveVelocity = moveInput.normalized * currentSpeed;
                controller.Move(moveVelocity);
        
        
                if (buttonDash)
                {
                    if (canDash == true)
                    {
                        StartCoroutine(dash());
                    }
                }
        
                if (time <= 0)
                {
                    canDash = true;
                }
                else
                {
                    canDash = false;
                    time -= Time.deltaTime;
                }
            }
        
            IEnumerator dash()
            {
                currentSpeed = dashspeed;
                GetComponent<KnockbackOnCollision>().dash = true;
                yield return new WaitForSeconds(dashtime);
                GetComponent<KnockbackOnCollision>().dash = false;
                time = waitime;
                currentSpeed = moveSpeed;
            }
        }
```        

- JSON & connection Arduino

```c#
        using System.Collections;
        using System.Collections.Generic;
        using UnityEngine;
        
        
        public class receiveArduinoData : MonoBehaviour
        {
            public static receiveArduinoData Instance;
            public GameObject case1;
            public GameObject case2;
            public GameObject case3;
            public GameObject case4;
            public GameObject case5;
            public GameObject case6;
            public GameObject case7;
            public GameObject case8;
            public GameObject case9;
            public GameObject case10;
            public GameObject case11;
            public GameObject case12;
            public GameObject case13;
            public GameObject case14;
            public GameObject case15;
            public GameObject case16;
        
        
            public GameObject p1;
            public GameObject p2;
            public GameObject p3;
        
            public ArduinoDatas d;
        
            private void Awake()
            {
                if(Instance != null)
                {
                    Destroy(this.gameObject);
                }
                else
                {
                    Instance = this;
                }
            }
        
            private void Start()
            {
                p1 = GameObject.FindGameObjectWithTag("P1").gameObject;
                p2 = GameObject.FindGameObjectWithTag("P2").gameObject;
                p3 = GameObject.FindGameObjectWithTag("P3").gameObject;
        
                case1 = GameObject.FindGameObjectWithTag("C1").gameObject;
                case2 = GameObject.FindGameObjectWithTag("C2").gameObject;
                case3 = GameObject.FindGameObjectWithTag("C3").gameObject;
                case4 = GameObject.FindGameObjectWithTag("C4").gameObject;
                case5 = GameObject.FindGameObjectWithTag("C5").gameObject;
                case6 = GameObject.FindGameObjectWithTag("C6").gameObject;
                case7 = GameObject.FindGameObjectWithTag("C7").gameObject;
                case8 = GameObject.FindGameObjectWithTag("C8").gameObject;
                case9 = GameObject.FindGameObjectWithTag("C9").gameObject;
                case10 = GameObject.FindGameObjectWithTag("C10").gameObject;
                case11 = GameObject.FindGameObjectWithTag("C11").gameObject;
                case12 = GameObject.FindGameObjectWithTag("C12").gameObject;
                case13 = GameObject.FindGameObjectWithTag("C13").gameObject;
                case14 = GameObject.FindGameObjectWithTag("C14").gameObject;
                case15 = GameObject.FindGameObjectWithTag("C15").gameObject;
                case16 = GameObject.FindGameObjectWithTag("C16").gameObject;
        
        
            }
            // Invoked when a line of data is received from the serial device.
            void OnMessageArrived(string msg)
            {
                d = JsonUtility.FromJson<ArduinoDatas>(msg);
                Debug.Log(msg);
        
                // TOUTES LES CASES
                // case 1
                if (d.C0 == false) case1.GetComponent<Animator>().Play("FadeOut");
                else case1.GetComponent<Animator>().Play("Default");
        
                // case 2
                if (d.C1 == false) case2.GetComponent<Animator>().Play("FadeOut");
                else case2.GetComponent<Animator>().Play("Default");
        
                // case 3
                if (d.C2 == false) case3.GetComponent<Animator>().Play("FadeOut");
                else case3.GetComponent<Animator>().Play("Default");
        
                // case 4
                if (d.C3 == false) case4.GetComponent<Animator>().Play("FadeOut");
                else case4.GetComponent<Animator>().Play("Default");
        
                // case 5
                if (d.C4 == false) case5.GetComponent<Animator>().Play("FadeOut");
                else case5.GetComponent<Animator>().Play("Default");
        
                // case 6
                if (d.C5 == false) case6.GetComponent<Animator>().Play("FadeOut");
                else case6.GetComponent<Animator>().Play("Default");
        
                // case 7
                if (d.C6 == false) case7.GetComponent<Animator>().Play("FadeOut");
                else case7.GetComponent<Animator>().Play("Default");
        
                // case 8
                if (d.C7 == false) case8.GetComponent<Animator>().Play("FadeOut");
                else case8.GetComponent<Animator>().Play("Default");
        
                // case 9
                if (d.C8 == false) case9.GetComponent<Animator>().Play("FadeOut");
                else case9.GetComponent<Animator>().Play("Default");
        
                // case 10
                if (d.C9 == false) case10.GetComponent<Animator>().Play("FadeOut");
                else case10.GetComponent<Animator>().Play("Default");
        
                // case 11
                if (d.C10 == false) case11.GetComponent<Animator>().Play("FadeOut");
                else case11.GetComponent<Animator>().Play("Default");
        
                // case 12
                if (d.C11 == false) case12.GetComponent<Animator>().Play("FadeOut");
                else case12.GetComponent<Animator>().Play("Default");
        
                // case 13
                if (d.C12 == false) case13.GetComponent<Animator>().Play("FadeOut");
                else case13.GetComponent<Animator>().Play("Default");
        
                // case 14
                if (d.C13 == false) case14.GetComponent<Animator>().Play("FadeOut");
                else case14.GetComponent<Animator>().Play("Default");
        
                // case 15
                if (d.C14 == false) case15.GetComponent<Animator>().Play("FadeOut");
                else case15.GetComponent<Animator>().Play("Default");
        
                // case 16
                if (d.C15 == false) case16.GetComponent<Animator>().Play("FadeOut");
                else case16.GetComponent<Animator>().Play("Default");
        
        
                //player3 controller
                if (p3 != null)
                {
                    if (d.JF03 == false && d.JL03 == false) p3.GetComponent<Player3>().moveInput = new Vector3(-1, 0, 1);
                    else if (d.JF03 == false && d.JR03 == false) p3.GetComponent<Player3>().moveInput = new Vector3(1, 0, 1);
                    else if (d.JB03 == false && d.JL03 == false) p3.GetComponent<Player3>().moveInput = new Vector3(-1, 0, -1);
                    else if (d.JB03 == false && d.JR03 == false) p3.GetComponent<Player3>().moveInput = new Vector3(1, 0, -1);
                    else if (d.JF03 == false) p3.GetComponent<Player3>().moveInput = new Vector3(0, 0, 1);
                    else if (d.JB03 == false) p3.GetComponent<Player3>().moveInput = new Vector3(0, 0, -1);
                    else if (d.JR03 == false) p3.GetComponent<Player3>().moveInput = new Vector3(1, 0, 0);
                    else if (d.JL03 == false) p3.GetComponent<Player3>().moveInput = new Vector3(-1, 0, 0);
                    else p3.GetComponent<Player3>().moveInput = new Vector3(0, 0, 0);
                }
        
                //player2 controller
                if (p2 != null)
                {
                    if (d.JF02 == false && d.JL02 == false) p2.GetComponent<Player2>().moveInput = new Vector3(-1, 0, 1);
                    else if (d.JF02 == false && d.JR02 == false) p2.GetComponent<Player2>().moveInput = new Vector3(1, 0, 1);
                    else if (d.JB02 == false && d.JL02 == false) p2.GetComponent<Player2>().moveInput = new Vector3(-1, 0, -1);
                    else if (d.JB02 == false && d.JR02 == false) p2.GetComponent<Player2>().moveInput = new Vector3(1, 0, -1);
                    else if (d.JF02 == false) p2.GetComponent<Player2>().moveInput = new Vector3(0, 0, 1);
                    else if (d.JB02 == false) p2.GetComponent<Player2>().moveInput = new Vector3(0, 0, -1);
                    else if (d.JR02 == false) p2.GetComponent<Player2>().moveInput = new Vector3(1, 0, 0);
                    else if (d.JL02 == false) p2.GetComponent<Player2>().moveInput = new Vector3(-1, 0, 0);
                    else p2.GetComponent<Player2>().moveInput = new Vector3(0, 0, 0);
                }
                //player1 controller
                if (p1 != null)
                {
                    if (d.JF01 == false && d.JL01 == false) p1.GetComponent<Player>().moveInput = new Vector3(-1, 0, 1);
                    else if (d.JF01 == false && d.JR01 == false) p1.GetComponent<Player>().moveInput = new Vector3(1, 0, 1);
                    else if (d.JB01 == false && d.JL01 == false) p1.GetComponent<Player>().moveInput = new Vector3(-1, 0, -1);
                    else if (d.JB01 == false && d.JR01 == false) p1.GetComponent<Player>().moveInput = new Vector3(1, 0, -1);
                    else if (d.JF01 == false) p1.GetComponent<Player>().moveInput = new Vector3(0, 0, 1);
                    else if (d.JB01 == false) p1.GetComponent<Player>().moveInput = new Vector3(0, 0, -1);
                    else if (d.JR01 == false) p1.GetComponent<Player>().moveInput = new Vector3(1, 0, 0);
                    else if (d.JL01 == false) p1.GetComponent<Player>().moveInput = new Vector3(-1, 0, 0);
                    else p1.GetComponent<Player>().moveInput = new Vector3(0, 0, 0);
                }
                // player3 dash
                if (p3 != null)
                {
                    if (d.B03 == false) p3.GetComponent<Player3>().buttonDash = true;
                    else p3.GetComponent<Player3>().buttonDash = false;
                }
                // player2 dash
                if (p2 != null)
                {
                    if (d.B02 == false) p2.GetComponent<Player2>().buttonDash = true;
                    else p2.GetComponent<Player2>().buttonDash = false;
                }
                // player1 dash
                if (p1 != null)
                {
                    if (d.B01 == false) p1.GetComponent<Player>().buttonDash = true;
                    else p1.GetComponent<Player>().buttonDash = false;
                }
            }
        
            // Invoked when a connect/disconnect event occurs. The parameter 'success'
            // will be 'true' upon connection, and 'false' upon disconnection or
            // failure to connect.
            void OnConnectionEvent(bool success)
            {
                Debug.Log("success");
            }
        }
        
        public class ArduinoDatas
        {
            public bool B01;
            public bool JR01;
            public bool JB01;
            public bool JF01;
            public bool JL01;
            public bool B02;
            public bool JL02;
            public bool JR02;
            public bool JF02;
            public bool JB02;
            public bool B03;
            public bool JR03;
            public bool JL03;
            public bool JB03;
            public bool JF03;
            public bool C0;
            public bool C1;
            public bool C2;
            public bool C3;
            public bool C4;
            public bool C5;
            public bool C6;
            public bool C7;
            public bool C8;
            public bool C9;
            public bool C10;
            public bool C11;
            public bool C12;
            public bool C13;
            public bool C14;
            public bool C15;
        }
```

```c#
        using System.Collections;
        using System.Collections.Generic;
        using UnityEngine;
        
        public class movment : MonoBehaviour
        {
        	public Transform big;
        	public Transform small;
        	private int score;
        	private bool grow = true;
        	
        	public float speed = 0.25f;
        
        	// Use this for initialization
        	void Start ()
        	{
        		
        	}
        	
        	// Update is called once per frame
        	void Update ()
        	{
        		Vector3 rMoving = transform.localScale;
        
        		Vector3 rBig = big.localScale;
        		Vector3 rSmall = small.localScale;
        
        
        		if (rMoving.x > rSmall.x && rMoving.x < rBig.x) {
        			score++;	
        			GetComponent<Renderer> ().material.SetColor ("_Color", new Color (1.0f, 0.0f, 1.0f, 0.5f));
        		} else {
        			score--;
        			GetComponent<Renderer> ().material.SetColor ("_Color", new Color (1.0f, 1.0f, 0.0f, 0.5f));
        		}
        
        		if (Input.GetKeyDown (KeyCode.A)) {
        			grow = true;
        		}
        		if (Input.GetKeyDown (KeyCode.Z)) {
        			grow = false;
        		}
        
        
        		/*	
        		if (grow) {
        			transform.localScale += new Vector3 (speed, speed, speed);
        
        		} else {
        			transform.localScale -= new Vector3 (speed, speed, speed);
        
        		}*/
        
        		transform.localScale = new Vector3 (Mathf.Clamp (transform.localScale.x, 0f, 20f),
        											Mathf.Clamp (transform.localScale.y, 0f, 20f),
        											Mathf.Clamp (transform.localScale.z, 0f, 20f));
        		//Debug.Log (score);
        
        
        
        		
        	}
        
        	// Invoked when a line of data is received from the serial device.
            void OnMessageArrived(string msg)
            {
              // Debug.Log(msg);
        	   ArduinoData d = JsonUtility.FromJson<ArduinoData>(msg);
        	   //Debug.Log(d.distance);
        
        
            }
        
            // Invoked when a connect/disconnect event occurs. The parameter 'success'
            // will be 'true' upon connection, and 'false' upon disconnection or
            // failure to connect.
            void OnConnectionEvent(bool success)
            {
               Debug.Log("connected : " + success);
            }
        }
        
        public class ArduinoData
        {
            public bool butP1;
            public string moveVerticaleP1;
        
            
           
        }
```

![Documentation%20Pogo%20Empire/Notice_de_montage_Plan_de_travail_1.jpg](Documentation%20Pogo%20Empire/Notice_de_montage_Plan_de_travail_1.jpg)


[**home**](../README.md)