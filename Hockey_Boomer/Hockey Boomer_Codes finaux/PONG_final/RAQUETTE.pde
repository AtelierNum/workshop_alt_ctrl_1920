class RAQUETTE {
  float x, y;
  int raqW = 30;
  int raqH = 300;


  RAQUETTE(float x_, float y_) {
    x = x_;
    y = y_;
  }

  void updateY(float positionY) {              //Positionnement en X
    y = lerp(y, positionY, 0.1);  
    if  (y <= raqH/2) {
      y = raqH/2;
    } else if (y>=height-(raqH/2)) {
      y = height-(raqH/2);
    }
  }
  

  //void updateX(float positionX) {            //Essai de positionnement en Y (pb de lerp rencontré : si la raquette est en déplacement, le palet passe à travers)
  //  x = lerp(x, positionX, 0.1);  
  //  if  (x <= raqW/2) {
  //    x = raqW/2;
  //  } else if (x>=width-(raqW/2)) {
  //    x = width-(raqW/2);
  //  }
  //}

  void display() {                             //Paramètres des raquettes
    fill(255);
    rectMode(CENTER);
    rect(x, y, raqW, raqH);
    rectMode(CORNER);
  }

  boolean collision(float px, float py) {      //Collision
    // On récupère les coordonnées du palet (px, py)
    // puis on cherche s'il est en collision avec la raquette
    boolean en_collision = false;
    if (px <= x+(raqW/2) && px >= x-(raqW/2) && py > y-(raqH/2) && py < y+(raqH/2)) en_collision = true;
    if (py <= y+(raqH/2) && py >= y-(raqH/2) && px > x-(raqW/2) && px < x+(raqW/2)) en_collision = true;
    return en_collision;
  }
}
