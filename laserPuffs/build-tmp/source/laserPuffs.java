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

public class laserPuffs extends PApplet {


// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);
//
Boolean isFinal = true;
int alf = 13;
float shapeSize = 100;

int cX, cY, xx, yy;

//  
int[] palette = { 
  0xffEF0000, 0xff00EF00, 0xff0000EF, 0xffEFEFEF, 0xffA59DA1, 0xffD96D55, 0xffF36613, 0xffA9ABEA, 0xffD23301, 0xffF6FAFD, 0xffAB6E9C, 0xffD6F9FF, 0xffF8751E, 0xff768A00, 0xffF05510, 0xffFFEE51, 0xffFFB02A, 0xffD7D5FA
};

int outerXX = 0;
int outerYY = 0;

float angle = 0;
float maxAngle;
float radius = 10;
float outerRadius = 100;

int offsetX = 0;
int offsetY = 0;
float _lerp = 0.01f;

int ct = 0;
int maxCt = 0;
boolean flip = false;

////////////////////////////////////////////////////
//
public void setup() {
  // setup core sketch settings items
  
  frameRate(303);
  background(9);
  fix.alpha(alf);
  //  setup variables
  cX = width/2;
  cY = height/2;

  offsetX = cX;
  offsetY = cY;

  maxCt = 360 * 30;

  // white scan lines
  stroke(255, 25 );
  for ( int ll = 0; ll <= width; ll += 2 ) 
  {  
    strokeWeight( random(1.1f) );

    line( 0, ll, random(width), ll );
    line( ll, 0, ll, random(height) );
  }
}


////////////////////////////////////////////////////
//

public void draw()
{
  smooth();
  strokeWeight( random(5.5f) );
  stroke( random(6), alf);
  noFill();

  xx = ( offsetX - PApplet.parseInt( cos(radians(angle)) * random(radius) ) );
  yy = ( offsetY - PApplet.parseInt( sin(radians(angle)) * random(radius) ) );

  outerXX = ( offsetX - PApplet.parseInt( cos(radians(angle)) * outerRadius ) );
  outerYY = ( offsetY - PApplet.parseInt( sin(radians(angle)) * outerRadius ) );

  strokeWeight(.5f);

  line(outerXX, outerYY, offsetX, offsetY);
  line(offsetX, offsetY, xx, yy);
//  point(xx, yy);
  
  strokeWeight( alf );

  stroke( 0xff90DEFA , alf);
  
//  point( outerXX, outerYY );
  point( random(xx, outerXX), random( yy, outerYY ) );
  point( lerp(xx, outerXX, _lerp ), lerp( yy, outerYY, _lerp ) );

  fix.ranPalStroke(palette);

  if( flip ) {
    fix.hexagon( lerp(offsetX, outerXX, _lerp ), lerp( offsetY, outerYY, _lerp ), random(shapeSize) );
  } else {
    ellipse( lerp(xx, outerXX, _lerp ), lerp( yy, outerYY, _lerp ), random(shapeSize), random(shapeSize) );
  }


//  point( random(lerp(xx, outerXX, _lerp )), random(lerp( yy, outerYY, _lerp )) );//, shapeSize, shapeSize );


  
  if ( angle >= maxCt ) {
    doExit();
  }

  if( _lerp < 1 ) {
    _lerp += 0.05f;
  } else {
    _lerp = 0.01f;
  }


if ( angle % 1080 == 0 ) {
    flip = !flip;
    angle  += 6;
    radius += 6;

    offsetY = (int)random(height);
    offsetX = (int)random(width);

    strokeWeight(4);
    stroke(0xffFF0000, alf*2);

    line( outerXX, outerYY, offsetX, offsetY );
    line( offsetX, offsetY, xx, yy );


    strokeWeight( random(6.9f) );
  } 
  else {
    angle+=2;  //6;
  }
}



///////
//  draw frame
public void drawFrame() {

  rectMode(CORNER);

  strokeWeight( 100 );
  rect( 0, 0, width, height);

  strokeWeight( 5 );
  rect( 64, 65, width-128, height-129 );

  strokeWeight( 15 );
  rect( 84, 85, width-168, height-168 );

  //  dashed line
  strokeWeight(6);
  int x = 110;
  int y = 110;

  strokeCap(PROJECT);

  for ( int pp = 0; pp <= (width*height); pp++ ) { 

    if ( x <= (width-110) ) {
      // top row    
      point( x, y );
      //  bottom row
      point( x, 790 );

      x += 10;
    } 
    else if ( y <= 780 ) {

      // left row    
      point( (width-110), y );
      //  right row
      point( 110, y );
      y += 10;
    }
  }

  strokeWeight( 5 );
  rect( 122, 122, width-245, height-245 );
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

  fill(0xffEFEFEF);
  text( " "+dailyMsg, this.width*.45f, this.height-18);
}

  public void settings() {  size(1024, 768); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "laserPuffs" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
