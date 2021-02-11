//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);

/*
Specifies vertex coordinates for curves. This function may only be used between beginShape() and 
 endShape() and only when there is no MODE parameter specified to beginShape(). 
 The first and last points in a series of curveVertex() lines will be used to guide the beginning 
 and end of a the curve. A minimum of four points is required to draw a tiny curve between the 
 second and third points. Adding a fifth point with curveVertex() will draw the curve between the 
 second, third, and fourth points. The curveVertex() function is an implementation of Catmull-Rom 
 splines. 
 Using the 3D version of requires rendering with P3D or OPENGL (see the Environment reference for 
 more information)
 */
Boolean isFinal = true;

//  
int alf = 69;

//  circle vars
float angle1 = 180, xx1, yy1, startX1, startY1, radius1 = 37;
/*
float angle2 = 0, xx2, yy2, startX2, startY2, radius2 = alf*5;
 float angle3 = 0, xx3, yy3, startX3, startY3, radius3 = alf*7;
 float angle4 = 0, xx4, yy4, startX4, startY4, radius4 = alf*9;
 */
int cX;
int cY;

color[] p1 = { 
  #EF0000, #00EF00, #0000EF, #CECE00, #FA7680, #EF1975, #007007, #EFEF00, #FA9187, #007007, #109109
};
PImage b;
ArrayList p3;

//  VECTOR ACTION - http://processing.org/reference/PVector.html
//PVector v1, v2;


////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  background(#000018);
  fix.alpha(alf);
  b = loadImage("white-flower.jpg");//  "white-flower.jpg" "HOTmess3.png"
  p3 = fix.getImgColors(b);

  //  setup variables
  cX = width/2;
  cY = height/2;

  startX1 = cX;
  startY1 = cY;

  stroke(0);
  strokeWeight(10);
  xx1 = yy1 = -alf;
  noFill();
}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();



    xx1 = startX1 - int( cos(radians(angle1)) * radius1 );
    yy1 = startY1 - int( sin(radians(angle1)) * radius1 );
  


    strokeWeight(12);
    fix.ranPalStroke(p3);
    ellipse( xx1, yy1, radius1, radius1 );

    strokeWeight(4);
    stroke(255, 360);
    point( xx1, yy1 );
  
  angle1 += 3;

  //  gradual spiral out
  radius1 += frameCount/PI/alf;

  //
  //  STOP
  //  
  if ( frameCount > (width+height) )
  {    
    doExit();
  }

}



///////////////////////////////////////////////////////////
//  
//  End handler, saves png
void doExit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 37 ) );  //  "AnonymousPro"
  smooth();

  fill(alf, alf);
  text( dailyMsg, 0, height-4 );
  fill(0, alf);
  text( dailyMsg, 0, height-2 );
  fill(255, alf);
  text( dailyMsg, 0, height );

}

