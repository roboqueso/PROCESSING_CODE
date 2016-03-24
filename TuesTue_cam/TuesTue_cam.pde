import processing.video.*;

float xx, yy, cX, cY, sz, radSz;

Capture cam;
PImage snap;

void setup()
{
  size(1280, 720 ); //, P3D);
  background(255);
  frameRate(404);
  smooth();
  ellipseMode(CENTER);
  rectMode(CENTER);
  cX = width/2;
  cY = height/2;
  sz = cY+cX;
  strokeWeight(HALF_PI);

  //  INIT Camera for color grabs
  cam = new Capture(this, Capture.list()[0]);
  cam.start();
}


void draw()
{
  xx = cX - int( cos(radians( frameCount )) * sz+noise(frameCount*.2) );
  yy = cY - int( sin(radians( frameCount )) * sz+noise(frameCount*.2) ); 

  if (cam.available()) 
  {
    if(snap==null || frameCount % 180 == 0 )
    {
      cam.read();
      snap = cam;
      tint(random(xx), random(yy), random(sz), random(255) );
      snap.filter(INVERT);
      image(snap, random(xx), random(yy), random(sz), random(sz) );
      snap.filter(INVERT);
      
    }
  }

  if(null!=snap) {

    radSz = random(-sz/2, sz/2);

    stroke( (frameCount%xx)-sz, (frameCount%yy)-sz, (frameCount%sz)-sz);
    point( (xx - int( cos(radians( frameCount )) * sz*noise(xx) )%width*noise(frameCount)),
           (yy - int( sin(radians( frameCount )) * sz*noise(yy) )%height*noise(frameCount))
      );

    stroke( snap.get( (int)xx, (int)yy ) );
    ellipse( (xx - int( cos(radians( frameCount )) * sz*noise(xx) )%width*noise(frameCount)),
           (yy - int( sin(radians( frameCount )) * sz*noise(yy) )%height*noise(frameCount)),
           radSz, radSz
      );

    stroke( snap.get( (int)xx, (int)yy ), random(sz));
    
    fill( snap.get( (int)xx, (int)yy), random(radSz));


    ellipse(xx, yy, radSz, radSz );
    
    
    stroke( (frameCount%xx)-radSz, (frameCount%yy)-radSz, (frameCount%sz)-radSz, random(radSz,sz) );
    fill( snap.get( (int)xx, (int)yy ), random(radSz) );
    rect(xx, yy, radSz, radSz, random(-radSz,radSz) );

  }

  if(frameCount%360==0)
  {
    sz -= (sz*.1234);
  }
  
  
  
  if(sz <= TWO_PI){
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

