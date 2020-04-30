# Workshop Arcade & Atl Ctrl

Marie Jollivet - Solenn Jaunait - Clara Mahe - Alice Briolat

# Contexte

Travaillant entre interaction designer et game designer, nous devions en une semaine concevoir un jeu d'arcade avec sa borde. Lors de ce workshop, nous avons eu une réflexion portée autour de l'identité d'un jeu et de son contrôleur afin de proposer un jeu amusant et original.
Durant cette semaine, nous sommes passées par une étape d'idéation, pour en suite travailler de manière itérative permettant de progresser efficacement.

# Réflexion

Tout d'abord, nous nous sommes intéressées à la mécanique du jeu "TIC TAC BOUM", qui est basé sur le stress et la frustration. C'est cette approche que nous voulions développer pour notre jeu. Un jeu d'apparence simple à jouer, mais provoquant stress et discorde tel que le jeu "jungle speed". Notre première idée était de réaliser un volcan en éruption, où chaque joueur doit souffler pour éviter que la lave coule de son côté. Une fois la lave éteinte de son côté, elle se dirige de façon aléatoire sur un autre joueur. Comme dans le tic-tac boom, on retrouve un son qui s’accélère provoquant du stress aux joueurs. Cependant, un capteur de son n'est pas adapté à une salle d'arcade. Par conséquent, nous avons changé de direction pour nous rediriger vers l'univers de l'enfance et de ses cauchemars qui l'accompagnent. "Notre jeu" se présente sous forme d'un 1 VS 1 VS 1 VS 1, ce qui va accentuer un esprit de compétition. À l'écran sont représentés quatre chambres d'enfants. Un monstre rôde de chambres en chambres en passant par les placards et vous devez le faire fuir en lui donnant des baffes. Mais faites attention, il est tenace et ne partira pas si facilement !

## Fonctionnement du jeu

Les quatre joueurs incarnent des enfants dans leurs chambres respectives qui sont différenciées par leurs couleurs (bleu, jaune, rouge et verte). Lorsque que le monstre apparaît dans votre chambre vous devez le faire fuir. Pour cela, le joueur doit donner des baffes à travers la commode. Si vous ne le baffez pas assez vite, le monstre va grossir de plus en plus et vous aller perdre.

# Sources

Son : 

