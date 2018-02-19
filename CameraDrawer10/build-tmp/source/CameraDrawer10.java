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

public class CameraDrawer10 extends PApplet {


// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);


Capture cam;

PVector a, b, c, d;
int sz = 39,
    ms = 100,
    strokeWt = 1,
    horSlitSz; 

float xx, yy, eSz;
PImage snap, lilMask;



//////////////////////////////////////////////////////////////////////
public void setup() 
{
  
  background(255);
  
  strokeWeight(strokeWt);
  cam = new Capture(this, Capture.list()[0]);
  cam.start();     
  xx = yy = 0;
}

//////////////////////////////////////////////////////////////////////
public void draw() {
  if (cam.available()) 
  {

    if(snap==null || millis() % ms==0 )
    {
      
      fill(255);
      textSize(random(sz));
      text("snap"+frameCount, xx, yy);
      cam.read();
      snap = cam;

      tint(255,100);
      image(snap, width-200, yy, 200, 200);

      snap.mask(cam);
      snap.filter(POSTERIZE,4);
      snap.filter(INVERT);
      image(snap, width-200,yy+200,200,200);
    }
    

//  ROTATO!
  if(frameCount%sz==0)
  rotateX(frameCount%width);
  else if(frameCount%13==0)
  rotateY(frameCount%width);
  else if(frameCount%31==0)
  rotateZ(frameCount%width);
  else if(frameCount%42==0)
  rotate(frameCount%width);


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

      //	HORIZONTAL ( right to left now that XX has new noise)
      horSlitSz = (int)random(HALF_PI,sz);
      
      //stroke(xx,yy,sz);
      stroke( snap.get( (int)xx, (int)yy) );
      // noStroke();
      rect(xx, yy-1, (width-xx), horSlitSz+1, random(-TWO_PI, -sz) );
      //noTint();

      cam.read();
      
		if(yy>=(height*.45f))
		{
			cam.filter(POSTERIZE, random(2,sz/2)+noise(frameCount) );

		}
		else if(yy<=(height/9))
		{
			cam.filter(GRAY);
		}


     image( cam.get( (int)xx, (int)yy, (int)(width-xx), horSlitSz), xx, yy);//, (width-xx), horSlitSz );

    }
 	

  if( frameCount % ms == 0 || frameCount%sz==0){

    
    eSz = random(width-200);  // (width-xx)*noise(frameCount);
    yy = yy*noise(frameCount);

	// MASK USING CANVAS?
	lilMask = get( (int)xx, (int)yy, snap.width, snap.height );
	// lilMask.filter(INVERT);
	lilMask.filter(POSTERIZE, 8);
	lilMask.mask(snap);

	tint(xx,yy,sz);
    image(lilMask, eSz, yy, 200, 200);


    stroke( snap.get( (int)xx, (int)yy), random(255));
    strokeWeight(1);
    line(eSz+200, 0, eSz+200, height);

    noFill();
    strokeWeight(PI);
    // stroke(yy, xx, sz);
    stroke( snap.get( (int)xx, (int)yy) );
    rect(eSz, yy, 200, 200, random(sz));
}

    xx = (frameCount%width)*noise(frameCount);
    yy = (frameCount%height) - PApplet.parseInt( sin(radians(frameCount)) * sz ) % height;


    a = GetRandVector( xx, yy, sz );
    b = GetRandVector( xx, yy, sz );
    c = GetRandVector( xx, yy, sz );
    d = GetRandVector( xx, yy, sz );



//  RE-UP SNAP
    if(frameCount%sz==0 || frameCount%ms==0){
      cam.read();
      snap = cam;
    }

  // "FIRE"ish neon - stroke(xx,yy,sz);
	stroke( snap.get( (int)xx, (int)yy) );
  strokeWeight(strokeWt);

  // noTint();
  beginShape();


  	texture( snap.get( (int)xx, (int)yy, sz, sz ) );

    vertex(a.x, a.y, 0,0 );
    vertex(b.x, b.y, sz, 0 );
    vertex(c.x, c.y, 0, sz );
    vertex(d.x, d.y, sz, sz );
    
  endShape();

  stroke( snap.get( (int)xx, (int)yy) );
  fill( snap.get( (int)yy, (int)xx) );
  noFill();
  
  eSz = (frameCount%sz/2)*noise(frameCount);

	strokeWeight(strokeWt);

  
  rect( yy, xx, random(sz), random(sz), random(-TWO_PI,TWO_PI) );
  rect( xx+sz, yy-sz, random(sz), random(sz), random(-TWO_PI,TWO_PI) );
  
  stroke(xx,yy, sz+eSz );
  point(xx,yy);
  point(yy,xx);
  
  stroke(xx,yy,sz);
  point(xx+sz,yy+sz);
  point(yy+sz,xx+sz);
  
stroke(xx,yy+eSz,sz);
  point(xx-sz,yy-sz);
  point(yy-sz,xx-sz);


  strokeWeight(PI);
	stroke(xx,yy, sz+eSz );
	ellipse(xx,yy,eSz,eSz);


  strokeWeight(TWO_PI);	
	stroke( snap.get( (int)yy, (int)xx) );
	point(xx,yy);


  strokeWeight(PI);
	stroke( snap.get( (int)xx, (int)yy) );
	point(xx,yy);


	strokeWeight(strokeWt);

 //	STOPPER
 if(frameCount>width*height)
 {
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
    String[] appletArgs = new String[] { "CameraDrawer10" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
