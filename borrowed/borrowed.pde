//  
//  http://ericfickes.com
//
/*
CODE FOR THUMB.GIF

VIBRATING SUN

  smooth();
strokeWeight( 2);
 
  x = sin(a)*sin(frameCount);
  y = cos(a)*cos(frameCount);
 
//  sz = map(sin(a)*noise(a)*sin(frameCount), -PI, PI, TWO_PI, a*random((width/frameCount)/PI/a) );
 sz = map( sin(a)*sin(frameCount), -TWO_PI, -PI, alf, PI );
 
    stroke(random(255), random(255), random(50) );
    fill(#efefef,75);
    ellipse(x, y, sz, sz);
    
    
*/
Boolean isFinal = true;
float alf = 37;

ArrayList p3;
PImage img;

FixLib fix = new FixLib();

float a, x, y, co, bri, i, sz;
int cX, cY;
 
void setup() {
  size(1024, 768 );
  background(37);
  cX = width/2;
  cY = height/2;


  fill(18);
  strokeWeight(.25);
  for( int h = 0; h < height; h++ ) {
    stroke( random(37), random(37), random(37), alf);
    line( 0, h, width, h );
  }
  
}
 
void draw() {
  smooth();
  noFill();
strokeWeight( 2);
 
  x = map(sin(a)*sin(a*0.8)*sin(frameCount), -1, 1, PI, width);
  y = map(sin(a*1.1+1.5)*sin(a*3.1), -1, 1, PI, height);
  sz = map(sin(a*1.7)*sin(a*2.3), -1, 1, 5, 30);
  
  // safe it
if ( x > width || x < 0 ) { x = y = random(width); }
if ( y > height || y < 0) { x = y = random(height); }

    stroke(random(75), random(255), random(75) );
    fill(random(37), random(377), random(255), alf);
    rect(x, y, sz, sz);

    stroke(random(255), random(37), random(50));
    fill(random(255), random(37), random(50));
    ellipse(y,x, sz*noise(sz), sz*noise(sz));

x = a + map(sin(a)*sin(a*0.8), -1, 1, 0, width);
y = a + map(sin(a*1.1+1.5)*sin(a*3.1), -1, 1, 0, height);

  // safe it
if ( x > width || x < 0 ) { x = y = frameCount/width; }
if ( y > height || y < 0) { x = y = frameCount/height; }


//    fill(#efefef);
noFill();
    stroke(255);
    fill(37);
    ellipse( y, x, sz/PI, sz/PI );
    ellipse( x, y, sz/PI, sz/PI );
    
    
    
 
/*
    stroke(#efefef,75);
    fill(random(255), random(255), random(50));
    ellipse( y, x, sz, sz );
 
    strokeWeight(.37);
    stroke(random(255), 75 );
    rect( x, y, width, 0 );
    stroke(random(75), 75);
    rect( y, x, 0, width );
*/ 
    a += 0.02;
 

    if( frameCount > height*PI ) {
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

  fill(#003700);
  text( " "+dailyMsg, -437, height-7);

  fill(#0000EF);
  text( " "+dailyMsg, width-460, height-9);
}

