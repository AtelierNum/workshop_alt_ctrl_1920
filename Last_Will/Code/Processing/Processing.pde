// Pour commencer, on importe nos librairies
// Pour Arduino
import processing.serial.*;

import cc.arduino.*;

//Pour jouer des sons
import processing.sound.*;

Arduino arduino;

// On crée nos variables de sons
SoundFile dead;
SoundFile bcg;
SoundFile victoire;
SoundFile debut;
SoundFile ding;
SoundFile voix_cloche;
SoundFile[] ambiance = new SoundFile[8];

// Et quelques bouléens utiles plus tard

boolean voix_clocheHasPlayed = false;
boolean debutHasPlayed = false;
boolean victoireHasPlayed = false;

boolean touche0 = false;
boolean touche1 = false;
boolean touche2 = false;

boolean etape1 = true;
boolean etape2 = false;
boolean etape3 = false;

boolean anySoundPlaying = true;

boolean  dingHasPlayed = false;

// On identifie nos LEDs

int ledPin0 = 8;
int ledPin1 = 9;
int ledPin2 = 10;



void setup() {

  // On précharge toute une palette de sons (ambiance, voix, bruitage)

  dead = new SoundFile(this, "shotGun.mp3");
  bcg = new SoundFile(this, "sonImpasseMexicaineBAISSE.wav");
  victoire = new SoundFile(this, "victoire.mp3");
  debut = new SoundFile(this, "debut.wav");
  voix_cloche = new SoundFile(this, "cloche.wav");
  ding = new SoundFile(this, "ding.wav");
  bcg.loop();

  // On charge 7 sons numérotés de 1 à 7
  for (int i = 1; i < 7; i ++) {
    ambiance[i] = new SoundFile(this, str(i)+".wav");
  }

  // On connecte la carte Arduino
  arduino = new Arduino(this, Arduino.list()[9], 57600);

  // On utilise ces sorties en output pour les LEDs
  for (int i = 8; i <= 10; i++) {
    arduino.pinMode(i, Arduino.OUTPUT);
  }

  // On utilise la pin 7 en input pour un bouton
  arduino.pinMode(7, Arduino.INPUT);
}

void draw() {

  if (etape1) {

    // On retourne tous les bouléens à leur états d'origine pour ramener le jeu au début 

    victoireHasPlayed = false;
    voix_clocheHasPlayed = false;
    debutHasPlayed = false;

    anySoundPlaying = true;

    dingHasPlayed = false;


    touche0 = false;
    touche1 = false;
    touche2 = false;

    etape1 = true;
    etape2 = false;
    etape3 = false;


    if (arduino.digitalRead(7) == Arduino.HIGH) { // Au clic du bouton on passe à l'étape 2
      etape1 = false;
      etape2 = true;
    }
  } else if (etape1 == false && etape2 == true) { // A l'étape 2 on dicte les instructions aux joueurs
    if (debut.isPlaying() == false && debutHasPlayed == false) {
      debutHasPlayed = true;
      debut.play(); // 1ere instruction
    }
    if (voix_cloche.isPlaying() == false && voix_clocheHasPlayed == false && debut.isPlaying() == false && debutHasPlayed == true) { // Après la 1ere instruction, on dicte la 2eme
      voix_cloche.play(); // 2eme instruction
      voix_clocheHasPlayed = true;
    }
    debut();
  } else if (etape1 == false && etape2 == false && etape3 == true) { // En appuyant une nouvelle fois sur le bouton, on passe à l'étape 3 : on lance une partie
    game();
  }
}

void debut() {

  // Cette void nous permet de créer une étape pour expliquer le jeu avant de débuter la partie

  if (voix_clocheHasPlayed == false) {                 // On ne fait rien tant que la 2eme instruction n'est pas lue
  } else {                                             // Après la 2eme instruction, on peut passer à l'étape 3 pour lancer une partie
    if (arduino.digitalRead(7) == Arduino.HIGH) {     // En appuyant sur le bouton
      etape1 = false;
      etape2 = false;
      etape3 = true;
    }
  }
}

