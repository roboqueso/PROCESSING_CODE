//  SEE:   https://ello.co/ericfickes/post/xnjf2p6ceekbannb5a7wia
//  GOTO:  https://github.com/ericfickes/FIXLIB   
import fixlib.*;

Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
int alf = 45;

ArrayList p3;
PImage img;


float a, x, y, co, bri, i, sz, h;
int cX, cY;

float angle = 0, angle2 = 0;
float x2, y2;


void settings() {
  size(displayWidth, displayHeight, P3D);
  smooth(8);
  pixelDensity(displayDensity());
}

////////////////////////////////////////////////////
//
void setup() {
  frameRate(420);
  background(#69EF37);
  noFill();
  fix.alpha(alf);
  cX = displayWidth/2;
  cY = displayHeight/2;

   img = loadImage("H8.png"); // 1-8
    p3 = fix.getImgColors(img);

  for ( int h = 0; h < displayHeight; h++ ) {
  smooth();
    strokeWeight(2);
    stroke( random(255),alf );
    line( 0, h, displayWidth, h );
    
    strokeWeight(noise(frameCount)/noise(h));
    stroke( random(255) );
    //fix.ranPalStroke( p3 );
    bezier( 0, h, displayWidth, displayHeight, h*noise(h), h*sin(h), displayWidth, h );
    stroke( random(255) );
    //fix.ranPalStroke( p3 );
    bezier( h, 0, displayWidth, displayHeight, h*noise(h), h*sin(h), h, displayWidth );
  }

  sz = 11;
}

/////////////////////////////////////////////////////////////////////////
void draw() {
  smooth();
  noFill();

  x = displayWidth - frameCount - int( cos(radians(angle)) * alf*sin(frameCount) );
  y = displayHeight - frameCount -int( sin(radians(angle)) * alf*sin(frameCount) );


  strokeWeight(random(TWO_PI, frameCount*noise(frameCount)/PI));
  stroke( random(255), 20, 12);
  point(x, y);
  stroke( random(255), 20, 12);
  point( displayWidth-frameCount, displayHeight-frameCount );
  stroke( random(255), 20, 12);
  point( displayHeight-frameCount, displayWidth-frameCount );  
  stroke( random(255), 20, 12);
  point(y,x);
  
  strokeWeight(noise(frameCount)*TWO_PI);
//  stroke( frameCount % 2 == 0 ? 0 : 255, alf*noise(frameCount) );
  stroke( random(255), 20, 12);
  bezier( x, y, frameCount*sin(frameCount), frameCount*noise(frameCount), displayWidth-frameCount, displayHeight-frameCount, y, x );
//  stroke( frameCount % 2 == 0 ? 0 : 255, alf*noise(frameCount) );
  stroke( random(255), 20, 12);
  bezier( y, x, frameCount*sin(frameCount), frameCount*noise(frameCount), displayWidth-frameCount, displayHeight-frameCount, x, y );
  
  //  BLACK * WHITE OVERLAYS
  strokeWeight(noise(frameCount)*PI);
  stroke( frameCount % 2 == 0 ? 0 : 255 );
  bezier( x, y, frameCount*sin(frameCount), frameCount*noise(frameCount), displayWidth-frameCount, displayHeight-frameCount, y, x );
  stroke( frameCount % 2 == 0 ? 0 : 255);
  bezier( y, x, frameCount*sin(frameCount), frameCount*noise(frameCount), displayWidth-frameCount, displayHeight-frameCount, x, y );
  
//strokeWeight(.75);

stroke(random(255),random(255), frameCount);
line(x,y, displayWidth-frameCount, displayHeight-frameCount);
line(y, x, displayHeight-frameCount, displayWidth-frameCount);

strokeWeight(37);
//stroke(random(255),random(255), frameCount, alf);
//stroke( frameCount % 2 == 0 ? 0 : 255 );
fix.ranPalStroke( p3 );
beginShape(TRIANGLE_FAN);//  QUAD_STRIP  QUADS  TRIANGLE_STRIP  POINTS
  vertex(x, y);
  vertex( displayWidth-frameCount, displayHeight-frameCount );
  vertex( displayHeight-frameCount, displayWidth-frameCount );  
  vertex(y,x);
endShape();

  angle++;



  if ( frameCount > displayHeight*1.22 ) {
    
    doExit();
  }
}




///////////////////////////////////////////////////////////
//  End handler, saves png
void doExit() 
{

  artDaily("ERICFICKES.COM" );

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

  textFont( createFont( "Silom", 37 ) );
  smooth();

  fill(255);
  text( " "+dailyMsg, displayWidth*.666, 35);

  fill(0);
  text( " "+dailyMsg, displayWidth*.666, 37);
}
