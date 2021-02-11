//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);


// circles
Boolean isFinal = true;
int ctMAIN = 0;
int alf = 37;

int cX;
int cY;

int stroke1 = 2;
//

color[] p2 = { 
#EF0000, #111111, #EFEFEF, #006768,#EF0000, #EFEF11, #36EF75, #EF7535, #FF1234, #EF3619,#A59DA1,#D96D55,#F36613,#A9ABEA,#D23301,#F6FAFD,#AB6E9C,#D6F9FF,#F8751E,#768A00,#F05510,#FFEE51,#FFB02A,#D7D5FA,
};

color[] p1 = { 
  #EFEFEF, #EF1975, #19EF75, #1975EF
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
  size(1024, 768);
  frameRate(303);
  background(36);

  //  -------------------------------------------
  smooth();
  noFill();

  cX = int( this.width / 2 );
  cY = int( this.height / 2 );

  maxAngle = 768 * 6;
  
  startX1 = startX2 = startX3 = startX4 = cX;
  startY1 = startY2 = startY3 = startY4 = cY;

  angle1 = angle2 = angle3 = angle4 = 90;
  
  //  setup circles
  radius1 = 50;
  radius2 = 150;
  radius3 = 200;
  radius4 = 250;
}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();
  noFill();


  xx1 = startX1 - int( cos(radians(angle1)) * radius1 );
  yy1 = startY1 - int( sin(radians(angle1)) * radius1 );
  
  xx2 = startX2 - int( cos(radians(angle2)) * radius2 );
  yy2 = startY2 - int( sin(radians(angle2)) * radius2 );
  
  xx3 = startX3 - int( cos(radians(angle3)) * radius3 );
  yy3 = startY3 - int( sin(radians(angle3)) * radius3 );
  
  xx4 = startX4 - int( cos(radians(angle4)) * radius4 );
  yy4 = startY4 - int( sin(radians(angle4)) * radius4 );
  
  //  -------------
  strokeWeight(stroke1);  
  
//
stroke( 0, 50);
ellipse( xx1, yy1, radius1, radius1);//, alf );

stroke( #000000,alf);
bezier( xx1, random(yy1), xx2, yy2, xx3, yy3, xx4, yy4 );

ranPalStroke100(p2);
bezier( xx1, yy1, xx2, yy2, xx3, yy3, xx4, yy4 );


ranPalStroke(p2);
strokeWeight( random(alf) );
point(xx1, yy1);
point(xx2, yy2);
point(xx3, yy3);
point(xx4, yy4);


  angle1 += 2;
  angle2 += alf/2;  //2;
  angle3 += alf/3;  //3;
  angle4 += alf;  //4;


  if( angle1 % 768 == 0 ) {
    radius1 += alf;
    radius2 += alf*2;
    radius3 += alf*3;
    radius4 += alf*4;
  }


  if ( angle1 >= maxAngle )
  {    
    exit();
  }
 
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

void ranPalFill(color[] palette)
{
  fill( palette[ int(random( palette.length-1 )) ], alf );
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

  super.stop();
}

///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randFill() {  
  fill( random(255), random(255), random(255), alf*2 );
}
void randStroke() {  
  stroke( random(255), random(255), random(255), alf*2 );
}
void randStroke100() {  
  stroke( random(255), random(255), random(255), 100 );
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
  
//  fill( #003600 , 666 );
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



