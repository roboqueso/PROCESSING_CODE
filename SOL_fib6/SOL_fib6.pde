Boolean isFinal = true;
int ctMAIN = 0;
float alf = 13;

int cX;
int cY;
float xx = 0;
float yy = 0;

float outerXX = 0;
float outerYY = 0;

int pad = 69;
float cubeSize = 20;

float angle = 0;
float outerAngle = 0;
float maxAngle;
float radius = 10;
float outerRadius = 1000;

float offsetX = 0;
float offsetY = 0;


//  , #F36613, #A9ABEA, #D23301, #F6FAFD, #AB6E9C, #D6F9FF, #F8751E, #768A00, #F05510, #FFEE51, #FFB02A, #D7D5FA
color[] p1 = { 
#EF0000, #EFEF00, #000036, #EF0000, #00EF00, #0000EF, #EFEFEF, #A59DA1, #D96D55
};

// ,#D6F9FF,#F8751E,#768A00,#F05510,#FFEE51,#FFB02A,#D7D5FA
color[] p2 = { 
#1975EF, #1975EF,#F6FAFD,#AB6E9C
};

////////////////////////////////////////////////////
//
void setup() {
  size(1024, 768 );

  //  ---------------------
  background (18);

  smooth();
  noFill();

  cX = int( this.width / 2 );
  cY = int( this.height / 2 );

  xx = -cubeSize;
  yy = xx;  

  offsetX = cX;
  offsetY = cY;

  //  max angle = where does the circle stop?
  maxAngle = (360 * 10 );

strokeJoin(BEVEL);
strokeCap(SQUARE);
}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();
  noFill();

  xx = ( offsetX - int( cos(radians(angle)) * radius ) );
  yy = ( offsetY - int( sin(radians(angle)) * radius ) );

  outerXX = ( offsetX - int( cos(radians(outerAngle)) * outerRadius ) );
  outerYY = ( offsetY - int( sin(radians(outerAngle)) * outerRadius ) );

  if( frameCount % 5 == 0 ) {
    
    strokeWeight(1);
          ranPalStroke(p1);//      stroke( #19EF19, alf );
      stroke(#ef0000, alf*3 );
      point( xx, yy);//, outerXX, random(yy,outerYY) );
//    ellipse( xx, yy, cubeSize, cubeSize );
    circle( xx, yy, cubeSize, cubeSize, 36 );
  }



//        ranPalStroke(p1);
    ranPalStroke(p2);
    strokeWeight( lerp(cubeSize,alf, random(.9)) );
    
  if( frameCount % 6 == 0 ) {


    line( xx, yy, outerXX, outerYY);
  }
  angle += alf;
  outerAngle += alf;

//    ellipse( xx, yy, radius, radius  );
//    point( outerXX, outerYY);//, radius, radius, 45 );
//    ellipse( yy, xx, radius, radius  );

  
  if ( angle >= maxAngle )
  {
    exit();
  }
  
  
  if( floor(angle) % 360 == 0 ) {
      radius += alf*2;
      outerRadius -= alf;

      cubeSize = nextFib( floor(cubeSize) );
      if( cubeSize > height-alf ) {
        cubeSize = alf;
      }

  }
}



//////////////////////////
int f0 = 0;
int f1 = 1;
//int f2 = 1;

int nextFib( int f2)
{
  //   int result = f2;
  f0 = f1;
  f1 = f2;
  f2 = f0 + f1;

  return f0 + f1;
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



//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
void circle( float startX, float startY, float w, float h ) {

  float angle = 0;
  float xx, yy;
  noFill();

  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    if ( angle % 3 == 0 ) {

      xx = startX - int( cos(radians(angle)) * w );
      yy = startY - int( sin(radians(angle)) * w );


      ellipse( xx, yy, w, h );
    }
    angle++;
  }
}


//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
//  OVERRIDE : @modAngle - restrict drawing to angle % @modAngle
void circle( float startX, float startY, float w, float h, float modAngle ) {

  float angle = 0;
  float xx, yy;

  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    if ( angle % modAngle == 0 ) {

      xx = startX - int( cos(radians(angle)) * w );
      yy = startY - int( sin(radians(angle)) * w );

      smooth();
      ellipse( xx, yy, w, h );
    }
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
void exit() 
{

  artDaily("ERICFICKES.COM"+getTimestamp() );

  //  if final, save output to png
  if ( isFinal )
  {
    save( pdeName() + "-" + getTimestamp()+".png" );
  }

  noLoop();
  System.gc();
  super.stop();
}




String getTimestamp() {
  return ""+month()+day()+year()+hour()+second()+millis();
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

  textFont( createFont( "Silom", 18 ) );
  smooth();

  fill(#EFefef);
  text( " "+dailyMsg, this.width-430, this.height-14);
  /*
float yy = 0;
   while( yy <= height ) {
   
   fill(#EFEFEF, yy*.15);
   text( " "+dailyMsg, 5, yy);
   yy += 18; 
   }
   */
}

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

