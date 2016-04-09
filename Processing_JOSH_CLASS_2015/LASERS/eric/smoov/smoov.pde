import processing.pdf.*;

float cX, cY, xx, yy, xx2, yy2, rad = 3, angle, shim = .420, sz = 11;
PVector pv1, pv2;
ArrayList<PVector> pts = new ArrayList<PVector>();

void setup()
{
  size(1280, 960, P3D );

  background(255);
  ellipseMode(CENTER);
  rectMode(CENTER);

  frameRate(420);

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

/*
	if( isFibonacci(pv1.x) || isFibonacci(pv1.y)  || isFibonacci(pv2.x) || isFibonacci(pv2.y) )
	{
		rad += shim*1.1;

	} else if( angle%11==0){
		rad += shim;
	}
*/

	fill(angle%255);//, frameCount%200);
	noStroke();
	ellipse( pv1.x, pv1.y, sz, sz );



  if(frameCount%45==0){
    rad += noise(frameCount)+noise(rad)+1;
  }

  if( rad >= height )
  {
    //  save PDF
    beginRecord(PDF, fileStamp()+".pdf");
    image(get(),0,0);
    endRecord();

    //  save PNG
    save(fileStamp()+".png");

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


//////////////////////////////////////////////////////////////////////////
//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}

