/**

This sketch originated from the P5 Blending sample : 
 * Blending 
 * by Andres Colubri. 
 * 
 * Images can be blended using one of the 10 blending modes 
 * (currently available only in P2D and P3).
 * Click to go to cycle through the modes.  
 */

// NOTE: THIS EXAMPLE IS IN PROGRESS -- REAS

PImage img1, img2;
int selMode = REPLACE;
String name = "REPLACE";
int picAlpha = 255;

String IMG_FILE1 = "DarkLamp7.png";
String IMG_FILE2 = "DarkLamp7 2.png";

String first = IMG_FILE1;
String second = IMG_FILE2;


void setup() {
  size(2048, 2048, P3D);
  loadImages(); 
  noStroke();
}

void loadImages(){
    img1 = loadImage( first );
    img2 = loadImage( second );
}

void draw() {
  
  picAlpha = int(map(mouseX, 0, width, 0, 255));
  
  background(0);
  
  tint(255, 255);
  image(img1, 0, 0);

  blendMode(selMode);  
  tint(255, picAlpha);
  image(img2, 0, 0);

  blendMode(REPLACE); 
  fill(255);
  rect(0, 0, 94, 22);
  fill(0);
  text(name, 10, 15);
}

void mousePressed() {
  
  if (selMode == REPLACE) { 
    selMode = BLEND;
    name = "BLEND";
  } else if (selMode == BLEND) { 
    selMode = ADD;
    name = "ADD";
  } else if (selMode == ADD) { 
    selMode = SUBTRACT;
    name = "SUBTRACT";
  } else if (selMode == SUBTRACT) { 
    selMode = LIGHTEST;
    name = "LIGHTEST";
  } else if (selMode == LIGHTEST) { 
    selMode = DARKEST;
    name = "DARKEST";
  } else if (selMode == DARKEST) { 
    selMode = DIFFERENCE;
    name = "DIFFERENCE";
  } else if (selMode == DIFFERENCE) { 
    selMode = EXCLUSION;  
    name = "EXCLUSION";
  } else if (selMode == EXCLUSION) { 
    selMode = MULTIPLY;  
    name = "MULTIPLY";
  } else if (selMode == MULTIPLY) { 
    selMode = SCREEN;
    name = "SCREEN";
  } else if (selMode == SCREEN) { 
    selMode = REPLACE;
    name = "REPLACE";
  }
}

void mouseDragged() {
  if (height - 50 < mouseY) {
    picAlpha = int(map(mouseX, 0, width, 0, 255));
  }
}

void keyPressed(){
  switch(key){
  
    case 's':
    case 'S':
    {
      //  todo: SAVE AS {NAME}_EPOCH
       save(this + "_"+name + "_"+getTimestamp() +".png");
    }
    break;
    
    //  F - flip flop the two images
    case 'f':
    case 'F':
    {
      if(first != IMG_FILE1){
        first = IMG_FILE1;
        second = IMG_FILE2;
      } else {
        first = IMG_FILE2;
        second = IMG_FILE1;      
      }
      
      // re-load images
      loadImages();
    }
    break;
  }
}

public String getTimestamp() {
    //  Calendar now = Calendar.getInstance();
    //  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM", now);
    return ""+ PApplet.month()+ PApplet.day()+ PApplet.year()+ PApplet.hour()+ PApplet.second()+millis();
  }