void game() {


  /////////////////////////////////
  // Lecture des sons
  //////////////////////////////////
  
  
  anySoundPlaying = false;    // Aucun son n'est joué actuellement

  // On vérifie que l'état l'affirmation précédente
  for (int j = 1; j < 7; j ++) {
    if (ambiance[j].isPlaying() || (ding.isPlaying())) {
      anySoundPlaying = true;
    }
  }


  if (anySoundPlaying == false) {         // Si aucun son de la liste n'est joué actuellement, on peut en jouer un

    int  r = int(random(10, 10));       // On définit/randomize la durée entre les sons (ici un son sera joué toutes les 10 secondes)
    int  a = int(random(1, 7));        // On randomize l'ordre de sortie des sons

    if (second()% r == 0) {           // Ici, toutes les 10 secondes (10%10=0; 20%10=0; 30%10=0; etc)
      ambiance[a].play();            // On joue un son de la liste au hasard
      anySoundPlaying = true;       // On est actuellement en train de jouer un son
    }
  }

  // On sort ce son de la liste car on veut être sûrs qu'il sorte régulièrement, il constitue un élément de gameplay important

  if (anySoundPlaying == false) {                       // Si aucun son de la liste n'est joué actuellement
    if (second()% 16 == 0 && dingHasPlayed == false) { // Ici, toutes les 16 secondes d'une minute (16%16=0; 32%10=0; 48%10=0)
      ding.play();                                     // On joue un son de cloche
      dingHasPlayed = true;                           // On ne le joue qu'une fois
    }
  }



  /////////////////////////////////
  //Captation des capteurs lumineux
  //////////////////////////////////

  // On capte la lumière avec les photoresistances, au dessus de 400 (éclairée par un laser) on déclenche un son de coup de feu et on éteint la LED du joueur pour signifier sa mort
  if (arduino.analogRead(0) > 400 && touche0 == false) {
    dead.play();
    touche0 = true;
  }
  if (touche0 == true) {
    arduino.digitalWrite(ledPin0, Arduino.LOW);
  } else {
    arduino.digitalWrite(ledPin0, Arduino.HIGH);
  }

  // Même chose ici

  if (arduino.analogRead(1) > 400 && touche1 == false) {
    dead.play();
    touche1 = true;
  }
  if (touche1 == true) {
    arduino.digitalWrite(ledPin1, Arduino.LOW);
  } else {
    arduino.digitalWrite(ledPin1, Arduino.HIGH);
  }

  // Et ici aussi

  if (arduino.analogRead(2) > 400 && touche2 == false) {
    dead.play();
    touche2 = true;
  }
  if (touche2 == true) {
    arduino.digitalWrite(ledPin2, Arduino.LOW);
  } else {
    arduino.digitalWrite(ledPin2, Arduino.HIGH);
  }

  /////////////////////////////////
  // VICTOIRE
  //////////////////////////////////

  // On déclenche la victoire du joueur 3 car les deux autres sont touchés, la victoire n'est officielle qu'après que la cloche ait sonné
  // On joue un son de victoire et retourne à l'étape 1 pour relancer le jeu

  if ( touche0 == true && touche1 == true && touche2 == false && dingHasPlayed == true) {
    if (victoire.isPlaying() == false && victoireHasPlayed == false) {
      victoireHasPlayed = true;
      victoire.play();
      etape1 = true;
    }
  }

  // On déclenche la victoire du joueur 2 car les deux autres sont touchés, la victoire n'est officielle qu'après que la cloche ait sonné
  // On joue un son de victoire et retourne à l'étape 1 pour relancer le jeu

  if ( touche0 == true && touche2 == true && touche1 == false && dingHasPlayed == true) {
    if (victoire.isPlaying() == false && victoireHasPlayed == false) {
      victoireHasPlayed = true;
      victoire.play();
      etape1 = true;
    }
  }

  // On déclenche la victoire du joueur 2 car les deux autres sont touchés, la victoire n'est officielle qu'après que la cloche ait sonné
  // On joue un son de victoire et retourne à l'étape 1 pour relancer le jeu

  if ( touche1 == true && touche2 == true && touche0 == false && dingHasPlayed == true) {
    if (victoire.isPlaying() == false && victoireHasPlayed == false) {
      victoireHasPlayed = true;
      victoire.play();
      etape1 = true;
    }
  }
}
