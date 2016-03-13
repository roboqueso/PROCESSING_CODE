/*
P5 App : Record sound wave to gif.

App
- Start / Stop record button
- Always redraw background
- Save each frame to /FRAMES/*.png
- Call GIFSICLE to combine frames into gif
- Open new gif file

** What are app export and distribute options?
** Can you bundle all required libs w/P5 app? ( MINIM, GIFSICLE )


gifsicle ­l ­ O3 —dither —colors=4 ­d5 folder/image­*.gif > output.gif

// ­l loops the gif when it reaches the end of the sequence

// ­O3 applies some optimizations

// —dither applies the default dithering option

// —colors=4 number of colors to use

// ­d5 the delay (speed) between frames

// input files > output file

// generally aim for 500x500 && < 2MB 24­48 frames

*/

import java.io.InputStreamReader;
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
String SRC_GIF = "sun.gif";	//	500, 500
// String SRC_GIF = "access_denied.gif";	//	400, 400
//	String SRC_GIF = "checkers.gif";	//	500, 500
//String SRC_GIF = "melty.gif";	//	400, 400
// String SRC_GIF = "melty_gif_berzerker.gif";	//	400, 400




void setup() 
{
	smooth();
  size(500,500); // be sure to match source gif dimensions
  background(255);

//	1. Load existing GIF into frames
allFrames = Gif.getPImages(this, SRC_GIF);
//	get frame count
frmCt = allFrames.length;
ct = 1; // KEEP THIS IN SYNC WITH frmCt LOOP BELOW
println("frmCt = " + frmCt);
/*
  if(gif){
	  gifExport = new GifMaker(this, split( SRC_GIF, ".")[0]+"_"+fileStamp()+".gif", 100);
	  gifExport.setRepeat(0);             // make it an "endless" animation
	  gifExport.setDispose(GifMaker.DISPOSE_REMOVE);
	  //  SCRIVNER: multiples of 16 frames
	  gifExport.setTransparent(255);    // white is transparent
	}
*/

//	2. Loop through each frame
for(PImage frm : allFrames)
{
	//	ADD FILTER(S) TO CREATE MASK IMAGE
	frmImg = frm;
	maskImg = frm;
	maskImg.filter(GRAY);
	maskImg.filter(INVERT); 
	frmImg.mask(maskImg);
	// NOTE: this should be fully TWEAKED at this pint
	maskImg = frmImg;

	//	save frame to disk
	image(maskImg,0,0);
	saveFrame("frames/frame"+ct+".png");


	ct++;
}


//	kill frames array
allFrames = null;


// NOTE: THIS DOESN'T WORK VIA PROCESSING ?!?!?
ImageMagick();

fill(255,0,0);
text("ALL DONE!!! - remember to delete your frame files", 42, height/2);

//	DO ALL WORK HERE THEN BAIL
println("ALL DONE!!! - remember to delete your frame files");
stop();
}


////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////
void ImageMagick()
{
	// UPDATE: Use cmd line ImageMagick CONVERT command to make gif from frames
	// String[] params = { "/opt/ImageMagick/bin/convert", "-delay 0 -loop 0 /Users/ericfickes/Documents/Processing/gif_berzerker_magick/frames/*.png /Users/ericfickes/Documents/Processing/gif_berzerker_magick/" + split( SRC_GIF, ".")[0]+"_"+fileStamp()+".gif" };
	// String params = "/opt/ImageMagick/bin/convert -delay 0 -loop 0 /Users/ericfickes/Documents/Processing/gif_berzerker_magick/frames/*.png /Users/ericfickes/Documents/Processing/gif_berzerker_magick/" + split( SRC_GIF, ".")[0]+"_"+fileStamp()+".gif";
	// String[] params = { "/opt/ImageMagick/bin/convert", "-delay 0 -loop 0 /Users/ericfickes/Documents/Processing/gif_berzerker_magick/frames/*.png /Users/ericfickes/Documents/Processing/gif_berzerker_magick/" + fileStamp()+".gif" };

	String cmdArray[] = { "/opt/ImageMagick/bin/convert", 
						"-delay", "0", 
						"-loop", "0", 
						"/Users/ericfickes/Documents/Processing/gif_berzerker_magick/frames/*.png", 
						"/Users/ericfickes/Documents/Processing/gif_berzerker_magick/" + split( SRC_GIF, ".")[0]+"_"+fileStamp()+".gif" };
//	println( cmdArray );
 
	try {

		Process p = Runtime.getRuntime().exec(cmdArray);
		BufferedReader input = new BufferedReader(new InputStreamReader(p.getInputStream()));

		String line;
		while ( (line = input.readLine ()) != null) 
		{
			println("PROCESS :: " + line);
		}
		
		input.close();
		println("PROCESS CLOSED");

	}
	catch(Exception e) 
	{
		println(" !!!! EXCEPTION : " + e  + " !!!! ");
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

//  return unique filename_timestamp string
public String sketchName(){
  return split( this.toString(), "[")[0];
}
//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}
