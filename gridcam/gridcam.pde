import processing.video.*;


Capture cam;
PImage snap;

float cX, cY, xx, yy;
int sz;

void setup()
{
  size(displayWidth, displayHeight);
  background(255);
  smooth();
  noFill();
  strokeWeight(2);

  cam = new Capture(this, Capture.list()[0]);
  cam.start();     

  sz = 69;
  xx = yy = 0;
}



void draw()
{
	if( xx > displayWidth && yy > displayHeight )
	{
		cam.stop();

		// fill(255,0,0);
		// text("DONE", width/2, height/2);

	    save(this+".png");
	    noLoop();
  	}
  	else
  	{

		if (cam.available() && snap == null)
		{
			cam.read();
			snap = cam;
			translate(snap.width, snap.height, 0);
		}

  		if(snap != null)
		{
	  		
	  		// image( snap.get( (int) random(width), (int) random(height),sz,sz), (int) xx, (int) yy );
	  		image( snap.get( (int) random(xx), (int) random(yy),sz,sz), (int) xx, (int) yy );
			stroke( snap.get((int)xx,(int)yy));
			rect( xx, yy, sz, sz);

	  		if( xx < displayWidth )
	  		{
	  			xx += sz;
	  		}
	  		else 
	  		{
	  			xx = -sz;
	  			yy += sz;	

				if (cam.available())
				{
					cam.read();
					snap = cam;
				}
	  		}

	  		if(isFibonacci(frameCount)){
	  			sz -= TWO_PI;
	  		}
		}
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


