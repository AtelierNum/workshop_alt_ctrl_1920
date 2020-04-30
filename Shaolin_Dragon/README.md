[**home**](../README.md)

##   Shaolin Dragon

![Shaolin%20Dragon/gif_1.gif](Shaolin%20Dragon/gif_1.gif)

## Matériel nécessaire

**éléctronique :** 

- une carte arduino Uno
- des fils connecteurs
- des longs fils connecteurs (plus de 2 mètres de long)
- un capteur flex
- un accéléromètres
- un fer à souder et de l'étain

**logiciels:** 

- Unity
- Arduino IDE

**le reste:**

- 2 tables
- du carton, beaucoup de carton
- de quoi faire le rolla bolla, nous avons fait avec les moyens du bord. On a utilisé un cylindre trouvé que nous avons renforcé et des planches de bois que nous avons collées et vissées entre elles pour plus de solidité.
- de la ficelle et du gaffeur, nous en avons utilisé pour les nuages et pour assembler plus facilement notre scénographie.

## L'idée

Ce projet a été réalisé dans le cadre d'un séminaire d'une semaine. La constitution des groupes de travail s'est fait en générant d'abord des idées de projets pour qu'ensuite les élèves se regroupent autour des idées qui les intéresse. 

![Shaolin%20Dragon/IMG_3218.jpg](Shaolin%20Dragon/IMG_3218.jpg)

Le projet qui nous a réuni était l'idée d'utiliser un rolla-bolla (accessoire de cirque) comme controlleur pour jeu avec deux joueurs qui s'affronte, nous avions aussi pensé à utiliser un capteur flex faisant office de catapulte. 

Le concept de base était d'avoir un duel entre deux joueurs aux extrémités d'un écran mis à plat. 

![Shaolin%20Dragon/Sans_titre_-_1.png](Shaolin%20Dragon/Sans_titre_-_1.png)

L’idée était de faire un dodge game où l’on est sur un Rolla Bolla, et le but était d’esquiver les projectiles catapultés par un autre joueur.

Références : Space Invader, Space Harrier, Splash Bash (Wii Party, 1 VS 3), Dragon Ball.

Nous avons vite défini notre univers : Incarner un moine Shaolin qui évite la colère du dragon sacré. L’atmosphère graphique et l’ambiance sonore ramènent à un univers asiatique se référant à la mythologie chinoise : Le dragon chinois ainsi que le roi Singe Sun Wukong (les moines Shaolin s’inspirent de ce personnage pour leurs postures d’arts martiaux).

Nous avons opté pour un aspect *Pixel Art*, voici nos assets : 

![Shaolin%20Dragon/Capture_decran_2020-03-03_a_15.06.37.png](Shaolin%20Dragon/Capture_decran_2020-03-03_a_15.06.37.png)

## Mise en oeuvre

### controlleurs

Pour le controlleur du joueur incarnant le dragon nous avons imaginé un dragon à prendre en tre ses mains dont on titillerait la queue pour lui faire lancer des boules de feu dans le jeu. 

Nous l'avons sculpté dans du polystyrène en y intégrant à la place de la queue un potentiomètre doublé d'un capteur flex.

![Shaolin%20Dragon/Capture_decran_2020-03-03_a_15.18.03.png](Shaolin%20Dragon/Capture_decran_2020-03-03_a_15.18.03.png)

À l'origine nous avions prévu d'utiliser le potentiomètre pour gérer l'orientation du dragon mais nous l'avons finalement retiré du gameplay à cause de problèmes de communication entre ce controlleur et le reste du système. Pour remplacer le potentiomètre nous avons programmé le dragon de sorte à ce que son orientation change toute seule et continuellement. 

Pour le rolla bolla nous avons découpé une planche en forme de nuage que nous avons ensuite collé et vissé à d'autres planches pour plus de solidité. Nous avons aussi trouvé un cylindre que nous avons renforcé.

![Shaolin%20Dragon/IMG_1871.jpg](Shaolin%20Dragon/IMG_1871.jpg)

Nous l'avons ensuite peint et mis un peu de grip qu'on a découpé en forme d'emprunte de chaussure. 

