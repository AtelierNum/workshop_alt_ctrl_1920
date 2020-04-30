//Bibliothèque de gestion des capteurs Skywriter et RGB sensor.

#include <Wire.h>
#include "Adafruit_TCS34725.h"
#include <Adafruit_NeoPixel.h>


//Adafruit_TCS34725 tcs = Adafruit_TCS34725(TCS34725_INTEGRATIONTIME_50MS, TCS34725_GAIN_4X);

// On définit l'emplacement de nos composants
#define BROCHE_LED  2
#define NUMPIXELS   30

Adafruit_NeoPixel pixels = Adafruit_NeoPixel (NUMPIXELS, BROCHE_LED, NEO_GRB + NEO_KHZ800);

char val;

// On définit dans le setup nos composant
void setup() {
  Serial.begin(9600);
  pixels.begin();
  mesLeds(255, 255, 255);
  pinMode(BROCHE_LED, OUTPUT);
  while (!Serial) {};
  Serial.println("Hello world!");
  //Serial.println("Color View Test!");
}

// The commented out code in loop is example of getRawData with clear value.
// Processing example colorview.pde can work with this kind of data too, but It requires manual conversion to
// [0-255] RGB value. You can still uncomments parts of colorview.pde and play with clear value.


// Puisn On définit une valeur aux couleurs de nos LED
void loop() {
  if (Serial.available() > 0) {
    val = Serial.read();
  }
  
  float red, green, blue;
  float flex = analogRead(0);

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
 
  //tcs.setInterrupt(false);  // turn on LED

 // delay(60);  // takes 50ms to read

 // tcs.getRGB(&red, &green, &blue);

  //tcs.setInterrupt(true);  // turn off LED


  // construire une chaine de caractère par concatenation
  String json;
  json = "{\"flex\":"; // on ajoute la première clé "photor1"
  json = json + flex; // on ajoute la première valeur  
  json = json +",\"red\":"; // on ajoute la seconde clé "photor2"
  json = json +  int(red);// on ajoute la seconde valeur  
  json = json +",\"green\":"; // on ajoute la seconde clé "photor2"
  json = json +  int(green);// on ajoute la seconde valeur  
  json = json +",\"blue\":"; // on ajoute la seconde clé "photor2"
  json = json +  int(blue);// on ajoute la seconde valeur  
  json = json + "}";
  Serial.println(json);
}


void mesLeds(int r, int v, int b) {
  for (int i = 0; i < pixels.numPixels(); i++) { // Le ruban prendra la couleur voulu
    pixels.setPixelColor(i, r, v, b);
  }
  pixels.show();
}
