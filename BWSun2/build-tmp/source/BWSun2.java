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

public class BWSun2 extends PApplet {

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
int alf = 69;

//  circle vars
float angle1 = 0, xx1, yy1, startX1, startY1, radius1 = alf;
float angle2 = 0, xx2, yy2, startX2, startY2, radius2 = alf*4;
float angle3 = 0, xx3, yy3, startX3, startY3, radius3 = alf*8;
float angle4 = 0, xx4, yy4, startX4, startY4, radius4 = alf*12;

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
  fix.alpha(alf);

//b = loadImage("HOTmess3.png");
//p3 = getImgColors(b);
//background(b);
  background(255);

  //  setup variables
  cX = width/2;
  cY = height/2;

  startX1 = startX2 = startX3 = startX4 = 0;  //cX;
  startY1 = startY2 = startY3 = startY4 = 0;  //cY;
  
  stroke(0);
  strokeWeight(.37f);
}


////////////////////////////////////////////////////
//
public void draw()
{
  smooth();

  xx1 = startX1 - PApplet.parseInt( cos(radians(angle1)) * radius1 );
  yy1 = startY1 - PApplet.parseInt( sin(radians(angle1)) * radius1 );
  
  xx2 = startX2 - PApplet.parseInt( cos(radians(angle2)) * radius2 );
  yy2 = startY2 - PApplet.parseInt( sin(radians(angle2)) * radius2 );
  
  xx3 = startX3 - PApplet.parseInt( cos(radians(angle3)) * radius3 );
  yy3 = startY3 - PApplet.parseInt( sin(radians(angle3)) * radius3 );
  
  xx4 = startX4 - PApplet.parseInt( cos(radians(angle4)) * radius4 );
  yy4 = startY4 - PApplet.parseInt( sin(radians(angle4)) * radius4 );
  
  //  -------------
//  strokeWeight(random(alf/TWO_PI));
//  ellipse( xx1, yy1, alf, alf );
//  ellipse( xx2, yy2, alf, alf );
//  ellipse( xx3, yy3, alf, alf );  
  xx4 += random(noise(xx4))+TWO_PI;//random(TWO_PI);
  yy4 += random(noise(yy4))+TWO_PI;//+random(TWO_PI);
  


//  sun beams
fix.drawLissajous( xx4, yy4, alf/PI );


  beginShape(TRIANGLES);

    vertex( xx1, yy1 );
    vertex( xx2, yy2 );
    vertex( xx3, yy3);
    vertex( xx4, yy4 );

  endShape();

  angle1 += 3;
  angle2 += 5;
  angle3 += 7;
  angle4 += 9;

if( frameCount % 90 == 0 ) {
  radius1 -= 9;
  radius2 -= 15;
  radius3 -= 21;
  radius4 += 27; 
}

/*
//  FILL
if( frameCount < 360 && frameCount > 69 ) {
  evenOddFill(#EF0000);  
} else if( frameCount < 720 && frameCount > 360 ) {
  evenOddFill(#0000EF);
} else {
  evenOddFill(#EFEFEF); 
}
*/


  //
  //  STOP
  //  
  if ( frameCount > height*alf || xx4 > width)
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

  textFont( createFont( "Silom", 18 ) );
  smooth();

  fill(0xff676800);
  text( " "+dailyMsg, this.width-230, this.height-14);
}

  public void settings() {  size(1024, 768); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "BWSun2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
