import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 
import fixlib.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class CameraDrawer2 extends PApplet {


// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);


Capture cam;

PVector a, b, c, d;
int sz = 75,
    ms = 500,
    horSlitSz;  

float xx, yy;
PImage snap;

//////////////////////////////////////////////////////////////////////
public void setup() 
{
  
  background(255);
  
  cam = new Capture(this, Capture.list()[0]);
  cam.start();     
  xx = yy = 0;
}

//////////////////////////////////////////////////////////////////////
public void draw() {
  if (cam.available()) 
  {
    if(snap==null || millis() % ms==0 ){
      fill(random(255));
      text("snap"+frameCount, xx, yy);
      cam.read();
      snap = cam;
    }
    
    // "slit cam" - real time
    if(frameCount%7==0)
    {
      //tint(255, 25);
      image(cam.get((int)xx, 0, (int)random(2,TWO_PI), height), xx, 0 );
    }
    else if ( frameCount%11==0){
      horSlitSz = (int)random(2,11);
      
      stroke(random(sz),random(sz),random(sz));
      rect(0, yy-1, width, horSlitSz+1);
      
      tint( random(155,255), 50);
      image(cam.get(0, (int)yy, width, horSlitSz), 0, yy );
    }

    // NOTE: THE & INSTEAD OF % OPERATOR ON Y
    xx = frameCount%width;
    yy = frameCount%height;

    a = GetRandVector( xx, yy, sz );
    b = GetRandVector( xx, yy, sz );
    c = GetRandVector( xx, yy, sz );
    d = GetRandVector( xx, yy, sz );
  
  stroke( snap.get( (int)xx, (int)yy) );
  fill( snap.get( (int)yy, (int)xx) );

  rect( yy, xx, random(sz), random(sz), random(-TWO_PI,TWO_PI) );
  rect( xx+sz, yy-sz, random(sz), random(sz), random(-TWO_PI,TWO_PI) );

  
  
  // "FIRE"ish neon - stroke(xx,yy,sz);
  stroke(xx,yy,sz);

  beginShape();

  texture( snap.get( (int)a.x, (int)a.y, sz, sz ) );
//cam.read();
//texture( cam );

    vertex(a.x, a.y, 0, 0);
    vertex(b.x, b.y, b.x, b.y );
    vertex(c.x, c.y,c.x, c.y);
    vertex(d.x, d.y,d.x, d.y);
    
  endShape();

//if(millis() % ms == 0){
//tint(255,5);
//image(snap,0,0);
//}
  


 //	STOPPER
 if(frameCount>width*10){
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    noLoop();
    exit();
}


  }
}


//  Return a random vector based on supplied x,y and sz
public PVector GetRandVector( float x, float y, float sz )
{
  return new PVector( 
        x - PApplet.parseInt( cos(radians( random(360) )) * sz ),
        y - PApplet.parseInt( sin(radians( random(360) )) * sz ),
        random(-sz,sz)
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
  public void settings() {  size(1280, 720, P3D);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CameraDrawer2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
