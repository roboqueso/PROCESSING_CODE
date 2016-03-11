//  
//  http://ericfickes.com
//
Boolean isFinal = true;
float alf = 75;
float sz=0;

int cX;
int cY;

ArrayList p3;
PImage img;

FixLib fix = new FixLib();

float xoff, n;

////////////////////////////////////////////////////
//
float i = 0; 
/////////////////////////////////////////////////////////////////////////
void setup() {
  background(37);
  size(1024, 768);//);  // P2D

  img = loadImage("indies.jpg");
  p3 = fix.getImgColors(img);

  ellipseMode(CENTER);


  cX = width/2;
  cY = height/2;
} 

/////////////////////////////////////////////////////////////////////////
void draw() {
  smooth();


  if ( i % ( width/2 ) == 0 ) {
    i = random( TWO_PI );
  } 
  else {
    i++;
  }


  i = frameCount*noise(frameCount, i, sz);
  sz = i/PI;
  strokeWeight(2);

  noiseDetail(frameCount/100);

  xoff = xoff + .01;
  n = noise(xoff, i, frameCount) * width;
//  fill(#FF0000);
  fix.ranPalFill(p3);
  stroke(#EFEFEF);
  ellipse( n, frameCount, sz, sz );
  //  safeit
  n = ( n > height*.75 ) ? alf : n;


  //////////////////////////////////
  //  CORNERS
  //////////////////////////////////
  stroke(255);
  fill(0);

  ellipse( frameCount, frameCount, sz, sz ); 
  ellipse( width-frameCount, frameCount, sz, sz ); 
  ellipse( frameCount, height-frameCount, sz, sz ); 
  ellipse( width-frameCount, height-frameCount, sz, sz ); 


  stroke(0);
  fill(255);
  //////////////////////////////////
  //  half way
  //////////////////////////////////
  ellipse(frameCount, (height/2), sz, sz ); 
  ellipse(width-frameCount, (height/2), sz, sz ); 


  //////////////////////////////////
  //  middle
  //////////////////////////////////
  ellipse( cX, frameCount, sz, sz ); 
  ellipse( cX, height-frameCount, sz, sz ); 



  //    stop
  if ( frameCount > height ) {
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

  textFont( createFont( "Silom", 18 ) );
  smooth();

  fill(#2012EF);
  text( " "+dailyMsg, 0, height);
}

