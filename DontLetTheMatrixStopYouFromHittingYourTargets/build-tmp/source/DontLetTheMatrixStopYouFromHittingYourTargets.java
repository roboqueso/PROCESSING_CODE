import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import fixlib.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class DontLetTheMatrixStopYouFromHittingYourTargets extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

int[] nz = new int[966];
boolean gotNoise = false, isFinal = true;
boolean vert = true;
float xx=0, yy=0;

////////////////////////////////////////////////////////////////////////////////////////////////
public void setup() {
    //640, 960);
  background(0xff001800);
  frameRate(303);
  
  noFill();
  rectMode(CENTER);

  strokeWeight(1);
}


////////////////////////////////////////////////////////////////////////////////////////////////
public void draw() {

  if (frameCount< 966 ) {
    nz[frameCount-1] = PApplet.parseInt(random(-11, 11)*noise(frameCount));
  }


  // move
  if (yy<960) {
    xx += nz[PApplet.parseInt(yy)]*noise(random(PI))+PI;
    yy += 11;
  } 
  else {
    yy =0;
    xx += 21;
    stroke(random(42, 255), 37, 37, 42);
  }



  stroke( 0, random(11, 50), 0);

  strokeWeight(random(TWO_PI,11));
  point(xx+cos(frameCount), yy+sin(frameCount));

  strokeWeight(1);
  line(xx+cos(frameCount)-random(42), yy+sin(frameCount), xx+random(42), yy);



  if (xx>1024||xx<-11)
  {
    xx=random(xx);

    fix.bullsEye( xx, yy, random(42, 210));

    strokeWeight(random(11, 42));
    stroke(random(42, 96), 11, 11);
    line(1024, yy, xx, yy);

    //  draw dot core
    strokeWeight(1);
    noFill();
    for ( int dx = 1024; dx >= xx; dx-= 12 ) {
      if(PApplet.parseInt(random(2))%2==0){
        stroke(random(42, 96), 11, 11);  
      } else {
        stroke(0xff001100);
      }
      rect( dx, yy, 5, 5 );
    }

    //  always reset strokeWeight
    strokeWeight(1);
    stroke(random(227));
  }

  if ( frameCount>(1024+768)*21) {

    fill(0xffEF2012);
    textFont(createFont("Silom", 23));

    fill(0xffEFEFEF);

    //    TOP RIGHT CORNER-ISH ( between the time and the battery )
    text("ERICFICKES.COM", (1024/2)*1.2f, 25 );  // 28

    if (isFinal) {
      save( fix.pdeName() + fix.getTimestamp() + ".png" );
    }
    noLoop();
    exit();
  }
}
  public void settings() {  size(1024, 768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "DontLetTheMatrixStopYouFromHittingYourTargets" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
