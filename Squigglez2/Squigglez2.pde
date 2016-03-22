//
//  This is a PRocessing sketch
//
// circles
Boolean isFinal = true;
int ctMAIN = 0;
float alf = 11;

int cX;
int cY;

int cubeSize = 50;

int dotSize = 16;  // size of ellipse used to draw sine wave
int xspacing = 8, yspacing = xspacing;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

float theta = 0.0;  // Start angle at 0
float amplitude = 15;  // Height of wave
float period = 100.0;  // How many pixels before the wave repeats
float dx;  // Value for incrementing X, a function of period and xspacing
float[] xvalues, yvalues;  // Using an array to store height values for the wave
float x = 0;

int xx = 0;
int yy = 0;

int outerXX = 0;
int outerYY = 0;

int pad = 69;

float angle = 0;
float maxAngle;
float radius = 69;  //150;
float outerRadius;

int offsetX = 0;
int offsetY = 0;

Boolean gotGrid = false;

Boolean flip = false;

color[] palette = { #EF1975, #EF0000, #19EF75, #1975EF, #928986, #918884, #9d9997, #8c8581, #7f7873, #6f6b67, #79746f, #7d7873, #817c77, #80766c, #908a83, #8b8884, #8a847c, #989085, #5e5446, #736e67, #7b756c, #8c8170, #594e3d, #706c65, #6b6457, #757066, #79746a, #555147, #6f6b61, #433c29, #6d674f, #534f3b, #575444, #47432c, #5d5a37, #434311 };

////////////////////////////////////////////////////
//
void setup() {
  // size to match image
  size(1024, 768);
  frameRate(303);
  background(21);

  //  -------------------------------------------

  smooth();
  noFill();


  cX = int( this.width / 2 );
  cY = int( this.height / 2 );


  offsetX = cX;///2;
  offsetY = cY;///2;

  //  max angle = where does the circle stop?
  maxAngle = (360*36);

  outerRadius = (radius + (PI+alf) );  //pow( radius, 2 );


  w = width+16;
  dx = (TWO_PI / period) * xspacing;
  xvalues = new float[w/yspacing];
  yvalues = new float[w/xspacing];

  
  strokeWeight(.75);
//  drawCore( offsetX, offsetY, int(maxAngle) );
}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();
  noFill();
  
  //  toggle at 180
  if( angle % 15 == 0 )
  {
    flip = !flip;
  }

    xx = ( offsetX - int( sin(radians(angle)) * radius ) );
    yy = ( offsetY - int( cos(radians(angle)) * radius ) );

    outerXX = ( offsetX - int( sin(radians(angle)) * outerRadius ) );
    outerYY = ( offsetY - int( cos(radians(angle)) * outerRadius ) );


  
if( frameCount % 15 == 0 ) {

  stroke( #EFEFEF, alf );
  ellipse( xx, yy, radius, radius );
  sineWave( outerXX, outerYY );
  
  radius++;
  
} else {
  
  if( flip )
    stroke( #1975EF, alf );
  else if( frameCount % 6 == 0 )
    stroke( #19EF75, alf );
  else
    stroke( #EF1975, alf );

  ellipse( xx, yy, radius, radius );  

  sineWave( xx, yy );
}

  if( flip ) {
    angle += 4;
  } else {
    angle += alf;
  }


  if ( angle >= maxAngle )
  {    
    exit();
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
void exit() 
{
  
  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( this + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
  }

  super.stop();
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
void randStrokeUser()
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ] , alf );
}
void randFillUser()
{
  fill( palette[ int(random( palette.length-1 )) ] , alf );
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
  fill(#CADDAC, pow(alf,3) );
  text( " "+dailyMsg, this.width-226, this.height-16);
}


///////////////////////////////////////////////////////////
//  draws circle from supplied x, y
void drawCore( int XX, int YY, int maxSize ) {

  float r = 1;  // 75;
  float theta = 2;

  float alf = 10;
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

/////
//  Sine Wave grid, axii starting and supplied x and y
void sineWave( float startX, float startY ) {

  // Increment theta (try different values for 'angular velocity' here
  float theta = 0.02;

// NOTE: all of this code assumes the same settings for x and yvalues

  // For every x value, calculate a y value with sine function
  float x = theta;
  float y = theta;
  for (int i = 0; i < yvalues.length; i++) {
    xvalues[i] = sin(y)*amplitude;
    yvalues[i] = sin(x)*amplitude;
    x+=dx;
    y+=dx;
    
  }


  noStroke();    

  // A simple way to draw the wave with an ellipse at each location
  int yy = 0;
  for (int xx = 0; xx < yvalues.length; xx++) {

    smooth();    
    strokeWeight(2);
    
    randStrokeUser();

    //  HORIZONTAL
//    ellipse(xx*xspacing,startY+yvalues[xx], dotSize, dotSize);
    point(xx*xspacing,startY+yvalues[xx]);

    //  VERTICAL
    point(startX+yvalues[xx], yy*yspacing);//,dotSize, dotSize);
    
    yy++;
  }
}

