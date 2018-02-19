// import geomerative.*;
//import processing.pdf.*;


Boolean isFinal = true;
int ctMAIN = 0;
// int alf = 255;

int cX, cY;
int xx = 0;
int yy = 0;
int pad = 0;
int cubeSize = 100;

float angle = 0;
float radius = 10;


////////////////////////////////////////////////////
//
void setup(){
  size(1024,768 );
  //  ---------------------
  background (255);

  smooth();
  noFill();

  cX = width / 2;
  cY = height / 2;
  
  stroke(0);
  strokeWeight(2);

  xx = -cubeSize;
  yy = xx;  
  
//  beginRecord( PDF, sketchName() + ".pdf" );

  noFill();
  
}


////////////////////////////////////////////////////
//
void draw()
{

  if( xx % 5 == 0 )
    ellipse( xx, yy, cubeSize*2, cubeSize*2 );
  else
    ellipse( xx, yy, cubeSize, cubeSize );  

  //  #1
  cube( xx, yy, cubeSize );

  // if( xx <= (width-cubeSize) )
  if( xx <= width+cubeSize )
  {  
    xx += cubeSize;
  }
  else
  {
    xx = -cubeSize;
    yy += cubeSize;
  }

  //  STOPPER ------------------------------------------
  if( yy >= width )
  {  
    //  if final, save output to png
    if ( isFinal )
    {
      save( fix.pdeName() + fix.getTimestamp()+".png" );
    }

//    endRecord();
  
    noLoop();
  }
}


///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{   
  artDaily("ERICFICKES.COM");


  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + fix.getTimestamp()+".png" );
  }

  noLoop();
}

///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randFill()    {  fill( random(255), random(255), random(255), random(100) );  }
void randStroke()  {  stroke( random(255), random(255), random(255), random(100) );  }

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  PFont font = createFont( "American Typewriter", 30 );
  textFont( font );
  
  fill( #000000, 666 );
  stroke( #696969, 666 );
    
  for( int ii = width-325; ii < width; ii += 5 )
  {

//    randFill();
//    randStroke();
    cube( ii, int( height-( cubeSize*2) ), cubeSize*2 );
  }
  
  fill( #EFEFEF, 666 );  
  text( " "+dailyMsg, width-275, height-72);
}


////////////////////////////////////////////////////////////////
//  
float x1, x2, x3, x4;
float y1, y2, y3, y4;

void cube( int x, int y, int cSize ) {
  
  
  x1 = x + cSize;
  y1 = y - cSize;

  x2 = x+ (cSize*1.5);
  y2 = y- (cSize*1.5);

  x3 = x+ cSize*2;
  y3 = y- cSize;

  x4 = x+ (cSize*1.5);
  y4 = y- (cSize*.5);

  quad( x1, y1, x2, y2, x3, y3, x4, y4 );
}



//////////////////////////
int f0 = 0;
int f1 = 1;
//int f2 = 1;

int nextFib( int f2)
{
   int result = f2;
   f0 = f1;
   f1 = f2;
   f2 = f0 + f1;
   return result;
}
