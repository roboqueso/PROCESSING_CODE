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

public class CameraDrawer6 extends PApplet {


// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);


Capture cam;

PVector a, b, c, d;
int sz = 33,
    ms = 1000,
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
      
      fill(255);
      text("snap"+frameCount, xx, yy);
      cam.read();
      snap = cam;
    }
    
    // "slit cam" - real time
    if(frameCount%7==0)
    {
	  // "FIRE"ish neon - stroke(xx,yy,sz);
	  // stroke(xx,yy,sz);

	//	VERTICAL
	cam.read();
	// tint(xx,yy,sz);// random(sz,255));
	tint( snap.get( (int)xx, (int)yy) );
	image(cam.get((int)xx, 0, (int)random(HALF_PI), (int)yy), xx, 0 );

    }
    else if ( frameCount%11==0)
    {
      //	HORIZONTAL
      horSlitSz = (int)random(HALF_PI,13);
      
      //stroke(xx,yy,sz);
      stroke( snap.get( (int)xx, (int)yy) );
      // noStroke();
      rect(0, yy-1, xx, horSlitSz+1, random(-TWO_PI,TWO_PI) );
      noTint();

      cam.read();
      
      if(yy>=(height*.45f))
      	
      	cam.filter(POSTERIZE, random(2,sz/2)+noise(frameCount) );

      else if(yy<=(height/9))

      	cam.filter(GRAY);

      else

      	noTint();
      
      // grab a slice that only goes to the shape, not full width	
      image( cam.get(0, (int)yy, (int)xx, horSlitSz), 0, yy, xx, horSlitSz );
    }


    xx = (frameCount%width)+noise(frameCount);
    yy = (frameCount%height) - PApplet.parseInt( sin(radians(frameCount)) * sz )
     			%height;

// xx +=noise(frameCount)*10;


    a = new PVector( xx-sz, yy, random(sz) );
    b = new PVector( xx, yy-sz, random(sz) );
    c = new PVector( xx+sz, yy, random(sz) );
    d = new PVector( xx, yy+sz, random(sz) );
  
	rotateZ(frameCount%sz);

  // "FIRE"ish neon - stroke(xx,yy,sz);
  // stroke(xx,yy,sz);
	stroke( snap.get( (int)xx, (int)yy) );

  noTint();
  beginShape();

  	texture( snap.get( (int)xx, (int)yy, sz, sz ) );

    vertex(a.x, a.y, 0,0 );
    vertex(b.x, b.y, sz, 0 );
    vertex(c.x, c.y, 0, sz );
    vertex(d.x, d.y, sz, sz );
    
  endShape();

  stroke( snap.get( (int)xx, (int)yy) );
  fill( snap.get( (int)yy, (int)xx) );

  rect( yy, xx, random(sz), random(sz), random(-TWO_PI,TWO_PI) );
  rect( xx+sz, yy-sz, random(sz), random(sz), random(-TWO_PI,TWO_PI) );


	stroke(xx,yy,sz);
	ellipse(xx,yy,sz,sz);
	point(xx,yy);
	noStroke();


 // STOPPER
 if(frameCount>width*5)
 {
   save( fix.pdeName() + fix.getTimestamp() + ".png");
   cam.stop();
   cam=null;

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
    String[] appletArgs = new String[] { "CameraDrawer6" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
