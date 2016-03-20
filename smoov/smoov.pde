float cX, cY, xx, yy, xx2, yy2, rad = 3, angle, shim = .360;
PVector pv1, pv2;
ArrayList<PVector> pts = new ArrayList<PVector>();

void setup()
{
  size(displayWidth, displayHeight);
  frameRate(420);
  background(0);
  smooth();
  noFill();
  
  cX = width/2;
  cY = height/2;

}



void draw()
{
  angle = frameCount;//+angle;
  // rad = random(rad-.5, rad+.5);
  pv1 = circleXY( cX, cY, rad, angle );
  pv2 = circleXY( cX, cY, rad, angle+shim );


  

	if( isFibonacci(pv1.x) || isFibonacci(pv1.y)  || isFibonacci(pv2.x) || isFibonacci(pv2.y) )
	{
		rad += shim*1.1;

	} else if( angle%11==0){
		rad += shim;
	}


	stroke(69, frameCount%200);
	strokeWeight(7);
	point( pv1.x, pv1.y );
	
	stroke(255, frameCount%255);
	strokeWeight(4);
	point( pv2.x, pv2.y );

	
	stroke(pv2.x, pv2.y, pv2.x, frameCount%255);
	strokeWeight(PI);
	point( pv2.x, pv2.y );

  if( rad > height )
  {
    
    save(this+".png");

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
    PVector t;
  
    while ( angle < 360 ) {

      // make circle draw faster by skipping angles
      if ( angle % 12 == 0 ) 
      {
      	t = circleXY( startX, startY, radius, angle );
        ellipse( t.x, t.y, radius, radius );
      }
      angle++;
    }
  }


