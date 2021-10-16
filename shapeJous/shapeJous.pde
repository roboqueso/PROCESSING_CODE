//  SEE:   https://ello.co/ericfickes/post/_9obthgdr-a-nsbqgxjitg
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);

int cX;
int cY;
float x,y, t;
float angle = 0;
float xx, yy, startX, startY;
float w = 33;

void setup() {

    size(displayWidth, displayHeight);
    pixelDensity(displayDensity());
    smooth(8);
    noFill(); 

    cX = width/2;
    cY = height/2;
    startX = cX;
    startY = cY;
    xx = yy = -(w/2);
}




void keyPressed(){

  if( keyCode == ESC ){
  
    save(fix.pdeName()+fix.getTimestamp()+".png");
    noLoop();
    super.exit();
  }
}


//////////////////////////////////////////////////////
//  TODO: optimize this
void drawLissajous( float a, float b, float amp )
{
  float x, y;
 
  for ( float t = 0; t <= 360; t+=.2)  //t+=.2 )
  {
    x = a - amp * sin(a * t * PI/180);
    y = b - amp * sin(b * t * PI/180);

    point(x, y);

  }

}


//////////////////////////////////////////////////////
//  Lissajous PShape maker
PShape shapeJous( float a, float b, float amp )
{
  
  PShape shp = createShape();
  shp.beginShape();

  float x, y;


//  TODO: build a P5 GIF maker that runs this shapeJous and increments the T+ value by .5
//  record frames and animate, include spitting out of T value so you know 
  for ( float t = 0; t <= 360; t+=12)
  {
    x = a - amp * sin(a * t * PI/180);
    y = b - amp * sin(b * t * PI/180);

    shp.vertex(x, y);
  }
  shp.endShape();
  return shp;
}




  float orbitRadius;
  float ypos;
  float xpos;
  float zpos;


////////////////////////////////////////////////////////////


void draw() {


strokeWeight(random(PI));

  translate(xx, yy, 11);
  shape( shapeJous( xx, yy, 21 ) );
  
  if( yy > height ) {
    save(this+".png");
    exit();
  }
  
  t++;

  if( xx > width ) {
    xx = -(w/2);
    yy += w;
  } else {
    xx += w; 
  }

  
  
  
  
}
