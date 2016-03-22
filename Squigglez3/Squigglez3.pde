//
//  This is a PRocessing sketch
//
// circles
Boolean isFinal = true;
int ctMAIN = 0;
float alf = 11;

int cX;
int cY;

int cubeSize = 150;

int dotSize     = 16;  // size of ellipse used to draw sine wave
int xspacing    = 10, yspacing = xspacing;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

float theta     = 0.0;  // Start angle at 0
float amplitude = 15;  // Height of wave
float period    = 100.0;  // How many pixels before the wave repeats
float dx;  // Value for incrementing X, a function of period and xspacing
float[] xvalues, yvalues;  // Using an array to store height values for the wave
float x = 0;

int xx = 0;
int yy = 0;

int outerXX = 0;
int outerYY = 0;

float angle = 0;
float maxAngle;
float radius = 100;
float outerRadius;

int offsetX = 0;
int offsetY = 0;

Boolean gotGrid = false;

Boolean flip = false;

color[] palette = { 
  #b8b6b8, #b8b6b7, #aba7a9, #999697, #bfbbbc, #a49fa0, #b5b1b1, #9a9393, #8d8a8a, #7f7c7c, #8d8887, #433e3d, #908886, #867e7c, #544d4b, #969392, #858281, #aca6a4, #999391, #888280, #988f8c, #9b9897, #999695, #675e5b, #544e4c, #8f8c8b, #6d6562, #8b8380, #5b5350, #bbb6b4, #9b9694, #918c8a, #7f7875, #79726f, #817874, #b0a7a3, #cccac9, #9d9997, #918985, #8b837f, #9a9694, #938f8d, #7f7773, #82807f, #68625f, #a69e9a, #9e9692, #aaa4a1, #9b9592, #7e7773, #7e7976, #827d7a, #6f6a67, #75706d, #7f7a77, #817c79, #918c89, #b3aba6, #918984, #a9a39f, #a6a09c, #9f9995, #99938f, #88827e, #999694, #7c7672, #b5afab, #9c9692, #878482, #a9a29d, #a7a09b, #9e9792, #8c8580, #b4b0ad, #a4a09d, #878380, #a39b95, #716d6a, #b1adaa, #a09c99, #9a9693, #999592, #77726e, #7c7773, #827d79, #948f8b, #898480, #afa9a4, #88827d, #aca6a1, #807a75, #b3ada8, #b1aaa4, #a8a19b, #968f89, #aba49e, #a9a19a, #84817e, #9e9a96, #7b7977, #86827e, #a09b96, #7c7976, #6b655f, #86807a, #4b4743, #b7b0a9, #b4afaa, #b4aea8, #ada8a3, #aca6a0, #a49e98, #6d6863, #a29c96, #8b857f, #827f7c, #aaa5a0, #8b8681, #989490, #bfb9b2, #807a73, #8a847d, #726d67, #a39e98, #a19a91, #74716d, #b3b0ac, #9b9894, #888581, #7d756a, #b6b1aa, #aea9a2, #847f78, #807b74, #9a958e, #89847d, #acaaa7, #a7a39d, #9e9a94, #ada9a3, #a5a19b, #a4a09a, #9c9892, #a6a097, #878178, #7c766d, #74726f, #aaa49b, #b0aba3, #8d8880, #a9a49c, #aeaba6, #86837e, #9c968c, #bab7b2, #9b9893, #888580, #9f9b94, #ada9a2, #6c6861, #9f9a91, #827d74, #4f4a41, #a19b90, #989287, #97938b, #9d988e, #49453d, #514c42, #8f8e8c, #8b8a88, #888785, #756f63, #b9b5ad, #a19e98, #a09d97, #979591, #a49f94, #847f74, #403b30, #cecac1, #9a968d, #a8a397, #615c50, #9c9a95, #7e7c77, #82807b, #857f6f, #b7b4ac, #b4b0a5, #7b776c, #737067, #3f3a2b, #969592, #74726b, #666358, #b2afa2, #696659, #85837a, #bab8af, #65635a, #535041, #464333, #6e6b5b, #747267, #5e5b4a, #88867a, #686657, #676554, #767462, #78776e, #67665a, #98978a, #6e6d5f, #5f5e50, #646940, #5a5c39, #4b5338, #5f6d50, #88a2d0, #8496c0, #74795e, #555544, #7c8c72, #8c937b, #8897a8, #c4daf2, #646555, #797c6a, #74867e, #898c79, #d5e8f8, #6f6f61, #9eacb7, #ddeffc, #828275, #dbebf4, #e4f5fd, #858e93, #c9d8dc, #e7f4fc, #8f9489, #ecfdfe, #898a81, #e8f5f9, #dae7ea, #a7b2b3, #edfcfe, #c5d0d1, #d1dcdd, #c0c9c5, #8e8e8b, #a7a7a5
 };

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
  maxAngle = (360*40);

  outerRadius = (radius + (PI+alf) );  //pow( radius, 2 );


  w = width+16;
  dx = (TWO_PI / period) * xspacing;
  xvalues = new float[w/yspacing];
  yvalues = new float[w/xspacing];

  
  strokeWeight(.75);

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

  if( flip ) {
    
    strokeWeight(.25);
    randStrokeUser();
    line( random(xx), random(yy), width-random(outerXX), height-random(outerYY) );
    
    
    stroke( #1975EF, alf );

  } else if( frameCount % 6 == 0 ) {
    strokeWeight(.5);
      stroke( #19EF75, (alf*2) );
      sineWave( xx, yy );
  } else {
    stroke( #EF1975, alf*3 );
    strokeWeight(.75);
    hexagon( xx, yy, alf*3 );
  }

  ellipse( xx, yy, radius, radius );  
}

  if( flip ) {
    angle += 4;
  } else {
    angle += alf;
  }


  if ( angle >= maxAngle )
  {    
    drawCore( offsetX, offsetY, int(maxAngle) );
    
    
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

