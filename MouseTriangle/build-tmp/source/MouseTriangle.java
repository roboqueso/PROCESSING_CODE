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

public class MouseTriangle extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

PVector a, b, c;
int sz = 42;

public void setup()
{
  
  background(255);
  strokeWeight(1);
}

public void draw()
{
  /*
  Take mouse coordinates and draw a triangle around the mouse
  mouseX,mouseY = center point
  sz = radius?
  a
  |
  M
  |
b--- c
*/
  a = new PVector( mouseX, mouseY-sz );
  b = new PVector( mouseX-(sz*2), mouseY+sz);
  c = new PVector( mouseX+(sz*2), mouseY+sz);
  
  triangle( a.x, a.y, b.x, b.y, c.x, c.y );

}

////// S SAVE HANDLER /////////

public void keyPressed(){
switch(key){
  case 's':
    save( fix.pdeName() + fix.getTimestamp() + ".png");
  break;

  case ESC:
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    noLoop();
    exit();
  break;
}

}
  public void settings() {  size(420, 420); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "MouseTriangle" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
