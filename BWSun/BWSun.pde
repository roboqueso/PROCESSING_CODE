Boolean isFinal = true;

//  
//  Black and White
//  Tatoo / Asian style sun
//  Use HOTmess3 as background
//  
//  B&W sunbeams slowly alpha out?
//  
int alf = 50;

//  circle vars
float angle1 = 0, xx1, yy1, startX1, startY1, radius1 = alf;
float angle2 = 0, xx2, yy2, startX2, startY2, radius2 = alf*4;
float angle3 = 0, xx3, yy3, startX3, startY3, radius3 = alf*8;
float angle4 = 0, xx4, yy4, startX4, startY4, radius4 = alf*12;

int cX;
int cY;

color[] palette = { #EF0000, #00EF00, #0000EF, #CECE00, #FA7680, #EF1975, #007007, #EFEF00, #FA9187, #007007, #109109 };
PImage b;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  
//  b = loadImage("HOTmess3.png");
//  background(b);
background(#EF2012);

  //  setup variables
  cX = width/2;
  cY = height/2;

  startX1 = startX2 = startX3 = startX4 = 0;//cX;
  startY1 = startY2 = startY3 = startY4 = 0;//cY;
  
  stroke(0);
//  strokeWeight(.5);
}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();

  xx1 = startX1 - int( cos(radians(angle1)) * radius1 );
  yy1 = startY1 - int( sin(radians(angle1)) * radius1 );
  
  xx2 = startX2 - int( cos(radians(angle2)) * radius2 );
  yy2 = startY2 - int( sin(radians(angle2)) * radius2 );
  
  xx3 = startX3 - int( cos(radians(angle3)) * radius3 );
  yy3 = startY3 - int( sin(radians(angle3)) * radius3 );
  
  xx4 = startX4 - int( cos(radians(angle4)) * radius4 );
  yy4 = startY4 - int( sin(radians(angle4)) * radius4 );
  
  //  -------------
//  strokeWeight(random(alf/TWO_PI));
//  ellipse( xx1, yy1, alf, alf );
//  ellipse( xx2, yy2, alf, alf );
//  ellipse( xx3, yy3, alf, alf );  
  xx4 += random(noise(xx4))+random(TWO_PI);
  yy4 += random(noise(yy4))+random(TWO_PI);
  
  rect( xx4, yy4, alf, alf );


  beginShape(TRIANGLES);

    vertex( xx1, yy1 );
    vertex( xx2, yy2 );
    vertex( xx3, yy3 );
    vertex( xx4, yy4 );

  endShape();

  angle1 += 3;
  angle2 += 5;
  angle3 += 6;
  angle4 += 10;

if( frameCount % 180 == 0 ) {
  radius1 -= 9;
  radius2 -= 15;
  radius3 -= 18;
  radius4 += alf; 
}

  if ( frameCount > width+height )
  {    
    exit();
  }
}





///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randFill() {  
  fill( random(255), random(255), random(255), alf );
}
void randStroke() {  
  stroke( random(255), random(255), random(255), alf );
}
void randStroke100() {  
  stroke( random(255), random(255), random(255), 100 );
}

////////////////////////////////////////////////////
//  Randomly stroke using image from color list
void ranPalStroke(color[] palette)
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ], alf );
}
void ranPalStroke100(color[] palette)
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ], 100 );
}



void ranPalStroke(ArrayList palette)
{
  // pallete
  stroke( (Integer)palette.get( (int)random( palette.size()-1 ) ), alf );
}
void ranPalStroke100(ArrayList palette)
{
  // pallete
  stroke( (Integer)palette.get( (int)random( palette.size()-1 ) ), 100 );
}

void ranPalFill(ArrayList palette)
{
  fill( (Integer)palette.get( (int)random( palette.size()-1 ) ), alf );
}



void ranPalFill(color[] palette)
{
  fill( palette[ int(random( palette.length-1 )) ], alf );
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
//  End handler, saves png
void exit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( pdeName() + "-" + getTimestamp()+".png" );
  }

  noLoop();
  System.gc();
  super.stop();
}

///////////////////////////////////////////////////////////
String getTimestamp() {
  return ""+month()+day()+year()+hour()+minute()+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
String pdeName() {
  return split( this.toString(), "[")[0];
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

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 18 ) );
  smooth();

  fill(#EFEFEF);
  text( " "+dailyMsg, this.width-222, this.height-14);
/*
float yy = 0;
while( yy <= height ) {

  fill(#EFEFEF, yy*.15);
 text( " "+dailyMsg, 5, yy);
 yy += 18; 
}
*/

}

