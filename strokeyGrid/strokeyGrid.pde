//  SEE:   https://ello.co/ericfickes/post/zk-z5fw7ukg-x7i4jtwquq     
//  GOTO:  https://github.com/ericfickes/FIXLIB
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
  frameRate(666);
  
  rectMode(CENTER);

  
  strokeWeight(TWO_PI);
  noFill();

  x = y = -sz;
}


void draw()
{  
  rect( x, y, noise(frameCount)*sz, noise(frameCount)+sz );  
 
  
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
    stroke(sColor);
  }
  
  if( sz < 42 ){

    
    String saveName = fix.pdeName() + "-" + fix.getTimestamp();
    save( saveName +".png" );
    
    exit();
  }

}
