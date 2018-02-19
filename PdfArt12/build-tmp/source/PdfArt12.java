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

public class PdfArt12 extends PApplet {



Fixlib fix = Fixlib.init(this);
PImage ss;

/*
Tessellation Error: a coordinate is too large
*/

String lines[];
// color[] palette = { #013459, #CF1312, #EF6900, #E8DA83, #CBFB5C, #1A74E2, #061C3F };
ArrayList palette;
PImage img;
String txt;
float cX, cY, xx,yy, tLen, txtSz;
int colorIdx;



public void setup()
{
  	// text is fuzzy in P3D
  // size( 1024, 728, P3D);

  background(0xffefefef);
  

  img = loadImage("make-kinect-like-this.jpg");
  palette = fix.getImgColors(img);

  lines = loadStrings("VoronoiType.pdf");	//"BlueNoiseThroughOptimalTransport.pdf");
  cX = width/2;
  cY = height/2;

  fix.paletteGrid(palette);
}


public void draw()
{

	if(frameCount < lines.length )
	{
		txt = lines[frameCount];
		tLen = txt.length();
		txtSz = width/tLen;
		colorIdx = frameCount % (palette.size()-1);
// fun to watch
//	Use surface.setTitle() instead of surface.setTitle in Processing 3
// surface.setTitle(txt);
surface.setTitle(txt);


try {

			xx = cX - PApplet.parseInt( cos(radians(tLen)) * frameCount%txtSz );
			yy = cY - PApplet.parseInt( sin(radians(tLen)) * frameCount%txtSz );

	
	fill( (Integer)palette.get( colorIdx ) , random(200,tLen) );
	
	// new BIG safety catch
	if(txtSz<1){txtSz+=TWO_PI;}
	textSize(txtSz);
	text(txt, xx, yy, width, txtSz);

	fill( frameCount%255, frameCount%255, frameCount%255,  random(txtSz, tLen) );
	
	// new BIG safety catch
	if((txtSz-PI)<1){txtSz+=TWO_PI;}
	textSize(txtSz-PI);
	text(txt, xx-PI, yy+PI, width, txtSz);	


		stroke( (Integer)palette.get( colorIdx ) );
	
		xx = cX - PApplet.parseInt( cos(radians(txtSz)) * frameCount%txtSz );
		yy = cY - PApplet.parseInt( sin(radians(txtSz)) * frameCount%txtSz );

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
    save("CRASH_"+ fix.pdeName() + fix.getTimestamp() + ".png");
    noLoop();
    exit();
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
		ss = get();
		image(ss,0,0);
		save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
		println("DONE!");
		noLoop();
		exit();
	}


		ss = get();
		image(ss,0,0);


}



////// S SAVE HANDLER /////////

public void keyPressed(){
switch(key)
{
  case 's':
    // save( fix.pdeName() + fix.getTimestamp() + ".png");
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  break;

  case ESC:
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    // save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
    noLoop();
    //For Java programmers, this is not the same as System.exit(). Further, System.exit() should not be used because closing out an application while draw() is running may cause a crash (particularly with P3D).
    exit();
  break;
}


} 
  public void settings() {  size( displayWidth, displayHeight, P3D);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PdfArt12" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
