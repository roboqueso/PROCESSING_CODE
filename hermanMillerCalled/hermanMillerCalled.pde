//  SEE:   https://ello.co/ericfickes/post/qwctg0xzw-o6dmutpjrtaq
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);

// circles
Boolean isFinal = true;
int ctMAIN = 0;
int alf = 42;

int cX;
int cY;


color[] p1 = { #EF0000, #111111, #959394, #bbb9ba, #787878, #273121, #2b3323, #31382a, #22251c, #373b2f, #414638, #41453a, #4c4e45, #3e453f, #575e55, #59605c, #a7b0b4, #7c7e81, #757874, #3c3c3a, #494b4a, #979599, #767977, #a19fa3, #b3b6b7, #606262, #959898, #9b9d9e, #828381, #9c9e9d, #9f9ea0, #b1b2b3, #d8d7d9, #5a5555, #a29b9b, #9a9191, #827e7e, #8e8785, #928986, #7d736f, #7b6f6a, #d2cbc8, #aca5a2, #a59f9c, #887f7a, #aca5a1, #87807b, #c4b9b1, #a39b95, #bcb4ae, #b0a8a2, #9f9791, #a8a39f, #b8b1ab, #b9b6b3, #a39e98, #a29d97, #98938c, #757068, #7d7a75, #75736f, #8b8882, #a6a196, #767469 };
color[] p2 = { #484547, #4c4434, #575550, #3c3a2f, #44432b, #3f3f2c, #383828, #32382a, #373c2d, #3b3b2d, #424636, #23261e, #262921, #444b3d, #394337, #485346, #434d45, #454e45, #52554b, #d8f8f8, #848c94, #e4fcfc, #323531, #838d8a, #73736c, #7b8283, #817e86, #d3d4dd, #f0f7f8, #dad7dc, #fafefe, #fbfefe,#574f50, #55443e, #5c4e48, #725644, #785c49, #4d453f, #9c8e83, #86684f, #997046, #be8649, #787571, #b19866, #6d6a64, #dabe82, #7c7a72, #313728, #333c2c, #5a5b49, #4c4c3e, #4c4f42, #4a5346, #4a4b40, #465147, #5e5a65, #5d5b65, #575159, #74787f, #707970, #6f7570, #797b7d };

//  circle vars
float angle1, xx1, yy1, startX1, startY1, radius1;
float angle2, xx2, yy2, startX2, startY2, radius2;
float angle3, xx3, yy3, startX3, startY3, radius3;
float angle4, xx4, yy4, startX4, startY4, radius4;

float maxAngle;

////////////////////////////////////////////////////
//
void setup() {
  size(displayWidth, displayHeight, P3D);
  frameRate(303);
  pixelDensity(displayDensity());
  background(9);
  smooth(8);
  noFill();

  cX = int( this.width / 2 );
  cY = int( this.height / 2 );

  maxAngle = 360;
  
  startX1 = startX2 = startX3 = startX4 = cX;
  startY1 = startY2 = startY3 = startY4 = cY;

  stroke(0, alf);
  strokeWeight(alf);
  
  //  setup circles
  radius1 = 50;
  radius2 = 150;
  radius3 = 250;
  radius4 = 350;
  
  
  
  // scan lines
//  stroke(#2012EF);
  stroke ( 1, 255, 1, alf);
  for ( int ll = 0; ll <= width; ll += 2 ) 
  {


    
    strokeWeight( noise(ll) );
    line( width, random(ll), random(width), random(ll) );
    line( random(ll), 0, random(ll), random(height) );
  }
  
  
  strokeWeight(3);
  stroke(#1975EF,alf);
  
  xx1 = cX;
  yy1 = cY;
}


////////////////////////////////////////////////////
//
void draw()
{

  xx1 += noise( frameCount );
  yy1 += noise( frameCount/2+alf );
  
  xx2 += noise( frameCount );
  yy2 += noise( frameCount/2+alf );  

  if( xx1 > width ) {
    xx1 = -noise( random(TWO_PI) ); 
  }
  if( yy1 > height ) {
    yy1 = -noise( random(PI, cY) ); 
  } 
  if( xx2 > width ) {
    xx2 = -noise( random(TWO_PI) ); 
  }
  if( yy2 > height ) {
    yy2 = -noise( random(PI, cY) ); 
  }  



  noiseDetail(3, random(TWO_PI/PI) );
  ranPalStroke100(p1);
  point( xx1, yy1 );
  ranPalStroke100(p1);
  point( xx2, yy2 );

  ranPalStroke100(p2);  
  line( xx1, yy2, xx2, yy1 );
  
  stroke(alf*255, alf);
  rect( xx1, yy1, xx2, yy2 );
  
  noiseDetail(8,0.65);
  ranPalStroke100(p1);
  point( yy1, xx1 );
  ranPalStroke100(p1);
  point( yy2, xx2 );  

  stroke(#EFEFEF, alf);
  rect( xx2, yy2, xx1, yy1 );
  
  ranPalStroke(p1);  
  line( xx2, yy1, xx1, yy2 );
  
  
  //  STOPPER   ////////////////////////////////////////////////
  if ( frameCount >= width+height )
  {    
    doExit();
  }
 
}
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////
//  noisely stroke using image from color list
void ranPalStroke(color[] palette)
{
  // pallete
  stroke( palette[ int(noise( palette.length-1 )) ], alf );
}
void ranPalStroke100(color[] palette)
{
  // pallete
  stroke( palette[ int(noise( palette.length-1 )) ], 100 );
}

void ranPalFill(color[] palette)
{
  fill( palette[ int(noise( palette.length-1 )) ], alf );
}


//////////////////////////
int f0 = 0;
int f1 = 1;
//int f2 = 1;

int nextFib( int f2)
{
  //   int result = f2;
  f0 = f1;
  f1 = f2;
  f2 = f0 + f1;

  return f0 + f1;
}

//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
void circle( float startX, float startY, float w, float h ) {

  float angle = 0;
  float xx, yy;
  noFill();
  
  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    if( angle % 3 == 0 ) {

    xx = startX - int( cos(radians(angle)) * w );
    yy = startY - int( sin(radians(angle)) * w );


    ellipse( xx, yy, w, h );
    }
    angle++;
  }
}


//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
//  OVERRIDE : @modAngle - restrict drawing to angle % @modAngle
void circle( float startX, float startY, float w, float h, float modAngle ) {

  float angle = 0;
  float xx, yy;

  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    if( angle % modAngle == 0 ) {

      xx = startX - int( cos(radians(angle)) * w );
      yy = startY - int( sin(radians(angle)) * w );
  
      smooth();
      ellipse( xx, yy, w, h );
    }
    angle++;
  }
}


//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
//  OVERRIDE : @modAngle - restrict drawing to angle % @modAngle
void dotCircle( float startX, float startY, float w, float h, float modAngle ) {

  float angle = 0;
  float xx, yy;

  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    if( angle % modAngle == 0 ) {

      xx = startX - int( cos(radians(angle)) * w );
      yy = startY - int( sin(radians(angle)) * w );
  
      smooth();
      point( xx, yy );
    }
    angle++;
  }
}

//////////////////////////////////////////////////////////////////////////
//  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
void hexagon( float startX, float startY, float shapeSize ) {

  line( startX, startY+(shapeSize*.5), startX+(shapeSize*.25), startY );
  line( startX+(shapeSize*.25), startY, startX+(shapeSize*.75), startY );
  line( startX+(shapeSize*.75), startY, startX+(shapeSize), startY+(shapeSize*.5) );

  line( startX+(shapeSize), startY+(shapeSize*.5), startX+(shapeSize*.75), startY+shapeSize );
  line( startX+(shapeSize*.75), startY+shapeSize, startX+(shapeSize*.25), startY+shapeSize );
  line( startX+(shapeSize*.25), startY+shapeSize, startX, startY+(shapeSize*.5) );
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
    save( fix.pdeName() + fix.getTimestamp() + ".png" );
  }

  exit();  
}

///////////////////////////////////////////////////////////
//  Helper to noise(255) stroke
void randFill() {  
  fill( noise(255), noise(255), noise(255), alf*2 );
}
void randStroke() {  
  stroke( noise(255), noise(255), noise(255), alf*2 );
}
void randStroke100() {  
  stroke( noise(255), noise(255), noise(255), 100 );
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
  fill(#EFEFEF, pow(alf,3) );
  text( " "+dailyMsg, this.width-225, this.height-15);
  
  fill( #EF0000 , 666 );
  fill(0, pow(alf,3) );
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
  //  MODE	Either CENTER, RADIUS, CORNER, or CORNERS


  //  lines	
  line( x-(w*2), y, x, y + w*PI);
  line( x+(w*2), y, x, y + w*PI);
}
