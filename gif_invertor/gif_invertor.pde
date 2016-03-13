import gifAnimation.*;

boolean gif = true;
GifMaker gifExport;
int ct = 1;
// String SRC_GIF = "oie_overlay.gif";	//	500, 489 * verify
//	String SRC_GIF = "crayola.gif";	//	400, 400
// String SRC_GIF = "sun.gif";	//	500, 500
// String SRC_GIF = "access_denied.gif";	//	400, 400
//	String SRC_GIF = "checkers.gif";	//	500, 500
String SRC_GIF = "melty.gif";	//	400, 400


void setup() 
{
  size(400,400, P3D); // be sure to match source gif dimensions
  background(255);

  if(gif){
	  gifExport = new GifMaker(this, SRC_GIF+"_INVERTED.gif");
	  gifExport.setRepeat(0);             // make it an "endless" animation
	  //  SCRIVNER: multiples of 16 frames
	//  gifExport.setTransparent(0,0,0);    // black is transparent
	  gifExport.setTransparent(255);    // white is transparent
	}

//	1. Load existing GIF into frames
PImage[] allFrames = Gif.getPImages(this, SRC_GIF);
//	get frame count
int frmCt = allFrames.length;
int ct = 1; // KEEP THIS IN SYNC WITH frmCt LOOP BELOW
println("frmCt = " + frmCt);

//	2. Loop through each frame
for(PImage frm : allFrames)
{
	//	save frame to disk
	// frm.save("frame"+ct+".png");
	image(frm,0,0);
	saveFrame("frames/frame"+ct+".png");

	//	ADD FILTER(S) TO CREATE MASK IMAGE
	frm.filter(GRAY);
	frm.filter(THRESHOLD);
	frm.filter(INVERT);

	//	save mask to disk
	image(frm,0,0);
	saveFrame("frames/frame"+ct+"_MASK.png");

	ct++;
}


//	kill frames array
allFrames = null;

//	loop through frmCt, piece frame and mask images back together into a new gif
PImage frmImg, maskImg;
ct = 1;
while(ct<frmCt)
{
	frmImg = loadImage("frames/frame"+ct+".png");
	maskImg = loadImage("frames/frame"+ct+"_MASK.png");

	frmImg.mask(maskImg);

	image(frmImg, 0,0);
	gifExport.setDelay(1);
    gifExport.addFrame();

    //	CLEANUP
    background(255);
    /*
    frmImg.delete();
    maskImg.delete();
    */
    ct++;
}

//	STOP THE GIF
gifExport.finish();

fill(255,0,0);
text("ALL DONE!!! - remember to delete your frame files", 42, height/2);

//	DO ALL WORK HERE THEN BAIL
println("ALL DONE!!! - remember to delete your frame files");
stop();

}

/*

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
*/

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
