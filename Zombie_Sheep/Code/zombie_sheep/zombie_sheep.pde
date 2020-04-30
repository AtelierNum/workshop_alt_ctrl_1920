/**
 *  Buttons and bodies
 *
 *  by Ricard Marxer
 *
 *  This example shows how to create a blob.
 */

//importation des bibliothèques
import processing.sound.*;
import fisica.*;
import processing.serial.*;
Serial arduino1;

//déclaration de variable fisica
FWorld world;

//déclaration de variable son 
AudioIn input;
SoundFile zombie; // https://freesound.org/people/Draconihype/sounds/100369/?fbclid=IwAR1e0etwsiuXyYKgqEIXSvPfpEEWM5hrXTO3pElpX0NNIgWrBJ6uEWSokR4
SoundFile soundzombie1; //https://www.youtube.com/watch?v=wg8u3AQj1Ac

// déclaration de variable fisica 
FBlob b = new FBlob(); // on déclare notre blob : l'objet qui comporte nos moutons 

//déclaration des entier pour le nombre de moutons avec la création de deux tableau
int nbmouton = 0;
boolean[] mouton_dedans = new boolean[41]; 
boolean moutonNoir_dedans; 

//déclaration des positions random des moutons 
float xPos;
float yPos;

//déclaration des valeur de la gravité // pour controler le mouvement de nos moutons
float gravX_totale, gravY_totale;
float gravX_m, gravY_m;
float gravX_champ = 0;
float gravY_champ = 100;
float a;

//déclaration des valeur pour le mpr121 (arduino) ainsi que l'initialisation des valeurs pour savoir le nombre de touche sous forme de tableau
int[] touches = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
int frappes_max = 32;    
int[][] frappes = new int[12][frappes_max];
int frappes_compteur = 0;

//création variable image
PImage moutonBlanc1;
PImage moutonBlanc2;
PImage moutonBlanc3;
PImage moutonBlanc4;
PImage moutonBlanc5;
PImage moutonBlanc6;
PImage moutonBlanc7;
PImage moutonNoir;
PImage background;

PImage tetemoutonrouge;
PImage tetemoutonbleu;
PImage tetemoutonjaune;
PImage tetemoutonvert;

PImage intro;

PImage cotejaune;
PImage coterouge;
PImage cotebleu;
PImage cotevert;

PImage rougegagne;
PImage jaunegagne;
PImage bleugagne;
PImage vertgagne;

PImage rocher1;
PImage rocher2;
PImage rocher3;

//création de la police
PFont police;

//création de boolean
boolean arrayInitBool = true;
boolean arrayRemplirDeMouton = true;

//création d'un tableu 
ArrayList<FBlob> tousLesMoutons = new ArrayList<FBlob>();

//déclaration des scores
int scoreRouge = 0;
int scoreBleu = 0;
int scoreJaune = 0;
int scoreVert = 0;
//déclaration du mode de jeu
int mode_jeu = 0;
long debut_de_la_fin;

void setup() {
  //fullScreen();
  //initialisation des sons
  input = new AudioIn(this, 0);
  zombie = new SoundFile(this, "100369__draconihype__ghost.wav");
  soundzombie1 = new SoundFile(this, "sound01.wav");
  soundzombie2 = new SoundFile(this, "sound02.wav");

  size(600, 600); // taille de la fenetre
  smooth();

  // initialiser arduino
  printArray(Serial.list());             // Afficher sur la console la liste des ports série utilisés
  String nom_port_1 = Serial.list()[4];  // Attention à choisir le bon port série! 
  arduino1 = new Serial(this, nom_port_1, 9600);
  arduino1.bufferUntil('\n'); 
  
  //initialisation les images
  moutonNoir = loadImage("Asset Graphique Workshop Arcade_Mouton Zombi Noir Tête Yeux V2.png");
  background = loadImage("Asset Graphique Workshop Arcade_Background.png");

  tetemoutonrouge = loadImage("Asset Graphique Workshop Arcade_Tête Mouton Rouge.png");
  tetemoutonbleu = loadImage("Asset Graphique Workshop Arcade_Tête Mouton Bleu.png");
  tetemoutonvert = loadImage("Asset Graphique Workshop Arcade_Tête Mouton Vert.png");
  tetemoutonjaune = loadImage("Asset Graphique Workshop Arcade_Tête Mouton Jaune.png");

  moutonBlanc1 = loadImage("Asset Graphique Workshop Arcade_Mouton Zombi Blanc Tête Viande V2.png");
  moutonBlanc2 = loadImage("Asset Graphique Workshop Arcade_Mouton Zombi Blanc Tête Viande.png");
  moutonBlanc3 = loadImage("Asset Graphique Workshop Arcade_Mouton Zombi Blanc Tête Yeux V2.png");
  moutonBlanc4 = loadImage("Asset Graphique Workshop Arcade_Mouton Zombi Blanc Tête Yeux Viande.png");
  moutonBlanc5 = loadImage("Asset Graphique Workshop Arcade_Mouton Zombi Blanc Tête Yeux.png");
  moutonBlanc6 = loadImage("Asset Graphique Workshop Arcade_Mouton Zombi Blanc Tête.png");
  moutonBlanc7 = loadImage("Asset Graphique Workshop Arcade_Mouton Zombi Blanc.png");

  intro = loadImage("image00001.png");

  cotejaune = loadImage("Asset Graphique Workshop Arcade_Bergerie Jaune.png");
  coterouge = loadImage("Asset Graphique Workshop Arcade_Bergerie Rouge.png");
  cotebleu = loadImage("Asset Graphique Workshop Arcade_Bergerie Bleu.png");
  cotevert = loadImage("Asset Graphique Workshop Arcade_Bergerie Verte.png");

  rocher1 = loadImage("Asset Graphique Workshop Arcade_Rocher 1.png");
  rocher2 = loadImage("Asset Graphique Workshop Arcade_Rocher 2.png");
  rocher3 =loadImage("Asset Graphique Workshop Arcade_Rocher 3.png");

  rougegagne = loadImage("rougegagne.png");
  jaunegagne = loadImage("jaunegagne.png");
  bleugagne = loadImage("bleugagne.png");
  vertgagne = loadImage("vertgagne.png");

  //initialisation de la police
  police = createFont("Zumanie.otf", 100);

  Fisica.init(this); // on initialise fisica ici
  world = new FWorld(); 
  creerBordure(); // on crée les borbures et des obstacles qui encadrent nos moutons // toutes les zones où les moutons ne peuvent pas se déplacer 
}

