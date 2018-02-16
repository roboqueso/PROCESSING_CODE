Boolean isFinal = true;

//  
//  Black and White
//  Tatoo / Asian style sun
//  Use HOTmess3 as background
//  
//  B&W sunbeams slowly alpha out?
//  
int alf = 42;

//  circle vars
float angle1 = 0, xx1, yy1, startX1, startY1, radius1 = alf;
float angle2 = 0, xx2, yy2, startX2, startY2, radius2 = alf*5;
float angle3 = 0, xx3, yy3, startX3, startY3, radius3 = alf*7;
float angle4 = 0, xx4, yy4, startX4, startY4, radius4 = alf*9;

int cX;
int cY;

color[] palette = { #EF0000, #00EF00, #0000EF, #CECE00, #FA7680, #EF1975, #007007, #EFEF00, #FA9187, #007007, #109109 };
PImage b;
ArrayList p3;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);//);
  frameRate(666);

//  b = loadImage("HOTmess3.png");
//  p3 = getImgColors(b);
//  background(b);
background(255);

  //  setup variables
  cX = width/2;
  cY = height/2;

//  startX1 = startX2 = startX3 = startX4 = cX;
//  startY1 = startY2 = startY3 = startY4 = cY;
  
  stroke(0);
  strokeWeight(.37);
}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();

if( xx1 < width ) {
 
 xx1 += alf; 
  
} else {

 xx1 = 0;
 yy1 += alf;
  
}
//  sun beams
drawLissajous( xx1, yy1, alf );



evenOddFill(#EF1975);

  //
  //  STOP
  //  frameCount > height*alf || 
  if ( frameCount > width)
  {    
    exit();
  }
}


//////////////////////////////////////////////////////
//  Pass in a color, and this will fill even frames with 255,
//  odd frames with clr
void evenOddFill( color clr ) {
  if( frameCount % 2 == 0 ) {
    fill(255, 11);
  } else {
    fill( clr, 11 );
  } 
}


//////////////////////////////////////////////////////
//  
void drawLissajous( float a, float b, float amp )
{
//  float amp = 33;
  float x, y;
  float sz = amp / TWO_PI;
  
  for( float t = 0; t <= 360; t += .1)
  {
    x = a - amp * sin(a * t * PI/180);
    y = b - amp * sin(b * t * PI/180);

//    point(x,y);

    ellipse(x,y,sz,sz);
    
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

  artDaily("ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( pdeName() + "-" + getTimestamp()+".png" );
  }

  System.gc();


  super.stop();
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
  for( int c = 0; c < img.pixels.length; c++ ) 
  {
      if( alColors.size() == 0 ) { 
        alColors.add( (color)img.pixels[ c ] );
      } else 
      {
         
        if( ! alColors.contains( (color)img.pixels[ c ] ) ) 
        {
          color1 = (Integer) alColors.get( alColors.size()-1 );
          color2 = img.pixels[c];
          // filter out colors    
          if( color2 > color1 )
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
  for( int cc = 0; cc < pall.size(); cc++ ) {
    
    noStroke();
    tmp = (Integer)pall.get(cc);
    fill( tmp, alf*4 );
    rect( xx, yy, sz, sz );
    
    if( xx < width ) {
      xx += (sz *1.25);
    } else {
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

  textFont( createFont( "Silom", 37 ) );
  smooth();

  fill(#373737);
  text( " "+dailyMsg, 0, height);
  /*
float y = 0;
   while( y <= height ) {
   
   fill(#EFEFEF, y*.15);
   text( " "+dailyMsg, 5, y);
   y += 18; 
   }
   */
}

