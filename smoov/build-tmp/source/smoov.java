import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class smoov extends PApplet {

float cX, cY, xx, yy, xx2, yy2, rad = 3, angle, shim = .360f;
PVector pv1, pv2;
ArrayList<PVector> pts = new ArrayList<PVector>();

public void setup()
{
  
  frameRate(420);
  background(0);
  
  noFill();
  
  cX = width/2;
  cY = height/2;

}



public void draw()
{
  angle = frameCount;//+angle;
  // rad = random(rad-.5, rad+.5);
  pv1 = circleXY( cX, cY, rad, angle );
  pv2 = circleXY( cX, cY, rad, angle+shim );


  

	if( isFibonacci(pv1.x) || isFibonacci(pv1.y)  || isFibonacci(pv2.x) || isFibonacci(pv2.y) )
	{
		rad += shim*1.1f;

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
public PVector circleXY( float centerX, float centerY, float radius, float angle )
{
  return new PVector(
                centerX - PApplet.parseInt( cos(radians(angle)) * radius ),
                centerY - PApplet.parseInt( sin(radians(angle)) * radius )
                );
}


// A utility function that returns true if x is perfect square
public boolean isPerfectSquare(float x)
{
    int s = (int)sqrt(x);
    return (s*s == x);
}
 
// Returns true if n is a Fibinacci Number, else false
public boolean isFibonacci(float n)
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


  public void settings() {  size(displayWidth, displayHeight);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "smoov" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
