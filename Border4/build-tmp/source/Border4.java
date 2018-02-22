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

public class Border4 extends PApplet {

// https://github.com/ericfickes/FIXLIB	


Fixlib fix = Fixlib.init(this);
Boolean isFinal = true;
int alf = 42; //37;

int cX;
int cY;

int[] palette = { 0xffEF0000, 0xff00EF00, 0xff0000EF, 0xffCECE00, 0xffFA7680, 0xffEF1975, 0xff007007, 0xffEFEF00, 0xffFA9187, 0xff007007, 0xff109109 };

ArrayList _pvectors = new ArrayList();
int ct = 0;
int maxCt = 0;

////////////////////////////////////////////////////
//
public void setup() {
  // setup core sketch settings items
  
  frameRate(303);
  background(6);
  fix.alpha(alf);
  //  setup variables
  cX = width/2;
  cY = height/2;

  // RED
  stroke( 0xffB00B13, alf );
  maxCt = 36;  //360;
  fix.drawFrame();
}


////////////////////////////////////////////////////
//

float _x = 135;
float _y = 135;
PVector thisPt,lastPt, pv1, pv2, pv3, pv4 = new PVector();

public void draw()
{
  smooth();
  fix.ranPalStroke(palette);
  
  _x = lerp( 666, random(width), .8f );
  _y = lerp( 666, random(height-100), .8f );

  // store this point
  _pvectors.add( new PVector( _x, _y ) );
  
  
  //  dot
  strokeWeight( random(alf) );
  point( _x, _y );



  if( _pvectors.size() > 1 )
  {

    //  connect this point ( _x, _y ) to the last
  
    lastPt = (PVector)_pvectors.get( _pvectors.size()-2 );

    line( lastPt.x, lastPt.y, _x, _y );

    ellipse( lastPt.x, lastPt.y, alf, alf );
    
    //  drop a curve every 4th point
    if( _pvectors.size() % 4 == 0 ) {
      pv1 = (PVector)_pvectors.get( _pvectors.size()-1 );
      pv2 = (PVector)_pvectors.get( _pvectors.size()-2 );
      pv3 = (PVector)_pvectors.get( _pvectors.size()-3 );
      pv4 = (PVector)_pvectors.get( _pvectors.size()-4 );

      curve( pv1.x, pv1.y, pv2.x, pv2.y, pv3.x, pv3.y, pv4.x, pv4.y );
     
    }
    
    
  }

/*

      PVector thisPt = (PVector)_pvectors.get(xx);
      PVector lastPt = new PVector();
      
      // draw dot
      vertex( thisPt.x, thisPt.y );
        
      if( xx > 0 )
      {
        lastPt = (PVector)_pvectors.get(xx-1);

        // connect the dots
        strokeWeight( lineSize );
        line( lastPt.x, lastPt.y, thisPt.x, thisPt.y );
      }

*/


  //  generate random point inside frame


  
  //  draw circle around that point
  
  
  //  generate next point
  
  
  //  connect thisPoint with nextPoint
  

  if( ct >= maxCt ) {
    doExit();
  }
  
  ct++;
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
    save( fix.pdeName() +".png" );
  }

  noLoop();
  exit();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
public void artDaily( String dailyMsg ) {

  PFont font = createFont( "Silom", 18 );

  smooth();
  textFont( font );
  strokeWeight(1);

//  fill( #000000 , 666 );
  fill(0xffEFEFEF, pow(alf,3) );
  text( " "+dailyMsg, this.width-225, this.height-15);
  
//  fill( #003600 , 666 );
  fill(0xffCADDAC, pow(alf,3) );
  text( " "+dailyMsg, this.width-226, this.height-16);
}

  public void settings() {  size(1024, 768); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Border4" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
