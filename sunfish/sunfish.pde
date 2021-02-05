//  SEE:   https://ello.co/ericfickes/post/bho_icech9hawissqodizw
//  GOTO:  https://github.com/ericfickes/FIXLIB

import fixlib.*;
Fixlib fix = Fixlib.init(this);





float x, y, cX, cY, rad, angle, sw;

void settings(){
  size(displayWidth, displayHeight, P3D);
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}


void setup()
{
  frameRate(666);
  background(#E2F2E2);
  rectMode(CENTER);
  noFill();
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
      pushMatrix();
    		translate(x, y);
    		rotate(angle);

    		// stroke(random(rad,255));
    		// stroke(rad%255);
    		stroke(x,y,angle);
    		rect(0, 0, rad, rad);

    		stroke(0, angle);
    		rect(0, 0, rad-HALF_PI, rad-HALF_PI, sw);
      popMatrix();
	}


  	if(frameCount%360==0)
  	{
  		sw++;
  		rad+=sw;
  		
  	}


  	if(rad>width){
    String saveName = fix.pdeName() + "-" + fix.getTimestamp();
    save( saveName +".tif" );
    save( saveName +".png" );

      exit();
  	}

}
