/**
 * Getting Started with Capture.
 * 
 * Reading and displaying an image from an attached Capture device. 
 */

import processing.video.*;

Capture cam;
String[] cameras;
PFont f;
int txtH;
String text;

void setup() {
  size(displayWidth, displayHeight, P3D);
  background(-1);
  pixelDensity(displayDensity());
  smooth(8);

  strokeWeight(1);

  cameras = Capture.list();

  txtH = (int)( (height/cameras.length )-HALF_PI);
  // debug
  print("txtH : " + txtH);
  f = createFont("Arial", txtH);

  if (cameras == null) {
    println("FAIL");
    // cam = new Capture(this, 640, 480);
  } 
  if (cameras.length == 0) {
    println("86 ON CAMERAS");
    exit();
  } else {
    println("Available cameras:");
    printArray(cameras);

    // The camera can be initialized directly using an element
    // from the array returned by list():
    //cam = new Capture(this, cameras[0]);
    //// Or, the settings can be defined based on the text in the list
    ////cam = new Capture(this, 640, 480, "Built-in iSight", 30);

    //// Start capturing the images from the camera
    //cam.start();
  }
  
textFont(f);  
textSize(txtH);
textAlign(LEFT,TOP);

}

void draw() {

    for (int c = 0; c < cameras.length; c++ ) {
            
text = cameras[c];

      
      if(frameCount < (width*.11)){
        stroke(random(160,255) );

        fill(random(160,255), random(160), random(160), 24);
        rect( (width-frameCount)-textWidth(text), c*(height/cameras.length)-textAscent(), (textWidth(text)+txtH), txtH, 0, txtH, txtH, 0);
        // rect(a, b, c, d, tl, tr, br, bl0

      }
      else 
        noStroke();





      
      // fill(random(240,250));
      // text( text, width-frameCount, c*(height/cameras.length) );//, width, txtH );




      fill(random(160,255), random(160), random(160), 43);
      rect( frameCount-(txtH/2), c*(height/cameras.length)-textAscent(), (textWidth(text)+(txtH*1.5)), txtH, -frameCount, txtH, txtH, -frameCount );
      // rect(a, b, c, d, tl, tr, br, bl0
      
      fill(random(240,250));
      text( text, frameCount%width, c*(height/cameras.length) );//, width, txtH );


      fill(255);
      text( text, frameCount%width, c*(height/cameras.length) );//, width, txtH );

      // check for hitting the side
      if( frameCount > width-(textWidth(text)+txtH) ){
        save(this+".png");
        exit();
      }
    }
  //}
}

// from https://forum.processing.org/two/discussion/20238/scale-text-to-screen-width
// doesn't do what I hoped
public void fittedText(String text, PFont font, float posX, float posY, float fitX, float fitY)
{
  textFont(font);
  textSize(min(font.getSize()*fitX/textWidth(text), fitY));
  text(text, posX, posY);
}
