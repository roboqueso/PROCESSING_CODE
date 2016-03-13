import gifAnimation.*;

boolean gif = true;
/*
bz_ prefix indicating a BerZerker setting to apply to the source gif

bz_REVERSE -> When creating the output gif, reverse it's playback order?
*/
boolean bz_REVERSE = true;	// output gif has it's frames inverted
GifMaker gifExport;
int ct, frmCt;
PImage frmImg, maskImg;
PImage[] allFrames;

// String SRC_GIF = "tumblr_no1.gif";	//	386, 383
// String SRC_GIF = "oie_overlay.gif";	//	500, 489
//	String SRC_GIF = "crayola.gif";	//	400, 400
// String SRC_GIF = "sun.gif";	//	500, 500
// String SRC_GIF = "access_denied.gif";	//	400, 400
//	String SRC_GIF = "checkers.gif";	//	500, 500
String SRC_GIF = "melty.gif";	//	400, 400
// String SRC_GIF = "melty_gif_berzerker.gif";	//	400, 400




void setup() 
{
	smooth();
  size(400,400); // be sure to match source gif dimensions
  background(255);

//	1. Load existing GIF into frames
allFrames = Gif.getPImages(this, SRC_GIF);
//	get frame count
frmCt = allFrames.length;
ct = 1; // KEEP THIS IN SYNC WITH frmCt LOOP BELOW
println("frmCt = " + frmCt);

  if(gif){
	  gifExport = new GifMaker(this, split( SRC_GIF, ".")[0]+"_"+fileStamp()+".gif", 100);
	  gifExport.setRepeat(0);             // make it an "endless" animation
	  gifExport.setDispose(GifMaker.DISPOSE_REMOVE);
	  //  SCRIVNER: multiples of 16 frames
	  gifExport.setTransparent(255);    // white is transparent
	}


//	2. Loop through each frame
for(PImage frm : allFrames)
{
	//	save frame to disk
	// frm.save("frame"+ct+".png");
	image(frm,0,0);
	saveFrame("frames/frame"+ct+".png");

	//	ADD FILTER(S) TO CREATE MASK IMAGE
	frm.filter(GRAY);
	frm.filter(INVERT); 
	// frm.filter(THRESHOLD, .42);
	

	//	save mask to disk
	image(frm,0,0);
	saveFrame("frames/frame"+ct+"_MASK.png");

	ct++;
}


//	kill frames array
allFrames = null;

//	loop through frmCt, piece frame and mask images back together into a new gif


// ct = bz_REVERSE ? frmCt : 1;
//	REVERSE SUPPORT : always keep "while(ct<frmCt)" constant and adjust ct and frmCt's values to comply to bz_REVERSE
if(bz_REVERSE)
{
	ct = -frmCt;
	frmCt = 0;
}
else 
{
	ct = 1;	
}


while(ct<frmCt)
{
	background(255);

 	// bz_REVERSE : negative ct detector
	frmImg = loadImage("frames/frame"+(ct<0?-ct:ct)+".png");
	maskImg = loadImage("frames/frame"+(ct<0?-ct:ct)+"_MASK.png");
	frmImg.filter(INVERT);
	frmImg.mask(maskImg);


	gifExport.setDelay(20);
    gifExport.addFrame(frmImg);

println(ct + " working");

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
