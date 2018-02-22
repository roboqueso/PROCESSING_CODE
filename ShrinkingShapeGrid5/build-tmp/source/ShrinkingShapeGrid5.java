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

public class ShrinkingShapeGrid5 extends PApplet {


// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);
//
//  Taking the concept behind shrinking shape grid and invert it, and use fibonacci
//  - start small, maxShapeSize, maxCt = fibonacci

Boolean isFinal = true;
int alf = 11;

int shapeSize = 2;  //10000;
float minShapeSize = 2;
float maxShapeSize = 2000;

int cX;
int cY;


int[] palette = { 
0xffD89054,0xff4A1A08,0xffF9DA9B,0xff955029,0xffE4B58B,0xffB59F88,0xffF5D7C9,0xffDCD3BC,0xffDCEED2,0xffC3C6AA,0xff877D60,0xffDDEEEE,0xffAA7C64,0xffD9BBBC,0xffF6DDEE,0xffC9CDCC,0xff879285,0xffDDDDDD,0xffB9B9BC,0xffFFFFFF,0xffFFFFEE,0xff77665E,0xffFFFFDD,0xffFFFFC1,0xffFFEEC4,0xffFFEEDD,0xffEEEEDD,0xffEEEEC6,0xffFFEEEF,0xffEEFFE9,0xffEEFFFF,0xffEEEEEE
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
  fix.alpha(alf);
  noFill();
  strokeWeight(.5f);
  

}


////////////////////////////////////////////////////
//

public void draw()
{
  //  keep drawing BIGGER AND BIGGER fibonacci powerred grids

  while( shapeSize <= maxShapeSize ) 
  {
    //  re-init loop vars
    x = y = ct = -5;

    maxCt = fix.getMax( shapeSize );    

    //  square grid1
    while( ct < maxCt ) {

      fix.ranPalStroke(palette);
      ellipse( x, y, shapeSize, shapeSize );

      fix.ranPalStroke(palette);
      fix.hexagon( x, y, shapeSize );

      fix.ranPalStroke(palette);
//      rect( x, y, shapeSize, shapeSize );


      if( x >= width ) {
        x = -5;
        y += shapeSize; 
      } else {
        x += shapeSize;
      }
      
      ct++;
    }
    

    // shrink the shape
    shapeSize += fix.nextFib( shapeSize );
  }

//  stroke( #EFEFEF, alf*2);
//  fix.drawFrame();

  doExit();
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
  //fill(#00EE00);
  fill(0xffEFEFEF);
  text( " "+dailyMsg, this.width*.45f, this.height-18);
  fix.ranPalFill(palette);
  text( " "+dailyMsg, this.width*.45f, this.height-18);
}

  public void settings() {  size(1024, 768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ShrinkingShapeGrid5" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
