//Adafruit_MPR121.h
#include <Wire.h>
#include "Adafruit_MPR121.h"

#ifndef _BV
#define _BV(bit) (1 << (bit))
#endif

/*LED*/
int ledPin = 7;


/*MPR121(sensor)*/
Adafruit_MPR121 cap = Adafruit_MPR121();


// Garder la trace de la dernière pin touchée
uint16_t lasttouched = 0;
uint16_t currtouched = 0;

int touches[12];

void setup() {
  /*LED*/
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
  /*CAPTEUR MPR121*/
  Serial.println("Adafruit MPR121 Capacitive Touch sensor test");
  // Default address is 0x5A, if tied to 3.3V its 0x5B
  // If tied to SDA its 0x5C and if SCL then 0x5D
  if (!cap.begin(0x5A)) {
    Serial.println("MPR121 not found, check wiring?");
    while (1);
  }
  Serial.println("MPR121 found!");
}

void loop() {


  /*CAPTEUR SENS*/

  // Get the currently touched pads
  currtouched = cap.touched();

  // Remettre l'état des touches à zéro
  for (uint8_t i = 0; i < 12; i++) {
    touches[i] = 0;
  }

  // Chercher l'état des touches
  for (uint8_t i = 0; i < 12; i++) {  //Pour les capteurs de sens allant de 0 à 12
    //si il "est" touché et "n'est pas" touché avant : message d'alerte
    if ((currtouched & _BV(i)) && !(lasttouched & _BV(i))) {
      touches[i] = 1;
    }
    // si il "est" touché et maintenant "n'est pas" touché alors message d'alerte
    if (!(currtouched & _BV(i)) && (lasttouched & _BV(i)) ) {
      //Serial.print(i); Serial.println(" released");
    }
  }

  // Renvoyer le message contenant l'état des touches
  Serial.print(touches[0]);
  Serial.print(",");
  Serial.print(touches[1]);
  Serial.print(",");
  Serial.print(touches[2]);
  Serial.print(",");
  Serial.print(touches[3]);
  Serial.print(",");
  Serial.print(touches[4]);
  Serial.print(",");
  Serial.print(touches[5]);
  Serial.print(",");
  Serial.print(touches[6]);
  Serial.print(",");
  Serial.print(touches[7]);
  Serial.print(",");
  Serial.print(touches[8]);
  Serial.print(",");
  Serial.print(touches[9]);
  Serial.print(",");
  Serial.print(touches[10]);
  Serial.print(",");
  Serial.print(touches[11]);
  Serial.println();


  // reset our state
  lasttouched = currtouched;
  delay(10);
}
