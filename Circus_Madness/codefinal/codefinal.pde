import processing.serial.*;// 
import cc.arduino.*;// on importe firmata pour capter la carte arduino

Arduino arduino;

import ddf.minim.*;  // on met la bibliothèque minim pour pouvoir jouer des sons
Minim minim;// bibiothèque minim
AudioPlayer track2;    // on déclare chaque son que l'on va utliliser
AudioPlayer track3;     
AudioPlayer track4d;
AudioPlayer track4g;
AudioPlayer malus;
AudioPlayer foret;
AudioPlayer coeur;
AudioPlayer fondfille;
AudioPlayer fille2;
AudioPlayer clownambiance;
AudioPlayer monstresambiance;
AudioPlayer cirque;
AudioPlayer finnegatif;
AudioPlayer finpositif;


boolean erreur= false;    // on déclare deux boolean pour réaliser les conditions dans le jeu
boolean validplaying  = false;

int hazard;   // on déclare les valeurs utilisées
int d;
int s;
int y;
float songo;  // valeur du son du klaxon
float lum;    // valeur de la lumière de la dynamo
int score = 1500;    // le score débute à 1500
int m;
int a;
int b;
int w;

int ledPin = 6;     // on déclare une led en pin 6 pour la jauge
int ledBrightness = 0;    // la luminosité commence à 0 pour la led de la jauge


void setup() {


  size(470, 280);
  arduino = new Arduino(this, Arduino.list()[0], 57600);


  minim = new Minim(this);
  track2 = minim.loadFile ("Roger1.mp3");    // on relie tout nos sons au fichiers source dans data
  track3 = minim.loadFile ("fille1.mp3");
  track4d = minim.loadFile ("monstredroite.mp3");
  track4g = minim.loadFile ("monstregauche.mp3");
  malus = minim.loadFile ("malus.mp3");
  foret = minim.loadFile ("foret.mp3");
  coeur = minim.loadFile ("coeur.mp3");
  fondfille = minim.loadFile ("fondfille.mp3");
  fille2 = minim.loadFile ("fille2.mp3");
  clownambiance = minim.loadFile ("clownambiance.mp3");
  monstresambiance = minim.loadFile ("monstresambiance.mp3");
  cirque = minim.loadFile ("cirque.mp3");
  finnegatif = minim.loadFile ("finnegatif.mp3");
  finpositif = minim.loadFile ("finpositif.mp3");

  arduino.pinMode(3, Arduino.INPUT);       // on déclare comme entrant la pin 3 pour le booléan quand on tourne le guidon du vélo
  arduino.pinMode(4, Arduino.INPUT);       // on déclare comme entrant la pin 4 pour le booléan quand on tourne le guidon du vélo
  arduino.pinMode(ledPin, Arduino.OUTPUT);    // on déclare comme sortant la led pour la jauge
} 


