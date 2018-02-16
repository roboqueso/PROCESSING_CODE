      


      // TODO: CHANGE OVER TO USING STL FILES AND HE_MESH
// SEE: BRENDAN'S BLOG POST
//  wasting to much time on DXFs

import processing.opengl.*;
import processing.dxf.*;
// https://github.com/ericfickes/FIXLIB  
import fixlib.*;

Fixlib fix = Fixlib.init(this);

int numFrames = 144;

// circles
Boolean isFinal = true;
int ctMAIN = 0;
int alf = 242;//42;//37;

int cX;
int cY;

int stroke1 = 1;
float stroke2 = .5;
//

color[] p2 = { 
  #69a142, #b00be5
};

color[] p1 = { 
  #0e75f0, #031224, 
  #E19F42, #E0BF42
};

//  circle vars
float angle1, xx1, yy1, startX1, startY1, radius1;
float angle2, xx2, yy2, startX2, startY2, radius2;
float angle3, xx3, yy3, startX3, startY3, radius3;
float angle4, xx4, yy4, startX4, startY4, radius4;

float maxAngle;

////////////////////////////////////////////////////
//
void setup() {
  // size to match image
  size(1024, 768, P3D);
  frameRate(303);
  background(42);
  
  fix.alpha(alf);
  
  //  -------------------------------------------
  smooth();
  noFill();

  cX = int( this.width / 2 );
  cY = int( this.height / 2 );

  maxAngle = width * 3;

  startX1 = startX2 = startX3 = startX4 = cX;
  startY1 = startY2 = startY3 = startY4 = cY;

  angle1 = angle2 = angle3 = angle4 = 90;

  //  setup circles
  radius1 = 100;
  radius2 = 200;
  radius3 = 300;
  radius4 = 500;

  strokeWeight( PI );
}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();
  noFill();

if( frameCount == 1 ){
  beginRaw( DXF, fix.pdeName() +".dxf" );
}


  xx1 = startX1 - int( cos(radians(angle1)) * radius1 );
  yy1 = startY1 - int( sin(radians(angle1)) * radius1 );

  xx2 = startX2 - int( cos(radians(angle2)) * radius2 );
  yy2 = startY2 - int( sin(radians(angle2)) * radius2 );

  xx3 = startX3 - int( cos(radians(angle3)) * radius3 );
  yy3 = startY3 - int( sin(radians(angle3)) * radius3 );

  xx4 = startX4 - int( cos(radians(angle4)) * radius4 );
  yy4 = startY4 - int( sin(radians(angle4)) * radius4 );

  //  -------------


  fix.ranPalStroke(p2);
  //  quad(x1, y1, x2, y2, x3, y3, x4, y4)
  //  arc(x, y, width, height, start, stop)
  //  bezier(x1, y1, cx1, cy1, cx2, cy2, x2, y2);
//  bezierVertex(cx1, cy1, cx2, cy2, x, y)
//bezier(xx1, yy1, xx2, yy2, xx3, yy3, xx4, yy4);


beginShape(POLYGON);

// NOTE : DON'T FORGET Z, WHEN 3-D ING

  vertex(xx4, yy4, yy2);
  // this one makes the buddha head
  bezierVertex(xx1, yy2, xx3, yy4, xx3, yy2);

  //  this one is backing spiral action
  // bezierVertex(xx2, yy2, xx3, yy3, xx4, yy4);
endShape(CLOSE);
    
/*

    //  TRIANGLE
//  strokeWeight( 1 );
beginShape(TRIANGLE_STRIP);
  fix.ranPalStroke(p1);
   vertex(xx1, yy1, frameCount);
   vertex(xx2, yy2, frameCount);
   vertex(xx3, yy3, frameCount);
   vertex(xx4, yy4, frameCount);
endShape();
*/

  angle1 += 2;
  angle2 += 4;  //2;
  angle3 += 6;
  angle4 += 8;

/*
  if ( floor(angle1) % 768 == 0 ) {
    radius1 += 4;
    radius2 += 4;
    radius3 += 4;
    radius4 += 4;
  }
*/

  // if ( angle1 >= maxAngle )
  if( frameCount % numFrames == 0 ){
    endRaw();

    save( fix.pdeName()+".png");

    noLoop();
    exit();
  }
}


///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName()+".png" );
  }

  noLoop();
  exit();
}



///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  PFont font = createFont( "Silom", 18 );

  smooth();
  textFont( font );
  strokeWeight(1);

  //  fill( #000000 , 666 );
  fill(#EFEFEF, pow(alf, 3) );
  text( " "+dailyMsg, this.width-225, this.height-15);

  //  fill( #004200 , 666 );
  fill(0, pow(alf, 3) );
  text( " "+dailyMsg, this.width-226, this.height-16);
}


///////////////////////////////////////////////////////////
//  draws circle from supplied x, y
void drawCore( int XX, int YY, int maxSize ) {

  float r = 1;  // 75;
  float theta = 2;

  int alf = 10;
  float x;
  float y;

  smooth();
  strokeWeight(.13);

  while ( theta <= maxSize )
  {    
    x = (PI*r) * cos(theta);
    y = (PI*r) * sin(theta);

    if (x%2==0)stroke(255, alf);
    else if (x%3==0) stroke(255, 0, 0, alf);
    else stroke( 109, 109, 109, alf);

    ellipse( int(XX+x), int(YY+y), x, x );

    heart( int(YY+y), int(XX+x), int(y), int(y) );

    theta+= 0.25;

    if ( frameCount%2==0) {
      r++;
      theta+=.5;
    }
  }
}




///////////////////////////////////////////////////////////
//  
//  draw heart
void heart( int x, int y, int w, int h ) 
{
  ellipseMode(RADIUS);
  smooth();

  //  stroke(#EF7519, alf);  // 37
  stroke(#EF1111, alf);  // 37

  strokeWeight(2);
  //  noFill();

  //  bubbles
  ellipse( x-w, y, w, w);
  ellipse( x+w, y, w, w);
  //  ellipseMode(MODE)
  //  MODE  Either CENTER, RADIUS, CORNER, or CORNERS


  //  lines  
  line( x-(w*2), y, x, y + w*PI);
  line( x+(w*2), y, x, y + w*PI);
}