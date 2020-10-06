// see: https://ello.co/ericfickes/post/o3a09blb2lrbpctwm6pu8g
float cX, cY, xx, yy, xx2, yy2, rad = 404, angle, sw = 11;
PVector pv1;

void setup()
{
  size(displayWidth, displayHeight);
  smooth();
  noFill();
  frameRate(666);
  cX = width/2;
  cY = height/2;
  
}



void draw()
{
  angle = frameCount;//+sw;
  pv1 = circleXY( cX, cY, rad, angle );
  
  strokeWeight(frameCount%sw);
  stroke(frameCount%255);
  // ellipse( pv1.x, pv1.y, frameCount%(sw*PI), frameCount%(sw*PI) );
  point( pv1.x, pv1.y );

  strokeWeight(PI);
  stroke(pv1.x%255, pv1.y%255 ,angle%255);
  if( isFibonacci(pv1.x) )
  {
    circle( pv1.x, pv1.y, sw);
  	// ellipse( pv1.x, pv1.y, sw, sw );
  }

  if( isFibonacci(pv1.y) )
  {
    circle( pv1.x, pv1.y, sw*PI );
  	// ellipse( pv1.x, pv1.y, sw*PI, sw*PI );
  }


  if(frameCount%360==0)
  {
    rad-=sw;
    if(sw>PI){
    	sw-=.75;	
    } else{
    	sw = 11;
    }
    
  }

  if( rad < 9 ){
    
    save(fix.pdeName()+fix.getTimestamp()+".png");

    noLoop();
  }

}

/////////////////////////////////////////////////////////////////////////////
PVector circleXY( float centerX, float centerY, float radius, float angle )
{
  return new PVector(
                centerX - int( cos(radians(angle)) * radius ),
                centerY - int( sin(radians(angle)) * radius )
                );
}


// A utility function that returns true if x is perfect square
boolean isPerfectSquare(float x)
{
    int s = (int)sqrt(x);
    return (s*s == x);
}
 
// Returns true if n is a Fibinacci Number, else false
boolean isFibonacci(float n)
{
    // n is Fibinacci if one of 5*n*n + 4 or 5*n*n - 4 or both
    // is a perferct square
    return isPerfectSquare(5*n*n + 4) ||
           isPerfectSquare(5*n*n - 4);
}


  //////////////////////////////////////////////////////////////////////////
  //  Draw manual circle
  //  ellipse(x, y, width, height)
  public void circle( float startX, float startY, float radius ) {
  
    float angle = 0;
    float x, y;
  
    while ( angle < 360 ) {
  
      // make circle draw faster by skipping angles
      // if ( angle % 4 == 0 ) {
      if( isFibonacci(angle)) {
  
        x = startX - int( cos(radians(angle)) * radius );
        y = startY - int( sin(radians(angle)) * radius );
  
        ellipse( x, y, radius, radius );
      }
      angle++;
    }
  }
