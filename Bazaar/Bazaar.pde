Boolean isFinal = true;
float alf = 100;

ArrayList p3;
PImage img;

FixLib fix = new FixLib();

float a, x, y, co, bri, i, sz, h;
int cX, cY;

float angle = 0, angle2 = 0;
float x2, y2;

////////////////////////////////////////////////////////////////////////
void setup() {
  size(1024, 768);
  frameRate(303);
  background(alf);
  noFill();

  cX = 1024/2;
  cY = 768/2;

  // img = loadImage("indies-cyansilver.jpg");
  //  p3 = fix.getImgColors(img);

  for ( int h = 0; h < 768; h++ ) {
  smooth();
    strokeWeight(2);
    stroke( random(255),alf );
    line( 0, h, 1024, h );
    
    strokeWeight(noise(frameCount)/noise(h));
    stroke( random(255) );
    bezier( 0, h, 1024, 768, h*noise(h), h*sin(h), 1024, h );
    stroke( random(255) );
    bezier( h, 0, 1024, 768, h*noise(h), h*sin(h), h, 1024 );
  }

  sz = 11;
}

/////////////////////////////////////////////////////////////////////////
void draw() {
  smooth();
  noFill();

  x = 1024 - frameCount - int( cos(radians(angle)) * alf*sin(frameCount) );
  y = 768 - frameCount -int( sin(radians(angle)) * alf*sin(frameCount) );


  strokeWeight(random(TWO_PI, frameCount*noise(frameCount)/PI));
  stroke( random(255), 20, 12);
  point(x, y);
  stroke( random(255), 20, 12);
  point( 1024-frameCount, 768-frameCount );
  stroke( random(255), 20, 12);
  point( 768-frameCount, 1024-frameCount );  
  stroke( random(255), 20, 12);
  point(y,x);
  
  strokeWeight(noise(frameCount)*TWO_PI);
//  stroke( frameCount % 2 == 0 ? 0 : 255, alf*noise(frameCount) );
  stroke( random(255), 20, 12);
  bezier( x, y, frameCount*sin(frameCount), frameCount*noise(frameCount), 1024-frameCount, 768-frameCount, y, x );
//  stroke( frameCount % 2 == 0 ? 0 : 255, alf*noise(frameCount) );
  stroke( random(255), 20, 12);
  bezier( y, x, frameCount*sin(frameCount), frameCount*noise(frameCount), 1024-frameCount, 768-frameCount, x, y );
  
  //  BLACK * WHITE OVERLAYS
  strokeWeight(noise(frameCount)*PI);
  stroke( frameCount % 2 == 0 ? 0 : 255 );
  bezier( x, y, frameCount*sin(frameCount), frameCount*noise(frameCount), 1024-frameCount, 768-frameCount, y, x );
  stroke( frameCount % 2 == 0 ? 0 : 255);
  bezier( y, x, frameCount*sin(frameCount), frameCount*noise(frameCount), 1024-frameCount, 768-frameCount, x, y );
  
//strokeWeight(.75);

stroke(random(255),random(255), frameCount);
line(x,y, 1024-frameCount, 768-frameCount);
line(y, x, 768-frameCount, 1024-frameCount);

strokeWeight(37);
//stroke(random(255),random(255), frameCount, alf);
stroke( frameCount % 2 == 0 ? 0 : 255 );
beginShape(TRIANGLE_FAN);//  QUAD_STRIP  QUADS  TRIANGLE_STRIP  POINTS
  vertex(x, y);
  vertex( 1024-frameCount, 768-frameCount );
  vertex( 768-frameCount, 1024-frameCount );  
  vertex(y,x);
endShape();

  angle++;



  if ( frameCount > 768*1.22 ) {
    
    exit();
  }
}




///////////////////////////////////////////////////////////
//  End handler, saves png
void exit() 
{

  artDaily("ERICFICKES.COM" );

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
  text( " "+dailyMsg, 1024*.666, 35);

  fill(0);
  text( " "+dailyMsg, 1024*.666, 37);
}

