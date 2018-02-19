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

public class PdfArt3 extends PApplet {

// https://github.com/ericfickes/FIXLIB	


Fixlib fix = Fixlib.init(this);

String lines[];
String txt;
float xx,yy, tLen, txtSz;


public void setup()
{
  
  background(0xffCF1312);


//	ORANGE - EF6900

  lines = loadStrings("my.pdf");
}


public void draw()
{
// fill( random(20,40), random(200,215), random(11), 5);
// rect(0,0, displayWidth, displayHeight);

	if(frameCount < lines.length )
	{
		txt = lines[frameCount];
		tLen = txt.length();
		txtSz = tLen;

	  // stroke( random(20,40), random(200,215), random(11) );
	  // line( random(yy), yy, random(yy), yy);


	  // fill( tLen, tLen, tLen );
	  fill( txtSz, txtSz, txtSz );
	  // textSize(random(tLen));
	  textSize(txtSz);

// MAKE IT RAIN TEXT ( ALA STALACTITES)
/*
 	textAlign(CENTER);

  pushMatrix();
  translate(xx, random(height));
  rotate(-HALF_PI);
  	text( txt, 0,0 );
  popMatrix();
*/
text(txt, xx, yy);

	  if(xx<width)
	  {
	  	xx += txtSz;// txt.length();
	  } 
	  else
	  {
	  	xx = 0;//random(PI);
	  }


	  if(yy<height)
	  {
	  	yy += txt.length();
	  } 
	  else
	  {
	  	yy = random(PI);
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
  public void settings() {  size( displayWidth, displayHeight ); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PdfArt3" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
