import processing.video.*;

float xx, yy, cX, cY, radSz;

Capture cam;
PImage snap;
PGraphics pg;


void setup()
{
  size(1280, 720, P3D);
  background(255);
  frameRate(404);

  cX = width/2;
  cY = height/2;
  radSz = width+height;

  pg = createGraphics(width,height,P3D);

  //  INIT Camera for color grabs
  cam = new Capture(this, Capture.list()[0]);
  cam.start();
}

float ix, iy, iSz;

void draw()
{
  xx = cX - int( cos(radians( frameCount )) * radSz+noise(frameCount) );
  yy = cY - int( sin(radians( frameCount )) * radSz+noise(frameCount) ); 


  if (cam.available()) 
  {
    if(snap==null || frameCount % 180 == 0 )
    {
      cam.read();
      snap = cam;

      if(xx%3==0)
        snap.filter(INVERT);
      else if ( xx % 4 == 0)
        snap.filter(GRAY);
      else if ( xx % 5 == 0)
        snap.filter(POSTERIZE,8);
      else
        noTint();

      ix = random(xx);
      iy = random(yy);
      iSz = random(radSz);

      pg.beginDraw();
      pg.ellipseMode(CENTER);
      pg.rectMode(CENTER);
      pg.imageMode(CENTER);
      pg.smooth();      
      
      

      // pg.tint(ix, iy, iSz, frameCount%111 );
      pg.tint(255, 42);
      pg.image(snap, ix, iy, iSz, iSz );

      pg.noFill();
      // pg.strokeWeight(PI);
      // pg.stroke( random(100,200) );
      pg.stroke( snap.get( (int)xx, (int)yy ) );
      pg.rect( ix, iy, iSz, iSz, random(-iSz, iSz) );

      //pg.strokeWeight(HALF_PI);
      pg.rect( ix, iy, iSz, iSz);

      
      pg.endDraw();
      image(pg,0,0);
      
    }

  }

  if(null!=snap) {
    pg.beginDraw();
    pg.smooth();
    pg.ellipseMode(CENTER);
    pg.rectMode(CENTER);
    // pg.strokeWeight(1);

    pg.stroke( snap.get( (int)xx, (int)yy ) );
    pg.noFill();


    //pg.rect( xx*noise(radSz), yy*noise(radSz), 20, 20, random(-42, 42) );

    pg.fill( xx%255, yy%255, (xx-yy)+frameCount%255, frameCount%255);
    pg.ellipse( xx*noise(radSz), yy*noise(radSz), 20, 20 );

    pg.endDraw();

    image(pg,0,0);

  }

  if(frameCount%360==0)
  {

    radSz -= 11;
  }
  
  
  
  if( radSz <= TWO_PI){
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

