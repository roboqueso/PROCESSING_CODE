//  
//  http://ericfickes.com
//
import fixlib.*;

//  https://github.com/ericfickes/FIXLIB
Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
int alf = 42; //37;
float sz=0;

int cX;
int cY;

ArrayList p3;
PImage img;

float x, y, co, bri, i, a;

/////////////////////////////////////////////////////////////////////////
void setup() {
  size(1024, 768 );
  background(#370000);
  noFill();

  fix.alpha(alf);
  ellipseMode(CENTER);
  img = loadImage("indies-redblack.jpg");
  p3 = fix.getImgColors(img);

  cX = 1024/2;
  cY = 768/2;

  strokeWeight(TWO_PI);
  stroke(#EF2012);

  fix.paletteGridFull(p3);
  fix.circleGrid(1024, 768);

  strokeWeight(PI);
  stroke(#EF0000);
  fix.circleGrid(1024, 768);
  stroke(0);
} 

/////////////////////////////////////////////////////////////////////////
void draw() {
  smooth();

  strokeWeight(.75);

  beginShape(QUAD_STRIP);

  fix.evenOddStroke(#EFEFEF, 11);
  vertex( frameCount, frameCount );
  vertex( 768-frameCount, frameCount);
  vertex( 1024-frameCount, frameCount);
fix.ranPalStroke(p3);
  vertex( frameCount, frameCount );
  vertex( frameCount, 768-frameCount);
  vertex( frameCount, 1024-frameCount);

  fix.evenOddStroke(#EFEFEF, 11);
  vertex( 768-frameCount, frameCount );
  vertex( 768-frameCount, 768-frameCount);
  vertex( 768-frameCount, 1024-frameCount);

  fix.ranPalStroke(p3);    
  vertex( frameCount, 768-frameCount );
  vertex( 768-frameCount, 768-frameCount);
  vertex( 1024-frameCount, 768-frameCount );

  fix.evenOddStroke(#EFEFEF, 11);
  vertex( 1024-frameCount, frameCount );
  vertex( 1024-frameCount, 768-frameCount);
  vertex( 1024-frameCount, 1024-frameCount);
  
  fix.ranPalStroke(p3);
  vertex( frameCount, 1024-frameCount );
  vertex( 768-frameCount, 1024-frameCount);
  vertex( 1024-frameCount, 1024-frameCount);

  endShape();


  i = frameCount*noise(frameCount, i, sz);
  sz = i/noise(frameCount);
  strokeWeight(PI);

  fix.evenOddStroke(#EF2012, (int)alf);
  x = map(sin(i)*sin(i*0.8), -1, 1, a*noise(frameCount), 1024);
  y = map(sin(a*i+1.5)*sin(a*3+i), -1, 1, a*noise(frameCount), 768);
  co = map(sin(a*0.03), -1, 1, 0, 100);
  sz = map(sin(a*1.7)*sin(a*2.3), -1, 1, 5, 30);
  bri = map(sin(a*1.3)*sin(a*4.1), -1, 1, 10, 60);

  fix.evenOddStroke(255, (int)alf);
  fix.ranPalFill(p3);
  rect(x, y, sz, sz);
  rect(y, x, sz, sz);
  noFill();
  a = a + 0.03;


  fix.evenOddStroke(#EF2012, (int)alf*2);
  rect( 1024-frameCount, 1024-frameCount, i, i ); 
  rect( 1024-frameCount, 1024-frameCount, sz, sz ); 



  //    stop
  if ( frameCount > 768*1.4666 ) {

    fix.circleGrid(768, 1024);

    doExit();
  }
}




///////////////////////////////////////////////////////////
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

  textFont( createFont( "Silom", 37 ) );
  smooth();

  fill(#370000);
  text( " "+dailyMsg, -437, 768-7);

  fill(#EF0000);
  text( " "+dailyMsg, 1024-439, 768-9);
}

