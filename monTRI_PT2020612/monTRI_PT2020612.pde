//  see:  https://ello.co/ericfickes/post/zqdx7oucehc9pusejabo6q
String dailyMsg = "ERICFICKES.COM";
String outFileName = "monTRI-pt2020612";  //don't add extension
Boolean isFinal = true;

int cX = 0;
int cY = 0;

int xx = 0;
int yy = 0;
int x2 = 0;
int y2 = 0;

//  art frame settings
int outerRectX;
int outerRectY;
int outerRectWidth = 69;
int outerRectHeight = 33;

//  grid settings
int shapeSize = 42;
float shapePadding = 0.69;


///////////////////////////////////////////////////////////
//  
void setup() {
  size( displayWidth, displayHeight );
  background(19);
  smooth();

  cX = width/2;
  cY = height/2;

  outerRectX = this.width-139;
  outerRectY = this.height-84;


  //  FRAME THE MESSAGE
  noFill();
  stroke(#1975EF, 100);
  rect( outerRectX, outerRectY, outerRectWidth, outerRectHeight );
  stroke(#19EF75, 100);
  rect( this.width-137, this.height-82, 124, 24 );
  stroke(#EF1975, 100);
  rect( this.width-135, this.height-80, 120, 20 );

  fill(#EFEFEF, 100);
  text( dailyMsg, this.width-130, this.height-65 );
  
  
  
}

///////////////////////////////////////////////////////////
//  
void draw() {


  //  make shape grids


  while ( yy < this.width )
  {
    noFill();

if( xx % 3 == 0 )
  stroke( 0,random(255), 0, 69);
else
  randStroke();


    // COLLISION DETECTION
    //  do not ellipse over the ART DAILY frame @ this.width-139, this.height-84
if ( ! isCollidingCircleRectangle( xx, yy, shapeSize, outerRectX, outerRectY, outerRectWidth, outerRectHeight) )
{
  
  drawTriangle( xx, yy, shapeSize );


  
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




  doExit();
}

///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randStroke()
{
  stroke( random(255), random(255), random(255), random(50) );
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
void doExit() 
{


  //  if final, save output to png
  if ( isFinal )
  {
    save( outFileName + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
  }

  exit();
}
