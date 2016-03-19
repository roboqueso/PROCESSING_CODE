/*
Specifies vertex coordinates for curves. This function may only be used between beginShape() and 
 endShape() and only when there is no MODE parameter specified to beginShape(). 
 The first and last points in a series of curveVertex() lines will be used to guide the beginning 
 and end of a the curve. A minimum of four points is required to draw a tiny curve between the 
 second and third points. Adding a fifth point with curveVertex() will draw the curve between the 
 second, third, and fourth points. The curveVertex() function is an implementation of Catmull-Rom 
 splines. 
 Using the 3D version of requires rendering with P3D or OPENGL (see the Environment reference for 
 more information)
 */
Boolean isFinal = true;
String artDailyMsg = "ERICFICKES.COM";  //"rotateX";  //"rotateY";  //"rotateZ";
//  
float alf = 69;

//  circle vars
float i, angle1 = 180, xx1, yy1, startX1, startY1, radius1 = 37;
/*
float angle2 = 0, xx2, yy2, startX2, startY2, radius2 = alf*5;
 float angle3 = 0, xx3, yy3, startX3, startY3, radius3 = alf*7;
 float angle4 = 0, xx4, yy4, startX4, startY4, radius4 = alf*9;
 */
int cX;
int cY;

color[] p1 = { 
  #EF0000, #00EF00, #0000EF, #CECE00, #FA7680, #EF1975, #007007, #EFEF00, #FA9187, #007007, #109109
};
//PImage b;
//ArrayList p3;

//  VECTOR ACTION - http://processing.org/reference/PVector.html
//PVector v1, v2;


////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  background(#C1C1C1);


  //  setup variables
  cX = width/2;
  cY = height/2;

//  startX1 = width;
//  startY1 = height;


  
  //  SCAN LINES
  strokeWeight(.75);
//  stroke(#EFEFEF);
  for( int w = 0; w < height; w++ ) {
    stroke( random(255),alf );
    line(0, w, width, w );
  }
  
  stroke(0);
  strokeWeight(10);
  xx1 = yy1 = -alf;
  noFill();
  
}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();

    strokeWeight(12);

//  ROTATE!!!
  rotateX(frameCount);
  rotateY(frameCount);
  rotateZ(frameCount);
    
    xx1 = cX-frameCount-cos( radians( frameCount ) ) * alf;
    yy1 = cY-frameCount-sin( radians( frameCount ) ) * alf;
   

    stroke(random(37) );//, 100);
    point( xx1, yy1, frameCount );
    point( yy1, xx1, frameCount );

    stroke(random(111) );
    point( xx1, yy1, frameCount+i*PI );
    point( yy1, xx1, frameCount+i*PI );

    stroke(random(255), random(37), random(37));//, 100);
    line( xx1, yy1, yy1, xx1 );
    
    stroke(random(37), random(255), random(37), 100);    
    ellipse( xx1, yy1, alf, alf );
    ellipse( yy1, xx1, alf, alf );

    // RESET BOTH IF Y GOES OUTSIDE
    if( yy1 > height || yy1 < 0) {
      xx1 = yy1 = random(alf)*noise(frameCount); 
    }


    // move over a pixel
    if ( i <= height || i < 0) {
        i += noise(frameCount) * cos( TWO_PI * sin(radians(frameCount)) );
    } else {
        i = cos(frameCount/TWO_PI) * sin( noise(frameCount) );
    }


  //
  //  STOP
  //  
  if ( frameCount > width )
  {    
    exit();
  }


  System.gc();
}


//////////////////////////////////////////////////////
//  Pass in a color, and this will fill even frames with 255,
//  odd frames with clr
void evenOddFill( color clr ) {
  if ( frameCount % 2 == 0 ) {
    fill(255);
  } 
  else {
    fill( clr );
  }
}
//////////////////////////////////////////////////////
//  Pass in a color, and this will fill even frames with 255,
//  odd frames with clr
//  * INVERTED for evenOddFill() pleasure
void evenOddStroke( color clr ) {
  if ( frameCount % 2 == 0 ) {
    stroke(clr);
  } 
  else {
    stroke(0);
  }
}

