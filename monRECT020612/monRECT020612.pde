// ** HOT
// JAZZ THIS UP


//  draw circles and stuff, save on exit
String dailyMsg = "ERICFICKES.COM";
String outFileName = "monRECT020612";  //don't add extension
Boolean isFinal = true;
int alf = 42;
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
int shapeSize = 42;

///////////////////////////////////////////////////////////
//  
void setup() {
  size( 1024, 768);
  background(19);
  smooth();

  cX = width/2;
  cY = height/2;

  outerRectX = this.width-139;
  outerRectY = this.height-84;


  //  FRAME THE MESSAGE
//  noFill();
//  stroke(#1975EF, 100);
//  rect( outerRectX, outerRectY, outerRectWidth, outerRectHeight );
//  stroke(#19EF75, 100);
//  rect( this.width-137, this.height-82, 124, 24 );
//  stroke(#EF1975, 100);
//  rect( this.width-135, this.height-80, 120, 20 );
//
//  fill(#EFEFEF, 100);
//  text( dailyMsg, this.width-130, this.height-65 );
}

///////////////////////////////////////////////////////////
//  
void draw() {


  //  make shape grids



    noFill();

      randStroke(alf);

      rectMode(RADIUS);
      rect(xx, yy, shapeSize, shapeSize);
      
      ellipseMode(RADIUS);
      ellipse(xx, yy, shapeSize, shapeSize);

    //  are we about to hit the wall?
    if ( xx < width )
    {
      xx += shapeSize;
    }
    else
    {
      xx = 0;
      yy += shapeSize;      
    }
    
    if( xx >= width && yy >= height )
    {
      xx = yy = int(random(shapeSize));      
    }

  if( frameCount > height+width ){
    text("ERICFICKES.COM", 0, height-11);
    doExit();
  }
}

///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randStroke(int alf)
{
  stroke( random(255), random(255), random(255), alf );
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
    save( outFileName + "-" + month()+day()+year()+hour()+minute()+millis()+".png" );
  }

  super.stop();
}

