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

public class MouseStar extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

/*
Use mouseX,mouseY as the center point for 5 random points ( simulated hand )
*/

PVector a, b, c, d, e;
int sz = 42;  
float xx, yy;

public void setup()
{
  
  background(255);
  strokeWeight(HALF_PI);
  
}

public void draw()
{

  a = GetRandVector( mouseX, mouseY, sz );
  b = GetRandVector( mouseX, mouseY, sz );
  c = GetRandVector( mouseX, mouseY, sz );
  d = GetRandVector( mouseX, mouseY, sz );
  e = GetRandVector( mouseX, mouseY, sz );  


  if( mouseY < height/2 )
  {
    stroke( random(sz) );
    fill( random(mouseX),random(mouseY),random(sz,255) );
  }
  else
  {
    fill( random(sz) );
    stroke(random(mouseX),random(mouseY),random(sz,255));
  }

  beginShape(QUAD_STRIP);
    vertex(a.x, a.y);
    vertex(b.x, b.y);
    vertex(c.x, c.y);
    vertex(d.x, d.y);
    vertex(e.x, e.y);
  endShape();
  
}

//  Return a random vector based on supplied x,y and sz
public PVector GetRandVector( float x, float y, float sz )
{
  return new PVector( 
        x - PApplet.parseInt( cos(radians( random(360) )) * sz ),
        y - PApplet.parseInt( sin(radians( random(360) )) * sz )
      );
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
  public void settings() {  size(1024, 768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "MouseStar" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
