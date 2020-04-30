import processing.serial.*;                 // Librairie communication avec arduino 
import ddf.minim.*;                         // Librairie pour utiliser du son

Minim minim;

// On déclare nos sons           
AudioPlayer track2;
AudioPlayer track_monstre;
AudioPlayer track_Gameover;
AudioPlayer track_tictac;
AudioPlayer track_ambiance;

// On déclare l'image du monstre 
float xpos, ypos, w, h ;
int counter = 0 ;
PImage monstreV2;

// On déclare les images des chambres
PImage chrouge; 
PImage chbleu;
PImage chvert;
PImage chjaune;
PImage Kartel;

// On déclare la position du monstre par rapport au zone 
int zone_du_monstre;
int zone_du_monstre_precedent; 

Serial myPort;

int flex = 0; // valeur du capteur flex
int red = 0; // valeur du capteur de couleur
int green = 0; // valeur du capteur de couleur
int blue = 0; // valeur du capteur de couleur

float vitesse = 0.15;
float aug_vitesse = 0.20;

int nbBaffes =0; // nombre de baff donné par le capteur flex
float tailleMonstre = 150; // taille du monstre initiale
float tailleMonstreMax = 300; // Taille du monstre maximale

// On structure notre jeu selon trois mode ( départ, partie, fin )
int mode_jeu = 0;
boolean mode_init = false; 
long debut_de_la_fin = 0;


void setup() {
  size(1920, 1080);
  // Le son de début 
  minim = new Minim(this);                            
  track2 = minim.loadFile("Ambiance_debutdejeu.mp3");  
  track_monstre = minim.loadFile("Sonmonstre.mp3"); 
  track_Gameover = minim.loadFile("Gameover.wav"); 
  track_tictac = minim.loadFile("tictac.wav");
  track_ambiance = minim.loadFile("Ambiance_pendantjeu.mp3");

  //Connexion avec arduino
  printArray(Serial.list());
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');

  background(250, 250, 250);
  noStroke();
  monstreV2 = loadImage("monstreV2.png"); //Image monstre

  //Chargement image
  chrouge = loadImage("Rouge.jpg");
  chbleu = loadImage("Bleu.jpg");
  chvert = loadImage("Vert.jpg");
  chjaune = loadImage("Jaune.jpg");
  Kartel = loadImage("Kartel.jpg");

  zone_du_monstre = int(random(4)); //emplacement random du monstre
  changer_de_zone(zone_du_monstre);
}

void draw() {

 
  if (mode_jeu == 0) {        // Ecran de démarrage
    afficherKartel();
    if (track2.isPlaying() == false) {
      track2.rewind();
      track2.play();
      track_ambiance.pause();
    } 
    depart_partie();
 
 
  } else if (mode_jeu == 1) { // Déroulement de la partie
    if (mode_init) { // A exécuter uniquement une fois en début de partie
      mode_init = false;
    }
    dessinerFond();
    if (track_ambiance.isPlaying() == false) {
      track_ambiance.rewind();
      track_ambiance.play();
    }
    track2.pause();

    // Tester le capteur flex et définir la taille du monstre
    if (flex > 290 || flex < 170) {
      tailleMonstre -= 5; // Diminution de la taille du monstre
      
    }
    tailleMonstre += vitesse; /// 0.1 est la vitesse de grossisement du monstre
    tailleMonstre = constrain(tailleMonstre, 0, tailleMonstreMax); //La taille est contraite entre 0 et 300 pixels

    // La partie continue ? ou pas
    if (tailleMonstre >= tailleMonstreMax) {
      // le jouer a perdu 
      mode_jeu = 2;
      debut_de_la_fin = millis();
    } else if (tailleMonstre == 0) {
      changer_de_zone(zone_du_monstre);
      track_monstre.play();
    }  
    if (tailleMonstre >= tailleMonstreMax - 100) { 
      if (!track_tictac.isPlaying()) {
        track_tictac.play();
        
      }
    } 

    // Afficher la creature
    imageMode(CENTER);
    image( monstreV2, xpos + 5, ypos + 5, tailleMonstre, tailleMonstre);

    // Incrémenter le compteur
    counter ++ ;
    println("vitesse", vitesse);

   
  } else if (mode_jeu == 2) { // Partie terminée

    if (millis() - debut_de_la_fin < 5000) {
      println("perdu");
      afficherGAMEOVER(); 
      track_Gameover.play();
    } else {
      tailleMonstre = 150; 
      mode_jeu = 0;
    }
  }
  if (track_monstre.isPlaying() == false) {
    track_monstre.rewind();
  }
} // fin du draw()




