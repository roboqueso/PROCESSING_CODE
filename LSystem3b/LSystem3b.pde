
Boolean isFinal = true;

int alf = 37;

int cX;
int cY;


int xx = 0;
int yy = 0;

int outerXX = 0;
int outerYY = 0;

float angle = 0;
float maxAngle;
float radius = 10;
float outerRadius = 20;  //50;

int offsetX = 0;
int offsetY = 0;

//  fibonacci numbers
int[] fibNums = { 
  1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987
};
int fibCt = 0;


color[] palette = { 
  #EF0000, #676800, 
  #585458, #716b6e, #837f81, #7f777a, #72696a, #8b8081, #141212, #151515, #a29a99, #7b7472, #9e9491, #9c928e, #a39995, #978881, #9f9894, #8b837e, #6e6a66, #56534d, #413a2a, #37301f, #615f5a, #3c372a, #3e3a2f, #444138, #383322, #312c19, #332e1b, #302d1b, #10100f, #131312, #b9b6bd
    , #DD570D, #D4190D, #9D0D0D, #65A90A, #660D0C, #D8930C, #DFDD0E, #595C0B
};

////////////////////////////////////////////////////
//
void setup() {
  // size to match image
  size(1024, 768);
  frameRate(303);
  background(6);

  //  -------------------------------------------

  smooth();
  noFill();


  cX = int( this.width / 2 );
  cY = int( this.height / 2 );


  offsetX = cX;///2;
  offsetY = cY;///2;

  //  max angle = where does the circle stop?
  maxAngle = (360*20);


  //  scan lines
  stroke( #EF7519, pow(alf, 2.5));

  strokeWeight(.5);
  for ( int ll = 0; ll <= height; ll += 2 ) 
  {  
    line( 0, ll, width, ll );
  }
  strokeWeight(22);
}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();
  noFill();

  //  CIRCLE ACTION
  xx = ( offsetX - int( sin(radians(angle)) * radius ) );
  yy = ( offsetY - int( cos(radians(angle)) * radius ) );

  outerXX = ( offsetX - int( sin(radians(angle)) * outerRadius ) );
  outerYY = ( offsetY - int( cos(radians(angle)) * outerRadius ) );

  //  randStrokeUser();
  stroke(#EFEFEF, 25);
  line( xx, yy, outerXX, outerYY );//fibNums[ fibCt ], fibNums[ fibCt ]);
  //  randStrokeUser();
  stroke(18, 50);
  line( lerp(xx, outerXX, random(.9) ), lerp(yy, outerYY, random(.9) ), xx, yy );


  strokeWeight( fibNums[ (int)random( fibNums.length-1) ] );
  noFill();
  randStrokeUser();
  point( lerp(xx, outerXX, random(.9) ), lerp(yy, outerYY, random(.9) ) );
  randStrokeUser();
  point( lerp(xx, outerXX, .1 ), lerp(yy, outerYY, .1 ) );

  strokeWeight(random(20));

  hexagon(  lerp(xx, outerXX, random(.95) ), lerp(yy, outerYY, random(.95) ), radius );

  angle += 3;

  if ( angle % 90 == 0 ) {
    radius += 3;
    outerRadius += 9;
  }

  if ( angle >= maxAngle )
  {    

    exit();
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

  super.stop();
}

///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randFill() {  
  fill( random(255), random(255), random(255), alf*2 );
}
void randStroke() {  
  stroke( random(255), random(255), random(255), alf*2 );
}
void randStroke100() {  
  stroke( random(255), random(255), random(255), 100 );
}

////////////////////////////////////////////////////
//  Randomly stroke using image from color list
void randStrokeUser()
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ], alf*2 );
}
void randFillUser()
{
  fill( palette[ int(random( palette.length-1 )) ], alf*2 );
}




///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  PFont font = createFont( "Silom", 18 );

  smooth();
  textFont( font );
  strokeWeight(1);

  //  fill( #000000 , 666 );
  fill(#EFEFEF, pow(alf, 3) );
  text( " "+dailyMsg, this.width-225, this.height-15);

  //  fill( #003600 , 666 );
  fill(#CADDAC, pow(alf, 3) );
  text( " "+dailyMsg, this.width-226, this.height-16);
}


