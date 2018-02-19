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

public class circeSystem extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
public float x, y;
public int alf = 11, gridSize = 4, colWidth, rowHeight, maxCt;
public int[] nums = { 2, 4, 6, 10, 16, 26, 42 };

/////////////////////////////////////////////////////////
public void setup() {
  background(0xff011223);
  
  noFill();
  
  fix.alpha(alf);
  strokeWeight(11);
  
  colWidth = floor( width / gridSize );
  rowHeight = floor( height / gridSize );
  maxCt = PApplet.parseInt( (width+height)*HALF_PI );
} 
/////////////////////////////////////////////////////////
public void draw() {

  xySystem(x, y);
  
  noFill();
  strokeWeight(11);
  point( x, y );
  point( y, x );
  
  strokeWeight(1);
  bezier( width-x, height-y, x, y,  y-x, x-y, height-x-y, width-y-x );
  curve( width-x, height-y, x, y,  y-x, x-y, height-x-y, width-y-x );
  
  // STOPPER
  if ( frameCount > maxCt )
  {
    fill(0xffEFEFEF);
    textFont( createFont( "Silom", 11 ) );
    text("ERICFICKES.COM", width-100, height-11);

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
  switch( PApplet.parseInt( random(4) ) )
  {
  case 0:
    {
      x += colWidth;
      y += rowHeight;
    } 
    break;
  
  case 2:
  case 3:
    {
      x += colWidth - PApplet.parseInt( cos(radians(frameCount)) * a-b );
      y += rowHeight - PApplet.parseInt( sin(radians(frameCount)) * b-a );
    } 
    break;

  case 1:
    {
      if ( b < height ) {
        y += rowHeight;
      } 
      else {
        x += colWidth;
        y = random(b);
      }
    }
    break;

  }
  //    ensure x & y are in screen
  if ( a > width || a < 0 ) {
    stroke(random(255), alf*PI);
    x = random(PI, width-x);
  }
  
  if ( b > height || b < 0 ) {
    stroke(100, alf);
    y = random(PI, height-y);
  }
  
  
  //  always want to check for this condition
  if ( frameCount % PApplet.parseInt(768/TWO_PI) == 0 ) {
    
    //  resize grid
    gridSize = nums[ floor( random(nums.length) ) ]; //floor(random( 2, 10 ));
    colWidth = floor( width / gridSize );
    rowHeight = floor( height / gridSize );
    x = y = 0;
    stroke(random(42,242),gridSize, gridSize);

      textFont( createFont("monospace", alf*gridSize ) );
      fill(0xff034567,alf);
      text( gridSize,  width-a*cos(frameCount), height-b*sin(frameCount) );
      fill(0xff1975EF,alf);
      text( gridSize,  width-a*cos(frameCount)-11, height-b*sin(frameCount)-11 );

    
  }
  
  
}


  public void settings() {  size(1024, 768 );  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "circeSystem" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