[https://www.purple-planet.com/](https://www.purple-planet.com/) (Ambiance)

[http://www.universal-soundbank.com/](http://www.universal-soundbank.com/) (Bruitage monstre)

 [https://fr.flossmanuals.net/processing/la-lecture-du-son/](https://fr.flossmanuals.net/processing/la-lecture-du-son/) (Integration code) 

Librairie code arduino : 

Wire.h
Adafruit_NeoPixel.h

Librairie code processing : 

ddf.minim

# Matériel

## Étape d'assemblage de la partie électronique

### Matériel :

- Carte arduino
- Capteur de flexion
- Cable
- Écran TV
- Ruban de LED

### Développement du jeu :

Nous avons commencé par diviser l'écran en quatre partie, qui correspondent chacune aux chambres. Puis, nous devions faire apparaître le monstre dans les chambres, et qu'il passe de zone en zone. Cependant, une fois le monstre battu, il ne doit pas revenir deux fois de suite dans la même chambre, cela permettra que les joueurs jouent à tour de rôle.
Pour battre le monstre, il faut lui donner des baffes. Nous avons choisi un capteur flex, ce qui permettra aux joueurs d'avoir une vraie sensation de donner des baffes au monstre. Nous devions connecter le capteur flex (arduino) au code processing. Ainsi, lorsque les joueurs donnent des baffes, le monstre diminue de taille. Dans le cas contraire, le monstre grossit et vous avez perdu, game over !
Lorsque le monstre apparaît dans une chambre, la zone où il se trouve est illuminée de la couleur correspondante à la chambre, permettant d'alerter le joueur que c'est bien son tour de le faire fuir.
Lorsque l'on rentre dans un jeu, une page d'accueil apparaît, permettant d'introduire le jeu et ses consignes. On y trouve également une indication pour lancer la partie. Pour lancer une partie, nous avons choisit de donner une première baffe !
Suite à cela, il a fallu définir le sound design permettant aux joueurs de se plonger dans l'univers de notre jeu. Une fois les sons trouvés, il a fallu les intégrer au code processing et les déclencher aux bons moments.

 

### Étape de montage connectivité :

![Workshop%20Arcade%20Atl%20Ctrl/Schema_arduino.png](Workshop%20Arcade%20Atl%20Ctrl/Schema_arduino.png)

Montage arduino reliant les led et le capteur flex

## Code Arduino

    #include <Wire.h>
    
    #include <Adafruit_NeoPixel.h>

Nous incluons le bibliothèque nécéssaire pour utiliser les différents capteurs : Le capteur de couleur (TCS34725) qui nous n’avons finalement pas utilisé ainsi que la bibliothèque permettant de gérer le ruban de LED (NeoPixel).

    float flex = analogRead(0);

Nous définissons une variable « flex » qui enregistrera les valeurs émises par not capteur Flex.

    String json;
      json = "{\"flex\":"; // on ajoute la première clé "flex"
      json = json + flex; // on ajoute la première valeur  
      json = json + "}";
      Serial.println(json);

De part « json » nous transmettons à Processing les valeurs de nous capteurs. Nous attribuons donc ici a json, les valeurs émises par le capteur flex qui nous permettront par la suite de developper les actions lié à ce capteurs et au monstre.

    if (val == 'R') {
        mesLeds(255, 0, 0);
      } else if (val == 'G') {
        mesLeds(0, 255, 0);
      } else if (val == 'B') {
        mesLeds(0, 0, 255);
      } else if (val == 'Y') {
        mesLeds(255, 255, 0);
      } else {
        mesLeds(255, 255, 255);
      }

A chaque chaine de caractère, nous associons une couleur que nous réutiliserons dans Processing pour allumer les LED de la bonne couleur, en fonction de la zone dans laquelle se trouve le monstre.

    void mesLeds(int r, int v, int b) {
      for (int i = 0; i < pixels.numPixels(); i++) { 
        pixels.setPixelColor(i, r, v, b);
      }
      pixels.show();
    }

De part cette fonction, nous indiquons au ruban de LED de quelle couleur il doit s’allumer. Les valeurs « r », « v », « b » sont émises par Processing et permettent d’allumer le ruban de LED en fonction de la zone dans laquelle le monstre se trouve.

# Code Processing

PARTIE 1

Premièrement on s’occupe du monstre, on déclare son image et une variable et une zone d’affichage.

    // On déclare l'image du monstre 
    float xpos, ypos, w, h ;
    int counter = 0 ;
    PImage monstreV2; 
    int zone_du_monstre;
    int zone_du_monstre_precedent;

- On initialise nos variables, dans le Setup

    monstreV2 = loadImage("monstreV2.png"); //Image monstre 
    zone_du_monstre = int(random(4)); //emplacement random du monstre
      changer_de_zone(zone_du_monstre);

Dans le draw, on affiche la créature. Nous reviendrons plus tard dans cette boucle pour la structure de notre jeu et l’interaction.

    // Afficher la creature
      imageMode(CENTER);
        image( monstreV2, xpos + 5, ypos + 5, tailleMonstre, tailleMonstre);

On définit une fonction, qui permet au monstre de s’afficher dans 4 zones différentes.

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

Ensuite on créer une autre fonction lui permettant de changer de zone de façon random en fonction de la zone ou il a été précédemment. Pour chaque zone nous associons une couleur que le ruban de LED affichera, par le biais de « myPort.write » qui communique directement avec Arduino.

A la fin de cette partie, nous retrouvons la notion de vitesse. En effet, a chaque fois que le monstre change de zone, la vitesse de grossissement de ce dernier augmente.

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
    ———————-

PARTIE 2

On affiche les images des chambres, les 4 zones deviennent visibles, le monstre se déplace dans le code précédent cette fois-çi il se déplacera dans 4 zones qui ont évolué graphiquement. On déclara les images des chambres.

    PImage chrouge; 
    PImage chbleu;
    PImage chvert;
    PImage chjaune;

Dans le Setup, on demande le chargement des images

    chrouge = loadImage("Rouge.jpg");
      chbleu = loadImage("Bleu.jpg");
      chvert = loadImage("Vert.jpg");
      chjaune = loadImage(« Jaune.jpg »);

On définit une nouvelle fonction appeler dessinerFond ou on lui demandera d’afficher les chambres selon la taille de notre écran.

    void dessinerFond() {
      // Afficher les chambres 
      imageMode(CORNER);
      image( chrouge, 0, 0, 960, 540); 
      image( chbleu, width/2, 0, 960, 540); 
      image( chvert, width/2, height/2, 960, 540); 
      image( chjaune, 0, height/2, 960, 540);
    }

PARTIE 3 : On va structurer nos draw. Le draw est structuré de tel sorte à proposer à l’utilisateur un mode de jeu d’introduction, le jeu et la game over. Le son sera également expliqué, car il est lié à la boucle draw.

Pour utiliser le son on utilise la bibliothèque minim qu’il faut télécharger et importer dans processing. Pour la structure du jeu on déclare un entier appelé « mode_jeu » celui-ci sera contraint à trois valeurs. Dans l’initialisation il a une valeur 0.

On indiquera également dans cette partie la taille du monstre, car il grossit en fonction d’une vitesse et l’avancé du joueur dans le jeu.

    import ddf.minim.*;                      
    Minim minim;
    int mode_jeu = 0;
    boolean mode_init = false; 
    long debut_de_la_fin = 0; 
    float vitesse = 0.15;
    float aug_vitesse = 0.20;
    int nbBaffes =0; // nombre de baff donné par le capteur flex
    float tailleMonstre = 150; // taille du monstre initiale
    float tailleMonstreMax = 300; // Taille du monstre maximale

On déclare nos sons, pour ensuite les utiliser dans le code.

    AudioPlayer track2;
    AudioPlayer track_monstre;
    AudioPlayer track_Gameover;
    AudioPlayer track_tictac;
    AudioPlayer track_ambiance;

Dans le Setup nous téléchargeons les sons,

    minim = new Minim(this);                            
      track2 = minim.loadFile("Ambiance_debutdejeu.mp3");  
      track_monstre = minim.loadFile("Sonmonstre.mp3"); 
      track_Gameover = minim.loadFile("Gameover.wav"); 
      track_tictac = minim.loadFile("tictac.wav");
      track_ambiance = minim.loadFile(« Ambiance_pendantjeu.mp3");

Dans le draw, tout le draw va être commenté ci-dessous. On fait une première partie, dis de mode jeu=0. C’est l’écran de démarrage, le jeu n’a pas commencé. On pourra afficher ce que l’on souhaite dans cette partie. Nous avons choisis d’afficher un cartel de présentation. Cependant si vous souhaitez afficher quelque chose comme nous, il vous faudra définir une fonction afficherkartel plus bas dans le code. Il suffit après de l’appeler dans la draw.

    if (mode_jeu == 0) {        // Ecran de démarrage
        afficherKartel();
        if (track2.isPlaying() == false) {
          track2.rewind();
          track2.play();
          track_ambiance.pause();
        } 
        depart_partie();

Ensuite, on fait une deuxième partie dis de mode_jeu=1. Qui constitue le déroulement de la partie. C’est ici que l’ensemble de notre jeu se joue. Faisant appelle à divers fonction que nous avons parlé ci-dessus. Certaines fonction n’ont pas été expliqué elles le seront pas la suite. Dans cette partie, le joueur doit vérifié des conditions.

Nous observons aussi que la taille du monstre varie dans cette partie. En effet, nous définissons un encadrement de valeurs émises par le capteur flex. Si le joueur joue en émettant une valeur se situant entre ces deux dernières, alors la taille du monstre diminue. Nous définissons aussi la taille des monstre qui évolue en fonction du temps : la taille du monstre augmente à une vitesse de 0.1.

Pour terminer, nous contraignons la taille de notre montre en 0 et 300 px, de sorte à ce qu’il y ai une condition de game over : si le joueur n’arrive pas à diminuer les taille du monstre avant que ce dernier n’atteigne 300px, alors c’est perdu.

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

Enfin la partie est dis en mode_jeu = 2 quand le joueur à perdu. Nous observons qu’il y a une condition, si le joueur perd alors le Game Over s’affiche sinon, la taille du monstre revient à 150px, lorsque ce dernier change de chambre.

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

Ensuite on fait appeler aux différents fonctions que nous avons utilisés dans le draw

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

PARTIE 4 : connexion avec Arduino

Pour récupérer les valeurs émises par la carte Arduino, nous avons utilisé la fonction serialEvent pour que Processing récupère les données d’Arduino ainsi que la variable « json » qui, comme expliqué dans le code Arduino, transmets les valeurs de Processing à Arduino pour le ruban de LED par exemple.

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

## Étape d'assemblage de la partie non électronique

Matériel : 

- Carton
- Bois correspondant à la structure du meuble
- tissus
- Visse
- Équerre

### Développement de la structure :

Nous avons pensé à réaliser une commode, ce meuble est souvent présent dans la chambre d'un enfant, c'est aussi un meuble où l'on a peur d'y trouver la présence d'un monstre. Nous retrouvons ce meuble dans les illustrations des chambres.

Le meuble a une structure en bois permettant de solidifier l'ensemble, la structure est recouverte de carton. Nous avons réalisé une étagère permettant d'y mettre le système électronique et d'y déposer le capteur flex où l'on devra donner des baffes. 

Suite à cela, nous avons décoré l'ensemble pour appuyer notre univers et plonger le joueur, à l'aide de peluche, de livre, de figurine...

### Étape de montage de la borne :

![Workshop%20Arcade%20Atl%20Ctrl/Illustration_sans_titre_5.png](Workshop%20Arcade%20Atl%20Ctrl/Illustration_sans_titre_5.png)