void initialiser() { //réinitialisation du jeu 

  nbmouton = 0; // remettre le jeu à zéro avec le bon nombre de mouton
  arrayRemplirDeMouton = true;


  //world.remove(b);
  b = new FBlob();

  for (int i = 0; i < 41; i++) { 
    mouton_dedans[i] = false;
  }

  for (int i = 0; i < tousLesMoutons.size(); i++) { // Itérer sur chaque blob
    FBlob m = tousLesMoutons.get(i);
    world.remove(m);
  }
  for (int i = tousLesMoutons.size() - 1; i >= 0; i--) {
    //FBlob f = tousLesMoutons.get(i);
    tousLesMoutons.remove(i);
  }
  // remettre la gravité des moutons à 0  
  gravX_m = 0; 
  gravX_champ = 0;
  gravY_m = 0; 
  gravY_champ = 0;

  //remettre le score à 0
  scoreRouge = 0;
  scoreBleu = 0;
  scoreJaune = 0;
  scoreVert = 0;
}

void draw() {

  if (!zombie.isPlaying()) { // pour lire en boucle le théme musical
    zombie.play();
  }
  //Ecran d'intro avec la position du texte et la possibilité d'aller au jeu en touchant une zone
  if (mode_jeu == 0) { // ATTRACT MODE
    initialiser();
    image(background, 0, 0, width, height);
    image(intro, width/6, height/5);
    textFont(police, 30);
    textAlign(CENTER, CENTER);
    text("Toucher une touche pour commencer", width/2, 380);
    if (touches[0] == 1 || touches[1] == 1 || touches[2] == 1  || touches[3] == 1  || touches[4] == 1 || touches[5] == 1 || touches[6] == 1 || touches[7] == 1 || touches[8] == 1 || touches[9] == 1 || touches[11] == 1 || touches[11] == 1 ) {
      mode_jeu = 1;//aller au mode de jeu 1
    }
  } else if (mode_jeu == 1) { // PARTIE EN COURS
    dessinerPlateau();//aller à dessiner plateau

    if (arrayRemplirDeMouton) {  // remplissage du tableau suivant la valeur du nombre mouton
      mouton_dedans[nbmouton] = true;
      if (nbmouton == 1) { // on crée UN nouton noir
        yPos = random(250, 350); // le y des moutons varie entre 250 et 350 au début
        xPos = random(250, 350); // le x des moutons varie entre 250 et 350 au début
        // b.setVelocity(10, 10);
        b.setAsCircle(xPos, yPos, 6, 3); // valeur des cercles où les images de moutons sont collées dessus 
        b.setStroke(0);
        b.setStrokeWeight(2);
        b.setFill(0);
        b.setFriction(10);
        b.attachImage(moutonNoir);
        moutonNoir.resize(0, 50);
        world.add(b); 
      } else if (nbmouton < 5) { // on crée que des moutons blanc // Du mouton 0 à 5, les montons auront l'image 1
        tousLesMoutons.add(new FBlob());
        FBlob f = tousLesMoutons.get(tousLesMoutons.size()-1);
        yPos = random(150, 450 );
        xPos = random(150, 450);
        //b.setVelocity(10, 10);
        f.setAsCircle(xPos, yPos, 6, 3);
        f.setStroke(0);
        f.setStrokeWeight(2);
        f.setFill(255);
        f.setFriction(10);
        f.attachImage(moutonBlanc1);
        moutonBlanc1.resize(0, 40);
        world.add(f);
      } else if ( nbmouton >5 && nbmouton <11) { // on crée que des moutons blanc // Du mouton 6 à 11, les montons auront l'image 2
        tousLesMoutons.add(new FBlob());
        FBlob f = tousLesMoutons.get(tousLesMoutons.size()-1);
        yPos = random(150, 450 );
        xPos = random(150, 450);
        //b.setVelocity(10, 10);
        f.setAsCircle(xPos, yPos, 6, 3);
        f.setStroke(0);
        f.setStrokeWeight(2);
        f.setFill(255);
        f.setFriction(10);
        f.attachImage(moutonBlanc2);
        moutonBlanc2.resize(0, 40);
        world.add(f);
        }
      } else if ( nbmouton >11 && nbmouton<17) { // on crée que des moutons blanc // // Du mouton 12 à 17, les montons auront l'image 3
        tousLesMoutons.add(new FBlob());
        FBlob f = tousLesMoutons.get(tousLesMoutons.size()-1);
        yPos = random(150, 450);
        xPos = random(150, 450);
        //b.setVelocity(10, 10);
        f.setAsCircle(xPos, yPos, 6, 3);
        f.setStroke(0);
        f.setStrokeWeight(2);
        f.setFill(255);
        f.setFriction(10);
        f.attachImage(moutonBlanc3);
        moutonBlanc3.resize(0, 40);
        world.add(f);
      } else if ( nbmouton >17 && nbmouton<22) { // on crée que des moutons blanc // Du mouton 18 à 22, les montons auront l'image 4
        tousLesMoutons.add(new FBlob());
        FBlob f = tousLesMoutons.get(tousLesMoutons.size()-1);
        yPos = random(150, 450 );
        xPos = random(150, 450);
        //b.setVelocity(10, 10);
        f.setAsCircle(xPos, yPos, 6, 3);
        f.setStroke(0);
        f.setStrokeWeight(2);
        f.setFill(255);
        f.setFriction(10);
        f.attachImage(moutonBlanc4);
        moutonBlanc4.resize(0, 40);
        world.add(f);
      } else if ( nbmouton >22 && nbmouton<28) { // on crée que des moutons blanc // Du mouton 23 à 28, les montons auront l'image 5
        tousLesMoutons.add(new FBlob());
        FBlob f = tousLesMoutons.get(tousLesMoutons.size()-1);
        yPos = random(150, 450 );
        xPos = random(150, 450);
        //b.setVelocity(10, 10);
        f.setAsCircle(xPos, yPos, 6, 3);
        f.setStroke(0);
        f.setStrokeWeight(2);
        f.setFill(255);
        f.setFriction(10);
        f.attachImage(moutonBlanc5);
        moutonBlanc5.resize(0, 40);
        world.add(f);
      } else if ( nbmouton >28 && nbmouton <35) { // on crée que des moutons blanc // Du mouton 29 à 35, les montons auront l'image 6
        tousLesMoutons.add(new FBlob());
        FBlob f = tousLesMoutons.get(tousLesMoutons.size()-1);
        yPos = random(150, 450 );
        xPos = random(150, 450);
        //b.setVelocity(10, 10);
        f.setAsCircle(xPos, yPos, 6, 3);
        f.setStroke(0);
        f.setStrokeWeight(2);
        f.setFill(255);
        f.setFriction(10);
        f.attachImage(moutonBlanc6);
        moutonBlanc6.resize(0, 40);
        world.add(f);
      } else if ( nbmouton >35) { // on crée que des moutons blanc // Du mouton 35 à 40, les montons auront l'image 7
        tousLesMoutons.add(new FBlob());
        FBlob f = tousLesMoutons.get(tousLesMoutons.size()-1);
        yPos = random(150, 450 );
        xPos = random(150, 450);
        //b.setVelocity(10, 10);
        f.setAsCircle(xPos, yPos, 6, 3);
        f.setStroke(0);
        f.setStrokeWeight(2);
        f.setFill(255);
        f.setFriction(10);
        f.attachImage(moutonBlanc7);
        moutonBlanc7.resize(0, 40);
        world.add(f);
      }
      nbmouton++;
      if (nbmouton >= 41) {   // si la valeur nbmouton est égal ou supérieur à 41 alors arreter d'ajouter
        arrayRemplirDeMouton = false;
      }
    }

    // remplissage du tableau pour récuperer les vertex du mouton noir
    ArrayList mn = b.getVertexBodies();
    float mns = mn.size();
    float mnx = 0, mny = 0; 
    for (int j = 0; j < mns; j++) {
      FBody mnvf = (FBody)mn.get(j);
      mnx += mnvf.getX();
      mny += mnvf.getY();
    }
    mnx /= mns;
    mny /= mns;
    // Chercher les moutons qui sortent du pré
    for (int i = 0; i < tousLesMoutons.size(); i++) { // Itérer sur chaque blob
      FBlob m = tousLesMoutons.get(i);
      ArrayList mv = m.getVertexBodies();
      float mvs = mv.size();
      float mx = 0, my = 0;   // coordonnées du centre composé par les vertex
      for (int j = 0; j < mvs; j++) { // Itérer sur les vertex qui composent le blob
        FBody mvf = (FBody)mv.get(j);
        mx += mvf.getX();
        my += mvf.getY();
      }
      mx /= mvs;
      my /= mvs;
      //println("mouton n°" + i + " , coord. x : " + mx + " , coord. y : " + my); 

      if (mx > 558 && my > 240 && my < 360 ) {    // mouton OUT! rouge
        // si le mouton est dans la zone alors ajouter +1 à score rouge
        if (mouton_dedans[i]) {
          scoreRouge ++;
          println("scoreRouge :" + scoreRouge);
          world.remove(m);
          if (!soundzombie1.isPlaying()) { // pour lire en boucle le théme musical
            soundzombie1.play();
          }
        }
        mouton_dedans[i] = false;
        // world.remove();
      }
      if (mx > 240 && mx < 360 && my < 42 ) {    // mouton OUT! bleu
        // si le mouton est dans la zone alors ajouter +1 à score bleu
        if (mouton_dedans[i]) {
          // println("scoreb");
          scoreBleu ++;
          println("scoreBleu :" + scoreBleu);
          world.remove(m);
          if (!soundzombie1.isPlaying()) { // pour lire en boucle le théme musical
            soundzombie1.play();
          }
        }
        mouton_dedans[i] = false;
      }
      if (mx < 42 && my > 240 && my < 360) {    // mouton OUT!  vert
        // si le mouton est dans la zone alors ajouter +1 à score vert
        if (mouton_dedans[i]) {
          // println("scorev");
          scoreVert ++;
          println("scoreVert :" + scoreVert);
          world.remove(m);
          if (!soundzombie1.isPlaying()) { // pour lire en boucle le théme musical
            soundzombie1.play();
          }
        }
        mouton_dedans[i] = false;
      }
      if (my > 558 && mx > 240 && mx < 360) {    // mouton OUT!  jaune
        // si le mouton est dans la zone alors ajouter +1 à score jaune
        if (mouton_dedans[i]) {
          // println("scorej");
          scoreJaune ++;
          println("scoreJaune :" + scoreJaune);
          world.remove(m);
          if (!soundzombie1.isPlaying()) { // pour lire en boucle le théme musical
            soundzombie1.play();
          }
        }
        mouton_dedans[i] = false;
      }

      if (mnx > 558 && mny > 240 && mny < 360 ) {    // mouton noir zone rouge
        // si le mouton noir est dans la zone alors ajouter +1 à score rouge
        if (mouton_dedans[i]) {
          // println("scorer");
          world.remove(b);
        }
        mouton_dedans[i] = false;
        // world.remove();
      }

      if (mnx > 240 && mnx < 360 && mny < 42 ) {    // mouton noir zone bleu
        // Il se passe un truc avec le score
        if (mouton_dedans[i]) {
          // println("scoreb");
          world.remove(b);
        }
        mouton_dedans[i] = false;
      }
      if (mnx < 42 && mny > 240 && mny < 360) {    // mouton noir zone  vert
        if (mouton_dedans[i]) {
          // println("scorev");
          world.remove(b);
        }
        mouton_dedans[i] = false;
      }
      if (mny > 558 && mnx > 240 && mnx < 360) {    // mouton OUT!  jaune
        if (mouton_dedans[i]) {
          //println("scorej");
          world.remove(b);
        }
        mouton_dedans[i] = false;
      }

      if ((mny > 558 && mnx > 240 && mnx < 360) && scoreJaune>scoreRouge && scoreVert>scoreRouge && scoreBleu>scoreRouge ) {   //rouge gagne car mouton noir passe par jaune et score rouge est inférieur aux autre
        mode_jeu = 2;
      }
      if ((mnx < 42 && mny > 240 && mny < 360) && scoreJaune>scoreRouge && scoreVert>scoreRouge && scoreBleu>scoreRouge ) {    //rouge gagne car mouton noir passe par vert et score rouge est inférieur aux autre
        mode_jeu = 2;
      }
      if ((mnx > 240 && mnx < 360 && mny < 42) && scoreJaune>scoreRouge && scoreVert>scoreRouge && scoreBleu>scoreRouge ) {    //rouge gagne car mouton noir passe par bleu et score rouge est inférieur aux autre
        mode_jeu = 2;
      }

      if ((mny > 558 && mnx > 240 && mnx < 360) && scoreJaune>scoreBleu && scoreVert>scoreBleu && scoreRouge>scoreBleu ) {   //bleu gagne car mouton noir passe par jaune et score rouge est inférieur aux autre
        mode_jeu = 3;
      }
      if ((mnx < 42 && mny > 240 && mny < 360) && scoreJaune>scoreBleu && scoreVert>scoreBleu && scoreRouge>scoreBleu ) {    //bleu gagne car mouton noir passe par vert et score rouge est inférieur aux autre
        mode_jeu = 3;
      }
      if ((mnx > 558 && mny > 240 && mny < 360) && scoreJaune>scoreBleu && scoreVert>scoreBleu && scoreRouge>scoreBleu ) {    //bleu gagne car mouton noir passe par rouge et score rouge est inférieur aux autre
        mode_jeu = 3;
      }

      if ((mny > 558 && mnx > 240 && mnx < 360) && scoreJaune>scoreVert && scoreRouge>scoreVert && scoreBleu>scoreVert ) {   //vert gagne car mouton noir passe par rouge et score rouge est inférieur aux autre
        mode_jeu = 4;
      }
      if ((mnx > 240 && mnx < 360 && mny < 42) && scoreJaune>scoreVert && scoreRouge>scoreVert && scoreBleu>scoreVert ) {    //vert gagne car mouton noir passe par  et score bleu est inférieur aux autre
        mode_jeu = 4;
      }
      if ((mnx > 558 && mny > 240 && mny < 360) && scoreJaune>scoreVert && scoreRouge>scoreVert && scoreRouge>scoreVert ) {    //vert gagne car mouton noir passe par rouge et score jaune est inférieur aux autre
        mode_jeu = 4;
      }

      if ((mnx < 42 && mny > 240 && mny < 360) && scoreVert>scoreJaune && scoreRouge>scoreJaune && scoreBleu>scoreJaune ) {   //jaune gagne car mouton noir passe par rouge et score vert est inférieur aux autre
        mode_jeu = 5;
      }
      if ((mnx > 240 && mnx < 360 && mny < 42) && scoreVert>scoreJaune && scoreRouge>scoreJaune && scoreBleu>scoreJaune ) {    //jaune gagne car mouton noir passe par rouge et score bleu est inférieur aux autre
        mode_jeu = 5;
      }
      if ((mnx > 558 && mny > 240 && mny < 360) && scoreVert>scoreJaune && scoreRouge>scoreJaune && scoreRouge>scoreJaune ) {    //jaune gagne car mouton noir passe par rouge et score rouge est inférieur aux autre
        mode_jeu = 5;
      }

      //les trois joeurs gagne si ils ont le meme score

      if ((mny > 558 && mnx > 240 && mnx < 360) &&   scoreRouge==scoreBleu &&  scoreRouge==scoreVert && scoreVert==scoreBleu) {   //jaune gagne en passant par vert
        mode_jeu = 6;
      }
      if ((mnx < 42 && mny > 240 && mny < 360) &&   scoreRouge==scoreBleu &&  scoreRouge==scoreJaune  &&  scoreBleu==scoreJaune) {   //jaune gagne en passant par vert
        mode_jeu = 7;
      }
      if ((mnx > 240 && mnx < 360 && mny < 42 ) &&   scoreRouge==scoreVert &&  scoreRouge==scoreJaune   &&  scoreVert==scoreJaune) {   //jaune gagne en passant par vert
        mode_jeu = 8;
      }
      if ((mnx > 558 && mny > 240 && mny < 360 ) &&   scoreBleu==scoreVert &&  scoreBleu==scoreJaune &&  scoreVert==scoreJaune) {   //jaune gagne en passant par vert
        mode_jeu = 9;
      }

      //deux joueurs gagne car ils ont le meme score et ils sont differents des autres

      if ((mnx < 42 && mny > 240 && mny < 360 ) &&   scoreRouge==scoreBleu  &&   scoreRouge!=scoreJaune  &&   scoreRouge!=scoreVert &&   scoreJaune!=scoreVert &&   scoreBleu!=scoreJaune &&   scoreBleu!=scoreVert) {   //jaune gagne en passant par vert
        mode_jeu = 10;
      }
      if ((mny > 558 && mnx > 240 && mnx < 360) &&   scoreRouge==scoreBleu    &&   scoreRouge!=scoreJaune  &&   scoreRouge!=scoreVert  &&   scoreJaune!=scoreVert &&   scoreBleu!=scoreJaune &&   scoreBleu!=scoreVert) {   //jaune gagne en passant par vert
        mode_jeu = 10;
      }

      if ((mnx > 240 && mnx < 360 && mny < 42 ) &&   scoreRouge==scoreJaune    &&   scoreRouge!=scoreBleu  &&   scoreRouge!=scoreVert &&   scoreJaune!=scoreVert &&   scoreBleu!=scoreJaune &&   scoreBleu!=scoreVert) {   //jaune gagne en passant par vert
        mode_jeu = 11;
      }
      if ((mnx < 42 && mny > 240 && mny < 360) &&   scoreRouge==scoreJaune &&   scoreRouge!=scoreBleu  &&   scoreRouge!=scoreVert &&   scoreJaune!=scoreVert &&   scoreBleu!=scoreJaune &&   scoreBleu!=scoreVert) {   //jaune gagne en passant par vert
        mode_jeu = 11;
      }

      if ((mnx > 240 && mnx < 360 && mny < 42 ) &&   scoreRouge==scoreVert  &&   scoreRouge!=scoreBleu  &&   scoreRouge!=scoreJaune &&   scoreJaune!=scoreVert &&   scoreBleu!=scoreJaune &&   scoreBleu!=scoreVert) {   //jaune gagne en passant par vert
        mode_jeu = 12;
      }
      if ((mnx < 42 && mny > 240 && mny < 360) &&   scoreRouge==scoreVert  &&   scoreRouge!=scoreBleu  &&   scoreRouge!=scoreJaune &&   scoreJaune!=scoreVert &&   scoreBleu!=scoreJaune &&   scoreBleu!=scoreVert) {   //jaune gagne en passant par vert
        mode_jeu = 12;
      }

      if ((mnx > 558 && mny > 240 && mny < 360 ) &&   scoreBleu==scoreJaune    &&   scoreRouge!=scoreBleu  &&   scoreRouge!=scoreJaune &&   scoreJaune!=scoreVert &&   scoreRouge!=scoreVert &&   scoreBleu!=scoreVert) {   //jaune gagne en passant par vert
        mode_jeu = 13;
      }
      if ((mnx < 42 && mny > 240 && mny < 360) &&   scoreBleu==scoreJaune    &&   scoreRouge!=scoreBleu  &&   scoreRouge!=scoreJaune &&   scoreJaune!=scoreVert &&   scoreRouge!=scoreVert &&   scoreBleu!=scoreVert) {   //jaune gagne en passant par vert
        mode_jeu = 13;
      }

      if ((mnx > 558 && mny > 240 && mny < 360 ) &&   scoreBleu==scoreVert && scoreBleu!=scoreJaune    &&   scoreRouge!=scoreBleu  &&   scoreRouge!=scoreJaune &&   scoreJaune!=scoreVert &&   scoreRouge!=scoreVert) {   //jaune gagne en passant par vert
        mode_jeu = 14;
      }
      if ((mny > 558 && mnx > 240 && mnx < 360) &&   scoreBleu==scoreVert && scoreBleu!=scoreJaune    &&   scoreRouge!=scoreBleu  &&   scoreRouge!=scoreJaune &&   scoreJaune!=scoreVert &&   scoreRouge!=scoreVert) {   //jaune gagne en passant par vert
        mode_jeu = 14;
      }

      if ((mnx > 558 && mny > 240 && mny < 360 ) &&   scoreJaune==scoreVert && scoreBleu!=scoreJaune    &&   scoreRouge!=scoreBleu  &&   scoreRouge!=scoreJaune &&   scoreBleu!=scoreVert &&   scoreRouge!=scoreVert) {   //jaune gagne en passant par vert
        mode_jeu = 15;
      }
      if ((mnx > 240 && mnx < 360 && mny < 42) &&   scoreJaune==scoreVert && scoreBleu!=scoreJaune    &&   scoreRouge!=scoreBleu  &&   scoreRouge!=scoreJaune &&   scoreBleu!=scoreVert &&   scoreRouge!=scoreVert) {   //jaune gagne en passant par vert
        mode_jeu = 15;
      }
    }

    gravX_totale = cos(a)*25 + gravX_m;
    gravY_totale = sin(a) * 25 + gravY_m;

    a = a + 0.08;

    world.setGravity(gravX_totale, gravY_totale);
    world.step();
    world.draw();


    if (touches[0] == 1) {  //droite vert, 45° cote opposé vert
      gravX_m = 200; 
      gravX_champ = 200;
      gravY_m = 200; 
      gravY_champ = 200;
    }

    if (touches[1] == 1) { //milieu vert, cote opposé vert
      gravX_m = 200; 
      gravX_champ = 200;
    }
    if (touches[2] == 1) {  //gauche vert, -45° cote opposé vert
      gravX_m = 200; 
      gravX_champ = 200;
      gravY_m = -200; 
      gravY_champ = -200;
    }

    if (touches[3] == 1) {//droite rouge, 45° cote opposé rouge
      gravX_m = -200; 
      gravX_champ = -200;
      gravY_m = -200; 
      gravY_champ = -200;
    }
    if (touches[4] == 1) { //milieu rouge, cote opposé rouge
      gravX_m = -200; 
      gravX_champ = -200;
    }
    if (touches[5] == 1) { //gauche rouge, -45° cote opposé rouge
      gravX_m = -200; 
      gravX_champ = -200;
      gravY_m = 200; 
      gravY_champ = 200;
    }

    if (touches[6] == 1) {  //droite bleu, 45° cote opposé bleu
      gravX_m = -200; 
      gravX_champ = -200;
      gravY_m = 200; 
      gravY_champ = 200;
    }

    if ( touches[7] == 1) {  //milieu bleu, cote opposé bleu
      gravY_m = 200; 
      gravY_champ = 200;
    }
    if (touches[8] == 1) {  //gauche bleu, -45° cote opposé bleu
      gravX_m = 200; 
      gravX_champ = 200;
      gravY_m = 200; 
      gravY_champ = 200;
    }

    if (touches[9] == 1) {  //droite jaune, 45° cote opposé jaune
      gravY_m = -200; 
      gravY_champ = -200;
      gravX_m = 200; 
      gravX_champ = 200;
    }
    if (touches[10] == 1) {   //milieu jaune,  cote opposé jaune
      gravY_m = -200; 
      gravY_champ = -200;
    }
    if (touches[11] == 1) {   //gauche jaune, -45° cote opposé jaune
      gravY_m = -200; 
      gravY_champ = -200;
      gravX_m = -200; 
      gravX_champ = -200;
    }
  } else if (mode_jeu == 2) { // FIN DE PARTIE
    background(0);
    text("fin de partie. Qui a gagné ?", width/2, height/2);
  }

  //ecrant fin mode jeu 2
  if (mode_jeu == 2) { // ATTRACT MODE
    image(background, 0, 0, width, height);
    image(rougegagne, 0, 0, width, height);
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(400, 300);
    rotate(-PI/2);
    text("Toucher une touche pour recommencer", 0, 0);
    popMatrix();
    //recommencer une partie
    if ( touches[0] == 1 || touches[1] == 1 || touches[2] == 1  || touches[3] == 1  || touches[4] == 1 || touches[5] == 1 || touches[6] == 1 || touches[7] == 1 || touches[8] == 1 || touches[9] == 1 || touches[11] == 1 || touches[11] == 1 ) {
      mode_jeu = 0;
    }
  }
  //ecrant fin mode jeu 3
  if (mode_jeu == 3) { // ATTRACT MODE
    image(background, 0, 0, width, height);
    image(bleugagne, 0, 0, width, height);
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 200);
    rotate(PI);
    text("Toucher une touche pour recommencer", 0, 0);
    popMatrix();
    //recommencer une partie
    if ( touches[0] == 1 || touches[1] == 1 || touches[2] == 1  || touches[3] == 1  || touches[4] == 1 || touches[5] == 1 || touches[6] == 1 || touches[7] == 1 || touches[8] == 1 || touches[9] == 1 || touches[11] == 1 || touches[11] == 1 ) {
      mode_jeu = 0;
    }
  }
  //ecrant fin mode jeu 4
  if (mode_jeu == 4) { // ATTRACT MODE
    image(background, 0, 0, width, height);
    image(vertgagne, 0, 0, width, height);
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(200, 300);
    rotate(PI/2);
    text("Toucher une touche pour recommencer", 0, 0);
    popMatrix();
    // recommencer une partie
    if ( touches[0] == 1 || touches[1] == 1 || touches[2] == 1  || touches[3] == 1  || touches[4] == 1 || touches[5] == 1 || touches[6] == 1 || touches[7] == 1 || touches[8] == 1 || touches[9] == 1 || touches[11] == 1 || touches[11] == 1 ) {
      mode_jeu = 0;
    }
  }
  //ecrant fin mode jeu 5
  if (mode_jeu == 5) { // ATTRACT MODE
    image(background, 0, 0, width, height);
    image(jaunegagne, 0, 0, width, height);
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 400);
    rotate(2*PI);
    text("Toucher une touche pour recommencer", 0, 0);
    popMatrix();
    //recommencer une partie
    if ( touches[0] == 1 || touches[1] == 1 || touches[2] == 1  || touches[3] == 1  || touches[4] == 1 || touches[5] == 1 || touches[6] == 1 || touches[7] == 1 || touches[8] == 1 || touches[9] == 1 || touches[11] == 1 || touches[11] == 1 ) {
      mode_jeu = 0;
    }
  }
  //ecrant fin mode jeu 6
  if (mode_jeu == 6) { // ATTRACT MODE
    image(background, 0, 0, width, height);
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 200);
    rotate(2*PI);
    text("Rouge, Bleu et Vert ont gagne", 0, 0);
    popMatrix();
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 400);
    rotate(2*PI);
    text("Toucher une touche pour recommencer", 0, 0);
    popMatrix();
    //recommencer une partie
    if ( touches[0] == 1 || touches[1] == 1 || touches[2] == 1  || touches[3] == 1  || touches[4] == 1 || touches[5] == 1 || touches[6] == 1 || touches[7] == 1 || touches[8] == 1 || touches[9] == 1 || touches[11] == 1 || touches[11] == 1 ) {
      mode_jeu = 0;
    }
  }
  //ecrant fin mode jeu 7
  if (mode_jeu == 7) { // ATTRACT MODE
    image(background, 0, 0, width, height);
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 200);
    rotate(2*PI);
    text("Rouge, Bleu et Jaune ont gagne", 0, 0);
    popMatrix();
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 400);
    rotate(2*PI);
    text("Toucher une touche pour recommencer", 0, 0);
    popMatrix();
    //recommencer une partie
    if ( touches[0] == 1 || touches[1] == 1 || touches[2] == 1  || touches[3] == 1  || touches[4] == 1 || touches[5] == 1 || touches[6] == 1 || touches[7] == 1 || touches[8] == 1 || touches[9] == 1 || touches[11] == 1 || touches[11] == 1 ) {
      mode_jeu = 0;
    }
  }
  //ecrant fin mode jeu 8
  if (mode_jeu == 8) { // ATTRACT MODE
    image(background, 0, 0, width, height);
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 200);
    rotate(2*PI);
    text("Rouge, Vert et Jaune ont gagne", 0, 0);
    popMatrix();
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 400);
    rotate(2*PI);
    text("Toucher une touche pour recommencer", 0, 0);
    popMatrix();
    //recommencer une partie
    if ( touches[0] == 1 || touches[1] == 1 || touches[2] == 1  || touches[3] == 1  || touches[4] == 1 || touches[5] == 1 || touches[6] == 1 || touches[7] == 1 || touches[8] == 1 || touches[9] == 1 || touches[11] == 1 || touches[11] == 1 ) {
      mode_jeu = 0;
    }
  }
  //ecrant fin mode jeu 9
  if (mode_jeu == 9) { // ATTRACT MODE
    image(background, 0, 0, width, height);
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 200);
    rotate(2*PI);
    text("Bleu, Vert et Jaune ont gagne", 0, 0);
    popMatrix();
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 400);
    rotate(2*PI);
    text("Toucher une touche pour recommencer", 0, 0);
    popMatrix();
    //recommencer une partie
    if ( touches[0] == 1 || touches[1] == 1 || touches[2] == 1  || touches[3] == 1  || touches[4] == 1 || touches[5] == 1 || touches[6] == 1 || touches[7] == 1 || touches[8] == 1 || touches[9] == 1 || touches[11] == 1 || touches[11] == 1 ) {
      mode_jeu = 0;
    }
  }
  //ecrant fin mode jeu 10
  if (mode_jeu == 10) { // ATTRACT MODE
    image(background, 0, 0, width, height);
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 200);
    rotate(2*PI);
    text("Rouge et Bleu ont gagne", 0, 0);
    popMatrix();
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 400);
    rotate(2*PI);
    text("Toucher une touche pour recommencer", 0, 0);
    popMatrix();
    //recommencer une partie
    if ( touches[0] == 1 || touches[1] == 1 || touches[2] == 1  || touches[3] == 1  || touches[4] == 1 || touches[5] == 1 || touches[6] == 1 || touches[7] == 1 || touches[8] == 1 || touches[9] == 1 || touches[11] == 1 || touches[11] == 1 ) {
      mode_jeu = 0;
    }
  }
  //ecrant fin mode jeu 11
  if (mode_jeu == 11) { // ATTRACT MODE
    image(background, 0, 0, width, height);
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 200);
    rotate(2*PI);
    text("Rouge et Jaune ont gagne", 0, 0);
    popMatrix();
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 400);
    rotate(2*PI);
    text("Toucher une touche pour recommencer", 0, 0);
    popMatrix();
    //recommencer une partie
    if ( touches[0] == 1 || touches[1] == 1 || touches[2] == 1  || touches[3] == 1  || touches[4] == 1 || touches[5] == 1 || touches[6] == 1 || touches[7] == 1 || touches[8] == 1 || touches[9] == 1 || touches[11] == 1 || touches[11] == 1 ) {
      mode_jeu = 0;
    }
  }
  //ecrant fin mode jeu 12
  if (mode_jeu == 12) { // ATTRACT MODE
    image(background, 0, 0, width, height);
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 200);
    rotate(2*PI);
    text("Rouge et Vert ont gagne", 0, 0);
    popMatrix();
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 400);
    rotate(2*PI);
    text("Toucher une touche pour recommencer", 0, 0);
    popMatrix();
    //recommencer une partie
    if ( touches[0] == 1 || touches[1] == 1 || touches[2] == 1  || touches[3] == 1  || touches[4] == 1 || touches[5] == 1 || touches[6] == 1 || touches[7] == 1 || touches[8] == 1 || touches[9] == 1 || touches[11] == 1 || touches[11] == 1 ) {
      mode_jeu = 0;
    }
  }
  //ecrant fin mode jeu 13
  if (mode_jeu == 13) { // ATTRACT MODE
    image(background, 0, 0, width, height);
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 200);
    rotate(2*PI);
    text("Bleu et Jaune ont gagne", 0, 0);
    popMatrix();
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 400);
    rotate(2*PI);
    text("Toucher une touche pour recommencer", 0, 0);
    popMatrix();
    //recommencer une partie
    if ( touches[0] == 1 || touches[1] == 1 || touches[2] == 1  || touches[3] == 1  || touches[4] == 1 || touches[5] == 1 || touches[6] == 1 || touches[7] == 1 || touches[8] == 1 || touches[9] == 1 || touches[11] == 1 || touches[11] == 1 ) {
      mode_jeu = 0;
    }
  }
  //ecrant fin mode jeu 14
  if (mode_jeu == 14) { // ATTRACT MODE
    image(background, 0, 0, width, height);
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 200);
    rotate(2*PI);
    text("Bleu et Vert ont gagne", 0, 0);
    popMatrix();
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 400);
    rotate(2*PI);
    text("Toucher une touche pour recommencer", 0, 0);
    popMatrix();
    //recommencer une partie
    if ( touches[0] == 1 || touches[1] == 1 || touches[2] == 1  || touches[3] == 1  || touches[4] == 1 || touches[5] == 1 || touches[6] == 1 || touches[7] == 1 || touches[8] == 1 || touches[9] == 1 || touches[11] == 1 || touches[11] == 1 ) {
      mode_jeu = 0;
    }
  }
  //ecrant fin mode jeu 15
  if (mode_jeu == 15) { // ATTRACT MODE
    image(background, 0, 0, width, height);
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 200);
    rotate(2*PI);
    text("Jaune et Vert ont gagne", 0, 0);
    popMatrix();
    pushMatrix();
    textAlign(CENTER, CENTER);
    translate(300, 400);
    rotate(2*PI);
    text("Toucher une touche pour recommencer", 0, 0);
    popMatrix();
    //recommencer une partie
    if ( touches[0] == 1 || touches[1] == 1 || touches[2] == 1  || touches[3] == 1  || touches[4] == 1 || touches[5] == 1 || touches[6] == 1 || touches[7] == 1 || touches[8] == 1 || touches[9] == 1 || touches[11] == 1 || touches[11] == 1 ) {
      mode_jeu = 0;
    }
  }
}
// condition pour faire avancer les moutons dans le sens opposé de celui qui à tapper le plus vite
int somme_frappes(int numero_touche) {
  int somme = 0;
  for (int i = 0; i < frappes_max; i++) {
    somme += frappes[numero_touche][i];
  }
  return somme;
}

