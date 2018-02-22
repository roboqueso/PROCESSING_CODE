//
//  Rotate the circles so the crown looking opening points up



Boolean isFinal = true;
int alf = 37;
float ii = 0;

float cX, cY;

float shapeSize = 20;
float ct, maxCt;
Boolean flip = true;

color[] p2;// = { };

color[] p1 = { 
#000000, #000000, #360000, #003600, #000036
};


//  image action
PImage img, img0, img1;
int randColor;
int imgPixCt;


//PGraphics topLayer;


////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(989, 1280);
  background(0);  //  #ff0000  #EF1975

  img = loadImage( "lion-crest.png");
  p2 = getColorsFromImage( img );


  image(img,0,0);

  //  blend - http://processing.org/reference/blend_.html
  blend(img, 0, 0, img.width, img.height, int(cX), int(cY), img.width, img.height, BURN);

//  filter(GRAY);

  img.loadPixels();
  int dimension = (img.width*img.height);
  for (int i=0; i < dimension; i+=2) { 
    if( i % 2 == 0 ) {
      //  update image pixels
      img.pixels[i] = color( random(255), random(255), random(255) );
    }
  } 
  img.updatePixels();


  cX = width/2;
  cY = height/2;

  smooth();

  ct = 0;
  maxCt = width + height;

}



void draw()
{
  noFill();

  if(flip) {
    ranPalStroke(p2);
  } else {
    ranPalStroke(p1);
  }

  strokeWeight( random( .5, 1.5 ) );

  //  vertical
  line( ii, 0, ii, height );

  line( 0, ii, height, ii );

  strokeWeight( 2 );

  // top
  circle( ii, 0, shapeSize, shapeSize, alf*2 );  
  // bottom
  circle( ii, height, shapeSize, shapeSize, alf*3 );
/*
  // left
  circle( 0, ii, shapeSize, shapeSize, alf );
  // right
  circle( width, ii, shapeSize, shapeSize, alf );
*/


  if( ii >= height ) {
    shapeSize += shapeSize;
    flip = !flip;
  } else if( ii < 0 ) {
    ii = -shapeSize;
   flip = !flip; 
  }

  //  control the counter ( fwd or bwd )
  if(flip) {
    ii += shapeSize; 
  } else {
    ii -= shapeSize;
  }


  // max count or size is too big
  if( ct > maxCt ) {
    
      exit();
  } else if (shapeSize > width) {
     shapeSize = floor( sqrt( shapeSize ) );
  } else {
     
  }

  // keep track of the loop
  ct++;
}

///////////////////////////////////////////////////////
//  Pass a loaded PImage, this will return a color array
color[]  getColorsFromImage( PImage img ) {
// see: http://docs.oracle.com/javase/1.4.2/docs/api/java/util/ArrayList.html
//  HACK: using _colors to make pImg hold only unique colors
//  Unsure how to achieve the same with only a color array
ArrayList _colors = new ArrayList();
color[] color_array = { #EFEFEF };

  img.loadPixels();
  for( int cc = 0; cc <= img.pixels.length-1; cc++)
  {
    if( ! _colors.contains( img.pixels[ cc ] ) )
    {
      //  These values are of the color datatype
      _colors.add( (color)img.pixels[ cc ] );

      if( color_array.length > 0 ) {
        color_array[ color_array.length-1 ] = (color)img.pixels[ cc ];
      }
    }
  }
  return color_array;
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




//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
//  ellipse(x, y, width, height)



void circle( float startX, float startY, float w, float h ) {

  float angle = 0;
  float xx, yy;

  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    if( angle % 10 == 0 ) {

      xx = startX - int( cos(radians(angle)) * w );
      yy = startY - int( sin(radians(angle)) * w );
  
      smooth();
      ellipse( xx, yy, w, h );
    }
    angle++;
  }
}

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
//  End handler, saves png to ../OUTPUT
void doExit() 
{

  artDaily("ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
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

  textFont( createFont( "Silom", 18 ) );
  smooth();

  fill(#EFEFEF);
  text( " "+dailyMsg, this.width-430, this.height-14);
/*
float yy = 0;
while( yy <= height ) {

  fill(#EFEFEF, yy*.15);
 text( " "+dailyMsg, 5, yy);
 yy += 18; 
}
*/

}