//Déterminer zone possible en fonction de la précédente
void changer_de_zone(int zone_du_monstre) {
  switch(zone_du_monstre) {
  case 0:
    nouvelle_zone_au_hasard(1, 2, 3);
    break;
  case 1:
    nouvelle_zone_au_hasard(0, 2, 3);
    break;
  case 2:
    nouvelle_zone_au_hasard(0, 1, 3);
    break;
  case 3:
    nouvelle_zone_au_hasard(0, 1, 2);
    break;
  }
  tailleMonstre = 150;
} 

//Changement de zone random en fonction de la précédente
void nouvelle_zone_au_hasard(int a, int b, int c) { 
  float hasard = random(100);


  println("ancienne zone du monstre : " + zone_du_monstre);

  if (hasard < 33) zone_du_monstre = a; 
  else if (hasard > 33 && hasard < 66) zone_du_monstre = b;
  else zone_du_monstre = c;

  println("nouvelle zone du monstre : " + zone_du_monstre);

  switch(zone_du_monstre) {
  case 0:
    xpos = random(tailleMonstreMax/2, width/2 - tailleMonstreMax/2);
    ypos = random(tailleMonstreMax/2, height/2 - tailleMonstreMax/2);
    myPort.write('R');
    break;
  case 1:
    xpos = random(width/2 + tailleMonstreMax/2, width - tailleMonstreMax/2);
    ypos = random(tailleMonstreMax/2, height/2 - tailleMonstreMax/2);
    myPort.write('B');
    break;
  case 2:
    xpos = random(width/2 + tailleMonstreMax/2, width - tailleMonstreMax/2);
    ypos = random(height/2 + tailleMonstreMax/2, height -tailleMonstreMax/2);
    myPort.write('G');
    break;
  case 3:
    xpos = random(tailleMonstreMax/2, width/2 - tailleMonstreMax/2);
    ypos = random(height/2 + tailleMonstreMax/2, height - tailleMonstreMax/2);
    myPort.write('Y');
    break;
  }
  vitesse = vitesse + aug_vitesse ;
} 

//Connexion avec arduino
void serialEvent (Serial myPort) {
  try {
    while (myPort.available() > 0) {
      String inBuffer = myPort.readStringUntil('\n');
      if (inBuffer != null) {
        if (inBuffer.substring(0, 1).equals("{")) {
          JSONObject json = parseJSONObject(inBuffer);
          if (json == null) {
            //println("JSONObject could not be parsed");
          } else {
            // récupérer les données stockée dans le format json transmis via usb
            flex    = json.getInt("flex"); // on récupère la valeur correspondant à la clé "flex"
            red    = json.getInt("red"); // on récupère la valeur correspondant à la clé "red"
            green    = json.getInt("green"); // on récupère la valeur correspondant à la clé "green"
            blue    = json.getInt("blue"); // on récupère la valeur correspondant à la clé "blue"
          }
        } else {
        }
      }
    }
  } 
  catch (Exception e) {
  }
}

void dessinerFond() {
  // Afficher les chambres 
  imageMode(CORNER);
  image( chrouge, 0, 0, 960, 540); 
  image( chbleu, width/2, 0, 960, 540); 
  image( chvert, width/2, height/2, 960, 540); 
  image( chjaune, 0, height/2, 960, 540);
}

void afficherKartel() {
  imageMode(CORNER);
  image( Kartel, 0, 0, width, height);
}


void afficherGAMEOVER() {
  fill(255, 0, 0);
  textSize(150);
  textAlign(CENTER, BOTTOM);
  text("GAME OVER", width/2, height/2);
  textSize(40);
  text("Dans 5s une partie recommencera", width/2, height/2 + 30);
}

void  depart_partie() {
  if (flex > 290 || flex < 170) {
    mode_init = true;
    mode_jeu = 1;
    println("DEPART !!!!!", flex);
  }
}
