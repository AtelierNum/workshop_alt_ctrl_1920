
// prévenir que nous allons avoir besoin de ces bibliothèques
#include <Wire.h>
#include <ADXL345.h>

ADXL345 accel; // on crée un objet qui nous permet de manipuler les données provenant de notre acceleromètre

// la leds qui doit s'allumer seulement quand un pouvoir est disponible
int LED_1 = 12;

// les trois bonton qui nous donne acces a des pouvoir 
int BOUTON_1 = 6;
int BOUTON_2 = 4;
int BOUTON_3 = 2;

int timer = 5000;
int intervalle = 5000;

void setup() {
  Serial.begin(9600);

  accel.powerOn(); // on active notre capteur

  pinMode(LED_1, OUTPUT);

  pinMode(BOUTON_1, INPUT);
  pinMode(BOUTON_2, INPUT);
  pinMode(BOUTON_3, INPUT);
}

void loop() {
  
  String json;
  
  int x, y, z; // variable pour l'accéléromètre
  
  bool xb = false , yb = false , zb = false; // variable pour les boutons
  
  accel.readXYZ(&x, &y, &z); //on lit données de l'accéleromètre et on les stockent dans nos variables.
  
  if (millis() - timer > intervalle) { // intervalle bloquant les pouvoir des bouton pendant un certain temps 

    if (digitalRead(BOUTON_1) == HIGH) { // quand le bonton est enclencher on eteint la leds et on transmette que celui ci as été appuyer 
      digitalWrite(LED_1, LOW);
      xb = true;
      timer = millis();
    }
    else if (digitalRead(BOUTON_2) == HIGH) { // quand le bonton est enclencher on eteint la leds et on transmette que celui ci as été appuyer 
      digitalWrite(LED_1, LOW);
      yb = true;
      timer = millis();
    }
    else if (digitalRead(BOUTON_3) == HIGH) { // quand le bonton est enclencher on eteint la leds et on transmette que celui ci as été appuyer 
      digitalWrite(LED_1, LOW);
      zb = true;
      timer = millis();
    }
    else {
      digitalWrite(LED_1, HIGH); // Si aucun des bontons n'est appuyer on allume la led

  }
  else { // reinisialisation des valeurs des bontons
    xb = false;
    zb = false;
    yb = false;
  }
  // l'envoie du message des different valeurs des boutons et de l'accéléromètre en Json pour Unity
  json = "{";
  json = json + "\"XAccel\":";
  json = json + x;
  json = json + ",\"YAccel\":";
  json = json + y;
  json = json + ",\"ZAccel\":";
  json = json + z;
  json = json + ",\"XBut\":";
  json = json + xb;
  json = json + ",\"YBut\":";
  json = json + yb;
  json = json + ",\"ZBut\":";
  json = json + zb;
  json = json + "}";
  Serial.println(json);
}