//////////////////////////////////////////////////////
//  
void drawLissajous( float a, float b, float amp )
{
  //  float amp = 33;
  float x, y;
  float sz = amp / PI;  //TWO_PI;

  noFill();

  for ( float t = 0; t <= 360; t += 1)
  {
    x = a - amp * sin(a * t * PI/180);
    y = b - amp * sin(b * t * PI/180);

    //    point(x,y);

    //  ranPalStroke100(p3);
    //  ranPalFill(p3);


    ellipse(x, y, sz, sz);
  }
}

/////////////////////////////////////////////////////////////////
//  spit out an 8bit heart
void bitHeart( float x, float y, boolean grid ) {

  int blockSize = 25;
  float htSize = 250;
  strokeWeight(.5);

  //  GRID
  if (grid) {
    stroke(#EFEFEF);//, 50);

    for ( int xx = 0 ; xx <= 13; xx++ ) {

      line( x+(blockSize*xx), 0, x+(blockSize*xx), height );
      line( 0, y+(blockSize*xx), width, y+(blockSize*xx) );
    }
  }
  //  GRID



  //  HEART
  stroke(#333333);

  //  white blocks
  fill(255);
  rect( x+(blockSize*2), y+blockSize, blockSize, blockSize );
  rect( x+(blockSize), y+(blockSize*2), blockSize, blockSize );

  fill(0);
  // TODO: make this smarter
  rect( x+(blockSize*2), y, blockSize, blockSize );
  rect( x+(blockSize*3), y, blockSize, blockSize );
  rect( x+(blockSize*4), y, blockSize, blockSize );

  rect( x+(blockSize*8), y, blockSize, blockSize );
  rect( x+(blockSize*9), y, blockSize, blockSize );
  rect( x+(blockSize*10), y, blockSize, blockSize );

  rect( x+(blockSize), y+blockSize, blockSize, blockSize );

  fill(#EF0000);
  rect( x+(blockSize*3), y+blockSize, blockSize, blockSize );
  rect( x+(blockSize*4), y+blockSize, blockSize, blockSize );
  rect( x+(blockSize*2), y+(blockSize*2), blockSize, blockSize );
  rect( x+(blockSize*3), y+(blockSize*2), blockSize, blockSize );
  rect( x+(blockSize*4), y+(blockSize*2), blockSize, blockSize );
  rect( x+(blockSize*5), y+(blockSize*2), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*2), blockSize, blockSize );
  rect( x+(blockSize*8), y+(blockSize*2), blockSize, blockSize );
  rect( x+(blockSize*9), y+(blockSize*2), blockSize, blockSize );
  rect( x+(blockSize*10), y+(blockSize*2), blockSize, blockSize );
  rect( x+(blockSize*11), y+(blockSize*2), blockSize, blockSize );

  rect( x+(blockSize), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*2), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*3), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*4), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*5), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*8), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*9), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*10), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*11), y+(blockSize*3), blockSize, blockSize );

  rect( x+(blockSize), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*2), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*3), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*4), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*5), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*8), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*9), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*10), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*11), y+(blockSize*4), blockSize, blockSize );

  rect( x+(blockSize*2), y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*3), y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*4), y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*5), y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*8), y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*9), y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*10), y+(blockSize*5), blockSize, blockSize );

  rect( x+(blockSize*2), y+(blockSize*6), blockSize, blockSize );
  rect( x+(blockSize*3), y+(blockSize*6), blockSize, blockSize );
  rect( x+(blockSize*4), y+(blockSize*6), blockSize, blockSize );
  rect( x+(blockSize*5), y+(blockSize*6), blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*6), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*6), blockSize, blockSize );
  rect( x+(blockSize*8), y+(blockSize*6), blockSize, blockSize );
  rect( x+(blockSize*9), y+(blockSize*6), blockSize, blockSize );
  rect( x+(blockSize*10), y+(blockSize*6), blockSize, blockSize );

  rect( x+(blockSize*3), y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*4), y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*5), y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*8), y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*9), y+(blockSize*7), blockSize, blockSize );

  rect( x+(blockSize*4), y+(blockSize*8), blockSize, blockSize );
  rect( x+(blockSize*5), y+(blockSize*8), blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*8), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*8), blockSize, blockSize );
  rect( x+(blockSize*8), y+(blockSize*8), blockSize, blockSize );

  rect( x+(blockSize*5), y+(blockSize*9), blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*9), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*9), blockSize, blockSize );

  rect( x+(blockSize*6), y+(blockSize*10), blockSize, blockSize );

  fill(0);




  rect( x+(blockSize*5), y+blockSize, blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*2), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize), blockSize, blockSize );


  fill(#EF0000);  
  rect( x+(blockSize*4), y+blockSize, blockSize, blockSize );
  rect( x+(blockSize*8), y+blockSize, blockSize, blockSize );
  rect( x+(blockSize*9), y+blockSize, blockSize, blockSize );
  rect( x+(blockSize*10), y+blockSize, blockSize, blockSize );
  rect( x+blockSize, y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*2), y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*3), y+(blockSize*8), blockSize, blockSize );
  rect( x+(blockSize*4), y+(blockSize*9), blockSize, blockSize );
  rect( x+(blockSize*5), y+(blockSize*10), blockSize, blockSize );  
  rect( x+(blockSize*6), y+(blockSize*11), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*10), blockSize, blockSize );
  rect( x+(blockSize*8), y+(blockSize*9), blockSize, blockSize );
  rect( x+(blockSize*9), y+(blockSize*8), blockSize, blockSize );
  rect( x+(blockSize*10), y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*11), y+(blockSize*5), blockSize, blockSize );

  fill(0);
  rect( x+(blockSize*11), y+blockSize, blockSize, blockSize );
  rect( x, y+(blockSize*2), blockSize, blockSize );
  rect( x, y+(blockSize*3), blockSize, blockSize );
  rect( x, y+(blockSize*4), blockSize, blockSize );
  rect( x, y+(blockSize*5), blockSize, blockSize );
  rect( x+blockSize, y+(blockSize*6), blockSize, blockSize );
  rect( x+blockSize, y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*2), y+(blockSize*8), blockSize, blockSize );
  rect( x+(blockSize*3), y+(blockSize*9), blockSize, blockSize );
  rect( x+(blockSize*4), y+(blockSize*10), blockSize, blockSize );
  rect( x+(blockSize*5), y+(blockSize*11), blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*12), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*11), blockSize, blockSize );
  rect( x+(blockSize*8), y+(blockSize*10), blockSize, blockSize );
  rect( x+(blockSize*9), y+(blockSize*9), blockSize, blockSize );
  rect( x+(blockSize*10), y+(blockSize*8), blockSize, blockSize );
  rect( x+(blockSize*11), y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*11), y+(blockSize*6), blockSize, blockSize );

  rect( x+(blockSize*12), y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*12), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*12), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*12), y+(blockSize*2), blockSize, blockSize );
}




