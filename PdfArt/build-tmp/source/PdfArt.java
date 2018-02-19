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

public class PdfArt extends PApplet {

// https://github.com/ericfickes/FIXLIB	


Fixlib fix = Fixlib.init(this);

String lines[];
String txt;
float xx,yy, tLen;

public void setup()
{
  
  background(0xffEF2014);

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

	  // stroke( random(20,40), random(200,215), random(11) );
	  // line( random(yy), yy, random(yy), yy);


	  fill( tLen, tLen, tLen );
	  textSize(random(tLen));

	  text( txt, random( width ), yy );

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

	    save( fix.pdeName() + fix.getTimestamp() + ".png");
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
  public void settings() {  size( displayWidth, displayHeight ); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PdfArt" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
