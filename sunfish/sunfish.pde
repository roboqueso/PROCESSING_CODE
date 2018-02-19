float x, y, cX, cY, rad, angle, sw;

void setup()
{
  // size( 1024, 768);
  size(displayWidth, displayHeight);
  frameRate(420);
  rectMode(CENTER);
  noFill();
  smooth();
  cX = width/2;
  cY = height/2;
  rad = 2;
  sw = 1;

}



void draw()
{
	angle = (frameCount%360);

	x = cX - int( cos(radians(angle)) * rad );
	y = cY - int( sin(radians(angle)) * rad );

	
  	if(frameCount%(int)Math.sqrt(rad)==0 || frameCount%(int)sw==0)
  	{
	  	strokeWeight(angle%sw);
		translate(x, y);
		rotate(angle);

		// stroke(random(rad,255));
		// stroke(rad%255);
		stroke(x,y,angle);
		rect(0, 0, rad, rad);

		stroke(0);
		rect(0, 0, rad-HALF_PI, rad-HALF_PI, sw);

		resetMatrix();
	}


  	if(frameCount%360==0)
  	{
  		sw++;
  		rad+=sw;
  		
  	}


  	if(rad>width){
 		save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  		stop();
  	}

}

String getTimestamp() {
   return ""+month()+day()+year()+hour()+minute()+millis();
 }
 
 
 /////////////
 //  TODO: Is there a better way to get the current sketch name?
String pdeName() {
   return split( this.toString(), "[")[0];
 }
