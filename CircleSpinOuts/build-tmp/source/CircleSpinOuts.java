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

public class CircleSpinOuts extends PApplet {

// https://github.com/ericfickes/FIXLIB	


Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
int alf = 42;
float shapeSize = 420;

int cX, xx, yy;
int cY;

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

  maxCt = 4200;	//36000;// * 72;


}


////////////////////////////////////////////////////
//

public void draw()
{
  smooth();


  xx = ( offsetX - PApplet.parseInt( cos(radians(angle)) * radius ) ) ;
  yy = ( offsetY - PApplet.parseInt( sin(radians(angle)) * radius ) ) %height;

  outerXX = ( offsetX - PApplet.parseInt( cos(radians(angle)) * outerRadius ) ) ;
  outerYY = ( offsetY - PApplet.parseInt( sin(radians(angle)) * outerRadius ) ) %height;

  strokeWeight( alf );
  stroke( (frameCount*1.01f)%255, alf*4 );
  point( xx, yy );
  point( outerXX, outerYY );

  strokeWeight( alf/4 );
  stroke( frameCount%255, alf*4 );
  point( xx, yy );
  point( outerXX, outerYY );


  strokeWeight( random(3, 36) );
  stroke( random(alf, 255), alf );
  point( yy, xx );  
  point( outerYY, outerXX );

  if ( angle >= maxCt ) {
    doExit();
  }
  
  if ( angle % 6 == 0 ) {
    smooth();  
    strokeWeight( 6);
    point( xx, yy );
//    stroke(#00EF00, alf);
    fix.ranPalStroke100(palette);
    line( xx, yy, outerXX, outerYY );
    point( outerXX, outerYY );
  }
  
  if ( angle % 720 == 0 ) {

    angle  += 3;//6;
    radius += 3;//6;

    offsetY = (int)random(cY, height);
    offsetX = (int)random(cX, width);

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
    String[] appletArgs = new String[] { "CircleSpinOuts" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
