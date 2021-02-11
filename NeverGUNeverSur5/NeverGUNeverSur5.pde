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
String artDailyMsg = "ERICFICKES.COM";  //"rotateX";  //"rotateY";  //"rotateZ";
//  
int alf = 69;

//  circle vars
float i, angle1 = 180, xx1, yy1, startX1, startY1, radius1 = 37;
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
//PImage b;
//ArrayList p3;

//  VECTOR ACTION - http://processing.org/reference/PVector.html
//PVector v1, v2;


////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768, P3D);
  background(#C1C1C1);


  //  setup variables
  cX = width/2;
  cY = height/2;

//  startX1 = width;
//  startY1 = height;
	fix.alpha(alf);

  
  //  SCAN LINES
  strokeWeight(.75);
//  stroke(#EFEFEF);
  for( int w = 0; w < height; w++ ) {
    stroke( random(255),alf );
    line(0, w, width, w );
  }
  
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

    strokeWeight(12);

//  ROTATE!!!
  rotateX(frameCount);
  rotateY(frameCount);
  rotateZ(frameCount);
    
    xx1 = cX-frameCount-cos( radians( frameCount ) ) * alf;
    yy1 = cY-frameCount-sin( radians( frameCount ) ) * alf;
   

    stroke(random(37) );//, 100);
    point( xx1, yy1, frameCount );
    point( yy1, xx1, frameCount );

    stroke(random(111) );
    point( xx1, yy1, frameCount+i*PI );
    point( yy1, xx1, frameCount+i*PI );

    stroke(random(255), random(37), random(37));//, 100);
    line( xx1, yy1, yy1, xx1 );
    
    stroke(random(37), random(255), random(37), 100);    
    ellipse( xx1, yy1, alf, alf );
    ellipse( yy1, xx1, alf, alf );

    // RESET BOTH IF Y GOES OUTSIDE
    if( yy1 > height || yy1 < 0) {
      xx1 = yy1 = random(alf)*noise(frameCount); 
    }


    // move over a pixel
    if ( i <= height || i < 0) {
        i += noise(frameCount) * cos( TWO_PI * sin(radians(frameCount)) );
    } else {
        i = cos(frameCount/TWO_PI) * sin( noise(frameCount) );
    }


  //
  //  STOP
  //  
  if ( frameCount > width )
  {    
    doExit();
  }

}



///////////////////////////////////////////////////////////
//  
//  End handler, saves png
void doExit() 
{

  artDaily( "'"+artDailyMsg + "' " + fix.getTimestamp() );

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

