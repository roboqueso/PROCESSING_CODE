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

public class IBackgroundRect2 extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

//  make rounded rect that match the app group
//  http://en.wikipedia.org/wiki/Silver_(color)

public Boolean isFinal = true;
int rowCt = 9, colCt = 5, dWidth, dHeight;
float rowH, colW, startX = 0, startY = 0, xx = 0, yy = 0, shapeSz;
int clr = 0xff228B22;

//  greens
int[] p3 = { 0xff19EF75, 0xff87A96B, 0xff006400, 0xff71BC78, 0xff228B22, 0xff49796B, 0xff29AB87, 0xffA9BA9D, 0xff90EE90, 0xff74C365, 0xffADDFAD, 0xff317873, 0xff98FB98, 0xff01796F, 0xff009E60, 0xff008080, 0xff00FF00, 0xff008000, 0xff00A550, 0xff009F6B, 0xff00A877, 0xff4B5320, 0xff006A4E, 0xff66FF00, 0xff1B4D3E, 0xff1E4D2B, 0xff00563F, 0xff00703C, 0xff50C878, 0xff4D5D53, 0xff00AB66, 0xffADFF2F, 0xff3FFF00, 0xff355E3B, 0xff138808, 0xff009768, 0xff00A86B, 0xff4CBB17, 0xff004953, 0xff18453B, 0xff39FF14, 0xff00853E, 0xff006600, 0xff00A693, 0xff2E8B57, 0xff014421 };



//////////////////////////////////////////////////////////////////////////////////////////////////////////
public void setup() {

  dWidth = 1024;  //640;
  dHeight = 768;  //960;
  
  
//  PImage imgBg = loadImage("iphone4s.PNG");
//  background(imgBg);
  background(0);
  frameRate(666);
  
  noFill();
  ellipseMode(CENTER);
  rectMode(CENTER);
  
  
  rowH = 175;
  colW = 153;
  
  startX = -62;
  startY = 124;

  strokeWeight(4);
  shapeSz = (rowH+colW);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
public void draw() {

  //  color
//  if( frameCount%3==0)
//     stroke(clr);
//    stroke( p3[ int(random( p3.length-1 )) ] );
//stroke(random(yy,255),xx, xx,100);
//    stroke(#EF2012);
//  else if( frameCount%4==0)
//    stroke(#EFEF37);
//  else if( frameCount%5==0)
//    stroke(#006A4E);
//  else
//    stroke(0);

  if(frameCount%2==0)
    stroke(0);
  else
    stroke(0xff757575);

    
  //  move
  if( xx < dWidth+colW ){
    xx += colW;
  } else {
    xx = 0;
    yy += rowH;    
  }
  
  if( xx >= dWidth+colW && yy >= dHeight+rowH ) {
    xx = 0;
    yy = 0;
  
    shapeSz -= 9;//+strokeSz;
  }
//    ellipse( startX+xx, startY+yy, shapeSz, shapeSz);
    rect( startX+xx, startY+yy, shapeSz, shapeSz, 21);


      
  if( shapeSz < 0 ) {
  
      fill(255);
      textFont(createFont("Silom",23));
      
      //    TOP RIGHT CORNER-ISH ( between the time and the battery )
      text("ERICFICKES.COM", (dWidth/2)*1.2f, 28 );

//      Bottom left corner
//      text("ERICFICKES.COM", -2, height-2 );

      if(isFinal){
        save( fix.pdeName() + fix.getTimestamp() + ".png" );
      }
      noLoop();
      exit();
  }
}
  public void settings() {  size( 1024, 768 );  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "IBackgroundRect2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