///////////////////////////////////////////////////////////
//  
//  End handler, saves png
void exit() 
{

  artDaily( "'"+artDailyMsg + "' " + getTimestamp() );

  //  if final, save output to png
  if ( isFinal )
  {
    save( pdeName() + "-" + getTimestamp()+".png" );
  }

  System.gc();


  super.stop();
}


void star(int n, float cx, float cy, float w, float h, float startAngle, float proportion)
{
  if (n > 2)
  {
    float angle = TWO_PI/ (2 *n);  // twice as many sides
    float dw; // draw width
    float dh; // draw height

    w = w / 2.0;
    h = h / 2.0;

    beginShape();
    for (int i = 0; i < 2 * n; i++)
    {
      dw = w;
      dh = h;
      if (i % 2 == 1) // for odd vertices, use short radius
      {
        dw = w * proportion;
        dh = h * proportion;
      }
      vertex(cx + dw * cos(startAngle + angle * i), 
      cy + dh * sin(startAngle + angle * i));
    }
    endShape(CLOSE);
  }
}





//////////////////////////
int f0 = 0;
int f1 = 1;
//int f2 = 1;

int nextFib( int f2)
{
  int result = f2;
  f0 = f1;
  f1 = f2;
  f2 = f0 + f1;
  return result;
}

