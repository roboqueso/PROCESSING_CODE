import fixlib.*;

Fixlib fix = Fixlib.init(this);

// TODO: THIS SKETCH IS NOT SAVING, FIX THE FATAL
/*
textSize(-0.30135608) ignored: the text size must be larger than zero
Tessellation Error: a coordinate is too large
textSize(-0.9124906) ignored: the text size must be larger than zero
textSize(-0.25002646) ignored: the text size must be larger than zero
textSize(-0.13532972) ignored: the text size must be larger than zero
You are trying to draw outside OpenGL's animation thread.
#
# A fatal error has been detected by the Java Runtime Environment:
#
#  SIGSEGV (0xb) at pc=0x00007fff32900f90, pid=3393, tid=0x000000000000df03
#
# JRE version: Java(TM) SE Runtime Environment (8.0_144-b01) (build 1.8.0_144-b01)
# Java VM: Java HotSpot(TM) 64-Bit Server VM (25.144-b01 mixed mode bsd-amd64 compressed oops)
# Problematic frame:
# Place all drawing commands in the draw() function, or inside
your own functions as long as they are called from draw(),
but not in event handling functions such as keyPressed()
or mousePressed().
C  [libGL.dylib+0x5f90]  glBindFramebuffer+0x12
#
# Failed to write core dump. Core dumps have been disabled. To enable core dumping, try "ulimit -c unlimited" before starting Java again
#
# An error report file with more information is saved as:
# /Applications/Processing.app/Contents/Java/hs_err_pid3393.log
Compiled method (nm)   75288 1985     n 0       jogamp.opengl.gl4.GL4bcImpl::dispatch_glBindFramebuffer1 (native)
 total in heap  [0x0000000118547b10,0x0000000118547e40] = 816
 relocation     [0x0000000118547c38,0x0000000118547c78] = 64
 main code      [0x0000000118547c80,0x0000000118547e38] = 440
 oops           [0x0000000118547e38,0x0000000118547e40] = 8
#
# If you would like to submit a bug report, please visit:
#   http://bugreport.java.com/bugreport/crash.jsp
# The crash happened outside the Java Virtual Machine in native code.
# See problematic frame for where to report the bug.
#
Finished.
[Finished in 77.1s]
*/

String lines[];
// color[] palette = { #013459, #CF1312, #EF6900, #E8DA83, #CBFB5C, #1A74E2, #061C3F };
ArrayList palette;
PImage img;
String txt;
float cX, cY, xx,yy, tLen, txtSz;
int colorIdx;



void setup()
{
  size( displayWidth, displayHeight, P3D);	// text is fuzzy in P3D
  // size( 1024, 728, P3D);

  background(#efefef);
  smooth();

  img = loadImage("make-kinect-like-this.jpg");
  palette = fix.getImgColors(img);

  lines = loadStrings("VoronoiType.pdf");	//"BlueNoiseThroughOptimalTransport.pdf");
  cX = width/2;
  cY = height/2;

  fix.paletteGrid(palette);
}


void draw()
{

	if(frameCount < lines.length )
	{
		txt = lines[frameCount];
		tLen = txt.length();
		txtSz = width/tLen;
		colorIdx = frameCount % (palette.size()-1);
// fun to watch
//	Use surface.setTitle() instead of frame.setTitle in Processing 3
// frame.setTitle(txt);
surface.setTitle(txt);


try {

			xx = cX - int( cos(radians(tLen)) * frameCount%txtSz );
			yy = cY - int( sin(radians(tLen)) * frameCount%txtSz );

	
	fill( (Integer)palette.get( colorIdx ) , random(200,tLen) );
	textSize(txtSz);
	text(txt, xx, yy, width, txtSz);

	fill( frameCount%255, frameCount%255, frameCount%255,  random(txtSz, tLen) );
	textSize(txtSz-PI);
	text(txt, xx-PI, yy+PI, width, txtSz);	


		stroke( (Integer)palette.get( colorIdx ) );
	
		xx = cX - int( cos(radians(txtSz)) * frameCount%txtSz );
		yy = cY - int( sin(radians(txtSz)) * frameCount%txtSz );

		fill( (Integer)palette.get( colorIdx ) , 25 );
		stroke( (Integer)palette.get( colorIdx ) );

		rect(xx, yy, txtSz, txtSz, tLen);
		ellipse(yy, xx, txtSz, txtSz);



  pushMatrix();
  translate(xx, yy, tLen);
  	
  	rotate( radians(frameCount) );
	
	fill( tLen, tLen, tLen );
	textAlign(RIGHT,CENTER);
	textSize(txtSz);
  	text( txt, 0,0, width, txtSz );


  	rotate( radians(tLen) );

	fill( frameCount%txtSz, frameCount%txtSz, frameCount%txtSz, random(255) );
	textAlign(LEFT,CENTER);
	textSize(random(txtSz));
  	text( txt, 0,0, width, txtSz );



	rotateX( radians(txtSz) );
	rotateY( radians(txtSz) );
  	rotateZ( radians(txtSz) );

	fill( frameCount%txtSz, frameCount%txtSz, frameCount%txtSz, random(200) );
	textAlign(LEFT,CENTER);
	textSize(random(txtSz));
  	text( txt, 0,0, width, txtSz );

	stroke( (Integer)palette.get( (frameCount%palette.size() ) ) );
	line(0,0, txtSz, txtSz);

	strokeWeight(PI);
	// stroke( (Integer)palette.get( colorIdx ) );
	stroke(xx%255,yy%255,tLen%255);
	fill( (Integer)palette.get( colorIdx ), 100);
	box( txtSz );


  popMatrix();


}
  catch (RuntimeException exc)
  {
	textSize(42);
    text("CRASH::"+exc, 42, height/2);
    tint(255);
    save("CRASH_"+pdeName() + getTimestamp() + ".png");
  }



	} 
	else 
	{



		tLen = 39;
		textSize(tLen);
		fill(0);
		text("ERICFICKES.COM", width, height-tLen );

		fill(255);
		text("ERICFICKES.COM", width-2, height-tLen );

		fill(0);
		text("ERICFICKES.COM", width-4, height-tLen );

		fill(255);
		text("ERICFICKES.COM", width-6, height-tLen );


// P3D RENDER HACK = grab a screenshot of the sketch and drop it on the stage as an image
// If you don't do this, P3D will *not* save any of the drawing in the PNG, just the background
		PImage ss = get();
		image(ss,0,0);


		noLoop();
	}


		PImage ss = get();
		image(ss,0,0);


}



////// S SAVE HANDLER /////////

void keyPressed(){
switch(key)
{
  case 's':
    // save(pdeName() + getTimestamp() + ".png");
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  break;

  case ESC:
    // save(pdeName() + getTimestamp() + ".png");
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
    exit();
  break;
}


} 




public String getTimestamp() {
  return ""+month()+day()+year()+hour()+minute()+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
public String pdeName() {
  return split( this.toString(), "[")[0];
}


