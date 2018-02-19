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

public class dotsys extends PApplet {

public float xx = 0, yy = 0;
// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);


Boolean isFinal = true;
/////////////////////////////////////////////////////////
public void setup() {
  background(0);
  
  noFill();
  
} 
/////////////////////////////////////////////////////////
public void draw() {

  xySystem(xx, yy);

  strokeWeight(random(HALF_PI, TWO_PI));
  point( xx, yy );
  

  // STOPPER
  if ( frameCount > (1024+768)*PI )
  {
    fill(0xffEFEFEF);
    textFont( createFont( "Monospace", 11 ) );
    text("ERICFICKES.COM", 11, height-11);

    if(isFinal){
      save( fix.pdeName() + fix.getTimestamp() + ".png");
    }
    noLoop();
    exit();
  }
}
/////////////////////////////////////////////////////////
public void xySystem( float a, float b)
{
  //    randomly adjust globals x and y
  switch( PApplet.parseInt( random(3) ) )
  {
  case 0:
    {
      if ( a < width ) {
        xx += 13;
      } 
      else {
        yy -= 13;
        xx = random(width);
      }
    } 
    break;

  case 1:
    {
      if ( b < height ) {
        yy += 13;
      } 
      else {
        xx += HALF_PI;
        yy = random(height);
      }
    }
    break;

  case 2:
    {
      if ( b > 0 ) {
        yy -= 13;
      } 
      else {
        xx += HALF_PI;
        yy = random(height);
      }
    }
    break;

  default:{
    xx += noise(b)*a;
    yy += noise(a)*b;
    rect(xx,yy, a, b, xx/yy);
  }break;

  }
  //    ensure x & y are in screen
  if ( a > width || a < 0 ) {
    stroke(42, random(255), 42);
    xx = random(PI, width-xx);
  }
  if ( b > height || b < 0 ) {
    stroke(42,random(42, 242), 42,random(222));
    yy = random(PI, height-yy);
  }
}
  public void settings() {  size(1024, 768 );  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "dotsys" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
