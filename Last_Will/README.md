[**home**](../README.md)

## **Une dernière volonté ?**

![Readme%20WS%20Arcade/Screenshot_(39).png](Readme%20WS%20Arcade/Screenshot_(39).png)


### Par Mathilde Belvèze, Siloë Boiteau, Aurélien Colloc et Victor Pérouse

## **CONTEXTE**

Nous avons réalisé ce jeu dans le cadre du workshop "Arcade & Alt Ctrl (Alternative Controller)" en février 2020. il nous était demandé de concevoir une borne d'arcade la plus originale et amusante possible : *"le contrôleur, le gameplay et l’aspect graphique doivent sortir de l’ordinaire et casser les codes du jeu vidéo classique"*.

## **PRINCIPE DU JEU**

Notre jeu se base sur un principe très connu et emblématique des films de western : l'impasse mexicaine. Trois joueurs se font face, munis d’un pistolet chacun et d’une cible sur leur ceinture. Au top départ, ils choisissent un joueur à éliminer en visant sa boucle de ceinture. Le dernier joueur en vie gagne la partie → One man standing.

![Readme%20WS%20Arcade/Schema_Impasse.png](Readme%20WS%20Arcade/Schema_Impasse.png)

Principe d'une impasse mexicaine

## **GAMEPLAY**

- Les joueurs sont disposés en forme de triangle autour d'un coffre.
- Chacun une arme dans le holster, les bras légèrement écartés de la hanche : prêts à dégainer.
- Les 3 joueurs doivent attendre le départ sonore qui leur indique qu’ils peuvent tirer.
- Une fois que le signal sonore à retenti c'est la fusillade ! Les joueurs doivent être les plus rapides à éliminer leurs adversaires ou les plus agiles pour éviter de se faire toucher.
- Une LED de couleur est associée à chaque joueur, elle s'éteint lorsque celui-ci est touché.
- La partie s'arrête et le vainqueur est désigné lorsque sa LED est la dernière allumée.

![Readme%20WS%20Arcade/Screenshot_2020-03-06_at_19.03.20.png](Readme%20WS%20Arcade/Screenshot_2020-03-06_at_19.03.20.png)

---

## **MODE D'EMPLOI**

### **Mise en place du matériel**

D’abord, branchez la carte Arduino à un ordinateur. Ensuite, délimitez les emplacements des joueurs au sol si vous le souhaitez. Placez les lasers dans les emplacements dédiés sur les pistolets. Placez aussi les étoiles sur les ceintures, en faisant bien attention à ce que l’étoile soit bien tournée vers l’extérieur. Les trois joueurs, enfilent leur ceinture, toujours avec l’étoile tournée vers l’extérieur, et accrochent leur pistolet sur la bande de velcro à droite de leur ceinture. Enfin, les trois utilisateurs peuvent se placer en triangle autour du coffre. Les trois LED présentes sur le haut du coffre indiquent si le joueur qui porte la ceinture associée est toujours en vie.

### **Début du jeu**

Un joueur appuie sur le bouton présent sur la boîte pour dérouler les instructions. Le narrateur demande aux joueurs de s’équiper, ce qui est normalement déjà fait. Il faut appuyer une nouvelle fois sur le bouton pour lancer la partie. Les joueurs doivent attendre le troisième coup de cloche pour tirer. Les coups de cloche peuvent très bien retentir dès le début de la partie, il faut donc être attentif et se tenir prêt à tirer. Quand le troisième coup de cloche retentit, chaque joueur doit tirer sur un autre joueur pour l’éliminer et tenter d'esquiver le laser de ses adversaires.

---

## **MATÉRIEL UTILISÉ**

### Composants électroniques

- 1 Carte Arduino
- 1 Breadboard
- 1 Boutons
- 3 LED (1 par joueur)
- 3 photorésistances (1 par joueur)
- 4 Résistances de 10K Ohms
- Assez de fils pour brancher tous les composants  (compter 1-2 mètres pour les photorésistances chaque joueur)
- 1 Ordinateur
- 1 câble USB Type A → USB Type B (Ordinateur → Arduino)

![Readme%20WS%20Arcade/IMG_20200228_104427.jpg](Readme%20WS%20Arcade/IMG_20200228_104427.jpg)

### Composants tangibles

**Pour la borne :**

- Carton plume
- Carton épais
- Colle chaude
- Épingles
- Patafix
- Peinture en bombe et liquide

**Pour les armes :**

- 3 pointeurs laser
- Carton
- Carton ondulé
- Colle chaude

    ![Readme%20WS%20Arcade/IMG_20200226_174802.jpg](Readme%20WS%20Arcade/IMG_20200226_174802.jpg)

**Pour les ceintures :**

- Tissu épais (50-60 centimètre par ceinture)
- Velcro (50-60 centimètre par ceinture)
- Carton (Pour les étoiles de shérif)
- Fil de couture


    ![Readme%20WS%20Arcade/IMG_20200228_093854.jpg](Readme%20WS%20Arcade/IMG_20200228_093854.jpg)

    Étoile équipée d'une photorésistance à passer à la ceinture

---

## **DÉ**ROULEMEN**T DU PROJET**

Dans un premier temps nous avons réfléchi à l'aspect et au concept précis de notre jeu en énumérant les tâches nécessaires à sa réalisation et comment nous allions procéder pour les mener à bien. Une fois le concept bien défini nous avons divisé les tâches selon les facilitées de chacun au sein du groupe.

Afin de valoriser au mieux et d'optimiser la faculté d'immersion du jeu d'arcade, nous avons accentué la partie "hardware" en réalisant des pistolets, des ceintures, des cartouches de revolver et un boitier central en forme de coffre-fort permettant au joueur de se plonger totalement dans la peau de son personnage et l'ambiance "Far-West". Cette étape nous a permis de repenser notre jeu dans les détails car nous étions confrontés à des interrogations qui poussaient à réfléchir continuellement le concept.

