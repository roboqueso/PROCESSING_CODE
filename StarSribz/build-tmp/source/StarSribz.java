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

public class StarSribz extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

public Boolean isFinal = true;
int dWidth, dHeight, r,g,b,opacity,nSides,cx,cy;
float xx, yy;

boolean isPolygon = false;
float proportion;

public void setup()
{
  dWidth = 1024;
  dHeight = 768;

  
  background(0xffEF2012);
frameRate(303);

  
  rectMode(CENTER);


  cx = dWidth/2;
  cy = dHeight/2;
}




public void draw()
{
  nSides = PApplet.parseInt(random(5, 55));

  


  
  if(frameCount% PApplet.parseInt(random(13,42))==0){
    fill(0xffEFEFEF);
    strokeWeight(.42f);
    line( xx, 0, xx, height );
  } else {
    noFill();
  }
  strokeWeight(random(PI));
  stroke( 0xffEF2012 );  
  rect( xx, yy, nSides, nSides, proportion*frameCount);

  proportion = random(0.2f, 0.8f) * cos(PI / frameCount);
  
  strokeWeight(random(2));
  stroke(random(42));
  fill(random(42,255),42,42);
  fix.star(5, xx, yy, random(PI*proportion,21), proportion );
//  text(proportion, random(dWidth), random(dHeight) );
  //  }
  
  if( xx <= dWidth ){
    xx += 11;
  } else {
    xx = 0;
    yy += nSides*PI;
  }
  
  //  safety checker
  if( yy >= height ){
    yy = random(yy);
  }
  
  
  if(frameCount>dWidth+dHeight){
  
  

      textFont(createFont("Silom",37));
      
      fill(0);
      text("ERICFICKES.COM", 0, height-11 );  // 28
      fill(0xff424242);
      text("ERICFICKES.COM", 1, height-10 );  // 28
      fill(0xffEFEFEF);
      text("ERICFICKES.COM", 2, height-9 );  // 28

      if(isFinal){
        save( fix.pdeName() + fix.getTimestamp() + ".png" );
      }
      noLoop();
      exit();
  }
}

public void polygon(int n, float cx, float cy, float r)
{
  float angle = 360.0f / n;

  beginShape();
  for (int i = 0; i < n; i++)
  {
    vertex(cx + r * cos(radians(angle * i)), 
    cy + r * sin(radians(angle * i)));
  }
  endShape(CLOSE);
}
  public void settings() {  size(1024, 768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "StarSribz" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