//////////////////////////
//  Calculate max loop count
float getMax( float shapeSize ) {
  return ( ( width * height ) / shapeSize );
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  pull colors out of image and return color[]
//  http://forum.processing.org/topic/extract-colors-from-images
ArrayList getImgColors( PImage img ) 
{
  ArrayList alColors = new ArrayList();

  img.loadPixels();

  int color1, color2;
  // TODO: what's a good way to pull DISTINCT colors with a color[]?
  for ( int c = 0; c < img.pixels.length; c++ ) 
  {
    if ( alColors.size() == 0 ) { 
      alColors.add( (color)img.pixels[ c ] );
    } 
    else 
    {

      if ( ! alColors.contains( (color)img.pixels[ c ] ) ) 
      {
        color1 = (Integer) alColors.get( alColors.size()-1 );
        color2 = img.pixels[c];
        // double distinct filtering
        if ( color1 > color2 )
        {

          alColors.add( (color)img.pixels[ c ] );
        }
      }
    }
  }

  return alColors;
}



///////////////////////////////////////////////////////
//  Make grid of shapes filled with each color in supplied
//  color[]
void paletteGrid( ArrayList pall ) {

  float xx = 0;
  float yy = 0;  
  float sz = 30;

  // debug
  //text( pall.size() + " colors ", sz, sz );
  color tmp;
  for ( int cc = 0; cc < pall.size(); cc++ ) {

    noStroke();
    tmp = (Integer)pall.get(cc);
    fill( tmp, alf*4 );
    rect( xx, yy, sz, sz );

    if ( xx < width ) {
      xx += (sz *1.25);
    } 
    else {
      xx = 0;
      yy += (sz *1.25);
    }
  }




  textFont( createFont( "HiraMaruProN-W4", 222 ) );
  fill(random(alf));
  text( pall.size(), random( alf, width/3 ), random(height) );
}







//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
//  ellipse(x, y, width, height)



void circle( float startX, float startY, float w, float h ) {

  float angle = 0;
  float x, y;

  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    if ( angle % 10 == 0 ) {

      x = startX - int( cos(radians(angle)) * w );
      y = startY - int( sin(radians(angle)) * w );

      smooth();
      ellipse( x, y, w, h );
    }
    angle++;
  }
}

///////////////////////////////////////////////////////////////////////////
//  draw a circle of circles
void circle( float startX, float startY, float w, float h, float modAngle ) {

  float angle = 0;
  float x, y;

  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    if ( angle % modAngle == 0 ) {

      x = startX - int( cos(radians(angle)) * w );
      y = startY - int( sin(radians(angle)) * w );

      smooth();
      ellipse( x, y, w, h );
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

////////////////////////////////////////////////////
//  Return a random color from supplied palette
color getRanColor(ArrayList palette)
{
  return (Integer)palette.get( (int)random( palette.size()-1 ) );
}


////////////////////////////////////////////////////
//  Randomly stroke using image from color list
void ranPalStroke(color[] palette)
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ], alf );
}
void ranPalStroke(ArrayList palette)
{
  // pallete
  stroke( (Integer)palette.get( (int)random( palette.size()-1 ) ), alf );
}
void ranPalStroke100(color[] palette)
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ], 100 );
}
void ranPalStroke100(ArrayList palette)
{
  // pallete
  stroke( (Integer)palette.get( (int)random( palette.size()-1 ) ), 100 );
}
void ranPalFill(color[] palette)
{
  fill( palette[ int(random( palette.length-1 )) ], alf );
}
void ranPalFill(ArrayList palette)
{
  // pallete
  fill( (Integer)palette.get( (int)random( palette.size()-1 ) ), alf );
}
void ranPalFill100(color[] palette)
{
  // pallete
  fill( palette[ int(random( palette.length-1 )) ], 100 );
}
void ranPalFill100(ArrayList palette)
{
  // pallete
  fill( (Integer)palette.get( (int)random( palette.size()-1 ) ), 100 );
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




String getTimestamp() {
  //  Calendar now = Calendar.getInstance();
  //  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM", now);


  return ""+month()+day()+year()+hour()+second()+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
String pdeName() {
  return split( this.toString(), "[")[0];
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 37 ) );  //  "AnonymousPro"
  smooth();

  fill(alf, alf);
  text( dailyMsg, 0, height-4 );
  fill(0, alf);
  text( dailyMsg, 0, height-2 );
  fill(255, alf);
  text( dailyMsg, 0, height );
  /*
float y = 0;
   while( y <= height ) {
   
   fill(#EFEFEF, y*.15);
   text( " "+dailyMsg, 5, y);
   y += 18; 
   }
   */
}

