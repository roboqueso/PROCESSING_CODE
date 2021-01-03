//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB

import fixlib.*;
Fixlib fix = Fixlib.init(this);

int sColor = 0;
float x, y, sz = 66;
float xx, yy, theta, r, i, cX, cY;


void settings(){
  size(displayWidth, displayHeight, P3D);
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}

void setup()
{
  background(255);
  frameRate(420);
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
    noLoop();
    exit();
  }

}
