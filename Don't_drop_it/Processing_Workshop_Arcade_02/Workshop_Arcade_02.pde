import processing.video.*;
import processing.serial.*;
import processing.sound.*;
import com.dhchoi.CountdownTimer;
import com.dhchoi.CountdownTimerService;

boolean DEBUG = false;

int x, y; // déclarer les variables de X et Y pour déplacer l'image

int trousse = 1015;
boolean actionTrousse = false;
int tube = 1800;
boolean actionTube = false;
int radioactif = 2680;
boolean actionRadioactif = false;
int collision_bonhomme = 250;

int intervalle = 3000;
CountdownTimer timer;
long debut_de_la_fin = 0;
long debut_partie = 0;

// Interactivité avec arduino
Serial arduino1;   // Déclarer l'objet série pour le premier arduino = accéléromètre
Serial arduino2;   // Déclarer l'objet série pour le second arduino = capteurs de distance ultrason
float ax, ay, az;  // valeurs de l'accéléromètre
float distance_gauche, distance_droite;
boolean bouton_start = false;

boolean Life1 = true;
boolean Life2 = true;
boolean Life3 = true;

float tolerance = 0.15;
boolean Life_orientation = true;
boolean fall_life = true;

PImage img;
PImage suck;
PImage win;
PImage regles;
PImage c;

SoundFile son_chirurgien;
Movie baboom;
Animation bonhomme;

/*
 mode_jeu = 0 -> attract mode             dure tant qu'on n'a pas appuyé sur start
 mode_jeu = 1 -> écran des règles de jeu  durée définie
 mode_jeu = 2 -> partie                   
 mode_jeu = 3 -> fin de partie win lose   durée définie avant de revenir à l'attract
 */
 
int mode_jeu = 0; // 

void setup() {

  // Création du image fond qui va défiler
  fullScreen();
  img= loadImage("Fichier_5.png");
  x = 0 ;
  pixelDensity(1);
  println(displayWidth, displayHeight);
  println(width, height);

  // Connexions des arduino sur les ports série
  printArray(Serial.list());             // Afficher sur la console la liste des ports série utilisés
  String nom_port_1 = Serial.list()[2];  // Attention à choisir le bon port série!
  arduino1 = new Serial(this, nom_port_1, 9600);
  arduino1.bufferUntil('\n'); 

  //importation des différentes images
  bonhomme = new Animation("frame", 7);
  son_chirurgien = new SoundFile(this, "chirurgien.wav");
  son_chirurgien.loop();
  baboom = new Movie(this, "truc.mp4");
  baboom.loop();
  suck = loadImage("you-suck.png");
  win = loadImage("you-win.png");
  regles = loadImage("regles.png");
  c = loadImage("c.png");

  // Création du timer
  timer = CountdownTimerService.getNewCountdownTimer(this).configure(100, intervalle);
  background(0);
}


