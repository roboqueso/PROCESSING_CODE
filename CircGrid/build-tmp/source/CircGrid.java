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

public class CircGrid extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);


Boolean isFinal = true;
int ctMAIN = 0;
int alf = 33;

int cX;
int cY;
int xx = 0;
int yy = 0;
int pad = 4;
int cubeSize = 20;

float angle = 15;
float radius = 45;


////////////////////////////////////////////////////
//
public void setup(){
  
  //  ---------------------
  background (18);
  fix.alpha(alf);

  
  noFill();

  cX = this.width / 2;
  cY = this.height / 2;
  
  stroke(0xffEFEFEF, alf);
  
  xx = -cubeSize;
  yy = xx;  
  
//exit();
  
}


////////////////////////////////////////////////////
//
public void draw()
{

//    xx = ( cX - int( cos(radians(angle)) * radius ) );
//    yy = ( cY - int( sin(radians(angle)) * radius ) );

  if( xx % 2 == 0 )
    stroke( 0xff19EF75, alf );
  else if( xx % 3 == 0 )
    stroke( 0xff0DEEF0, alf );
  else if( xx % 4 == 0 )
    stroke( 0xff0E750F, alf );
  else
    stroke( 0xff75EF19, alf );
  
  //  ALTERING ELLIPSE SIZES MAKES FOR DIFF GRID ACTION
  if( xx % 2 == 0 )
    ellipse( xx, yy, cubeSize*2, cubeSize*2 );
  else if( xx % 3 == 0 )
    ellipse( xx, yy, cubeSize*3, cubeSize*3 );
  else if( xx % 4 == 0 )
    ellipse( xx, yy, cubeSize*4, cubeSize*4 );
  else if( xx % 5 == 0 )
    ellipse( xx, yy, cubeSize*5, cubeSize*5 );
  else
    ellipse( xx, yy, cubeSize, cubeSize );  
  
  
  //  #1
  cube( xx, yy, cubeSize );



  if( xx <= (this.width-cubeSize) )
  {  
    xx += cubeSize;
  }
  else
  {
    xx = -cubeSize;
    yy += cubeSize;
    alf--;
  }


  if( yy >= this.height )
  {  
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
    save( fix.pdeName() + "-" + fix.getTimestamp() +".png" );
  }

  noLoop();
  exit();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
public void artDaily( String dailyMsg ) {

  PFont font = createFont( "Silom", 30 );
  textFont( font );
  
  fill( 0xff000000, 666 );
  stroke( 0xff696969, 666 );
    
  for( int ii = this.width-325; ii < this.width; ii += 5 )
  {

//    randFill();
//    randStroke();
    cube( ii, PApplet.parseInt( this.height-( cubeSize*2) ), cubeSize*2 );
  }
  
  fill( 0xffEFEFEF, 666 );  
  text( " "+dailyMsg, this.width-275, this.height-72);
}
////////////////////////////////////////////////////////////////
//  
float x1, x2, x3, x4;
float y1, y2, y3, y4;

public void cube( int x, int y, int cSize ) {
  
  
  x1 = x + cSize;
  y1 = y - cSize;
//  stroke(255, 0, 0);
//  ellipse( x+ cSize, y- cSize, cSize, cSize );

  //  #2
//  stroke(0, 255, 0);
  x2 = x+ (cSize*1.5f);
  y2 = y- (cSize*1.5f);
//  ellipse( x+ (cSize*1.5), y- (cSize*1.5), cSize, cSize );

  //  #3
//  stroke(0,0,255);
  x3 = x+ cSize*2;
  y3 = y- cSize;
//  ellipse( x+ cSize*2, y- cSize, cSize, cSize );
  
  //  #3
//  stroke(255, alf);
  x4 = x+ (cSize*1.5f);
  y4 = y- (cSize*.5f);
//  ellipse( x+ (cSize*1.5), y- (cSize*.5), cSize, cSize ); 

//  randStroke();
/*
  if( xx % 3 == 0 )
    stroke( #0E750F, alf );
  else
    stroke( #0DEEF0, alf );
*/
  if( y % 2 == 0 )
    stroke( 0xff19EF75, alf );
  else if( y % 3 == 0 )
    stroke( 0xff0DEEF0, alf );
  else if( y % 4 == 0 )
    stroke( 0xff0E750F, alf );
  else
    stroke( 0xff75EF19, alf );


  quad( x1, y1, x2, y2, x3, y3, x4, y4 );
}
  public void settings() {  size(1024, 768 );  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CircGrid" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
