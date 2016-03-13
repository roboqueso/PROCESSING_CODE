import gifAnimation.*;

boolean gif = true, grow = false;
GifMaker gifExport;
float xx, sz;
int ct = 1;

/* Vertical bars drawing left to right across the stage */

void setup() 
{
  size(250,250, P3D);
  background(255);
  smooth();
  rectMode(CENTER);
  
  frameRate(64);
  if(gif){
	  gifExport = new GifMaker(this, sketchName()+".gif");
	  gifExport.setRepeat(0);             // make it an "endless" animation
	  //  SCRIVNER: multiples of 16 frames
	//  gifExport.setTransparent(0,0,0);    // black is transparent
	  gifExport.setTransparent(255);    // white is transparent
	}
  

  sz=width;
  noFill();
  xx=-width;

}



void draw() 
{

	background(255);	

	translate(width/2, height/2);

	if(frameCount%2==0){
		rotate(frameCount);
	}

	stroke(0);
	noFill();
	strokeWeight(12);
	rect(0,0, sz, sz, frameCount);

	stroke(frameCount%100);
	strokeWeight(4);
	noFill();
	rect(0,0, sz, sz, (grow?frameCount:frameCount));
	
	if(grow){
		sz=frameCount*1.5;
	}else{
		sz-=1.5;
	}

	//if(frameCount>11){
		// NOTE: does this need to be delayed to avoid the initial BLANK frame?
		if(gif){
		//gifExport.setDelay(1);
		gifExport.addFrame();
		}


		if(grow&&frameCount>width*.5)
		{
		if(gif){
		gifExport.finish();  // write file
		}
		stop();
		}
	//}

	if(sz>=width)
	{
		grow=!grow;
	}

}

////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////
PVector circleXY( float centerX, float centerY, float radius, float angle )
{
  return new PVector(
                centerX - int( cos(radians(angle)) * radius ),
                centerY - int( sin(radians(angle)) * radius )
                );
}

//  return unique filename_timestamp string
public String sketchName(){
  return split( this.toString(), "[")[0];
}
//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}
