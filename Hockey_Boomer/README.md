# Hockey Boomer

Ce projet a été réalisé par Basile Bellanger, Elliot Chevalier, Ronan Chopineaux et Noémie El Kholti. Il est encadré par l'Ecole de design Nantes Atlantique. 

## Hockey Boomer

Hockey-Boomer est un jeu de réactivité, où deux joueurs s'affrontent. A l'aide d'un casque qui contrôle la crosse, ils doivent marquer le plus de points possible en rentrant le palet dans la zone d'embut. Selon que le joueur incline la tête à droite ou à gauche il peut se déplacer sur le terrain pour taper le palet et l'envoyer vers la zone d'embut. Lorsque 10 points sont marqués par un joueur, la partie est finie. 

Le principe du Hockey-boomer est le mélange d'un Pong et du hockey sur glace.  Nous avons souhaité donné une ambiance de rétro gaming des années 80, afin de jouer sur la tradition des jeux d'arcade. C'est à l'aide des effets néon, du graphisme et des effets sonores que nous proposons cette atmosphère. 

![Hockey%20Boomer/88129403_631927267638070_6749168680459829248_n.png](Hockey%20Boomer/88129403_631927267638070_6749168680459829248_n.png)

## **Démarche**

Si la thématique du hockey est centrale dans notre jeu, nous avons en revanche réfléchi à plusieurs moyens pour que les joueurs puissent controler les crosses de hockey. 

Dans un premier temps, c'est autour de la voix que s'oriente notre idée, afin de jouer sur le mot "kara-hockey". Au delà des limitations techniques, la voix ne nous a pas semblé le controleur le plus intéressant à mettre en place.

Nous avons donc réfléchi à un autre moyen de détourner les crosses de hockey, notamment par l'idée du mouvement. 

Puisque le hockey est réputé assez violent, avec des affronts avec la tête, nous avons décidé de remplacer la crosse par des mouvements de tête. 

Cela nous a paru pertinent, car rajoute un côté burlesque et décalé à notre jeu. Ce ton volontairement kitsch, nous avons souhaité le retranscrire au travers de la scénographie (graphisme, sons) mais aussi au travers du nom du jeu, "HOCKEY BOOMER". 

En effet, nous avons réalisé des sons sur Ableton Live afin de renforcer notre univers. 

## Pitch contrôleur :

Les joueurs contrôlent le palet à l'aide d'un casque de hockey qu'ils vont enfiler avant de jouer. 

Nous utilisons des capteurs IMU pour profiter de l'accéléromètre et du gyroscope pour situer le joueur sur le terrain. 

En fonction des mouvements de tête que le joueur fait, il peut déplacer la crosse de hockey de haut en bas. 

Les capteurs IMU sont fixés sur les casques des joueurs pour éviter de restreindre leur mobilité.   

## Assemblage partie non électronique

![Hockey%20Boomer/Fichier_2.png](Hockey%20Boomer/Fichier_2.png)

- 1 : Boitier collé au casque contenant les capteurs IMU
- 2 : Casque de hockey que le joueur enfile

![Hockey%20Boomer/Fichier_3.png](Hockey%20Boomer/Fichier_3.png)

- Vidéo projecteur placé en vue zénithale pour projeter le jeu sur une surface plane

 

![Hockey%20Boomer/Zones_de_Patinoire.png](Hockey%20Boomer/Zones_de_Patinoire.png)

- Chaque joueur doit défendre son camp en renvoyant le palet. Le joueur déplace la tête de gauche à droite pour bouger la crosse.

## Liste de matériel :

- Arduino UNO   x 2
- 2 IMU
- 2 casques de Hockey sur Glace
- (4 capteurs de mouvement)
- 1 drap noir
- Carton plume (rambardes de sécurité de la patinoire)
- Papier plastifié (vitres de sécurité de la patinoire)
- 1 projecteur LG mini-beam
- 1 pied
- 1 Breadboard

## Assemblage partie électronique

