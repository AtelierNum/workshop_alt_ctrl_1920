import processing.sound.*;        //Utilisation des bibliothèques "processing.sound", "processing.video" et "processing.serial"
import processing.video.*;
import processing.serial.*;

PImage bg;                         //Intégration imlage en fond

Serial arduino1;                   // Définition de la carte arduino1
float a1x, a1y;                    //On récupère les valeurs x et y de l'IMU
float xRect1, yRect1;
float buttonState;

Serial arduino2;                   // Définition de la carte arduino2
float a2x, a2y;                    //On récupère les valeurs x et y de l'IMU
float xRect2, yRect2;

PALET palet = new PALET();         //Intégration des classes PALET et RAQUETTE
RAQUETTE gauche;
RAQUETTE droite; 

int mode_jeu = 0;                  //Démarrage sur écran d'accueil
boolean mode_init = false;
boolean but = false;
long but_time = 0;

int score1 = 0;
int score2 = 0;
int score_max = 10;                //Définition du score max à atteindre pour gagner
float xpos1, ypos1, xpos2, ypos2;  //Initialisation des variables de postions des raquettes

long debut_de_la_fin = 0;

Movie accueilFilm;                 //Intégration du film d'accueil

SoundFile sirene;                  //Intégration des sons
SoundFile boomer;
SoundFile crowd;
SoundFile bandeson;


//********************************************************************************************//

void setup() {

  size(1920, 1080);

  // Connexion des arduino
  printArray(Serial.list());
  String portName1 = Serial.list()[3];
  arduino1 = new Serial(this, portName1, 57600);
  arduino1.bufferUntil('\n');
  printArray(Serial.list());
  String portName2 = Serial.list()[4];
  arduino2 = new Serial(this, portName2, 57600);
  arduino2.bufferUntil('\n');

  //Image du terrain en background
  bg = loadImage("fond terrain.jpg");

  background(0);

  //Positions des 2 raquettes
  gauche = new RAQUETTE(100, height/2);
  droite = new RAQUETTE(width-100, height/2);

  //Définition des sons
  sirene = new SoundFile(this, "sirene.wav");
  boomer = new SoundFile(this, "hockey-boomer.wav");
  crowd = new SoundFile(this, "crowd.wav");
  bandeson = new SoundFile(this, "bande son.wav");


  //Définition du film à jouer en écran d'accueil
  accueilFilm = new Movie(this, "Accueil.mp4");
  accueilFilm.loop();
}

void movieEvent(Movie m) {                                               //Lecture de la vidéo d'accueil
  m.read();
}

//********************************************************************************************//

void draw() {
  background(bg);
  fill(255);

  if (mode_jeu == 0) {                                                   // Ecran de démarrage
    image(accueilFilm, 0, 0, width, height);                             //Vidéo d'accueil en fond
    if (bandeson.isPlaying() == false) bandeson.play();
    afficherTitre();
    initialiser();
    pushStart();

    // ********************************************************************
  } else if (mode_jeu == 1) {                                            // Déroulement de la partie
    if (mode_init) {                                                     // A exécuter uniquement une fois en début de partie
      initialiser();
      mode_init = false;
      if (sirene.isPlaying() == false) sirene.play();
    }

    if (but) {                                                           //En cas de but
      if (millis() - but_time < 2000) {                                  //Attendre 2sec avant l'engagement
        palet.x = width/2;                                               //Palet au centre
        palet.y = height/2;
      } else {                                                           //Engagement
        palet.departDuCentre();
        palet.display();
        but = false;
        if (sirene.isPlaying() == false) sirene.play();
      }
    }

    if (bandeson.isPlaying() == false) bandeson.play();                  //Fond sonore
    afficherScore1();                                                    //Affichage des scores
    afficherScore2();

    gauche.updateY(map(-a1x, -1, 1, 0, height));                         //Position raquette gauche
    gauche.display();

    droite.updateY(map(a2x, -1, 1, 0, height));                          //Position raquette droite
    droite.display();

    if (!but) {                                                          //Si pas but
      palet.update();
      palet.display();
    }

    if (gauche.collision(palet.x, palet.y)) {                            //Si le palet heurte la raquette gauche : rebond
      palet.inverser();
    }
    if (droite.collision(palet.x, palet.y)) {                            //Si le palet heurte la raquette droite : rebond
      palet.inverser();
    }

    if (palet.x < 0 && palet.y >= 270 && palet.y <= height-270) {        //Si le palet rentre dans le but gauche : but du joueur 2
      score2 ++;
      if (boomer.isPlaying() == true) boomer.stop();
      if (boomer.isPlaying() == false) boomer.play();
      if (crowd.isPlaying() == true) crowd.stop();
      if (crowd.isPlaying() == false) crowd.play();
      palet.sens = 1;
      but = true;
      but_time = millis();
    }

    if (palet.x > width && palet.y >= 270 && palet.y <= height-270) {    //Si le palet rentre dans le but droit : but du joueur 1
      score1 ++;
      if (boomer.isPlaying() == true) boomer.stop();
      if (boomer.isPlaying() == false) boomer.play();
      if (crowd.isPlaying() == true) crowd.stop();
      if (crowd.isPlaying() == false) crowd.play();
      palet.sens = -1;
      but = true;
      but_time = millis();
    }

    if (score1 == score_max || score2 == score_max) {                    //Si un des scores atteint la limite de score définie : fin de la partie
      debut_de_la_fin = millis();
      mode_jeu = 2;
    }

    // ********************************************************************
  } else if (mode_jeu == 2) {                                            //Partie terminée
    afficherScore1();
    afficherScore2();
    afficherGagnant(score1, score2);
    if (sirene.isPlaying() == true) sirene.stop();
    if (sirene.isPlaying() == false) sirene.play();
    if (millis() - debut_de_la_fin > 5000) mode_jeu = 0;                 //Retour au menu principal après 5 secondes
  }
}

