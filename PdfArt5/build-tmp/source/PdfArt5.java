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

public class PdfArt5 extends PApplet {

// https://github.com/ericfickes/FIXLIB	


Fixlib fix = Fixlib.init(this);

String lines[];
String txt;
float xx,yy, tLen, txtSz;


public void setup()
{
  	// text is fuzzy in P3D
  background(0xffCF1312);
  

//	ORANGE - EF6900

  lines = loadStrings("render.pdf");
  xx = width;
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

	  
	fill( txtSz, txtSz, txtSz, random(txtSz, tLen) );

	// textAlign(RIGHT);
	textSize(txtSz);
	text(txt, xx, yy);




	stroke(txtSz,txtSz,txtSz);
	
	// line(yy, xx, tLen, txtSz);
	line(tLen, yy, txtSz, tLen);


// MAKE IT RAIN TEXT ( ALA STALACTITES)
	fill( tLen, tLen, tLen );
	textAlign(CENTER,BOTTOM);
	textSize(random(txtSz));

  pushMatrix();
  translate(xx, random(height), tLen);
  // rotate( random(-HALF_PI, HALF_PI) );
  rotate(-HALF_PI);
  	text( txt, 0,0 );
  popMatrix();



/*
	  if(xx<width)
	  {
	  	xx += txtSz;// txt.length();
	  } 
	  else
	  {
	  	xx = 0;//random(PI);
	  }
*/xx = random(width);

	  if(yy<height)
	  {
	  	yy += txtSz;
	  } 
	  else
	  {
	  	yy = random(txtSz);
	  }


	} 
	else 
	{



		tLen = 39;
		textSize(tLen);
		fill(0);
		text("ERICFICKES.COM", 0, height-tLen );

		fill(255);
		text("ERICFICKES.COM", 2, height-tLen );

		fill(0);
		text("ERICFICKES.COM", 4, height-tLen );

		fill(255);
		text("ERICFICKES.COM", 6, height-tLen );


// P3D RENDER HACK = grab a screenshot of the sketch and drop it on the stage as an image
// If you don't do this, P3D will *not* save any of the drawing in the PNG, just the background
		PImage ss = get();
		image(ss,0,0);

		save(fix.pdeName()+fix.getTimestamp()+".png");

		noLoop();
	}


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
    String[] appletArgs = new String[] { "PdfArt5" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
