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

public class CircleStroke2 extends PApplet {


// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);
//
Boolean isFinal = true;
int alf = 42;
float shapeSize = 400;

int cX,cY;
float xx, yy;

//  
int[] palette = { 
  0xffEF0000, 0xff00EF00, 0xff0000EF, 0xffEFEFEF, 0xffA59DA1, 0xffD96D55, 0xffF36613, 0xffA9ABEA, 0xffD23301, 0xffF6FAFD, 0xffAB6E9C, 0xffD6F9FF, 0xffF8751E, 0xff768A00, 0xffF05510, 0xffFFEE51, 0xffFFB02A, 0xffD7D5FA
};

int outerXX = 0;
int outerYY = 0;

float angle = 0;
float maxAngle;
float radius = 5;
float outerRadius = 1;

int offsetX = 0;
int offsetY = 0;


int ct = 0;
int maxCt = 0;

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

  maxCt = 3600;// * 72;


}


////////////////////////////////////////////////////
//

public void draw()
{
  smooth();

  stroke( random(25, 255), alf);
  noFill();

  xx = ( offsetX - PApplet.parseInt( cos(radians(angle)) * radius ) );
  yy = ( offsetY - PApplet.parseInt( sin(radians(angle)) * radius ) );

  outerXX = ( offsetX - PApplet.parseInt( cos(radians(angle)) * outerRadius ) );
  outerYY = ( offsetY - PApplet.parseInt( sin(radians(angle)) * outerRadius ) );

fix.ranPalStroke(palette);
  strokeWeight( alf );
  point( xx, yy );
  point( outerXX, outerYY );


  strokeWeight( random(3, 36) );
  point( yy, xx );  
  point( outerYY, outerXX );

  if ( angle >= maxCt ) {
    doExit();
  }
  
  if ( angle < 720 ) {
line( xx, yy, outerXX, outerYY );
  }
  
  if ( angle % 720 == 0 ) {

        smooth();  
    strokeWeight( 6);
    point( xx, yy );
//    stroke(#00EF00, alf);
    fix.ranPalStroke(palette);
    line( xx, yy, outerXX, outerYY );
    point( outerXX, outerYY );
    
    
    angle  += 2;//6;
    radius += 2;//6;

    offsetY += (int)random(PI, PI+height);
    offsetX = (int)random(PI, PI+width);

    strokeWeight(13);
    stroke(0xffEF1111, alf*2);

//    line( outerXX, outerYY, offsetX, offsetY );
//    line( offsetX, offsetY, xx, yy );


    strokeWeight( random(36) );
  } 
  else {
    angle++;
    outerRadius++;

    if( radius > width+height )
      radius = 36;
    else
      radius = fix.nextFib( PApplet.parseInt(radius) );
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

  //  stroke(#EFEFEF);
  fill(0xffEE0000);
  text( " "+dailyMsg, this.width*.45f, this.height-18);
}

  public void settings() {  size(1024, 768); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CircleStroke2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