Le sound design contribue également à l'immersion, nous avons créé les sons nous-même de façon à grossir le trait et donner une ambiance sonore, créer une tension entre les joueurs comme dans les vrais duels de cow-boys. Nous avons aussi enregistré des répliques qui servent d’instructions et viennent accentuer l’ambiance pesante qui règne.

Nous nous sommes ensuite attardés sur le software en réalisant nos fonctionnalités électroniques les unes après les autres. Cette partie s'est avérée plus laborieuse et complexe que les autres. Nous avons rencontré des problèmes pour lier toutes les fonctionnalités et superposer les sons de manière aléatoire, ce qui apporte beaucoup à l'immersion. Nous avons conçu notre jeu avec pour seule règle celle du "One man standing" : peu importe comment les joueurs/cowboys sont vaincus tant qu'ils sont vaincus. Il n'y a qu'un seul vainqueur et peu imposte s'il triche, c'est ça le far-west.

Une fois cette étape accomplie nous avons pensé les finitions avec la réalisation de la scénographie ainsi que sa mobilité et sa visibilité via des flyers disposés autour de la borne. Enfin nous avons assemblé toutes les parties ensemble et pré-testé notre jeu afin de relever les derniers détails a régler tels qu'un marquage au sol et un jeu de couleurs pour guider le joueur dans son expérience de jeu.

![Readme%20WS%20Arcade/D64E912E-44FF-4C16-9DED-40EBB8D93F12.jpeg](Readme%20WS%20Arcade/D64E912E-44FF-4C16-9DED-40EBB8D93F12.jpeg)

## **CONCEPTION DES PISTOLETS**

Pour la réalisation des pistolets nous avons opté pour le carton étant donné les contraintes de temps évidentes du workshop. Il nous fallait quelque chose de facile à travailler, en grande quantité et qui ne nécessitait pas trop de temps et de technique. Après avoir testé une V1 "Crash-test", L'inspiration pour les pistolets est venue au fur et à mesure de leur avancement grâce à des références de films et de jeux comme McCree de Overwatch, "le Bon, la Brute et le Truand" ou Red Dead Redemption. Nous les voulions différents les uns des autres à l'image de leurs personnages afin de scénariser le plus possible et donner de l'identité à notre jeu. Les pistolets sont inspirés de modèles d'armes existantes, certains détails sont exagérés pour accentuer le côté "Cartoonesque". L'emplacement ainsi que le système pour activer le laser ont été pensés sur le moment lors de la création des pistolets. pour des raisons de temps et de complexité technique nous avons pris le parti de ne pas les laisser le joueur presser une gâchette ou appuyer sur un bouton pour déclencher la lumière cela facilitant également le gameplay.

![Readme%20WS%20Arcade/Screenshot_2020-03-06_at_22.15.14.png](Readme%20WS%20Arcade/Screenshot_2020-03-06_at_22.15.14.png)

Quelques inspirations pour nos armes

![Readme%20WS%20Arcade/Screenshot_(43).png](Readme%20WS%20Arcade/Screenshot_(43).png)

2 de nos 3 armes réalisées entièrement en carton

---

## **SCHÉMA DU MONTAGE ÉLECTRONIQUE**

![Readme%20WS%20Arcade/Mathilde_Siloe_Aurelien_Victor_arcade_circuit.png](Readme%20WS%20Arcade/Mathilde_Siloe_Aurelien_Victor_arcade_circuit.png)

## **CODE**

Nous présentons ici le code commenté, étape par étape puis dans son entièreté.

Nous n'abordons pas le code Arduino puisqu'il s'agit de la librairie Firmata qu'il faut télécharger avant de téléverser le code StandardFirmata dans la carte.

Nous pouvons donc passer directement à Processing. Nous allons tout piloter, même la carte, depuis Processing.

### **1. Librairies et variables*

```java
 // Pour commencer, on importe nos librairies
 
 // Pour Arduino (Nous téléversons l'exemplStandardFirmata sur la carte Arduino poula controler avec Processing)
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
 ```

### **2. Setup**

```java
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
```

### **3. Lancement des instructions et de la partie**

```java
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
```
    

### **4. Lecture des sons d'ambiance**

```java
    void game() {
    
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
```

### **5. Gestion des photorésistances**

```java
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
```

### **6. Système de victoire**

```java
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
```

### **CODE COMPLET**

```java
    // Pour commencer, on importe nos librairies
    // Pour Arduino (Nous utilisons Firmata sur Arduino pour utiliser la carte avec Processing)
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
```

## **RÉSULTAT FINAL**

![Readme%20WS%20Arcade/IMG_20200227_202814.jpg](Readme%20WS%20Arcade/IMG_20200227_202814.jpg)

![Readme%20WS%20Arcade/Screenshot_(48).png](Readme%20WS%20Arcade/Screenshot_(48).png)

![Readme%20WS%20Arcade/Screenshot_(44).png](Readme%20WS%20Arcade/Screenshot_(44).png)

---

C'est tout pour nous ! Nous espérons que tout est clair et que ce protocole vous permettra de recréer et de vous approprier notre jeu. N'hésitez pas à nous contacter si vous rencontrez des difficulté ou si vous voulez partager votre version du jeu avec nous :

**Interaction Design :**

v.perouse@lecolededesign.com

a.colloc@lecolededesign.com

**Game Design :**

m.belveze@lecolededesign.com

s.boiteau@lecolededesign.com

Merci pour votre attention,

**Mathilde, Siloë, Aurélien et Victor**

[**home**](../README.md)