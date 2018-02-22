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

public class FrizzleFri2 extends PApplet {

//  
//  http://ericfickes.com
//

//  https://github.com/ericfickes/FIXLIB
Fixlib fix = Fixlib.init(this);
Boolean isFinal = true;
int alf = 75;
float sz=0;
int cX;
int cY;
ArrayList p3;
PImage img;
float xoff, n;

////////////////////////////////////////////////////
//
float i = 0; 
/////////////////////////////////////////////////////////////////////////
public void setup() {
  background(37);
  //);  // P2D
  fix.alpha(alf);
  img = loadImage("indies.jpg");
  p3 = fix.getImgColors(img);

  ellipseMode(CENTER);


  cX = width/2;
  cY = height/2;
} 

/////////////////////////////////////////////////////////////////////////
public void draw() {
  smooth();


  if ( i % ( width/2 ) == 0 ) {
    i = random( TWO_PI );
  } 
  else {
    i++;
  }


  i = frameCount*noise(frameCount, i, sz);
  sz = i/PI;
  strokeWeight(2);

  noiseDetail(frameCount/100);

  xoff = xoff + .01f;
  n = noise(xoff, i, frameCount) * width;
//  fill(#FF0000);
  fix.ranPalFill(p3);
  stroke(0xffEFEFEF);
  ellipse( n, frameCount, sz, sz );
  //  safeit
  n = ( n > height*.75f ) ? alf : n;


  //////////////////////////////////
  //  CORNERS
  //////////////////////////////////
  stroke(255);
  fill(0);

  ellipse( frameCount, frameCount, sz, sz ); 
  ellipse( width-frameCount, frameCount, sz, sz ); 
  ellipse( frameCount, height-frameCount, sz, sz ); 
  ellipse( width-frameCount, height-frameCount, sz, sz ); 


  stroke(0);
  fill(255);
  //////////////////////////////////
  //  half way
  //////////////////////////////////
  ellipse(frameCount, (height/2), sz, sz ); 
  ellipse(width-frameCount, (height/2), sz, sz ); 


  //////////////////////////////////
  //  middle
  //////////////////////////////////
  ellipse( cX, frameCount, sz, sz ); 
  ellipse( cX, height-frameCount, sz, sz ); 



  //    stop
  if ( frameCount > height ) {
    doExit();
  }
}




///////////////////////////////////////////////////////////
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

  fill(0xff2012EF);
  text( " "+dailyMsg, 0, height);
}

  public void settings() {  size(1024, 768); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "FrizzleFri2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
