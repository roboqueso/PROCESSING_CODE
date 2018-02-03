//  
//  http://ericfickes.com
import fixlib.*;

Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
float alf = 100;

ArrayList p3;
PImage img;

float a, x, y, co, bri, i, sz;
int cX, cY;

float angle = 0, angle2 = 0;
float x2, y2;

////////////////////////////////////////////////////////////////////////
void setup() {
  size(1024,768);  //  big:  1024x768
  
  background(alf);
  noFill();

  cX = width/2;
  cY = height/2;

  for ( int h = 0; h < height; h++ ) {
  smooth();
    strokeWeight(2);
    stroke( random(255),alf );
    line( 0, h, width, h );
    
    strokeWeight(PI+noise(h));
    stroke( random(255) );
    bezier( 0, h, width, height, h*noise(h), h*sin(h), width, h );
    stroke( random(255) );
    bezier( h, 0, width, height, h*noise(h), h*sin(h), h, width );
  }

  sz = 11;
}

/////////////////////////////////////////////////////////////////////////
void draw() {
  smooth();
  noFill();
  strokeWeight(PI+noise(frameCount));
  stroke( frameCount % 2 == 0 ? 0 : 255, alf*noise(frameCount) );

  x = cX + cos(angle) * radians(sz) * sin(frameCount);
  y = cY + sin(angle) * radians(sz) * sin(frameCount);

  //  stroke(#EF2012, bri);
  stroke( random(255), 20, 12);

  bezier( x, y, frameCount, frameCount*noise(frameCount), width-frameCount, height-frameCount, y, x );
  bezier( y, x, frameCount, frameCount*noise(frameCount), width-frameCount, height-frameCount, x, y );


  angle *= sin(frameCount);



  if ( frameCount > height ) {
    
    exit();
  }
}




///////////////////////////////////////////////////////////
//  End handler, saves png
void exit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

  noLoop();
  System.gc();
  super.stop();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 37 ) );
  smooth();

  fill(255);
  text( " "+dailyMsg, width*.666, height-5);

  fill(0);
  text( " "+dailyMsg, width*.666, height-7);
}

