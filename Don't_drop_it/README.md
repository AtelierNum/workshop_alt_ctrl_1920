[**home**](../README.md)

Le workshop Arcade est le fruit de la collaboration des élèves des filières Game Design et d'Interactivité à l'École de Design Nantes Atlantique.
Les élèves ont eut 5 jours pour réalisé une jeu d'Arcade avec une manette originale.

Voici le journal ainsi que la documentation du groupe 2 composé de
Carrère Yohan et Hugo Bochat en Game Design et de Sandevoir Marie et Gharbi Meriem en Intérativité. 

## Réflexions

La journée de Lundi a permis de former les idées et les groupes.
Dans un premier temps, par table il y a eu un brainstorming pour trouver des idées de “jeu d’arcade”, il  y a eu plusieurs idées. Mais une spécificité de notre table était que, même s’il y avait plusieurs personnes autours des sous-groupes “autonomes” se sont rapidement formés.

Le sous-groupe qui a eu l’idée “de voleur de parpin” se compose principalement des futurs membres du groupe 2 (Team Pink) Marie Sandevoir et Hugo Bochat et Meriem Gharbi.

Les premières idées du groupe se sont inspiré de jeux qui se composent de 
mini-jeux tels que *WarioWare* et *Dumb ways to die* le but étant de retrouver cet esprit de partie rapide qui donne sans cesse envie de rejouer.

L’idée la plus aboutit fut celle qui a été nommé “voleur de parpins”, le contrôleur original serait le parpin qui a la particularité d’être un objet lourd. Le joueur se devrait de le garder au maximum stable. Et pour corsé les choses, des difficultés s’ajouterait avec un jeu de rythme centré sur les jambes de l’utilisateur pour le déstabilisé et rendre la partie plus intéressante. 

La seconde idée moins aboutit était de reprendre l’illustre jeu snake et de créer un contrôleur pas pratique. Le partie prit est de rendre le moins facile possible l’interaction avec la manette.

Après la phase de brainstorming, les groupes et sous-groupes ont présentés leurs idées à toutes la classes. Les idées n’était pas un propriété du groupe mais de la classe, ce qui a permis aux élèves de choisir des concepts qui leur plaisaient.
Il y a eu en tout 26 idées, beaucoup trop pour les 12 groupes maximum. C’est pourquoi, nous avons d'abord procédé à un vote préliminaire pour garder les idées qui aurait le plus de chance de former des groupes.

A l’issu de ce vote l’idée de snake a malheureusement pas “survécu” et le voleur de parpin c’est à son instar imposé.

Ensuite, les groupes finaux se sont formés dans la partie “postit” de la journée. En effet, les élèves devait coller un post it avec leurs noms et le coller au tableau sur l’idée de jeu qui leurs plaisait le plus. On retrouve le sous-groupe fondateur de l’idée, c’est à dire Marie Sandevoir, Hugo Bochat et Gharbi Meriem et une nouvelle recrue Carrere Yohan.

C’est ainsi que l’aventure commença… 
L’idée de base assez bien pensée, la première étapes fut de créer une fiches sur laquelles on marquerait le matériel dont aurait besoins et les régles du jeu autrement “le game play”.

Les règles du jeux sont simples : 

Il y a 5 niveaux, avec des univers complètement différents. Mais pour gagner le principe reste le même. 
Il y a un objet lourd, le contrôleur dont une inclinaison maximum est autorisée. Si l’inclinaison max est dépassé le joueur a perdu toutes ses vies d’un coup.
Mais garder un objet en équilibre c’est simple, c’est pourquoi il fallait augmenter la difficulté, en déstabilisant l’utilisateur. C'est pourquoi, il devra avec ses jambes accomplir des actions tels rester à cloche pieds, lever les jambes et même sauter tout en gardant l’objet lourd dans les mains le plus stable possible. Pour le jeu de jambe du joueur, s'il rate une consigne donné par le jeu, il perdra une vie.
Le joueur a droit a 3 vie par partie, mais si l’incline trop l’objet ce sera mort subite.

