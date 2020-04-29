import processing.serial.*;
Serial camPort;
Serial arduinoPort;

// timer
import com.dhchoi.CountdownTimer;
import com.dhchoi.CountdownTimerService;
CountdownTimer timer;
String timerCallbackInfo = "";

// SOUND DESIGN
import ddf.minim.*;
Minim minim;
AudioPlayer plop_1;
AudioPlayer plop_2;
AudioPlayer plop_3;
AudioPlayer plop_4;
AudioPlayer plop_5;
AudioPlayer plop_6;

// FISICA
import fisica.*;

FWorld world;
FBlob b;
FPoly obstacle, obstacle2, obstacle3, obstacle4;
FBox stamp_box, side, ground;
int circleCount = 20;
float hole = 200;
float topMargin = 50;
float bottomMargin = 300;
float sideMargin = 50;
float xPos = 0;

float obstacleMargin = 190;
float speed = 2;

// Storage data from serial ( arduino + openmv )
boolean debounce = false ;
boolean debounceContact = false ;
PVector[] stampPos = new PVector[2];
PVector[] pos = new PVector[2];
float[] angle = new float[2];

int b_length, b_height ;
int forceStamp = 470 ;

boolean rStampIsOnScreen, lStampIsOnScreen ;
int charge_l, charge_r ;
PVector rechargingStamp = new PVector(0, 0);

// animations
ArrayList<TrucPousse> trucs = new ArrayList<TrucPousse>();
ArrayList<AnimBoxes> boxes = new ArrayList<AnimBoxes>();
ArrayList<Storage> items = new ArrayList<Storage>();

// store plateforms stamped
ArrayList<Stamp> stamps = new ArrayList<Stamp>();
FBox[] stamps_boxes = new FBox[30];

// game variables
boolean startGame = false ;
boolean screenLoose = false ;
boolean isDropInScreen = true ;

PFont f;
PFont fbold;
int score, score1, score2;

//two players
PVector selecter, oneplayer, twoplayers ;
boolean players = false ;
color blue, red ;

boolean lastPlayerTouched;
boolean isPlayerGuilty = false ;

PImage solo, multi ;

void setup() {
    fullScreen(P3D);
    smooth();
    noCursor();
    
    printArray(Serial.list()); 
    String portName = Serial.list()[1];  // openmv cam
    String arduinoPortName = Serial.list()[0]; // arduino
    camPort = new Serial(this, portName, 9600); 
    arduinoPort = new Serial(this, arduinoPortName, 9600);
    camPort.bufferUntil('\n');
    arduinoPort.bufferUntil('\n');
  
  // initialize storages
    for (int i = 0; i < 2; i++) {
      pos[i] = new PVector(-500, -600);
      stampPos[i] = new PVector(-500, - 600);
      angle[i] = 0;
    }
    
    score = 0 ;
    score1 = 0;
    score2 = 0;
  
    charge_r = 5;
    charge_l = 5;
  
    rStampIsOnScreen = false;
    lStampIsOnScreen = false;
    
    red = color( 190, 12, 34);
    blue = color(34, 12, 190);
    
    oneplayer = new PVector((height/3) - 400, (width/2) + 100);
    twoplayers = new PVector((height/3) + 580, (width/2) + 100); // putains de coordonnées !
    selecter = new PVector( - height, - width);
    
    solo = loadImage("./data/tampon1.png");
    multi = loadImage("./data/tampon2.png");
    solo.resize(0, b_height);
    multi.resize(0, b_height);
  
    initColliders();
    initSounds();
  
    b_length = 550;
    b_height = 350;
  
    f = createFont("AmaticSC-Regular.ttf", 100);
    fbold = createFont("AmaticSC-Bold.ttf", 100);
    textFont(f);
    textAlign(CENTER);
  
  }
  
  void draw() {
  
    translate(width/2, height/2);
    rotate(-PI/2);
    translate(-height/2, -width/2);
    background(255, 255, 255);
  
    if (startGame) {
      updateGhosts(); // display target stamps on screen
      displayGhosts(); // before press them
  
  // update stamped plateforms
      for ( int i = 0; i < stamps.size(); i ++) {
        Stamp stamp = stamps.get(i);
  
        if (stamp.checkEdges()) {
          stamps.remove(i);
        } else {
          stamp.update();
          stamp.display();
        }
      }
  
      updateCollideAnim(); // animation on collides between drop and plateforms
  
  // world fisica update
      world.step();
      world.draw();
  
  
  // subtil mais efficace : on detruit les objets enfants de l'objet world, pour les updater à la prochaine itération
      for ( Stamp stamp : stamps) {
        world.remove(stamp.box);
      }
  
  // avoid call to much samples on collides
      if (debounce) {
        playSample(triggerSample(moyenneStorage()));
        debounce = !debounce ;
      }
  
  // game become faster and faster
      if (frameCount % 50 == 0) {
        if (speed < 8) speed += .005 ;
        if (b_length > 250){
           b_length -- ;
           b_height -- ;
        }
        score ++ ;
      }
  
      rechargeStamps(); // update recharge stamps gauge
      displayChargeStamps(); // display stamps gauge
      displayScore();
      checkDrop(); // check if drop is still on screen (or a little bit higher than the top)
  
      if (!isDropInScreen) { // if drop out, so player(s) loose game
        looseGame();
      }
    } else { // if game is end or not started
        if (screenLoose) { // on end game, display screen loose with score during 10sec
            displayScreenLoose();
        } else {
          waitingForStart(); // else display player selecter screen
        }
    }
  }
  
  
  
  void checkDrop(){
    //print("getx :");
    //println(b.get);
    //printArray(world.getBodies());
    
    // get pos of drop in Fbody class  and determine if it still in screen
    float yBlob = 0;
    ArrayList <FBody> bodies = world.getBodies();
  
    for (FBody body : bodies) {
      if (body.getClass().getName().equals("fisica.FCircle")) {
        //fill(255, 0, 0);
        //ellipse(body.getX(), body.getY(), 50, 50);
        //println(body.getX(), body.getY());
        
        yBlob = body.getY();
        
        if (players){ // on multiplayer mode, if a player push drop out off screen on top, he loose
          if (yBlob < - width / 8){
            isDropInScreen = false;
            isPlayerGuilty = true ;
          }
          if (yBlob > width){ // else, if drop goes out on down, display score of two players
            isDropInScreen = false;
          }
        } else {
          if (yBlob > width || yBlob < - width / 8){
            isDropInScreen = false;
          }
        }
        if (yBlob < 0){ // when drop is out of top of screen, display a target which indicate where it will fall
           fill(210);
           noStroke();
           ellipse(body.getX(), 120, 50, 50);
        }
      }
    } 
  }
    
    // convert pos from openmv cam to screen ratio
  PVector posConverter(float y, float x){
    return new PVector(map(y, 14, 101, 0, height),
                        map(x, 13, 147, 0, width));
  }
   
