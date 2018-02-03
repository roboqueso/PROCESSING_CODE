
//  
//  http://ericfickes.com
import fixlib.*;

Fixlib fix = Fixlib.init(this);
Boolean isFinal = true;
float alf = 75;

ArrayList p3;
PImage img;
float a, x, y, co, bri, i, sz;
int cX, cY;

float angle = 0,angle2 = 0;
float x2, y2;

////////////////////////////////////////////////////////////////////////
void setup() {
  size(1024, 768);
  frameRate(303);
  background(alf);
  
  cX = width/2;
  cY = height/2;

  img = loadImage("indies-cyansilver.jpg");
  p3 = fix.getImgColors(img);

  fill(18);
  strokeWeight(.25);
  for( int h = 0; h < height; h++ ) {
    stroke( random(37), random(37), random(37), alf);
    line( 0, h, width, h );
  }
  
  sz = 11;
  

}
 
/////////////////////////////////////////////////////////////////////////
void draw() {
  smooth();
  noFill();
  strokeWeight(noise(frameCount));
  
  x = cX - int( cos(radians(angle)) * sz );
  y = cY - int( sin(radians(angle)) * sz );
  
  

fix.ranPalStroke(p3);
fix.trunk(x,y);

if( frameCount > 37 )  {
    stroke(random(75), random(75), random(75),alf);
     fix.trunk(x+37,y+37); 
   
    bezier( x+37,y+37, float(frameCount), sz*noise(angle), sz*noise(angle), float(frameCount), random(x+37), random(y+37) );
}

if( frameCount > 1975 )  {
    stroke(#1975EF, alf*5);
  fix.ranPalStroke(p3);
   fix.trunk(x+1975,y+1975); 
    bezier( x+1975, y+1975, float(frameCount), sz*noise(angle), sz*noise(angle), float(frameCount), random(x+1975), random(y+1975) );
}

if( frameCount > 2012 )  {
    stroke(#EF2012, alf*10);
  fix.ranPalStroke(p3);
   fix.trunk(x-2012,y-2012); 
    bezier( x-random(20.12), y-random(20.12), float(frameCount), sz*noise(angle-random(20.12)), sz-random(20.12)*noise(angle), float(frameCount), random(x-random(20.12)), random(y-random(20.12)) );
}



if( frameCount > cX )  {
    stroke(random(75), random(75), random(75),alf);
  fix.trunk(x-cX,y-cY); 
    bezier( x, y, float(frameCount), sz*noise(angle), sz*noise(angle), float(frameCount), random(x), random(y) );
}

if( frameCount > height )  {
    stroke(random(75), random(75), random(75),alf);
    fix.ranPalStroke100(p3);
   fix.trunk(x+height,y+height); 
    bezier( x, y, float(frameCount), sz*noise(angle), sz*noise(angle), float(frameCount), random(x), random(y) );
}

    strokeWeight(2);
    fix.ranPalStroke100(p3);
    bezier( x, y, float(frameCount), sz*noise(angle), sz*noise(angle), float(frameCount), random(x), random(y) );

    angle += sz*noise(angle);



  if( frameCount > width +height) {
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
  text( " "+dailyMsg, 0, height-7);

  fill(#757575);
  text( " "+dailyMsg, 0, height-9);
}

