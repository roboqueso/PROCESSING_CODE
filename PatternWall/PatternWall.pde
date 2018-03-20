//
//  Rotate the circles so the crown looking opening points up

Boolean isFinal = true;
int alf = 13;
float ii = 0;

float cX, cY;

float shapeSize = 50;

float maxCt = 10;


////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(3);

  cX = width/2;
  cY = height/2;

  noFill();
  smooth();

}



void draw()
{

  strokeWeight( 1 );
  stroke(255, (alf*2));

  //  vertical
  line( ii, 0, ii, height );
  //  horizontal
  line( 0, ii, width, ii );

  stroke(#19EF66, alf);
  strokeWeight(.5);
  circle( ii, 0, shapeSize, shapeSize );
  circle( 0, ii, shapeSize, shapeSize );
  
  circle( ii, height, shapeSize, shapeSize );
  circle( width, ii, shapeSize, shapeSize );

  if( ii % ( shapeSize * 40) == 0 ) {
    shapeSize -= alf; 
//    ii = 0;
  }


  if( ii >= width+height ) {
      exit();
  }

  ii += shapeSize;
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




//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
//  ellipse(x, y, width, height)



void circle( float startX, float startY, float w, float h ) {

  float angle = 0;
  float xx, yy;

  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    //if( angle % 3 == 0 ) {

    xx = startX - int( cos(radians(angle)) * w );
    yy = startY - int( sin(radians(angle)) * w );


    ellipse( xx, yy, w, h );
    //}
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
    save( pdeName() + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
  }

  noLoop();
  exit();
}

////////////////////////////////////////////////////
//  Randomly stroke using image from color list
void ranPalStroke(color[] palette)
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ], alf );
}
void ranPalStroke100(color[] palette)
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ], 100 );
}

void ranPalFill(color[] palette)
{
  fill( palette[ int(random( palette.length-1 )) ], alf );
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





/////////////
//  TODO: Is there a better way to get the current sketch name?
String pdeName() {
  return split( this.toString(), "[")[0];
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Anonymous Pro", 18 ) );
  smooth();

  fill(#EFEFEF);
  text( " "+dailyMsg, this.width*.45, this.height-18);
/*
float yy = 0;
while( yy <= height ) {

  fill(#EFEFEF, yy*.15);
 text( " "+dailyMsg, 5, yy);
 yy += 18; 
}
*/

}