![Hockey%20Boomer/Documentation-Gp10-Bellanger_Elkholti_Chevalier_Chopineaux_arcade_Schemacircuit.jpg](Hockey%20Boomer/Documentation-Gp10-Bellanger_Elkholti_Chevalier_Chopineaux_arcade_Schemacircuit.jpg)

[MPU-9250 et Arduino (IMU 9 axes)](https://lucidar.me/fr/inertial-measurement-unit/mpu-9250-and-arduino-9-axis-imu/)

## Code

Nous avons utilisé Arduino et Processing pour programmer notre jeu. Ci-dessous, il s'agit du code Processing permettant de contrôler les crosses de hockey. Nous nous sommes inspiré du système du pong pour réaliser le jeu. 
```java

    //Biblihotèques
    import processing.sound.*;
    import processing.video.*;
    import processing.serial.*;
    
    PImage bg;
    int y;
    
    // Create object from Serial class
    Serial arduino1;
    float a1x, a1y;
    float xRect1, yRect1;
    float buttonState;
    
    // Create object from Serial class
    Serial arduino2;  
    float a2x, a2y;
    float xRect2, yRect2;
    
    //Déclarations des raquettes
    PALET palet = new PALET();
    RAQUETTE gauche;
    RAQUETTE droite; 
    
    //Variable de jeu
    int mode_jeu = 0;
    boolean mode_init = false;
    boolean but = false;
    long but_time = 0;
    int score1 = 0;
    int score2 = 0;
    int score_max = 10;
    float xpos1, ypos1, xpos2, ypos2;
    long debut_de_la_fin = 0;
    
    //Déclarations des assets externe
    Movie accueilFilm;
    
    SoundFile sirene;
    SoundFile boomer;
    SoundFile crowd;
    SoundFile bandeson;
    
    
    
    //********************************************************************************************//
    
    void setup() {
    
      size(1920, 1080);
    
      // Connexion des ports à arduino
      printArray(Serial.list());
      String portName1 = Serial.list()[12];
      arduino1 = new Serial(this, portName1, 57600);
      arduino1.bufferUntil('\n');
      printArray(Serial.list());
      String portName2 = Serial.list()[11];
      arduino2 = new Serial(this, portName2, 57600);
      arduino2.bufferUntil('\n');
    
      bg = loadImage("fond terrain.jpg");
      background(0);
    
      // Upload de l'ecran d'accueil
      accueilFilm = new Movie(this, "Accueil.mp4");
      accueilFilm.loop();
    	//
    
    	// Création de deux objet de classe raquette
      gauche = new RAQUETTE(100, height/2);
      droite = new RAQUETTE(width-100, height/2);
    	//
    
    	// Upload du son
      sirene = new SoundFile(this, "sirene.wav");
      boomer = new SoundFile(this, "hockey-boomer.wav");
      crowd = new SoundFile(this, "crowd.wav");
      bandeson = new SoundFile(this, "bande son.wav");
    	//
    }
    
    void movieEvent(Movie m) {
      m.read();
    }
    
    //********************************************************************************************//
    
    void draw() {
      background(bg);
      fill(255);
    
      if (mode_jeu == 0) {      // Ecran de démarrage
        image(accueilFilm, 0, 0, width, height);
        if (bandeson.isPlaying() == false) bandeson.play();
        afficherTitre();
        initialiser();
        pushStart();
    
        // ********************************************************************
      } else if (mode_jeu == 1) { // Déroulement de la partie
        if (mode_init) { // A exécuter uniquement une fois en début de partie
          initialiser();
          mode_init = false;
          if (sirene.isPlaying() == false) sirene.play();
        }
    
        if (but) {
          if (millis() - but_time < 2000) {
            palet.x = width/2;
            palet.y = height/2;
            // son ? effet ?
          } else {
            palet.departDuCentre();
            palet.display();
            but = false;
            if (sirene.isPlaying() == false) sirene.play();
          }
        }
    
        //but = false;
        if (bandeson.isPlaying() == false) bandeson.play();
        afficherScore1();
        afficherScore2();
    
        //gauche.update((float)mouseX/(float)width);
        gauche.updateY(map(-a1x, -1, 1, 0, height));
        //gauche.updateX(map(-a1y, -1, 1, 0, width/2));
        gauche.display();
    
        //droite.update((float)mouseY/(float)height);
        droite.updateY(map(a2x, -1, 1, 0, height));
        //gauche.updateX(map(a2y, -1, 1, width/2, width));
        droite.display();
    
        if (!but) {
          palet.update();
          palet.display();
        }
    
        if (gauche.collision(palet.x, palet.y)) {
          palet.inverser();
        }
        if (droite.collision(palet.x, palet.y)) {
          palet.inverser();
        }
    
        if (palet.x < 0 && palet.y >= 270 && palet.y <= height-270) {  //Joueur2 marque
          score2 ++;
          if (boomer.isPlaying() == true) boomer.stop();
          if (boomer.isPlaying() == false) boomer.play();
          if (crowd.isPlaying() == true) crowd.stop();
          if (crowd.isPlaying() == false) crowd.play();
          palet.sens = 1;
          but = true;
          but_time = millis();
        }
    
        if (palet.x > width && palet.y >= 270 && palet.y <= height-270) { //Joueur1 marque
          score1 ++;
          if (boomer.isPlaying() == true) boomer.stop();
          if (boomer.isPlaying() == false) boomer.play();
          if (crowd.isPlaying() == true) crowd.stop();
          if (crowd.isPlaying() == false) crowd.play();
          palet.sens = -1;
          but = true;
          but_time = millis();
        }
    
        if (score1 == score_max || score2 == score_max) {
          debut_de_la_fin = millis();
          mode_jeu = 2;
        }
    
        // ********************************************************************
      } else if (mode_jeu == 2) { // Partie terminée
        afficherScore1();
        afficherScore2();
        afficherGagnant(score1, score2);
        if (sirene.isPlaying() == true) sirene.stop();
        if (sirene.isPlaying() == false) sirene.play();
        if (millis() - debut_de_la_fin > 5000) mode_jeu = 0;
      }
    }
    
    //********************************************************************************************//
    
    void initialiser() {
      score1 = 0;
      score2 = 0;
    }
    
    //********************************************************************************************//
    
    void afficherScore1() {
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(100);
      text(score1, width / 4, height/2);
    
      //translate(width / 4, height/2);
      //rotate(PI*0.5);
      //fill(255);
      //textAlign(CENTER, CENTER);
      //textSize(100);
      //text(score1, width / 4, height/2);
    }
    
    //********************************************************************************************//
    
    void afficherScore2() {
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(100);
      text(score2, width / 4 * 3, height/2);
    
      //translate(width / 4 * 3, height/2);
      //rotate(PI*0.5);
      //fill(255);
      //textAlign(CENTER, CENTER);
      //textSize(100);
      //text(score2, width / 4 * 3, height/2);
    }
    
    //********************************************************************************************//
    
    void afficherTitre() {
      fill(255);
      textSize(64);
      textAlign(CENTER, BOTTOM);
      textSize(50);
      text("Press Start button", width/2, height/2 + 250);
    }
    
    //********************************************************************************************//
    
    void afficherGagnant(int score1, int score2) {
      int max_partie = 0;
      int gagnant = 0;
      if (score1 > score2) {
        max_partie = score1;
        gagnant = 1;
      } else if (score1 < score2) {
        max_partie = score2;
        gagnant = 2;
      } else {
        max_partie = score1;
        gagnant = 3;
      }
      fill(255);
      textSize(48);
      textAlign(CENTER, BOTTOM);
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
    
    void pushStart() {
      if ((buttonState == 1) && ((mode_jeu == 0) || (mode_jeu == 2)) ) { // Début de la partie
        if (bandeson.isPlaying() == true) bandeson.stop();
        mode_init = true;
        mode_jeu = 1;
      }
    }
    
    //********************************************************************************************//
    
    void serialEvent (Serial port) {
    
      if (port == arduino1) {
        String inBuffer = port.readStringUntil('\n');
        if (inBuffer != null) {
          //println(inBuffer);
          String[] data1 = split(inBuffer, ',');
          if (data1.length == 10) {
            a1x = float(data1[0]);
            a1y = float(data1[1]);
            buttonState = float(data1[9]);
          }
        }
      } 
    
      if (port == arduino2) {
        String inBuffer = port.readStringUntil('\n');
        if (inBuffer != null) {
          //println(inBuffer);
          String[] data2 = split(inBuffer, ',');
          if (data2.length == 10) {
    
            a2x = float(data2[0]);
            a2y = float(data2[1]);
          }
        }
      }
    }
    
    //********************************************************************************************//
    
    void keyPressed() {
      if (((mode_jeu == 0) || (mode_jeu == 2)) ) { // Début de la partie
        mode_init = true;
        mode_jeu = 1;
      }
    }
```

La classe Palet

```java
    class PALET {
    //ses variables
      float x, y;
      float vx, vy;
      float sens = random (2);
    
      PALET() {
    //son comportement
        x= width*0.5;
        y= height*0.5;
        if (sens>1) {
          sens = 1;
        } else {
          sens = -1;
        }
        vx=10*sens;
        vy=(random(8, 12))*sens;
      }
    
    //ses fonctions
    
      void but() {
        x= width*0.5;
        y= height*0.5;
        vx=0;
        vy=0;
      }
    
      void update() {
    
        // Déplacer la bille
        x = x+(2*vx);
        y = y+(2*vy);
    
        //// Changer le déplacement de la bille si elle sort de la fenêtre
        if (x<0 || x>width) vx = -vx;
        if (y < 0 || y>height) vy=-vy;
      }
    
    
      void inverser() {
        vx = -vx;
      }
    
      void departDuCentre() {
        x= width*0.5;
        y= height*0.5;
        vx=8*sens;
        vy=(random(6, 10))*sens;
      }
    
    
      void display() {
        noStroke();
        fill(255);
        ellipse(x, y, 60, 60);
      }
    }
```

La class Raquette
```java
    class RAQUETTE {
      float x, y;
      int raqW = 30;
      int raqH = 300;
    
    
      RAQUETTE(float x_, float y_) {
        x = x_;
        y = y_;
      }
    
      void updateY(float positionY) {
        y = lerp(y, positionY, 0.1);  
        if  (y <= raqH/2) {
          y = raqH/2;
        } else if (y>=height-(raqH/2)) {
          y = height-(raqH/2);
        }
      }
      
    
      //void updateX(float positionX) {
      //  x = lerp(x, positionX, 0.1);  
      //  if  (x <= raqW/2) {
      //    x = raqW/2;
      //  } else if (x>=width-(raqW/2)) {
      //    x = width-(raqW/2);
      //  }
      //}
    
      void display() {
        fill(255);
        rectMode(CENTER);
        rect(x, y, raqW, raqH);
        rectMode(CORNER);
      }
    
      boolean collision(float px, float py) {
        // recoit les coordonnées du palet (px, py)
        // et cherche s'il est en collision avec la raquette
        boolean en_collision = false;
        if (px <= x+(raqW/2) && px >= x-(raqW/2) && py > y-(raqH/2) && py < y+(raqH/2)) en_collision = true;
        if (py <= y+(raqH/2) && py >= y-(raqH/2) && px > x-(raqW/2) && px < x+(raqW/2)) en_collision = true;
        return en_collision;
      }
    }
```

Remerciements : l'équipe encadrante de L'Ecole de design Nantes Atlantique, tout particulièrement à Pierre Commenge, Bérenger Recoules et Clément Gault.

Mentions spéciales à Raphaël Perraud et Théo Geiller pour leur aide précieuse en termes d'électronique et de code.