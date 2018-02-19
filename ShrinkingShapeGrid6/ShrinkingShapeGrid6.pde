//
//  go smaller

Boolean isFinal = true;
int alf = 9;

int shapeSize = 100;
float minShapeSize = 2;
//float maxShapeSize = 100;

int cX;
int cY;


color[] palette = { 
#D89054,#4A1A08,#F9DA9B,#955029,#E4B58B,#B59F88,#F5D7C9,#DCD3BC,#DCEED2,#C3C6AA,#877D60,#DDEEEE,#AA7C64,#D9BBBC,#F6DDEE,#C9CDCC,#879285,#DDDDDD,#B9B9BC,#FFFFFF,#FFFFEE,#77665E,#FFFFDD,#FFFFC1,#FFEEC4,#FFEEDD,#EEEEDD,#EEEEC6,#FFEEEF,#EEFFE9,#EEFFFF,#EEEEEE
};

int x = 0;
int y = 0;

int ct = 0;
float maxCt = 0;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(alf);

  noFill();
  strokeWeight(.5);
  smooth();

}


////////////////////////////////////////////////////
//

void draw()
{
  //  get small

    //  re-init loop vars
    x = y = ct = 0;  //-5;

    maxCt = getMax( shapeSize );    

    while( ct < maxCt ) {

      randStrokeUser();

      circle( x, y, shapeSize, shapeSize );

//      rect( x, y, shapeSize, shapeSize );


      if( x >= width ) {
        x = -5;
        y += shapeSize; 
      } else {
        x += shapeSize;
      }
      
      ct+=11;
    }
    

    // shrink the shape
    shapeSize = int(shapeSize/2);

  if( shapeSize <= minShapeSize ){
    exit();
  }
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

//////////////////////////
//  Calculate max loop count
float getMax( float shapeSize ) {
  return ( ( width * height ) / shapeSize );
}

void fix.textLines() {


  textFont( createFont( "Helvetica", 300 ) );

  fill(10, pow(alf, 1.5) );//, (alf*4) );
  // MAKE TEXT BIG
  fill(#210000, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.3 );
  fill(#000021, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.3 );
  //  & curve
  fill(#210000, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.49 );
  fill(#000021, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.49 );
  //  & quad
  fill(#210000, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.65 );
  fill(#000021, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.65 );

  //  & triangle
  fill(#210000, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.85 );
  fill(#000021, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.85 );
}



/*
void mousePressed() {
  println("mousePressed()");
}


void keyPressed() {
  println("keyPressed()");
}
*/


///////
//  draw frame
void drawFrame() {

  rectMode(CORNER);

  strokeWeight( 100 );
  rect( 0, 0, width, height);

  strokeWeight( 5 );
  rect( 64, 65, width-128, height-129 );

  strokeWeight( 15 );
  rect( 84, 85, width-168, height-168 );

  //  dashed line
  strokeWeight(6);
  int x = 110;
  int y = 110;

  strokeCap(PROJECT);

  for ( int pp = 0; pp <= (width*height); pp++ ) { 

    if ( x <= (width-110) ) {
      // top row    
      point( x, y );
      //  bottom row
      point( x, 790 );

      x += 10;
    } 
    else if ( y <= 780 ) {

      // left row    
      point( (width-110), y );
      //  right row
      point( 110, y );
      y += 10;
    }
  }

  strokeWeight( 5 );
  rect( 122, 122, width-245, height-245 );
}

//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
//  ellipse(x, y, width, height)

float radius2 = 18, xx, yy;

void circle( float startX, float startY, float w, float h ) {

  float angle = 0;

  while ( angle < 360 ) {
    
    xx = startX - int( cos(radians(angle)) * radius2 );
    yy = startY - int( sin(radians(angle)) * radius2 );


    ellipse( xx, yy, w, h );

    angle++;
  }
}

//////////////////////////////////////////////////////////////////////////
//  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
void hexagon( float startX, float startY, float shapeSize ) {

  line( startX, startY+(shapeSize*.5), startX+(shapeSize*.25), startY );
  line( startX+(shapeSize*.25), startY, startX+(shapeSize*.75), startY );
  line( startX+(shapeSize*.75), startY, startX+(shapeSize), startY+(shapeSize*.5) );

  line( startX+(shapeSize), startY+(shapeSize*.5), startX+(shapeSize*.75), startY+shapeSize );
  line( startX+(shapeSize*.75), startY+shapeSize, startX+(shapeSize*.25), startY+shapeSize );
  line( startX+(shapeSize*.25), startY+shapeSize, startX, startY+(shapeSize*.5) );
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
    save( fix.pdeName() + fix.getTimestamp() + ".png" );
  }
  
  noLoop();
  System.gc();
  super.stop();
}

///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randFill() {  
  fill( random(255), random(255), random(255), alf );
}
void randStroke() {  
  stroke( random(255), random(255), random(255), alf );
}
void randStroke100() {  
  stroke( random(255), random(255), random(255), 100 );
}

////////////////////////////////////////////////////
//  Randomly stroke using image from color list
void randStrokeUser()
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ], alf*.75 );
}
void randFillUser()
{
  fill( palette[ int(random( palette.length-1 )) ], alf*.75 );
}




///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 18 ) );
  smooth();

  //  stroke(#EFEFEF);
//  fill(#EE0000);
  //fill(#00EE00);
  fill(#EFEFEF);
  text( " "+dailyMsg, this.width*.45, this.height-18);
  randFillUser();
  text( " "+dailyMsg, this.width*.45, this.height-18);
}

