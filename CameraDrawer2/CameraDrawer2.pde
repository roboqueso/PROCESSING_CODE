import processing.video.*;
// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);


Capture cam;

PVector a, b, c, d;
int sz = 75,
    ms = 500,
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