//********************************************************************************************//

void initialiser() {                                                     //On initialise les scores à 0 au début de partie
  score1 = 0;
  score2 = 0;
}

//********************************************************************************************//

void afficherScore1() {                                                  //Affichage du score 1
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(100);
  text(score1, width / 4, height/2);
}

//********************************************************************************************//

void afficherScore2() {                                                  //Affichage du score 2
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(100);
  text(score2, width / 4 * 3, height/2);
}

//********************************************************************************************//

void afficherTitre() {                                                   //Affichage du titre "press Start button"
  fill(255);
  textSize(64);
  textAlign(CENTER, BOTTOM);
  textSize(50);
  text("Press Start button", width/2, height/2 + 250);
}

//********************************************************************************************//

void afficherGagnant(int score1, int score2) {                          //Affichage du gagnant
  int max_partie = 0;
  int gagnant = 0;
  if (score1 > score2) {                                                //Si le joueur 1 gagne
    max_partie = score1;
    gagnant = 1;
  } else if (score1 < score2) {                                         //Si le joueur 2 gagne
    max_partie = score2;
    gagnant = 2;
  } else {                                                              //Égalité (situation impossible néanmoins)
    max_partie = score1;
    gagnant = 3;
  }
  fill(255);
  textSize(48);
  textAlign(CENTER, BOTTOM);                                            //Afficher le nom du gagnant
  if (gagnant == 1) text("PLAYER 1 WINS", width/2, height/2);
  if (gagnant == 2) text("PLAYER 2 WINS", width/2, height/2);
  if (gagnant == 3) text("ALL PLAYERS WIN", width/2, height/2);
}

//********************************************************************************************//

void afficherWin() {
  fill(255);
  textSize(48);
  textAlign(CENTER, CENTER);
  text("WIN", width/2, height/2);
}

//********************************************************************************************//

void pushStart() {                                                      //Bouton Start
  if ((buttonState == 1) && ((mode_jeu == 0) || (mode_jeu == 2)) ) {    //Début de la partie si le bouton est appuyé
    if (bandeson.isPlaying() == true) bandeson.stop();
    mode_init = true;
    mode_jeu = 1;
  }
}

//********************************************************************************************//

void serialEvent (Serial port) {                                        //Récupération des valeurs sur les cartes arduino

  if (port == arduino1) {                                               //Arduino1 : création d'un tableau de valeur data1
    String inBuffer = port.readStringUntil('\n');
    if (inBuffer != null) {
      String[] data1 = split(inBuffer, ',');
      if (data1.length == 10) {                                         //10 valeurs récupérées : 9 valeurs de l'IMU + état du bouton
        a1x = float(data1[0]);
        a1y = float(data1[1]);
        buttonState = float(data1[9]);
      }
    }
  } 

  if (port == arduino2) {                                               //Arduino1 : création d'un tableau de valeur data2
    String inBuffer = port.readStringUntil('\n');
    if (inBuffer != null) {
      String[] data2 = split(inBuffer, ',');
      if (data2.length == 9) {                                          //9 valeurs récupérées : 9 valeurs de l'IMU
        a2x = float(data2[0]);
        a2y = float(data2[1]);
      }
    }
  }
}
