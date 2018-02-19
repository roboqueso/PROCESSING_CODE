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

public class splaterdots extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

public float x = 0, y = 0;
Boolean isFinal = true;
/////////////////////////////////////////////////////////
public void setup() {
  background(0xff000110);
  
  noFill();

} 
/////////////////////////////////////////////////////////
public void draw() {

  xySystem(x, y);

  strokeWeight(11);
  point( x, y );
  
  strokeWeight(random(22));
  point( x-y, y );
  
  strokeWeight(random(37));
  point( y, x );

  if ( frameCount > (width+height)*TWO_PI )
  {
    fill(0xffEFEFEF);
    textFont( createFont( "Silom", 11 ) );
    text("ERICFICKES.COM", 3, height-11);

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
  switch( PApplet.parseInt( random(12) ) )
  {
  case 0:
    {
      if ( a < width ) {
        x += 11;
      } 
      else {
        y += 11;
        x = random(11);
      }
    } 
    break;

  case 1:
    {
      if ( b < height ) {
        y += 11;
      } 
      else {
        x += 11;
        y = random(11);
      }
    }
    break;
    
  case 2:
    {
      x ++;
      y --;
    }
    break;

  case 3:
    {
      x --;
      y --;
    }
    break;

  case 4:
    {
      x --;
      y ++;
    }
    break;

  case 5:
    {
      if ( a > 0 ) {
        x -= 11;
      } 
      else {
        y -= 11;
        x = random(11);
      }
    } 
    break;

  case 6:
    {
      if ( b > 0  ) {
        y -= 11;
      } 
      else {
        x -= 11;
        y = random(11);
      }
    }
    break;
    
  case 7:
    {
      x += 11;
      y += 11;
    }
    break;

  case 8:
    {
      x += 11;
      y -= 11;
    }
    break;

  case 9:
    {
      x -= 11;
      y += 11;
    }
    break;

  case 10:
    {
      x -= cos(a)*noise(frameCount)*radians(a);
      y -= sin(b)*noise(frameCount)*radians(b);
    }
    break;
    
  case 11:
    {
      x -= cos(b)*noise(frameCount);
      y += sin(a)*noise(frameCount);
    }
    break;

  default:{
    x += noise(b)*a;
    y += noise(a)*b;
    rect(x,y, a, b);
  }break;

  }
  //    ensure x & y are in screen
  if ( x > width || x < 0 ) {
    stroke(random(200,255), random(100));
    x = random(PI, width-x);
  }
  if ( y > height || y < 0 ) {
    stroke(random(150), random(100));
    y = random(PI, height-y);
  }
}
  public void settings() {  size(1024, 768 ); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "splaterdots" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
