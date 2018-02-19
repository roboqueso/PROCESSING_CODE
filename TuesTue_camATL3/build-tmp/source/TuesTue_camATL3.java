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

public class TuesTue_camATL3 extends PApplet {


// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);


float xx, yy, cX, cY, sz, radSz;

Capture cam;
PImage snap;


public void setup()
{
  //, P3D);
  background(255);
  frameRate(404);
  
  rectMode(CENTER);
  cX = width/2;
  cY = height/2;
  sz = HALF_PI;
  strokeWeight(sz);

  //  INIT Camera for color grabs
  cam = new Capture(this, Capture.list()[0]);
  cam.start();     
}

public void draw()
{

  // snap every 90
  if (cam.available()) 
  {

    if(snap==null || frameCount % 270 == 0 )
    {
      cam.read();
      snap = cam;

      // line(xx, 0, xx, height);
      // text("SNAP", xx, yy);

      // 
      tint(yy-xx+sz, xx-sz, yy-sz, random(42));
      //  VERTICAL
      image( cam.get( (int)xx, 0, (int)random(sz), height ), xx, 0 );

      tint( snap.get( (int)yy, (int)xx), random(42) );
      //  HORIZONTAL
      image( cam.get( 0, (int)yy, width, (int)random(sz) ), 0, yy );
    }
  }

  xx = cX - PApplet.parseInt( cos(radians( frameCount )) * sz+noise(frameCount*.2f) );
  yy = cY - PApplet.parseInt( sin(radians( frameCount )) * sz+noise(frameCount*.2f) ); 
  
  
  if(null != snap)
  {
    stroke( snap.get( (int)xx, (int)yy) );
    fill( snap.get( (int)yy, (int)xx), 42);
	
	//	OG  
	// stroke( (frameCount%xx)-sz, (frameCount%yy)-sz, (frameCount%sz)-sz);
	// fill( yy-xx+sz, xx-sz, yy-sz);
	radSz = random(-42,42);
	rect(xx, yy, TWO_PI+noise(sz), TWO_PI+noise(sz), radSz );

	fill( snap.get( (int)yy, (int)xx), 100);	
	ellipse(xx, yy, 11+noise(sz), 11+noise(sz) );

	fill( snap.get( (int)yy, (int)xx), 50);
	ellipse(xx, yy, radSz, radSz );

	point(xx, yy);

  sz += .021f; //.016;

}

  if(sz>=height){
  	
  	cam.stop();

    save( fix.pdeName() + fix.getTimestamp() + ".png");
    noLoop();
    exit();
  }


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
  public void settings() {  size(1280, 720);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TuesTue_camATL3" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
