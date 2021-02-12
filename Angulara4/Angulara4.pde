// SEE :  https://ello.co/ericfickes/post/en4ahtzb23mjdkc9xyqwwa
// GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);



float cX, cY, xx, yy, xx2, yy2, rad = 404, angle;
PVector pv1, pv2;
ArrayList<PVector> pts = new ArrayList<PVector>();


void setup()
{
  size(displayWidth, displayHeight);
  background(0);
  
  smooth(8);
  noFill();
  frameRate(420);
  rectMode(CENTER);
  ellipseMode(CENTER);
  cX = width/2;
  cY = height/2;

}



void draw()
{
  angle = frameCount;//+angle;
  // rad = random(rad-.5, rad+.5);
  pv1 = circleXY( cX, cY, rad, angle );
  pv2 = circleXY( cX, cY, rad, angle+.5 );

  strokeWeight(PI);
  stroke( pv1.y%255, pv1.x%255, pv1.x%255);

	if( isFibonacci(pv1.x) || isFibonacci(pv1.y) )
	{
		ellipse( pv1.x, pv1.y, angle , angle );
		pts.add(pv1);

		pv2 = circleXY( pv1.x, pv1.y, (angle+rad)*HALF_PI, angle*HALF_PI );

		strokeWeight(PI);
		stroke( pv1.y%255, pv1.x%255, pv1.x%255, angle%255);
		line( pv1.x, pv1.y, pv2.x, pv2.y );

		stroke(frameCount%255);
		strokeWeight(HALF_PI);
		line( pv1.x, pv1.y, pv2.x, pv2.y );
	}
	else
	{
		
		stroke(255, frameCount%255);
		strokeWeight(TWO_PI);
		point( pv1.x, pv1.y );
		strokeWeight(PI);
		point( pv2.x, pv2.y );

	}


  if(frameCount%361==0)
  {
    rad-= 13;    
  }

  if( rad < 8 )
  {
  	noStroke();

	beginShape(QUADS);//TRIANGLES);
  	// CONNECT THE DOTS A LA LA LAAAAAAA
  	for(int x = pts.size()-1; x > -1; x-- )
  	{
  		pv1 = pts.get(x);
fill(random(255), 100);
		vertex( pv1.x, pv1.y);
  	}
  	endShape();

    
    save(fix.pdeName()+fix.getTimestamp()+".png");

    noLoop();
    exit();
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
