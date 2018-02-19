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

public class TriangleStrip extends PApplet {
  public void setup() {
// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);



background(204);


Boolean isFinal = true;
int x = width/2;
int y = height/2;
float outerRad = 10;//min(width, height) * 0.4;
float innerRad = 5;//outerRad * 0.6;
float px = 0, py = 0, angle = 0;
float pts = 36;
float rot = 360.0f/pts;

while( outerRad < height ) {
  
  beginShape(TRIANGLE_STRIP); 
  for (int i = 0; i < pts; i++) {
    px = x + cos(radians(angle))*outerRad;
    py = y + sin(radians(angle))*outerRad;
    angle += rot;
    vertex(px, py);
    px = x + cos(radians(angle))*innerRad;
    py = y + sin(radians(angle))*innerRad;
    vertex(px, py); 
    angle += rot;
  }
  endShape();
 
  //  make bigger
  innerRad += 5;
  outerRad += 5;
}

fill(0xff1975EF);
text("ERICFICKES.COM", 0, height-11);


  if ( isFinal )
  {
    save( fix.pdeName() + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
    noLoop();
  }

  public void settings() { 
size(1024, 768 ); 
smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TriangleStrip" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