void draw() {
  //

  if (mode_jeu == 0) { 
    background(0);//l'ATTRACT-MODE
    //if (bouton_start) {
    // mode_jeu = 1;
    debut_partie = millis();
    bouton_start = false;
    Life1 = true; 
    Life2 = true; 
    Life3 = true;
    Life_orientation = true;
    fall_life = true;
    actionTrousse = false;
    actionTube = false;
    actionRadioactif = false;
    debut_de_la_fin = 0;
    debut_partie = 0;

    x =  0;
    //}
    image(baboom, 0, 0, width, height); //Affcher la vidéo de l'attract Mode
  } else if (mode_jeu == 1) {    // ECRAN REGLES
    background(0);
    if (millis() - debut_partie > 8000) mode_jeu = 2;
    image(regles, 0, 0); //afficher image regles
    bouton_start = false;
  } else if (mode_jeu == 2) {    // PARTIE EN COURS

    //Déplacement de l'image de fond
    if (x + img.width > width ) { 
      x--; // x = x-1

      // Determiner position des obstacles dans le jeu
      trousse-- ;
      tube--;
      radioactif--;
    }

    //Nommer les axes de l'images X et Y pour son déplacement
    image(img, x, y);  

    //Nombre de vies restantes
    text(combien_de_vies_restent(), width-50, 200);
    image(c, 1750, 180, width/20, height/20);

    // Placement du bonhomme == personnage du jeu
    bonhomme.display(100, 470);


    // Regles du jeu --- le jeu de pied 

    // collision trousse avec timer action
    if (trousse - 50 <= collision_bonhomme && trousse >= collision_bonhomme) {
      if (actionTrousse == false) {
        timer.start();
        println("start timer");
      }
      actionTrousse = true;
    }
    if (actionTrousse == true) {
      if (timer.isRunning()) {
        fill(#0A3864);
        textSize(35);
        text("Lever la jambe droite", 800, width/2);
         
         // affichage graphique du temps restant du timer -- obstacle 1
        fill(#0A3864);
        arc(750, width/2, 50, 50, 0, 
          map(timer.getTimeLeftUntilFinish(), 3000, 0, 0, TWO_PI));
      } else {
        if (distance_droite < 25) { // Le pied est toujours = on n'a pas passé l'obstacle
          Life1 = false;           // alors on perd une vie
        }
        actionTrousse = false;
        timer.reset(CountdownTimer.StopBehavior.STOP_AFTER_INTERVAL);
      }
    }

    // collision tube avec timer action -- obstacle 2
    if (tube - 50 <= collision_bonhomme && tube >= collision_bonhomme) {
      if (actionTube == false) {
        timer.start();
        fill(0);

        println("start timer");
      }
      actionTube = true;
    }
    if (actionTube == true) {
      if (timer.isRunning()) {
        fill(#0A3864);
        textSize(35);
        text("Lever la jambe gauche", 800, width/2);
        fill(#0A3864);
        arc(750,width/2, 50, 50, 0, 
          map(timer.getTimeLeftUntilFinish(), 3000, 0, 0, TWO_PI));
        //println("timer");
      } else {
        if (distance_gauche < 25) { // Le pied est toujours = on n'a pas passé l'obstacle
          Life2 = false;           // alors on perd une vie
        }
        actionTube = false;
        timer.reset(CountdownTimer.StopBehavior.STOP_AFTER_INTERVAL);
      }
    }

// collision tube avec timer action -- obstacle 3

    if (radioactif - 50 <= collision_bonhomme && radioactif >= collision_bonhomme) {
      if (actionRadioactif == false) {
        timer.start();
        fill(0);

        println("start timer");
      }
      actionRadioactif = true;
    }
    if (actionRadioactif == true) {
      if (timer.isRunning()) {
        fill(#0A3864);
        textSize(35);
        text("Faites un petit saut", 800, width/2);
        fill(#0A3864);
        arc(750, width/2, 50, 50, 0, 
          map(timer.getTimeLeftUntilFinish(), 3000, 0, 0, TWO_PI));
        //println("timer");
      } else {
        if (distance_gauche < 25 && distance_gauche < 25) { // Les pieds sont toujours la = on n'a pas passé l'obstacle
          Life3 = false;           // alors on perd une vie
        }
        actionRadioactif = false;
        timer.reset(CountdownTimer.StopBehavior.STOP_AFTER_INTERVAL);
      }
    }

    ///////////////////
    // Règles du jeux -- jeu de main

    // ( Tester si l'objet est tombé! on verra si on en a besoin )

    // Perdre toutes les vies d'un coup si l'inclinaison est trop forte
    if (ax > abs(tolerance) ||  ay > abs(tolerance)) {
      Life1 = false; 
      Life2 = false; 
      Life3 = false;
    }


    if (!Life1 && !Life2 && !Life3) {
      mode_jeu = 3;
      debut_de_la_fin = millis();
    }

    if ( !(x + img.width > width)) { 
      mode_jeu = 3;
      debut_de_la_fin = millis();
    }

    /////////// you win & you loose ////////////
  } else if (mode_jeu == 3) {

    //if (bouton_start) {
    //  mode_jeu = 2;
    //} else {
    if (!Life1 && !Life2 && !Life3) {
      image(suck, 0, 0);
    } 
    if (Life1 || Life2|| Life3) { 
      image(win, 0, 0);
    }
    // if (millis() - debut_de_la_fin > 5000) {
    //  mode_jeu = 0;
    // }
  }
  //}


  ////////////////////
  if (DEBUG) {
    fill(100);
    textSize(24);
    text(ax, 20, 50);
    text(ay, 20, 80);
    text(distance_droite, 20, 110);
    text(distance_gauche, 20, 140);
    // text(az, 20, 110);
    text("vies " + combien_de_vies_restent(), 20, 170);
    text("mode_jeu " + mode_jeu, 20, 200);
  }
  ////////////////////
}

// Nombre de vies qui restent
int combien_de_vies_restent() {
  int vies = 0;
  if (Life1) vies ++;
  if (Life2) vies ++;
  if (Life3) vies ++;
  return vies;
}

//void keyPressed() {
void keyReleased() {
  if (key == ' ') {
    bouton_start = true;
    mode_jeu++;  
    if (mode_jeu >= 4) {
      mode_jeu = 0;
      Life1 = true; 
      Life2 = true; 
      Life3 = true;
      Life_orientation = true;
      fall_life = true;
      actionTrousse = false;
      actionTube = false;
      actionRadioactif = false;
      debut_de_la_fin = 0;
      debut_partie = 0;

      x =  0;
    }
  }
  if (key == 'd' || key == 'D') {
    mode_jeu = 3;
    Life1 = false; 
    Life2 = false; 
    Life3 = false;
    x = 0;
  }
}

// Connexion Arduino et Processing
// Réception des évènements sur les ports série
// les deux ports sont différenciés avant de traiter les données
void serialEvent (Serial port) {
  if (port == arduino1) {
    String inBuffer = port.readStringUntil('\n');
    if (inBuffer != null) {
      //println(inBuffer);
      String[] data1 = split(inBuffer, ','); //buffer les infos dont on a besoin
      if (data1.length == 5) {
        ax = float(data1[0]);
        ay = float(data1[1]);
        az = float(data1[2]);
        distance_droite = float(data1[3]);
        distance_gauche = float(data1[4]);
      }
    }
  } else if (port == arduino2) {
    String inBuffer = port.readStringUntil('\n');
    if (inBuffer != null) {
      //println(inBuffer);
    }
  }
}

// trucs nécessaires à l'éxecution des timers
void onTickEvent(CountdownTimer t, long timeLeftUntilFinish) {
  // timerCallbackInfo = "[tick] - timeLeft: " + timeLeftUntilFinish + "ms";
}

void onFinishEvent(CountdownTimer t) {
  // timerCallbackInfo = "[finished]";
}

void movieEvent(Movie m) {
  m.read();
}
