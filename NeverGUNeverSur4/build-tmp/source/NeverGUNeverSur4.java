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

public class NeverGUNeverSur4 extends PApplet {


// https://github.com/ericfickes/FIXLIB	


Fixlib fix = Fixlib.init(this);
/*
Specifies vertex coordinates for curves. This function may only be used between beginShape() and 
 endShape() and only when there is no MODE parameter specified to beginShape(). 
 The first and last points in a series of curveVertex() lines will be used to guide the beginning 
 and end of a the curve. A minimum of four points is required to draw a tiny curve between the 
 second and third points. Adding a fifth point with curveVertex() will draw the curve between the 
 second, third, and fourth points. The curveVertex() function is an implementation of Catmull-Rom 
 splines. 
 Using the 3D version of requires rendering with P3D or OPENGL (see the Environment reference for 
 more information)
 */
Boolean isFinal = true;

//  
int alf = 69;

//  circle vars
float angle1 = 180, xx1, yy1, startX1, startY1, radius1 = 37;
/*
float angle2 = 0, xx2, yy2, startX2, startY2, radius2 = alf*5;
 float angle3 = 0, xx3, yy3, startX3, startY3, radius3 = alf*7;
 float angle4 = 0, xx4, yy4, startX4, startY4, radius4 = alf*9;
 */
int cX;
int cY;

int[] p1 = { 
  0xffEF0000, 0xff00EF00, 0xff0000EF, 0xffCECE00, 0xffFA7680, 0xffEF1975, 0xff007007, 0xffEFEF00, 0xffFA9187, 0xff007007, 0xff109109
};
PImage b;
ArrayList p3;

//  VECTOR ACTION - http://processing.org/reference/PVector.html
//PVector v1, v2;


////////////////////////////////////////////////////
//
public void setup() {
  // setup core sketch settings items
  
  background(0xff000018);
  fix.alpha(alf);
  b = loadImage("white-flower.jpg");//  "white-flower.jpg" "HOTmess3.png"
  p3 = fix.getImgColors(b);

  //  setup variables
  cX = width/2;
  cY = height/2;

  startX1 = cX;
  startY1 = cY;

  stroke(0);
  strokeWeight(10);
  xx1 = yy1 = -alf;
  noFill();
}


////////////////////////////////////////////////////
//
public void draw()
{
  smooth();



    xx1 = startX1 - PApplet.parseInt( cos(radians(angle1)) * radius1 );
    yy1 = startY1 - PApplet.parseInt( sin(radians(angle1)) * radius1 );
  


    strokeWeight(12);
    fix.ranPalStroke(p3);
    ellipse( xx1, yy1, radius1, radius1 );

    strokeWeight(4);
    stroke(255, 360);
    point( xx1, yy1 );
  
  angle1 += 3;

  //  gradual spiral out
  radius1 += frameCount/PI/alf;

  //
  //  STOP
  //  
  if ( frameCount > (width+height) )
  {    
    doExit();
  }

}



///////////////////////////////////////////////////////////
//  
//  End handler, saves png
public void doExit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
public void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 37 ) );  //  "AnonymousPro"
  smooth();

  fill(alf, alf);
  text( dailyMsg, 0, height-4 );
  fill(0, alf);
  text( dailyMsg, 0, height-2 );
  fill(255, alf);
  text( dailyMsg, 0, height );

}

  public void settings() {  size(1024, 768); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "NeverGUNeverSur4" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
