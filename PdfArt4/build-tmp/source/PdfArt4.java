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

public class PdfArt4 extends PApplet {

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

  lines = loadStrings("my.pdf");
  xx = width;
}


public void draw()
{
	if(frameCount < lines.length )
	{
		txt = lines[frameCount];
		tLen = txt.length();
		txtSz = width/tLen;


	  
	  fill( txtSz, txtSz, txtSz, random(txtSz, tLen) );

	  textAlign(RIGHT);
	  textSize(txtSz);
	text(txt, xx, yy);

// MAKE IT RAIN TEXT ( ALA STALACTITES)
	fill( tLen, tLen, tLen );
	textAlign(CENTER,TOP);
	textSize(random(txtSz));


  pushMatrix();
  translate(xx, random(height), tLen);
  rotate( random(-HALF_PI, HALF_PI) );
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
		tLen = 14;
		textSize(tLen);

		fill(0xffEF1975);
		text("ERICFICKES.COM", 0, height-(tLen*2) );

		fill(0xff19EF75);
		text("ERICFICKES.COM", 0, height-(tLen*1) );

		fill(0xff1975EF);
		text("ERICFICKES.COM", 0, height );

		save(fix.pdeName()+fix.getTimestamp()+".png");
		noLoop();
		exit();
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
    String[] appletArgs = new String[] { "PdfArt4" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
