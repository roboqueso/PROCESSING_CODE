
// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);
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
  pv1 = fix.circleXY( cX, cY, rad, angle );
  pv2 = fix.circleXY( cX, cY, rad, angle+shim );


  

	if( fix.isFibonacci(pv1.x) || fix.isFibonacci(pv1.y)  || fix.isFibonacci(pv2.x) || fix.isFibonacci(pv2.y) )
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
    
    save(fix.pdeName()+fix.getTimestamp()+".png");

    noLoop();
    exit();
  }

}
