import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class burlapGrid extends PApplet {

//
//  Learning Processing CH6 EX 6-8 -> rand grid of squares
//

Boolean isFinal = true;
int alf = 42;

float shapeSize = 1000;
float minShapeSize = 2.5f;

int cX;
int cY;

//  
int[] palette = { 
  0xffEF0000, 0xff00EF00, 0xff0000EF, 0xffEFEFEF, 0xffA59DA1, 0xffD96D55, 0xffF36613, 0xffA9ABEA, 0xffD23301, 0xffF6FAFD, 0xffAB6E9C, 0xffD6F9FF, 0xffF8751E, 0xff768A00, 0xffF05510, 0xffFFEE51, 0xffFFB02A, 0xffD7D5FA
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
  background(9);

  //  setup variables
  cX = width/2;
  cY = height/2;

//  maxCt = int( (width*height)/shapeSize );

    noFill();
    strokeWeight(.5f);
    
}


////////////////////////////////////////////////////
//

public void draw()
{
  //  keep drawing smaller and smaller square grids

    x = y = ct = 0;
    maxCt = getMaxCt( shapeSize );    

    //  square grid1
    while( ct < maxCt ) {

      randStrokeUser();
      rect( x, y, shapeSize, shapeSize );

      randStrokeUser();
      ellipse( x, y, shapeSize, shapeSize );
      
      if( x >= width ) {
        x = 0;
        y += shapeSize; 
      } else {
        x += shapeSize;
      }
      
      ct++;
    }
    

    // shrink the shape
//    shapeSize /= 2;
    shapeSize -= minShapeSize;


if( shapeSize <= minShapeSize ) {
  exit();
}
}

public float getMaxCt( float shapeSize ) {
  return ( ( width * height ) / shapeSize );
}

public void textLines() {


  textFont( createFont( "Helvetica", 300 ) );

  fill(10, pow(alf, 1.5f) );//, (alf*4) );
  // MAKE TEXT BIG
  fill(0xff210000, pow(alf, 1.5f) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.3f );
  fill(0xff000021, pow(alf, 1.5f) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.3f );
  //  & curve
  fill(0xff210000, pow(alf, 1.5f) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.49f );
  fill(0xff000021, pow(alf, 1.5f) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.49f );
  //  & quad
  fill(0xff210000, pow(alf, 1.5f) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.65f );
  fill(0xff000021, pow(alf, 1.5f) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.65f );

  //  & triangle
  fill(0xff210000, pow(alf, 1.5f) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.85f );
  fill(0xff000021, pow(alf, 1.5f) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.85f );
}




public void mousePressed() {
  println("mousePressed()");
}


public void keyPressed() {
  println("keyPressed()");
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

//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
//  ellipse(x, y, width, height)

float radius2 = 18, xx, yy;

public void circle( float startX, float startY, float w, float h ) {

  float angle = 0;

  while ( angle < 360 ) {
    xx = startX - PApplet.parseInt( cos(radians(angle)) * radius2 );
    yy = startY - PApplet.parseInt( sin(radians(angle)) * radius2 );


    ellipse( xx, yy, w, h );

    angle++;
  }
}

//////////////////////////////////////////////////////////////////////////
//  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
public void hexagon( float startX, float startY, float shapeSize ) {

  line( startX, startY+(shapeSize*.5f), startX+(shapeSize*.25f), startY );
  line( startX+(shapeSize*.25f), startY, startX+(shapeSize*.75f), startY );
  line( startX+(shapeSize*.75f), startY, startX+(shapeSize), startY+(shapeSize*.5f) );

  line( startX+(shapeSize), startY+(shapeSize*.5f), startX+(shapeSize*.75f), startY+shapeSize );
  line( startX+(shapeSize*.75f), startY+shapeSize, startX+(shapeSize*.25f), startY+shapeSize );
  line( startX+(shapeSize*.25f), startY+shapeSize, startX, startY+(shapeSize*.5f) );
}




///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
public void exit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( this + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
  }

  super.stop();
}

///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
public void randFill() {  
  fill( random(255), random(255), random(255), alf );
}
public void randStroke() {  
  stroke( random(255), random(255), random(255), alf );
}
public void randStroke100() {  
  stroke( random(255), random(255), random(255), 100 );
}

////////////////////////////////////////////////////
//  Randomly stroke using image from color list
public void randStrokeUser()
{
  // pallete
  stroke( palette[ PApplet.parseInt(random( palette.length-1 )) ], alf*.75f );
}
public void randFillUser()
{
  fill( palette[ PApplet.parseInt(random( palette.length-1 )) ], alf*.75f );
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

  public void settings() {  size(1024, 768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "burlapGrid" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