// mise en fonction du code arduino pour processing 
void serialEvent (Serial port) {
  if (port == arduino1) {
    String inBuffer = port.readStringUntil('\n');
    if (inBuffer != null) {
      String[] data = split(inBuffer, ',');
      if (data.length == 12) {
        frappes_compteur ++;
        if (frappes_compteur == frappes_max) frappes_compteur = 0;
        for (int i =0; i < 12; i++) {
          touches[i] = int(data[i]);
          frappes[i][frappes_compteur] = int(data[i]);
        }
      }
    }
  }
}

void creerBordure() {
  
  //création des obstacles 
  FPoly obstacle1 = new FPoly();
  obstacle1.vertex(150, 250);
  obstacle1.vertex(250, 300);
  obstacle1.vertex(300, 250);
  obstacle1.vertex(250, 200);
  obstacle1.vertex(200, 200); // coté
  obstacle1.setStatic(true);
  obstacle1.setFill(0, 0, 0, 0);
  obstacle1.setStroke(0, 0, 0, 0);
  obstacle1.setFriction(0);
  world.add(obstacle1);

  FPoly obstacle2 = new FPoly();
  obstacle2.vertex(400, 400);
  obstacle2.vertex(400, 450);
  obstacle2.vertex(450, 450);
  obstacle2.vertex(450, 400);
  obstacle2.vertex(400, 400); // coté
  obstacle2.setStatic(true);
  obstacle2.setFill(0, 0, 0, 0);
  obstacle2.setStroke(0, 0, 0, 0);
  obstacle2.setFriction(0);
  world.add(obstacle2);

  FPoly obstacle3 = new FPoly();
  obstacle3.vertex(400, 200);
  obstacle3.vertex(400, 250);
  obstacle3.vertex(450, 250);
  obstacle3.vertex(450, 200);
  obstacle3.vertex(400, 200); // coté
  obstacle3.setStatic(true);
  obstacle3.setStroke(0, 0, 0, 0);
  obstacle3.setFill(0, 0, 0, 0);
  obstacle3.setFriction(0);
  world.add(obstacle3);

  FPoly obstacle4 = new FPoly();
  obstacle4.vertex(200, 400);
  obstacle4.vertex(200, 450);
  obstacle4.vertex(250, 450);
  obstacle4.vertex(250, 400);
  obstacle4.vertex(200, 400); // coté
  obstacle4.setStatic(true);
  obstacle4.setFill(0, 0, 0, 0);
  obstacle4.setStroke(0, 0, 0, 0);
  obstacle4.setFriction(0);
  world.add(obstacle4);

  //création des bordure pour les barières
  FPoly lh = new FPoly(); // gauche haut
  lh.vertex(width/2.5, 0);
  lh.vertex(0, 0);
  lh.vertex(0, height/2.5);
  lh.vertex(width/10, height/2.5); // bas
  lh.vertex(width/10, height/10); // coté
  lh.vertex(width/10, height/10);
  lh.vertex(width/2.5, height/10);
  lh.setStatic(true);
  lh.setFill(0, 0, 0, 0);
  lh.setStroke(0, 0, 0, 0);
  lh.setFriction(0);
  world.add(lh);

  FPoly ll = new FPoly(); // gauche bas
  ll.vertex(width/1.75, 0);
  ll.vertex(600, 0);
  ll.vertex(width, height/2.5);
  ll.vertex(width-width/10, height/2.5); // bas
  ll.vertex(width-width/10, height/10); // bas
  ll.vertex(width-width/10, height/10); // coté
  ll.vertex(width/1.75, height/10);
  ll.setStatic(true);
  ll.setFill(0, 0, 0, 0);
  ll.setStroke(0, 0, 0, 0);
  ll.setFriction(0);
  world.add(ll);

  FPoly rh = new FPoly(); // droite haut
  rh.vertex(width/2.5, height); 
  rh.vertex(0, height);
  rh.vertex(0, height/1.75);
  rh.vertex(width/10, height/1.75);
  rh.vertex(width/10, height-height/10);
  rh.vertex(width/2.5, height-height/10);
  rh.setStatic(true);
  rh.setFill(0, 0, 0, 0);
  rh.setStroke(0, 0, 0, 0);
  rh.setFriction(0);
  world.add(rh);

  FPoly rl = new FPoly(); // droite bas
  rl.vertex(width/1.75, height);
  rl.vertex(width, height);
  rl.vertex(width, height/1.75);
  rl.vertex(width-width/10, height/1.75);
  rl.vertex(width-width/10, height-height/10);
  rl.vertex(width/1.75, height-height/10);
  rl.setStatic(true);
  rl.setFill(0, 0, 0, 0);
  rl.setStroke(0, 0, 0, 0);
  rl.setFriction(0);
  world.add(rl);
}