Pour réaliser le jeu, nous avons utilisé [Processing](https://processing.org/) et [Arduino](https://www.arduino.cc/) dans la partie logiciel.
Toutefois, Il y a la possibilité de réalise le jeu avec [Unity](https://unity.com/) toujours accompagné d'Arduino mais on savait qu'on serait plus apte à recevoir l'aide des professeurs et encadrants avec Processing.

## Matériels

Avant de passé à la partie de l'assemblage, nous allons couvrir la partie matériel.

Dans un premier temps, il faut faire le choix du logiciel pour nous allons utilisé, comme nous l'avons cité un peu plus haut, nous allons porté notre choix sur Processing pour codé les règles du jeux et Arduino pour la partie éléctronique.

Pour notre controller/ manette nous aurons besoin d'un objet lourd, dans notre cas il s'agit d'un carton épais sous forme cylindrique. Pour capter les mouvements, inclinaisons et accélérations nous avons placé un accéléromètre. 

*Il est important de prévoir un petit socle de carton solid, plastique ou de bois sous l'accéléromètre pour permettre son bon fonctionnement.*

Puis pour capter le mouvement des jambes nous avons placé deux capteurs à ultrasons. Un pour chaque jambes.

Il faudra de même une carte Arduino Uno et des cables de branchements long pour donner de l'espace à l'utilisateur.

Enfin, il faudra vous munir d'un écran pour l'arcade.

Dans le cas ou vous prévoyez de créer completement l'arcade, utilisé du carton ou du bois et de la peinture pour recréer la force ci-dessus. (conf image)

![Image Arcade modélisation 3D](https://drive.google.com/file/d/1JzruKDS-UItaviXCs5-kmMAAqHNz21Tm/view?usp=sharing)
## Étape d’assemblage

Puisqu'on nous étions en groupe de 4, nous avons d'abord procédé à une division des tâches.

Marie s'est occupé des illustrations, Hugo de forme physique de l'arcade, Yohan de la musique, des vidéos et de l'[attract mode](https://www.definitions.net/definition/attract%20mode) et Meriem du code.

Pour commencer, après avoir établit la liste du matériel nécéssaire, nous allons testé chaque composant individuellement sur Arduino.

Voici le code pour tester les deux capteurs ultrason : 
[code ultrason](https://drive.google.com/file/d/14BFB9vm4ptsEfmOVOLQM4yv8-S4kilfz/view?usp=sharing)

A présent nous allons voir le code pour tester l'accéléromètre : 
[Code accéléromètre](https://drive.google.com/file/d/1BkYRik-0ETc7ydXmBqkuJrWvFoqbOpVJ/view?usp=sharing)

Simultanément, il faudra entammer le travail d'illustration du personnage principal, 
et du background du niveau.
*Faite attention à la taille en pixel en hauteur de votre écran, si l'image est trop grande elle ne s'affichera pas.*

Maintenant il est temps d'assembler les deux codes pour en avoir qu'un seul, nous y ajouterons de même le code pour le bouton. 

[code arduino entier et final](https://drive.google.com/file/d/1iWInDk5A6a7LDm4aR-xwAsO3FoWtHjZW/view?usp=sharing)

Vous pouvez vous référez à l'image ci-dessous pour affectuer votre branchement final.

[schema montage arduino](https://drive.google.com/file/d/1kpBLHijQka-xGlTmeiCrhmGjL55-KSuE/view?usp=sharing)
 
 Maintenant que toute la partie sur Arduino est finit, nous allons passé à Processing.
 Dans un premier temps, nous allons créer le document et mettre les setup de base :

- Mettre l'écran en fullScreen();
- Ajouter l'image de fond 

Puis dans un second temps il faudra faire le lien entre les Arduino et Processing.

Pour enfin commencer à la coder les régles du jeu sur processing.
Sur cette [vidéo](https://drive.google.com/file/d/1gTuJQeP7eICAJcmlcecTsmUBkEzWgkEn/view?usp=sharing)  vous pourrez voir l'ensemble du code commenter, faite pause sur les parties que vous avez besoin de coder.


## Illustration, musique et attract mode

Concernant les illustrations, Marie les a toute réalisé à l'aide du logiciel d'illustrator et d'une tablette graphique.
Toutefois, nous nous sommes inspiré de certain visuel récolté sur freepik.

https://www.freepik.com/free-vector/animation-skeleton_1036094.htm

La musique du jeu a été créer par Yohan en utilisant FL studios.
Enfin l'attract mode a aussi été fait par Yohan utilisant illustrator et After Effects.

## Sources

Pour les sources, dans un premier temps nous avons utilisé les ressources de Berenger Recoules pour toute la partie arduino, 
vous pouvez la retrouver [ici](https://github.com/b2renger/Introduction_arduino#contenu)
Sur cette documentation les branchements et les codes sont expliqués pour chaque élément utilisé y sont détaillés.

Ensuite, pour toute la partie sur processing nous avons utilisé plusieurs sources, mais la plus importante fut celle de Pierre Commenge disponible sur le cloud de l'École de Design Nantes Atlantique.
Sur cette documentation, nous nous sommes inspiré de l'oragnisation pour le déroullement du jeu, ainsi que de la communication entre Arduino et Processing.

Nous avons aussi utilisé la page de référence de Processing disponible [ici](https://processing.org/reference/)
Et les exemples disponibles dans les librairies téléchargées.

Pour y accéder vous devez aller sur processing > fichier > Exemples > Livrairies > Choisir son exemple et le sélectionner.

## Les tests

Losqu'on a emtammé nos tests après le montage de l'arcade, on a remarqué que notre niveau était impossible à gagner si on effectue a dernière étape du jeu c'est à dire sauter avec les deux jambes en tenant l'objet avec l'accéromètre.
L'accéromètre remarque les changements d'inclinaison mais aussi les accélérations.
Par concéquent, losque le joueur saute avec le cotroller il perd automatiquement puisqu'il fait un mouvement avec une accélération forte et rapide.
Alors que s'il ne fait rien à la 3ème étape du jeu il perd une seule vie et gagne quand même.
On a trouver drole qu'il faille se laisser perdre pour gagner. Et on c'est dit qu'on allait jouer avec cette erreur de planification.
Il faudra que le joueur comprennent exactemment quand et comment il perd pour savoir comment gagner et jouer stratégiquement. 
En fin de compte, notre jeu d'arcade n'est pas jeu de rythme ou d'attention à l'inclinaison mais plutôt de savoir comment maîtriser ses vies et le controller et comme on dit en anglais "play by the rules". Il faut connaître les règles pour savoir comment les controuner.
---
[**home**](../README.md)