![Shaolin%20Dragon/Capture_decran_2020-03-03_a_15.18.16.png](Shaolin%20Dragon/Capture_decran_2020-03-03_a_15.18.16.png)

### La scénographie

![Shaolin%20Dragon/Capture_decran_2020-03-03_a_15.19.14.png](Shaolin%20Dragon/Capture_decran_2020-03-03_a_15.19.14.png)

Concernant la scénographie nous voulions au départ utiliser un grand écran mais nous avons finalement préféré nous contraindre à utiliser deux écrans plus petits qui permettaient à eux deux d'avoir une grande plage d'affichage. Cette contrainte nous a poussé à être plus créatif, le fait d'utiliser deux écrans nous a donné une idée, celle qu'un des joueurs ne voit pas le contenu de l'autre. Nous avons ainsi décidé de donner un avantage au joueur incarnant le dragon en inclinant son écran de sorte à ce que le jouer incarnant le moine shaoline ne puisse voir comment les boules de feu lui sont lancé. 

![Shaolin%20Dragon/IMG_4194.jpg](Shaolin%20Dragon/IMG_4194.jpg)

Pour le décor nous avons utilisé comme matière première du carton. C'est une matière peu coûteuse et très facile à travailler. Nous avons découpé nos nuages dans des grandes planches et les avons suspendus à l'aide de deux fils que l'on a attaché aux écrans avec du Gaffer (scotch noir particulièrement robuste). On peut voir ci-dessous la structure (sans les nuages qui sont posés dessus) qui nous a permis d'incliner notre écran, trois ou quatre cales enfoncées dans une planche de carton ont suffit à faire tenir efficacement l'écran. 

![Shaolin%20Dragon/setup.jpg](Shaolin%20Dragon/setup.jpg)

Pour développer notre jeu, nous le testions d'abord sur la table de notre groupe en travaillant sur les deux écrans de sorte à pouvoir itérer notre jeu avant de les installer dans notre borne d'arcade. 

![Shaolin%20Dragon/unity.jpg](Shaolin%20Dragon/unity.jpg)

Voici ci-dessous les affiches et panneaux nous avons réalisé pour donner à envie aux passants de jouer et pour que les utilisateurs puissent s'approprier la borne de manière autonome : 

![Shaolin%20Dragon/Capture_decran_2020-03-03_a_19.07.42.png](Shaolin%20Dragon/Capture_decran_2020-03-03_a_19.07.42.png)

![Shaolin%20Dragon/Capture_decran_2020-03-03_a_19.07.30.png](Shaolin%20Dragon/Capture_decran_2020-03-03_a_19.07.30.png)

### L'éléctronique

Concernant l'éléctronique voici les branchements que nous avons effectué. Pour rappel, nous avons finalement décidé de ne pas exploiter le potentiomètre dans le jeu à cause de problèmes de connexion, il est donc inutile de le garder dans votre circuit éléctronique si vous comptez utiliser notre code Unity sans le modifier. 

![Shaolin%20Dragon/_.png](Shaolin%20Dragon/_.png)

Dans notre scénographie, notre carte arduino était direcement connecté à une unité centrale d'ordinateur qui servait à faire tourner le jeu. L'unité centrale et la carte arduino était positionnées en dessous d'une des tables. La carte arduino étant par ce fait particulièrement éloignée des controlleurs, il nous a fallut couper des longs fils de plus de 2 mètres pour être sûr de bien pouvoir connecter les différents composants.  

![Shaolin%20Dragon/fils.jpg](Shaolin%20Dragon/fils.jpg)

pour éviter que nos fils s'emmêle nous les avons "tressé" eutre eux(il serait plus juste de dire "emmêlé de manière méthodique"). Pour ne pas confondre les fils, nous les avons etiquetées à l'aide de scotch (voir ci-dessous) ce qui a été fort pratique. 

![Shaolin%20Dragon/IMG_3730.jpg](Shaolin%20Dragon/IMG_3730.jpg)


En vous souhaitant de belles parties, 

Célia Toupin, Allan Guégan, Léo Archer, Ulysse Ducamp

[**home**](../README.md)