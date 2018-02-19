import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import fixlib.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class PdfArt10 extends PApplet {

// https://github.com/ericfickes/FIXLIB	


Fixlib fix = Fixlib.init(this);


String lines[];
int[] palette = { 0xff013459, 0xffCF1312, 0xffEF6900, 0xffE8DA83, 0xffCBFB5C, 0xff1A74E2, 0xff061C3F };
String txt;
float xx,yy, tLen, txtSz;


public void setup()
{
  	// text is fuzzy in P3D
  background(0xffefefef);
  

//	blue - #013459
//	red  - #CF1312
//	ORANGE - #EF6900

  lines = loadStrings("rtmp_specification_1.0.pdf");
  xx = width/2;
  yy = height/2;
}


public void draw()
{


	if(frameCount < lines.length )
	{
		txt = lines[frameCount];
		tLen = txt.length();
		txtSz = width/tLen;

// fun to watch
surface.setTitle(txt);


	fill( random(txtSz),  random(txtSz),  random(txtSz), tLen );
	textSize(txtSz);
	text(txt, xx, yy, width, txtSz);

	// stroke( random(txtSz), random(txtSz), random(txtSz), random(txtSz, tLen) );
	stroke( palette[ PApplet.parseInt(random( palette.length-1 )) ], random(txtSz, tLen) );
	

	line(xx, yy, txtSz, tLen);
	line(tLen, txtSz, yy, xx);


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

  popMatrix();


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


		save( fix.pdeName() + fix.getTimestamp() + ".png");
		noLoop();
		exit();
	}


		PImage ss = get();
		image(ss,0,0);


}



////// S SAVE HANDLER /////////

public void keyPressed(){
switch(key)
{
  case 's':
    save( fix.pdeName() + fix.getTimestamp() + ".png");
  break;

  case ESC:
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    noLoop();
    exit();
  break;
}


} 
  public void settings() {  size( displayWidth, displayHeight, P3D);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PdfArt10" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
