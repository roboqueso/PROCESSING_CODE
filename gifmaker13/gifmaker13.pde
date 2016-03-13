import gifAnimation.*;

boolean gif = true, grow = false;
GifMaker gifExport;
float xx, sz;
int ct = 1;

/* Vertical bars drawing left to right across the stage */

void setup() 
{
  size(250,250);//, P3D);
  background(255);
  smooth();
  rectMode(CENTER);
  
  frameRate(64);
  if(gif){
	  gifExport = new GifMaker(this, sketchName()+".gif", 255, 255);
	  gifExport.setRepeat(0);             // make it an "endless" animation
	  //  SCRIVNER: multiples of 16 frames
	//  gifExport.setTransparent(0,0,0);    // black is transparent
	  gifExport.setTransparent(255);    // white is transparent
	}
  

  sz=width;
  noFill();
  xx=-width;
	strokeWeight(2);
}



void draw() 
{
	if( ((int)sz )!=0)
	{
		background(255);

/*
noStroke();
fill(255,50);
rect(width/2, height/2,width,height);
*/ 
	translate(width/2, height/2);

	if(frameCount%2==0){
		rotate(frameCount);
	}

	stroke(0);
	// fill(255);
 	// noFill();
println("FILL #"+((sz<0)?-sz:sz));
	
	fill((sz<0)?-sz:sz);

	ellipse(0,0, sz*HALF_PI, sz*HALF_PI);
	fill(255);
	ellipse(0,0, sz, sz);
	





		// NOTE: does this need to be delayed to avoid the initial BLANK frame?
		if(gif){
			gifExport.setDelay(0);
			gifExport.addFrame();
		}


			if(!grow&&(-sz*2 >= width*2))
			{
				if(gif){
				gifExport.finish();  // write file
				
				println("ABOUT TO STOP");
				stop();
			}

		}
	}

	if(grow)
		sz=frameCount*2;
	else
		sz-=2;
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
