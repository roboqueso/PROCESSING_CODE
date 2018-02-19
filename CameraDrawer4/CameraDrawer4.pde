import processing.video.*;
// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);


Capture cam;

PVector a, b, c, d;
int sz = 42,
    ms = 1000,
    horSlitSz;  

float xx, yy;
PImage snap;



//////////////////////////////////////////////////////////////////////
void setup() 
{
  size(1280, 720, P3D);
  background(255);
  smooth();

  cam = new Capture(this, Capture.list()[0]);
  cam.start();     
  xx = yy = 0;
}

//////////////////////////////////////////////////////////////////////
void draw() {

 // STOPPER
 if(frameCount>width*5)
 {
  cam.stop();
  save( fix.pdeName() + fix.getTimestamp() + ".png");
  println("done");
  noLoop();
  exit();
 }



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
/*

    	//	VERTICAL
      cam.read();
      tint(255, random(155,255));
      // noTint();
      image(cam.get((int)xx, 0, (int)random(2,TWO_PI), height), xx, 0 );
*/
    }
    else if ( frameCount%11==0)
    {
      //	HORIZONTAL
      horSlitSz = (int)random(HALF_PI,13);
      
      stroke( snap.get( (int)xx, (int)yy) );
      rect(0, yy-1, xx, horSlitSz+1);
      
      cam.read();
      
      if(yy>(height/2))
      	cam.filter(POSTERIZE, random(PI, sz) );
      else
      	cam.filter(GRAY);
      
      // grab a slice that only goes to the shape, not full width	
      image( cam.get(0, (int)yy, (int)xx, horSlitSz), 0, yy, xx, horSlitSz );
    }


    xx = frameCount%width;
    yy = (frameCount%height) - int( sin(radians(frameCount)) * sz )
    			%height;

    a = new PVector( xx-sz, yy, random(sz) );
    b = new PVector( xx, yy-sz, random(sz) );
    c = new PVector( xx+sz, yy, random(sz) );
    d = new PVector( xx, yy+sz, random(sz) );
  
  // "FIRE"ish neon - stroke(xx,yy,sz);
  // stroke(xx,yy,sz);
  beginShape();

  	texture( snap.get( (int)xx, (int)yy, sz, sz ) );

    vertex(a.x, a.y, 0,0 );
    vertex(b.x, b.y, sz, 0 );
    vertex(c.x, c.y, sz, sz );
    vertex(d.x, d.y, 0, sz );
    
  endShape();

  stroke( snap.get( (int)xx, (int)yy) );
  fill( snap.get( (int)yy, (int)xx) );

  rect( yy, xx, random(sz), random(sz), random(-TWO_PI,TWO_PI) );
  rect( xx+sz, yy-sz, random(sz), random(sz), random(-TWO_PI,TWO_PI) );


  }



}


//  Return a random vector based on supplied x,y and sz
PVector GetRandVector( float x, float y, float sz )
{
  return new PVector( 
        x - int( cos(radians( random(360) )) * sz ),
        y - int( sin(radians( random(360) )) * sz ),
        random(-sz,sz)
      );
}





////// S SAVE HANDLER /////////

void keyPressed(){
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