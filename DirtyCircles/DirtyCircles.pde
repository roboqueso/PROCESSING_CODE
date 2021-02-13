//	IMPORTS	////////////////////////////////////////////////////
import processing.opengl.*;
//  SEE:   https://ello.co/ericfickes/post/npnx8v3rmc55buimqfm5ja
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);


Boolean isFinal = true;
int alf = 13;
float angle, radius = 69, x, y, cX, cY, strokeSz = 1;

color[] p3 = {   #0B00B5, 
  #B000B5, 
  #2B00B5, 
  #B00B1E, 
  #B00B33, 
  #080085, 
  #800085, 
  #280085, 
  #80081E, 
  #800833 }; 

float rX, rY;
int i = 0; 


void settings() {
  size(displayWidth, displayHeight);
  smooth(8);
  pixelDensity(displayDensity());
  sketchSmooth(); //  WTF does this do?
}

////////////////////////////////////////////////////
//
void setup() {

	frameRate(420);
  background(11);

  //  setup variables
  cX = width/2;
  cY = height/2;

  ellipseMode(CENTER);
  rectMode(CENTER);

  noFill();



}


////////////////////////////////////////////////////
//
void draw()
{
    x = cX - int( cos(radians(frameCount)) * radius );
    y = cY - int( sin(radians(frameCount)) * radius );
    rX = random( width);
    rY = random( height );


    stroke(0);
    strokeWeight(13);
    point(x,y);
 
    // stroke(random(200,255));
    fix.ranPalStroke100(p3);
    strokeWeight(11);
    point(x,y);
 
    // stroke(random(50), random(255), random(255), 37);
    stroke(random(37),69);
    strokeWeight(.5);
    line(x,y, i, rY);
 
    // stroke(frameCount%2==0?0:255,50);
    // stroke(random(255), random(255), random(50), 75);
    fix.ranPalStroke(p3);
    strokeWeight(1);

    rX = random(PI, radius);
    ellipse(i, rY, rX, rX );
 
    if( frameCount % 360 == 0 ){
        radius += 16;
    }
 
    // move over a pixel
    if (i < width) {
        i++;
    } else {
        i = 0; 
    }
 
    if(radius*PI > height){

      doExit();
    }





}




///////////////////////////////////////////////////////////
//  End handler, saves png
void doExit() 
{
	artDaily( "ERICFICKES.COM" );


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

textFont( createFont( "Silom", 21 ) );
smooth();

  fill(0);
  text( " "+dailyMsg, 0, height-21 );
  fill(#EF2012);
  text( " "+dailyMsg, 0, height-22 );
}