//création du plateau
void dessinerPlateau() {
  image(background, 0, 0, width, height);

  image(cotejaune, 65, 535, 470, 65);
  image(cotebleu, 65, 0, 470, 65);
  image(cotevert, 0, 65, 65, 470);
  image(coterouge, 535, 70, 65, 470);


  image(rocher1, 200, 200, 65, 65);
  image(rocher2, 200, 400, 65, 65);
  image(rocher3, 400, 200, 65, 65);
  image(rocher2, 400, 400, 65, 65);

  //position des images et des scores
  image(tetemoutonrouge, 550, 30, 35, 30);
  image(tetemoutonbleu, 30, 10, 30, 35);
  image(tetemoutonvert, 15, 540, 35, 30);
  image(tetemoutonjaune, 540, 555, 30, 35);

  textFont(police, 17);
  pushMatrix();
  textAlign(CENTER, CENTER);
  translate(570, 15);
  rotate(-PI/2);
  text(scoreRouge, 0, 0);
  popMatrix();

  pushMatrix();
  textAlign(CENTER, CENTER);
  translate(17, 30);
  rotate(PI);
  text(scoreBleu, 0, 0);
  popMatrix();

  pushMatrix();
  textAlign(CENTER, CENTER);
  translate(30, 585);
  rotate(PI/2);
  text(scoreVert, 0, 0);
  popMatrix();

  pushMatrix();
  textAlign(CENTER, CENTER);
  translate(585, 577);
  rotate(2*PI);
  text(scoreJaune, 0, 0);
  popMatrix();
}
