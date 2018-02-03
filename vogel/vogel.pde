//  grid with shrinking strokeWeight
import fixlib.*;

Fixlib fix = Fixlib.init(this);
int sColor = 0;
float x, y, sz = 66;
float xx, yy, theta, r, i, cX, cY;

void setup()
{
//  size(displayWidth, displayHeight);
  size(1024,768);
  background(255);
  frameRate(420);
  
  smooth();
  noFill();
  
  x = y = -sz;
  cX = width/2;
  cY = height/2;
}


void draw()
{  



i = (sz + sqrt(5)) / 2;
theta = i * ((2 * PI)/i*i);
xx = cX + int( cos(radians(theta)) * i );
yy = cY + int( sin(radians(theta)) * i );
  



if(frameCount%15==0){
  strokeWeight(1);
  stroke(frameCount%255, 20);
  line(x,y,xx,yy);
}

stroke(frameCount%255);
strokeWeight(frameCount%7);
point(x, xx);
strokeWeight(frameCount%21);
point(y, yy);
point(xx,yy);	

  //  increment size
  if(x<width){
    x+=sz+i;
  } else {
    x = -sz;
    y += sz;
  }

  if( y > height ){

    y = -sz;
    sz -= sqrt(sz);
    cX = random(width/2);
    cY = random(height/2);
  }
  

  
  if( sz < 7 ){

    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
    
    stop();
  }

}
