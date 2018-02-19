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

public class ReggaeCircle extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

float xx, yy, zz, cX, cY, sz;

public void setup()
{
  //
  //  boardpusher.com 8.5 board template dimensions
  //size( 9900, 2700 );
  // size( 4950, 1350 );
  size( displayWidth, displayHeight );

  background(0);
  frameRate(404);
  
  rectMode(CENTER);
  cX = width/2;
  cY = height/2;
  sz = 21;
  strokeWeight(PI);
}

public void draw()
{
	xx = cX - PApplet.parseInt( cos(radians( frameCount )) * sz+noise(frameCount*.3f) );
	yy = cY - PApplet.parseInt( sin(radians( frameCount )) * sz+noise(frameCount*.3f) ); 
	
	
	stroke( (frameCount%xx)-sz, (frameCount%yy)-sz, (frameCount%sz)-sz);
	fill( yy-xx+sz, xx-sz, yy-sz);
	rect(xx, yy, TWO_PI+noise(sz), TWO_PI+noise(sz), random(-TWO_PI,TWO_PI) );

//	strokeWeight(HALF_PI);
	// noFill();
 //  stroke( (xx%frameCount)-sz, (yy%frameCount)-sz, (sz%frameCount)-sz);
	// ellipse(xx, yy, TWO_PI*noise(sz), TWO_PI*noise(sz) );

	sz += .036f;
  
	if(sz>=height){
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
  public void settings() {  size( displayWidth, displayHeight );  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ReggaeCircle" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
