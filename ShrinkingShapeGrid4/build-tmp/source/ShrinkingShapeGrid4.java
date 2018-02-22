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

public class ShrinkingShapeGrid4 extends PApplet {


// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);
//
//  Taking the concept behind shrinking shape grid and invert it, and use fibonacci
//  - start small, maxShapeSize, maxCt = fibonacci

Boolean isFinal = true;
int alf = 9;

float shapeSize = 42;  //10000;
float minShapeSize = alf;
float maxShapeSize = 2013;

int cX;
int cY;


int[] palette = { 
0xff69EF19, 0xff00EE00, 0xff00EF00, 0xff004200, 0xff001768, 0xff007500,
0xffB00B13, 0xffEFADED
};

int x = 0;
int y = 0;

int ct = 0;
float maxCt = 0;
  
////////////////////////////////////////////////////
//
public void setup() {
  // setup core sketch settings items
  
  frameRate(303);
  background(alf);
  ellipseMode(CENTER);
  rectMode(CENTER);
  fix.alpha(alf);
  noFill();
  strokeWeight(.5f);
  

}


////////////////////////////////////////////////////
//

public void draw()
{
  //  keep drawing BIGGER AND BIGGER fibonacci powerred grids

    //  re-init loop vars
    x = y = 13;
    ct = 0;

    maxCt = fix.nextFib( (int)shapeSize );    

    //  square grid1
    while( ct < maxCt ) {

      fix.ranPalStroke(palette);
      fix.circle( x, y, shapeSize, shapeSize );

//      fix.ranPalStroke(palette);
//      hexagon( x, y, shapeSize );
      
      
      
      if( x >= width ) {
        x = 0;
        y += shapeSize; 
      } else {
        x += shapeSize;
      }
      
      ct+= 42;
    }

  // shrink the shape
  shapeSize += minShapeSize;

  if( shapeSize >= maxShapeSize ) {
    stroke(0);
    fix.drawFrame();
  
    doExit();
  }
}


///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
public void doExit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + fix.getTimestamp() + ".png" );
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

  //  stroke(#EFEFEF);
//  fill(#EE0000);
  fill(0xff00EE00);
  text( " "+dailyMsg, this.width*.45f, this.height-18);
}

  public void settings() {  size(1024, 768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ShrinkingShapeGrid4" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
