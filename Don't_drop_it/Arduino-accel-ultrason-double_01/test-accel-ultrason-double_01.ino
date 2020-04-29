// Ajouter les biliothèques qui manquent
#include <Wire.h>
#include <ADXL345.h>
#include "Ultrasonic.h"

//Variable pour l'inclinaison
double tolerance = 0.3;

// Déclarer les composants qu'on utilise
ADXL345 accel;
Ultrasonic ultrasonic (2);
Ultrasonic ultrasonic2 (5);

void setup() {
  Serial.begin(9600); // Définiton vitesse des infos
  accel.powerOn(); // On active notre capteur
}

void loop() {

  //Accélérémètres infos
  double xyz[3];
  accel.getAcceleration(xyz);

  // Ultrason Droit
  long RangeInCentimetersDR = ultrasonic.MeasureInCentimeters(); // mesurer la distance en cm
  //Serial.println(RangeInCentimetersDR);//0~400cm
  if (RangeInCentimetersDR < 25) {
    // Serial.println("le pied DROIT est détecté");
  } else {
    //Serial.println("le pied DROIT n'est pas détecté");
  }

  //Ultrason Gauche
  long RangeInCentimetersGA = ultrasonic2.MeasureInCentimeters(); // mesurer la distance en cm
  Serial.println(RangeInCentimetersGA);//0~400cm
  if (RangeInCentimetersGA < 25) {
    //Serial.println("le pied GAUCHE est détecté");
  } else {
    // Serial.println("le pied GAUCHE n'est pas détecté");
  }
  // delay(1000); // attendre un peu entre deux mesures.
 
 //Accéléromètre degrés
  Serial.print(xyz[0]);
  Serial.print(",");

  Serial.print(xyz[1]);
  Serial.print(",");

  Serial.print(xyz[2]);
  Serial.print(",");

  Serial.print(RangeInCentimetersDR);
  Serial.print(",");
  
  Serial.print(RangeInCentimetersGA);
  Serial.println();
  delay(50); 


  if (xyz[0] > tolerance) {
    //Serial.println("forward");
  } else if (xyz[0] < -tolerance) {
    //Serial.println("back");
  } else {
    // Serial.println("ok xy");
  }

  if (xyz[1] > tolerance) {
    //Serial.println("left");
  } else if (xyz[1] < -tolerance) {
    //Serial.println("right")
  } else {
    //serial.println("okey xy");
  }


}
