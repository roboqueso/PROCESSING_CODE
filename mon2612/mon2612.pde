//  draw circles and stuff, save on exit
String dailyMsg = "ERICFICKES.COM";
String outFileName = "mon2612";  //don't add extension
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
int ellipseSize = 42;

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

}

///////////////////////////////////////////////////////////
//  
void draw() {

  
  //  make shape grids

  

    noFill();

randStroke();

if( frameCount % 13 == 0 ){
    //  this is awesome!!!
  ellipseMode(RADIUS);
  ellipse(xx, yy, ellipseSize, ellipseSize);
  ellipse(xx, yy, ellipseSize, ellipseSize);
} else {
  ellipseMode(CENTER);
  rectMode(CENTER);
  rect(xx, yy, ellipseSize, ellipseSize, random(yy) );

}  
   
    
    // width detection
    if( xx > width ){
      xx = 0;
      yy += ellipseSize+random(13);
    } else {
      xx += ellipseSize+random(13);
    }
    
    if( xx >= width && yy >= height ){
      xx = yy = int(random(13));
    }


  
  if(frameCount>width+height){
  
      text("ERICFICKES.COM", 0, height-11);
    
  exit();

  }
}

///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randStroke()
{
    stroke( random(255), random(255), random(255), random(75) );
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

    if (circleDistanceX > (rectangleWidth/2 + radius)) { return false; }
    if (circleDistanceY > (rectangleHeight/2 + radius)) { return false; }

    if (circleDistanceX <= (rectangleWidth/2)) { return true; } 
    if (circleDistanceY <= (rectangleHeight/2)) { return true; }

    float cornerDistance_sq = pow(circleDistanceX - rectangleWidth/2, 2) +
                         pow(circleDistanceY - rectangleHeight/2, 2);

    return (cornerDistance_sq <= pow(radius,2));
}



///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void exit() 
{

  
  //  if final, save output to png
  if( isFinal )
  {
    save( outFileName + "-" + month()+day()+year()+hour()+minute()+millis()+".png" );
  }

  super.stop();
}
