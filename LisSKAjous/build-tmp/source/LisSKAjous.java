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

public class LisSKAjous extends PApplet {


// https://github.com/ericfickes/FIXLIB	


Fixlib fix = Fixlib.init(this);
Boolean isFinal = true;

//  
//  Black and White
//  Tatoo / Asian style sun
//  Use HOTmess3 as background
//  
//  B&W sunbeams slowly alpha out?
//  
int alf = 150;

//  circle vars
float angle1 = 0, xx1, yy1, startX1, startY1, radius1 = alf;
float angle2 = 0, xx2, yy2, startX2, startY2, radius2 = alf*5;
float angle3 = 0, xx3, yy3, startX3, startY3, radius3 = alf*7;
float angle4 = 0, xx4, yy4, startX4, startY4, radius4 = alf*9;

int cX;
int cY;

int[] palette = { 0xffEF0000, 0xff00EF00, 0xff0000EF, 0xffCECE00, 0xffFA7680, 0xffEF1975, 0xff007007, 0xffEFEF00, 0xffFA9187, 0xff007007, 0xff109109 };
PImage b;
ArrayList p3;

////////////////////////////////////////////////////
//
public void setup() {
  // setup core sketch settings items
  
  frameRate(303);//);

//  b = loadImage("HOTmess3.png");
//  p3 = getImgColors(b);
//  background(b);
background(255);
	fix.alpha(alf);
  //  setup variables
  cX = width/2;
  cY = height/2;

//  startX1 = startX2 = startX3 = startX4 = cX;
//  startY1 = startY2 = startY3 = startY4 = cY;
  
  stroke(0);
  strokeWeight(.37f);
  xx1 = -alf/PI;
}


////////////////////////////////////////////////////
//
public void draw()
{
  smooth();



//  sun beams
fix.drawLissajous( xx1, yy1, alf/PI );
fix.evenOddFill(0);//  #EF2012


if( xx1 < width ) {
 
 xx1 += alf; 
 
} else if( xx1 > width && yy1 > height ) {
  alf -= TWO_PI;
  xx1 = -alf/TWO_PI;
  yy1 = alf/TWO_PI;
} else {

 xx1 = -alf/PI;
 yy1 += alf;
  
}



  //
  //  STOP
  //  frameCount > height*alf || 
  if ( frameCount > width)
  {    
    doExit();
  }
  
}



///////////////////////////////////////////////////////////
//  
//  End handler, saves png
public void doExit() 
{

  artDaily("ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
public void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 37 ) );
  smooth();

  fill(0xffEF2012);
  text( " "+dailyMsg, 0, height);
}

  public void settings() {  size(1024, 768); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "LisSKAjous" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
