//  SEE:   https://ello.co/ericfickes/post/nbtnenwpy7dgkuz2bf_otg
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);


PImage bg;
PImage tmp;


void settings(){
  size(displayWidth, displayHeight, P3D);
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}



void setup() {
  frameRate(303);
  background(#ACEDAD);
  smooth();
}

void draw () 
{

	//scale(random(-2,2));
	ellipse( random(width), random(height), frameCount%42, frameCount%42);

	if(frameCount%42==0){
		
		tmp = get();
		
		if(frameCount%84==0)
		{
			tmp.filter(INVERT);
		}

		//tmp.mask(bg);

		image(tmp, random(width), frameCount%height, width, height);
	}


	if(frameCount> (width+height)){
		
		tmp = get();
		//tmp.mask(bg);
		background(tmp);

		save(fix.pdeName()+fix.getTimestamp()+".png");  //  4 tifs, 4 pngs
		noLoop();
		exit();
	}

}
