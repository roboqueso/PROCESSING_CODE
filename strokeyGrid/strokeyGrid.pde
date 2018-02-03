//  grid with shrinking strokeWeight
import fixlib.*;

Fixlib fix = Fixlib.init(this);

int sColor = 0;
float x, y;
int sz = 1000;

void setup()
{
  size(displayWidth, displayHeight);
  background(#EFEFEF);
  frameRate(420);
  
  rectMode(CENTER);
//  ellipseMode(CENTER);
  
  strokeWeight(TWO_PI);
  noFill();

  x = y = -sz;
}


void draw()
{  
  rect( x, y, sz, sz );  
 
//  TODO: bring in webcam image and fill each box with image
//pushMatrix();
//translate(x, y, t);
//rotateX(radians(amp));
//box(amp%sz);
//popMatrix();
 
 
  
  //  increment size
  if(x<width){
    x+=sz;
  } else {
    x = -sz;
    y += sz;
  }

  if( y > height ){
    y = -sz;
    sz -= sqrt(sz);
    strokeWeight(sqrt(sz));
    sColor = ( sColor == 0 ? 255 : 0 );
    stroke(sColor, random(200,255));
  }
  
  if( sz < 42 ){
//    fill(#EF2014);
//    textSize(sz);
//    text("DONE", sz, height-sz);
    
    save( this+".png" );
    
    stop();
  }

}
