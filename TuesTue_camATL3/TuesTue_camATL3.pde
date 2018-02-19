import processing.video.*;
// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);


float xx, yy, cX, cY, sz, radSz;

Capture cam;
PImage snap;


void setup()
{
  size(1280, 720);//, P3D);
  background(255);
  frameRate(404);
  smooth();
  rectMode(CENTER);
  cX = width/2;
  cY = height/2;
  sz = HALF_PI;
  strokeWeight(sz);

  //  INIT Camera for color grabs
  cam = new Capture(this, Capture.list()[0]);
  cam.start();     
}

void draw()
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

  xx = cX - int( cos(radians( frameCount )) * sz+noise(frameCount*.2) );
  yy = cY - int( sin(radians( frameCount )) * sz+noise(frameCount*.2) ); 
  
  
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

  sz += .021; //.016;

}

  if(sz>=height){
  	
  	cam.stop();

    save( fix.pdeName() + fix.getTimestamp() + ".png");
    noLoop();
    exit();
  }


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