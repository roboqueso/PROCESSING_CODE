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

public class TargetSystem extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;

int gridSize = 4;    // grid will always be gridSize X gridSize
int maxCt = 13;    // how many passes do you want?
int alf = 75;
int colWidth, rowHeight;
int x = 0, y = 0;
int[] nums = { 
  3, 9, 11, 13, 22, 37, 42, 69
};


public void setup() {
  background(alf);
   
  fix.alpha(alf);
  
  noFill();

  colWidth = floor( width / gridSize );
  rowHeight = floor( height / gridSize );
} 

//////////////////////////////////////////////////////////////////////
public void draw() {

  moveSystem( x, y );

  fill(random(222),gridSize);
  stroke(random(222),gridSize);
  drawSystem( x, y );

  fill(random(222), 42);
  stroke(random(222), 42);
  drawSystem( y, x );
  
  fix.bullsEye( x, y, gridSize*TWO_PI );
  fix.rectEye( x, y, gridSize*noise(frameCount) );
  fix.rectEye( y, x, gridSize);

  //  adjust grid size
  if ( frameCount % width == 0 ) {
    gridSize = nums[ floor( random(nums.length) ) ]; //floor(random( 2, 10 ));
    colWidth = floor( width / gridSize );
    rowHeight = floor( height / gridSize );
  }

  if ( frameCount > width )
  {
    artDaily("ERICFICKES.COM");
    
    if(isFinal){
     save( fix.pdeName()+fix.getTimestamp()+".png" );
    }
    
    noLoop();
    exit();
  }
}





//////////////////////////////////////////////////////////////////////
//    System for adjusting x & y coordinates
public void moveSystem( float x, float y )
{

  switch( floor( random(10) ) )
  {
  case 0:
  case 1:
  case 2:
    {
      if ( x < width )
      {
        x += colWidth;
      } 
      else {
        x = 0;
        y += rowHeight;
      }
    }
    break;

  case 3:
    {
      if ( y > height )
      {
        y = random(colWidth);
      } 
      else {
        y += rowHeight+colWidth;
        x -= y;
      }
    }
    break;

  case 4 :
    {
      x = width/2 + cos(x) * radians(frameCount );
      y = width/2 + sin(y) * radians(frameCount );
    }
    break;

  case 5 :
    {
      x += random(colWidth);
      y += random(rowHeight);
    }
    break;

  case 6 :
    {
      if( x < width ) {
        x += colWidth;
      } else {
        x = colWidth;
        y += rowHeight;
      }
    }
    break;

  case 7 :
    {
      x += 9;
      y += 11;
    }
    break;

  case 8 :
    {
      if( x > width/2 ) {
        x -= 11;
        y -= PI;
      } else {
        x += 11;
        y += PI;
      }
    }
    break;

  case 9 :
    {
      x +=9;
      y -= 11;
    }
    break;
  }

  // set adjusted values by calling SET functions
  setX( ceil(x) );
  setY( ceil(y) );
} 

// coord helpers ///////////////////////////////////////////////////
public void setX( int val )
{
  x = val;
}
// coord helpers ///////////////////////////////////////////////////
public void setY( int val )
{
  y = val;
}


//////////////////////////////////////////////////////////////////////
//    System for laying down random drawings
public void drawSystem( float x, float y )
{
  switch( floor(random(14)) )
  {
  case 0:
    {
      point( x, y );
      point( y, x );
      
      ellipse( x, y, x, x );
      ellipse( y, x, y, y );
    }
    break;

  case 1:
    {
      ellipse( x, y, x/PI, x/PI );
      ellipse( y, x, x/TWO_PI, x/TWO_PI );
    }
    break;

  case 2:
    {
      rect( x, y, y/PI, y/TWO_PI, x-y );
      rect( y, x, y*TWO_PI, y*QUARTER_PI, y-x );
    }
    break;

  case 3:
    {
      fix.bullsEye( y, y, gridSize*PI);
      line( y, y, x, x );
      fix.bullsEye( x, x, gridSize);
    }
    break;

  case 4:
    {
      fill( random(255), random(255), random(255), x-y );
      textFont( createFont( "monospace", random(11, 227) ));
      text( frameCount, x, y );
      noFill();
    }
    break;

  case 5:
    {
      line( y, height-x, width, y*noise(frameCount) );
    }
    break;

  case 6:
    {
      ellipse( y, x, x/TWO_PI, x/TWO_PI );
    }
    break;

  case 7:
    {
      rect( y, x, y/TWO_PI, y/TWO_PI, y-x );
    }
    break;

  case 10:
    {
      fix.bullsEye( x, y, gridSize * PI);
      fix.bullsEye( y, x, gridSize/TWO_PI);
      
//      noFill();
      stroke(0xff1975EF,x-y);
      curve( width*noise(frameCount), height, height-x, y, x, width-y, width-x, height-y*noise(frameCount) );

      fix.rectEye( x, y, gridSize);
      fix.rectEye( y, x, gridSize);
            
    }
    break;

  case 11:
    {
//      noFill();
      stroke(0xffEF2012);
      bezier( width, height, height-x, y, x, width-y, width-x, height-y );
      bezier( height, width, y, height-x, y, width-x, width-y, height-x );
    }
    break;
    
    case 12 :{
      fix.bullsEye( x, y, gridSize);
      fix.bullsEye( y, x, gridSize);
    }
    break;
    
    case 13 :{
      fix.rectEye( x, y, gridSize);
      fix.rectEye( y, x, gridSize);
    }
    break;
  }
}






///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
public void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 13 ) );
  smooth();

  fill(255);
  text( dailyMsg, 0, height-HALF_PI);
}

  public void settings() {  size(1024, 768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TargetSystem" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
