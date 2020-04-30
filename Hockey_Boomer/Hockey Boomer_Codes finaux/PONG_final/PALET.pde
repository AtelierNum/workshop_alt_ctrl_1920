class PALET {
  float x, y;
  float vx, vy;
  float sens = random (2);

  PALET() {

    x= width*0.5;              //Le palet part du centre
    y= height*0.5;
    if (sens>1) {              //Aléat du sens d'engagement au début de partie
      sens = 1;
    } else {
      sens = -1;
    }
    vx=12*sens;                //Paramétrage de la vitesse du palet
    vy=(random(10, 14))*sens;
  }

  void but() {                //Après un but : attente en position statique
    x= width*0.5;
    y= height*0.5;
    vx=0;
    vy=0;
  }

  void update() {            //Déplacement du palet

    x = x+vx;
    y = y+vy;

    if (x<0 || x>width) vx = -vx;    //Inversion du sens si le palet rencontre un obstacle
    if (y < 0 || y>height) vy=-vy;
  }


  void inverser() {    //Inversion du sens si le palet rencontre un obstacle
    vx = -vx;
  }

  void departDuCentre() {    //Départ du centre du terrain
    x= width*0.5;
    y= height*0.5;
    vx=12*sens;
    vy=(random(10, 14))*sens;
  }


  void display() {          //Affichage du palet, couleur, taille, forme
    noStroke();
    fill(255);
    ellipse(x, y, 60, 60);
  }
}
