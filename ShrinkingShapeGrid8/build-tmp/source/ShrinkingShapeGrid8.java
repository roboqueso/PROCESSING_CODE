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

public class ShrinkingShapeGrid8 extends PApplet {


// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
int alf = 42;


int shapeSize = 4000;
float minShapeSize = 30;
//float maxShapeSize = 100;

int cX;
int cY;


int[] palette = { 
0xffA59DA1,0xffD96D55,0xffF36613,0xffA9ABEA,0xffD23301,0xffF6FAFD,0xffAB6E9C,0xffD6F9FF,0xffF8751E,0xff768A00,0xffF05510,0xffFFEE51,0xffFFB02A,0xffD7D5FA
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
  background(3);
  fix.alpha(alf);
  cX = width / 2;
  cY = height / 2;

  noFill();
  strokeWeight(.5f);
  

  shapeSize = width;

}


////////////////////////////////////////////////////
//

public void draw()
{
  //  get small

  while( shapeSize >= minShapeSize ) 
  {
    //  re-init loop vars
    x = y = ct = (int)-alf;

    maxCt = fix.getMax( shapeSize );
          
    while( ct < maxCt ) {
      
      smooth();

      strokeWeight( random(.9f) );

      fix.ranPalStroke(palette);
      fix.hexagon( x, y, shapeSize );

      fix.ranPalStroke(palette);
      rect( x, y, shapeSize, shapeSize );

      fix.ranPalStroke(palette);
      ellipse( x, y, shapeSize, shapeSize );

      if( x >= width ) {
        x = (int)-alf;
        y += shapeSize; 
      } else {
        x += shapeSize;
      }
      
      ct++;
    }
    

    // shrink the shape
    shapeSize = PApplet.parseInt(shapeSize*.75f);
  }

//  fix.drawFrame();

  ct = 4;
  
  while( ct < 500 ) {

    fix.circle( cX, cY, ct, ct );

    ct += fix.nextFib( ct );
  }
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
}

  public void settings() {  size(1024, 768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ShrinkingShapeGrid8" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
