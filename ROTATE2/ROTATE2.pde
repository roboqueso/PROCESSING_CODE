import processing.opengl.*;
import fixlib.*;

//  https://github.com/ericfickes/FIXLIB
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
String artDailyMsg = "ERICFICKES.COM";
//  
int alf = 42; //37;

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
  size(1024, 768, OPENGL);  //  P3D or OPENGL since we're using z
  background(#C1C1C1);


  //  setup variables
  cX = width/2;
  cY = height/2;

  startX1 = startY1 = alf*PI;


  
  //  SCAN LINES
  strokeWeight(.75);

  for( int w = 0; w < height; w++ ) {
    stroke( random(255), 37 );
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
//  rotateX(frameCount);
//  rotateY(frameCount);
//rotateZ(frameCount);
    

    xx1 = startX1+frameCount+cos( radians( frameCount ) ) * alf + noise(frameCount);
    yy1 = startY1+frameCount+sin( radians( frameCount ) ) * alf + noise(frameCount);


    stroke(random(255), random(37), random(37),alf);
//    point( xx1, yy1, frameCount );
//    point( yy1, xx1, frameCount );
    fix.circle( xx1*noise(xx1), yy1*noise(yy1), alf*noise(frameCount), alf*noise(frameCount) );
    fix.circle( yy1*noise(yy1), xx1*noise(xx1), alf*noise(frameCount), alf*noise(frameCount) );

    stroke(random(37), random(255), random(37));    
    point( xx1, yy1, frameCount/TWO_PI );
    point( yy1, xx1, frameCount/TWO_PI );

    // rain
    stroke(random(37), random(37), random(255));
    line( xx1, yy1, yy1, xx1 );
    

    stroke(random(169) );
//    ellipse( xx1, yy1, alf, alf );
//    ellipse( yy1, xx1, alf, alf );
fix.hexagon( xx1, yy1, alf*noise(frameCount) );
fix.hexagon( yy1, xx1, alf*noise(frameCount) );




    // RESET BOTH IF Y GOES OUTSIDE
    if( yy1 > height || yy1 < 0 || xx1 > height || xx1 < 0 || xx1 > cX || yy1 > cY) {
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
  if ( frameCount > height )
  {    
save(this+".png");
    doExit();
  }

}




///////////////////////////////////////////////////////////
//  
//  End handler, saves png
void doExit() 
{

  artDaily( artDailyMsg );//+ " : " + getTimestamp() );//+ "' " + getTimestamp() );

  //  if final, save output to png
  if ( isFinal )
  {
save( fix.pdeName() + fix.getTimestamp()+".png" );
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
  text( dailyMsg, cX, cY-4 );
  fill(0, alf);
  text( dailyMsg, cX, cY-2 );
  fill(255, alf);
  text( dailyMsg, cX, cY );
  /*
float y = 0;
   while( y <= height ) {
   
   fill(#EFEFEF, y*.15);
   text( " "+dailyMsg, 5, y);
   y += 18; 
   }
   */
}

