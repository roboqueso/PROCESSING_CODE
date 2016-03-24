import processing.video.*;

float xx, yy, cX, cY, sz;

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

  xx = cX - int( cos(radians( frameCount )) * sz+noise(frameCount*.2) );
  yy = cY - int( sin(radians( frameCount )) * sz+noise(frameCount*.2) ); 

  if(null!=snap)
    stroke( snap.get( (int)xx, (int)yy) );
  else
    stroke( (frameCount%xx)-sz, (frameCount%yy)-sz, (frameCount%sz)-sz);
  
  
  if(null != snap)
    fill( snap.get( (int)yy, (int)xx), 42);
  else
  	fill( yy-xx+sz, xx-sz, yy-sz);  
	
	//	OG  
	// stroke( (frameCount%xx)-sz, (frameCount%yy)-sz, (frameCount%sz)-sz);
	// fill( yy-xx+sz, xx-sz, yy-sz);

  rect(xx, yy, TWO_PI+noise(sz), TWO_PI+noise(sz), random(-42,42) );

  sz += .021; //.016;



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

  
  if(sz>=height){
  	
  	cam.stop();

    save(pdeName() + getTimestamp() + ".png");
    noLoop();
  }


}




////// S SAVE HANDLER /////////

void keyPressed(){
switch(key){
  case 's':
    save(pdeName() + getTimestamp() + ".png");
  break;

  case ESC:
    save(pdeName() + getTimestamp() + ".png");
    stop();
  break;
}

}  

public String getTimestamp() {
  return ""+month()+day()+year()+hour()+minute()+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
public String pdeName() {
  return split( this.toString(), "[")[0];
}

