//  draw circles and stuff, save on exit
String dailyMsg = "ERICFICKES.COM";
String outFileName = "wedImageColor20712";  //don't add extension
Boolean isFinal = true;

int cX = 0;
int cY = 0;

int xx = 0;
int yy = 0;

//  art frame settings
int outerRectX;
int outerRectY;
int outerRectWidth = 128;
int outerRectHeight = 28;

//  grid settings
int shapeSize = 10;
float shapePadding = 1;
float alf = 69;

//  image action
PImage img;
int randColor;
int imgPixCt;

// see: http://docs.oracle.com/javase/1.4.2/docs/api/java/util/ArrayList.html
ArrayList _colors = new ArrayList();

///////////////////////////////////////////////////////////
//  
void setup() {
  size( 1024, 768);
  
  // load up external image
 img = loadImage( "movies-3d-glasses.jpg" );
// img = loadImage( "indie-logo.gif" );
  // img = loadImage( "ROLEX-MILGAUSS.JPG");
  img.loadPixels();
  
  background( 20 );
  smooth();

  cX = width/2;
  cY = height/2;

  outerRectX = this.width-139;
  outerRectY = this.height-84;

  //  pull out DISTINCT colors for sketch

  for( int cc = 0; cc <= img.pixels.length-1; cc++)
  {
    if( ! _colors.contains( img.pixels[ cc ] ) )
    {
      //  These values are of the color datatype
      _colors.add( (color)img.pixels[ cc ] );
      
      if( cc % 3 == 0 )
      {
        fill( random(255), alf );
        text( img.pixels[ cc ], cc, cY - cc );
      }
    }
  }

//text("og color: " + img.pixels.length, 500,500);
//text("DISTINCT: " + _colors.size(), 600,600);
  imgPixCt = _colors.size();
  
    artDaily();
}

///////////////////////////////////////////////////////////
//  
void draw() {

//TODO: build pixel colorist
  
  while ( yy < this.width )
  {

    // COLLISION DETECTION
    //  do not ellipse over the ART DAILY frame @ this.width-139, this.height-84
if ( ! isCollidingCircleRectangle( xx, yy, shapeSize, outerRectX, outerRectY, outerRectWidth, outerRectHeight) )
{

  noFill();
  imgColorStroke();

//  drawTriangle( xx, yy, shapeSize );
//  ellipseMode( RADIUS );
  ellipse( xx, yy, shapeSize, shapeSize );
}   

    //  are we about to hit the wall?
    if ( (xx-shapeSize) >= (this.width-shapeSize) )
    {
      xx = 0;
      yy += shapeSize+shapePadding;
    }
    else
    {
      xx += shapeSize+shapePadding;
    }
  }




  exit();
}

///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randStroke()
{
  stroke( random(255), random(255), random(255), random(alf) );
}


///////////////////////////////////////////////////////////
//  /\
void drawTriangle( int xx, int yy, int shapeSize )
{
  float cx0 = xx;
  float cy0 = yy - 0 * shapeSize;
  float cx1 = xx - shapeSize/2;
  float cy1 = yy + tan(shapeSize) * shapeSize;
  float cx2 = xx + shapeSize/2;
  float cy2 = yy + tan(shapeSize) * shapeSize;
  
  triangle(cx0, cy0, cx1, cy1, cx2, cy2);
} 


/********************************************************
 isCollidingCircleRectangle()
 
 params:
 circleX - center x coordinate for circle
 circleY - center y coordinate for circle
 radius  - radius of circle
 rectangleX - top left corner X coordinate
 rectangleY - top left corner Y coordinate
 rectangleWidth - width of rectangle
 rectangleHeight - and the height
 
 returns boolean - whether the two shapes are colliding
 
 code adapted from:
 http://stackoverflow.com/questions/401847/circle-rectangle-collision-detection-intersection
 adapted by: Jonathan Cecil
 ********************************************************/
boolean isCollidingCircleRectangle(
float circleX, 
float circleY, 
float radius, 
float rectangleX, 
float rectangleY, 
float rectangleWidth, 
float rectangleHeight)
{
  float circleDistanceX = abs(circleX - rectangleX - rectangleWidth/2);
  float circleDistanceY = abs(circleY - rectangleY - rectangleHeight/2);

  if (circleDistanceX > (rectangleWidth/2 + radius)) { 
    return false;
  }
  if (circleDistanceY > (rectangleHeight/2 + radius)) { 
    return false;
  }

  if (circleDistanceX <= (rectangleWidth/2)) { 
    return true;
  } 
  if (circleDistanceY <= (rectangleHeight/2)) { 
    return true;
  }

  float cornerDistance_sq = pow(circleDistanceX - rectangleWidth/2, 2) +
    pow(circleDistanceY - rectangleHeight/2, 2);

  return (cornerDistance_sq <= pow(radius, 2));
}



///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void exit() 
{


  //  if final, save output to png
  if ( isFinal )
  {
save( split( this.toString(), "[")[0] + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
  }

  super.stop();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily() {
  
    //  FRAME THE MESSAGE
  noFill();
  //  stroke(#1975EF, 100);
  imgColorStroke();
  rect( outerRectX, outerRectY, outerRectWidth, outerRectHeight );
  
  //  stroke(#19EF75, 100);
  imgColorStroke();
  rect( this.width-137, this.height-82, 124, 24 );

  //  stroke(#EF1975, 100);
  imgColorStroke();
  rect( this.width-135, this.height-80, 120, 20 );

  //  fill(#EFEFEF, 100);
  imgColorFill();
  text( dailyMsg, this.width-130, this.height-65 );
}

//  stroke a random color out of loaded image
void imgColorStroke() {
  randColor = int( random( imgPixCt ) );
  color tmpColor = (color)(Integer) _colors.get(randColor);

  // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
  float r = red( tmpColor );
  float g = green(tmpColor);
  float b = blue(tmpColor);
  stroke( r,g,b, alf );

}

//  stroke a random color out of loaded image
void imgColorFill() {
  randColor = int( random( imgPixCt ) );
  color tmpColor = (color)(Integer) _colors.get(randColor);

  // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
  float r = red( tmpColor );
  float g = green(tmpColor);
  float b = blue(tmpColor);
  fill( r,g,b, alf );
}