void draw() {
foret.play();   // le son d'ambiance joue toujours



 if (millis()>10000){   // on y ajoute le son du coeur qui bat
   coeur.play();
 }
 
 if (millis()>15000){    // on ajoute le fond sonore du chapitre 1 avec la petite fille
   fondfille.play();
 }
  
  if (millis()>40000){    // on ajoute le fond sonore du chapitre 2 avec le clown en plus
   clownambiance.play();
 }
 
 
  //PETITE FILLE 1
  ////////////
  ///////////

  //////////// on gère l'arrivée de la petite fille


  if (millis()>20000) {     // au bout de 20s de jeu la petite fille arrive
    lum = map(arduino.analogRead(1), 0, 512, 0, 600);    // on transforme les valeurs captés par la lumière de 0 à 512 en des valeurs prise de 0 à 600
 
  if (lum >= 1100 && track3.isPlaying() == false) {       // si lum au dessus de 1100 la personne pedale trop vite la lumière augmente alors la petite fille s'active
      track3.play(); 
      w = millis();   // on déclare un millis()
      erreur = false;
      validplaying = false;
    }

    ////////////// on gère la jauge

    else if (millis() - w >= 4000 && track3.isPlaying() == true ) {   // si le temps écoulé depuis l'apparition de la petite fille est au dessus de 4s et que le son se joue
        malus.play();                // le son du malus se met en route
        malus.rewind();
      if (validplaying == false) {  // la personne perd 100 points
        score = score - 100;
        println("score:" + score);
        lum = map(arduino.analogRead(1), 0, 512, 0, 600);
        //ledBrightness = score;
      } else if (erreur == true) {
        malus.play();
        score = score - 100;
           
       score =  ledBrightness;    // la baisse de score est rendu visible par lumière qui monte
       } 
      track3.pause();   // le son s'arrête
      track3.rewind();
      erreur = false;  // il n'y a plus d'erreurs
    }


    ////////////// on gère l'interaction pour le stopper


    if (lum <= 700 &&  track3.isPlaying() == true && millis() -w <=4000 ) {     // si les 4s sont dépassées et que la personne a ralenti
      track3.pause();   // le son s'arrête
      track3.rewind(); 
      println("NON");
      erreur = false;  // il n'y a pas d'erreur
      validplaying = true;   
    } else if (lum <= 700  && track3.isPlaying() == false  && millis() - w <=4000) {              // si les 4s sont dépassées et que la personne a ralenti
      track3.pause();     // le son s'arrête
      println("OUI");
      track3.rewind();
      validplaying = false; // ça ne joue plus
      erreur = true;   // il a une erreur
    }
  }

 //PETITE FILLE 2
  ////////////
  ///////////

  //////////// on gère l'arrivée de la petite fille


  if (millis()>=40000) {     // dans le chapitre 2, une 2ème petite fille apparait
    lum = map(arduino.analogRead(1), 0, 512, 0, 600);
    //println("lum" +lum);
    if (lum >= 1000 && fille2.isPlaying() == false) {    
      fille2.play(); 
      s = millis();
      //println("ça joue ou bien?");
      erreur = false;
      validplaying = false;
    }

    ////////////// on gère la jauge

    else if (millis() - s >= 4000 && fille2.isPlaying() == true ) {
        malus.play();
        malus.rewind();
      if (validplaying == false) {
        score = score - 100;
              malus.play();
        println("score:" + score);
        lum = map(arduino.analogRead(1), 0, 512, 0, 600);
        ledBrightness = score;
      } else if (erreur == true) {
        malus.play();
        score = score - 100;
        score =  ledBrightness;
        } 
      fille2.pause();
      fille2.rewind();
      erreur = false;
    }


    ////////////// on gère l'interaction pour le stopper


    if (lum <= 600 &&  fille2.isPlaying() == true && millis() -s <=4000 ) {   // il faut plus ralentir pour la faire partir, en ralentissant la luminosité baisse
      fille2.pause();
      fille2.rewind();
      println("NON");
      erreur = false;
      validplaying = true;
    } else if (lum <= 600  && fille2.isPlaying() == false  && millis() - s <=4000) {
      // baisser la jauge
      fille2.pause();
      println("OUI");
      fille2.rewind();
      validplaying = false;
      erreur = true;
    }
  }



  //CLOWN
   ////////////
   ///////////
   
   //////////// on gère l'arrivée du clown
   
  
   
   //println("h " +h);
   if ( millis()<60000) {   //
   // hazard = int(random(30000));
   hazard = 21;
   } else if (millis() >= 60000) {    // au bout de 1minute de jeu le clown arrive
   hazard = int(random(20));
   }
   else if (millis() >= 120000) {   // au bout de 2minute de jeu le clown arrive plus souvent
   hazard = int(random(15));
   }
   
   
   println("hazard :", hazard, " _ ", millis(),  track2.isPlaying() );
   
   
   if (hazard == 0 && track2.isPlaying() == false) {    // si hazard tombe sur 0 alors le clown se déclanche
   track2.play(); 
   m = millis();
   
   println("ça joue ou bien?");
   //previousMillis = currentMillis;
   //isplaying = false;
   erreur = false;
   validplaying = false;
   } 
   
   else if (millis() - m >= 6000 && track2.isPlaying() == true ) { /////////////////// on gère la jauge si la personne n'arrive pas à le stopper, même système que la petite fille
   malus.play();
   malus.rewind();
   println("m=" + m);
   if (validplaying == false) {
   score = score - 100;
    score =  ledBrightness;
   println("score:" + score);
   } else if (erreur == true) {
   score = score - 100;
    score =  ledBrightness;
   } 
   track2.pause();
   track2.rewind();
   erreur = false;
   }
   
   
   ////////////// on gère l'interaction pour le stopper, même système que la petite fille
   songo = map(arduino.analogRead(4), 0, 512, 0, 1000); // ici on map les valeur du sons
   println("songo : " + songo);
   //println("m=" + m);
   if (songo >= 1000 &&  track2.isPlaying() == true && millis() - m <= 6000 ) {
   
   track2.pause();
   track2.rewind();
   //println("NON");
   erreur = false;
   validplaying = true;
   } else if (songo >= 1000  && track2.isPlaying() == false  && millis() - m <=6000) {
   // baisser la jauge
   track2.pause();
   println("OUI");
   track2.rewind();
   validplaying = false;
   erreur = true;
   }


  //LES MONSTRES
  ////////////    // c le même système que le clown, sauf que à la place de klaxonner on va à droite ou à gauche pour les éviter
  ///////////


  //MONSTRES DROITE   
   ////////////
   ///////////
   
   if ( millis()<120000) {
   y = 21;
   }  else if (millis() >= 120000) {// les monstres s'ajoutes au bout de deux minutes de jeu
   y = int(random(100));
   }
   
   
   
   //println( "random " + d);
   if (y == 0 && track4d.isPlaying() == false) {  
   track4d.play();
   
  a = millis();
   
   println("ça joue ou bien?");
   erreur = false;
   validplaying = false;
   } 
   
   ////////////// on gère la jauge
   
   else if (millis() - a >= 5000 && track4d.isPlaying() == true ){
     malus.play();
    malus.rewind();
   if (validplaying == false){    
   score = score - 100;
   println("score:" + score);
    score =  ledBrightness;
   }
   else if (erreur == true) {
   score = score - 100;
    score =  ledBrightness;
   } 
   track4d.pause();
   track4d.rewind();
   erreur = false;
   }
   
   
   ////////////// on gère l'interaction pour le stopper
   println("droite "+ arduino.digitalRead(4));
   if (arduino.digitalRead(4) == Arduino.HIGH &&  track4d.isPlaying() == true && millis() - a <= 5000 ) {   // si le joueur a bien tourner du bon côté et que le son se joue 
   println("droite "+ arduino.digitalRead(4));  
   track4d.pause();    // alors le son s'arrête
   track4d.rewind();
   println("NON");
   erreur = false;
   validplaying = true;
   }
   
   
   else if (arduino.digitalRead(4) == Arduino.HIGH && track4d.isPlaying() == false  && millis() - a <= 5000) {   // si la personne a fait une erreur alors elle perd des points
   // baisser la jauge
   track4d.pause();
   println("OUI");
   track4d.rewind();
   validplaying = false;
   erreur = true;
   } 
   
   //MONSTRE GAUCHE   // même sytème avec le droite mais il faisait planter tout le jeu donc nous avons décider de l'enlever pour que le jeu soit fonctionnel
   ////////////
   /*//////////
   
   
   if ( millis()<120000) {
  
   d = 21;
  
   }  else if (millis() >= 120000) {
   d = int(random(20));
   }
     println("d :", d, " _ ", millis(),  track4g.isPlaying() );
    
   //println( "random " + d);
   if (d == 0 && track4g.isPlaying() == false) {  
   track4g.play(); 
   b = millis();
   
   println("ça joue ou bien?");
   //previousMillis = currentMillis;
   //isplaying = false;
   erreur = false;
   validplaying = false;
   }
   
   ////////////// on gère la jauge
   
   else if (b >=10000 && track4g.isPlaying() == true ){
     malus.play();
              malus.rewind();
   if (validplaying == false){
   score = score - 100;
    score =  ledBrightness;
   println("score:" + score);
   }
   else if (erreur == true) {
   score = score - 100;
    score =  ledBrightness;
    
   } 
   track4g.pause();
   track4g.rewind();
   erreur = false;
   }
   //////ça plante
   
   ////////////// on gère l'interaction pour le stopper
   //songo = map(arduino.analogRead(0), 0, 512, 0, 1600);
   //println("songo : " + songo);
   
   println("gauche "+ arduino.digitalRead(4));
   if (arduino.digitalRead(4) == Arduino.HIGH &&  track4g.isPlaying() == true && millis() - b <= 7000 ) {
   println("gauche "+ arduino.digitalRead(4));
   track4g.pause();
   track4g.rewind();
   println("NON");
   erreur = false;
   validplaying = true;
   }
   
   
   else if (arduino.digitalRead(4) == Arduino.HIGH && track4g.isPlaying() == false  && millis() - b <= 7000) {
   // baisser la jauge
   track4g.pause();
   println("OUI");
   track4g.rewind();
   validplaying = false;
   erreur = true;
   }*/
 if (millis()>175000){    // si la personne arrive  2m55 de jeu le son de victoire se joue
     finpositif.play();    
   exit();
 }

  if (millis()>180000){   // le jeu s'arrête
   
   exit();
 }
 
 if (score <= 100){  // si le score va en dessous de 100 le son de fin négative se joue
    finnegatif.play();
  
 }
 
 if (score <= 0){  // quand le score est à 0 alors on sort du jeu  
    
   exit();
 }


  ledBrightness = int(map(score, 0, 1200, 0, 255));   // le map pour la luminosité de la jauge
  arduino.analogWrite(ledPin, ledBrightness);         // on affiche ledBrightness à chaque tour de jeu
  
}
