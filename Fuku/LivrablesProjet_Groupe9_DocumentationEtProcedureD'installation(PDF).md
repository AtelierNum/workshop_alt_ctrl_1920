# FUKU 



# **Réflexion**

Notre idée initiale était de faire un jeu typiquement japonais (WTF), ou le but serait de soulever des jupes d'étudiantes japonaises.
Au fur et à mesure de notre réflexion, nous avons convenu qu'il serait intéressant d'y ajouter une pointe de masculinité avec des kilts. Pourquoi on souleverait toujours les jupes des filles, et pas des garçons ?
Nous avons donc ajouté à notre jeu, de nouveaux personnages, tel qu'un écossais, puis des hommes et des policiers pour le rendre plus complexe.
Pour ce qui est du controleur, beaucoup de changements on été réalisés. 
Nous voulions utiliser notre souffle, mais après un test, un mal de tête arrivait très vite. Ensuite, nous avions pensé à utiliser un seche cheveux, mais cela rapellait trop le thème du salon de coiffure. Nous avons alors cherché un nouvel objet, symbole du souffle et permettant de faire du vent. Nous avons trouvé un mini ventilateur, connectable à arduino et nous l'avons disposé dans un slider.

Pour l'installation, nous avons décidé de représenter un buisson dans lequel le joueur peut se cacher. Nous avons créé le buste et la jupe d'une femme, sous laquelle le joueur se tiendra. 


# **Scénario**

Imaginez, vous êtes dans la peau d'un voyeur qui passe sa journée dans un parc.
Une chose en particulier vous interesse, la diversité des culottes des jeunes japonaises. Pour cela, vous vous armez de votre meilleur allié: votre mini ventilateur !!
Cachez dans un buisson, vous tentez de souffler sous les jupes des filles sans vous faire remarquer. Attention, évitez les policiers, et ne soufflez pas sur les hommes.

Oh, un kilt ! 



# **Principe du jeu** 

Votre but avec Fuku est de souffler le plus longtemps possible sur de jeunes étudiantes japonnaises. Armez vous de votre mini ventilo et soulevez un maximum de jupes avant que la journée ne s’achève.


# **Gameplay**

**Controleur**: bougez de droite à gauche et appuyez sur le bouton pour souffler.

## **Les différents personnages** :

**Les étudiantes**: la cible
Soufflez sous leurs jupes mais attention, ne vous faites pas repérer !

**Les écossais**: le bonus
Les écossais sont les personnages les plus rares du jeu, si vous parvenez à leurs souffler dessus et soulever leur kilt, cela vous rajoute 30 secondes de temps.

**Les policiers**: le danger
Attention aux policiers, qui seront de plus en plus nombreux au fur et à mesure de votre progression. Arretez de soufffler sur les filles tant qu’ils sont visibles à l'écran. 

**Les hommes**: les obstacles
Ne soufflez pas sur les hommes, ils vous feront perdres des points ! 

> Plus les niveaux passent, plus la complexité augmente. Au fur et à mesure, il y aura plus d'hommes et de policiers, et les filles se retournerons plus vite.

> Le temps initial de la partie est de 2 min, et si par chance vous soulevez des kilts, votre temps est augmenté ( 30 secondes par kilt)




# **Matériel**
 - Carte Arduio Uno
   - capteur de distance ultrasonic
   - boutton pressoir
   - servomoteur avec hélice
   - cable d'alimentation : arduino-USB
 - écran en HDMI 1920 * 1080
   - cable HDMI
   - cable d'alimentation
 - PC ou Mac
   - cable d'alimentation
   - donc logiciel Unity et Arduino
 - Table basse
 - Structure de la borne
 - Multiprise avec ralonge
 - Panel avec le controlleur




# **Assemblage** 
## **Parties non électroniques**

 1. Prévoir un endroit en **coin de pièce** pour commencer l'installation de la borne.

 2. **Mise en place** de la table basse, mettre l'écran dessus, le PC en dessous.

 3. Poser par dessus la **structure** en carton.

 4. **Placer** devant l'écran le panel avec le controleur, et l'arduino derrière l'écran.

 5. Coller la **notice de jeu** au dessus de l'écran.
 
 


## **Parties électroniques**

6. Reproduire le **schéma électronique** (ci-joint)
 ![](schemacircuitelectro.png)


7. **Assembler et disposer** les éléments éléctroniques (arduino...) vers le controller et derrière l'écran.

8. Faire un trou à l'arrière du carton pour ensuite y passer les fils de l'écran et le cable d'alimentation.

9. Brancher le câble usb de la carte arduino à l'ordinateur (disposer sur le coté de la borne)et y **téléverser le code**.
