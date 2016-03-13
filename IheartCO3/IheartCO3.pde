/*
I HEART CO
 - 8 bit heart
 - #EFEFEF & silver sun filling up the board
 */
Boolean isFinal = true;
float alf = 20;
float cX, cY;

//  circle vars
float angle1, x1, y1, startX1, startY1, radius1;
float angle2, x2, y2, startX2, startY2, radius2;
float angle3, x3, y3, startX3, startY3, radius3;
float angle4, x4, y4, startX4, startY4, radius4;
float angle5, x5, y5, startX5, startY5, radius5;

float ct, maxCt;

color[] p1 = { 
  #EFEFEF, #C0C0C0, #EFEFEF, #C0C0C0, #FFFFFF
};

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(185);
  noFill();

  cX = width * .5;
  cY = height * .5;

  maxCt = (height+width)*TWO_PI;

  angle1 = 0;
  angle2 = 0;
  angle3 = 0;

  startX1 = startX2 = startX3 = startX4 = cX+410;
  startY1 = startY2 = startY3 = startY4 = cY+30;

  //  setup circles
  radius1 = 5;
  radius2 = 999;
  radius3 = 1200;
  radius4 = 1300;
  radius5 = 1400;


   // scan lines
   stroke(#1975ef, pow(alf,3) ); // 255
   for ( int ll = 0; ll <= width; ll += 2 ) 
   {  
     strokeWeight( random(1.1) );
   
     line( 0, ll, random(width), ll );
     line( ll, 0, ll, random(height) );
   }

  // debug
//  iHeartCO();
//  exit();


}


////////////////////////////////////////////////////
//
void draw()
{

  smooth();

  x1 = startX1 - int( cos(radians(angle1)) * radius1 );
  y1 = startY1 - int( sin(radians(angle1)) * radius1 );

  x2 = startX2 - int( cos(radians(angle2)) * radius2 );
  y2 = startY2 - int( sin(radians(angle2)) * radius2 );

  x3 = startX3 - int( cos(radians(angle3)) * radius3 );
  y3 = startY3 - int( sin(radians(angle3)) * radius3 );

  x4 = startX4 - int( cos(radians(angle4)) * radius4 );
  y4 = startY4 - int( sin(radians(angle4)) * radius4 );

  x5 = startX1 - int( cos(radians(angle5)) * radius5 );
  y5 = startY1 - int( sin(radians(angle5)) * radius5 );

  strokeWeight( random(69) );

  ranPalStroke(p1);
  line( x1, y1, x5, y5 );

  ranPalStroke(p1);
  line( x1, y1, x4, y4 );
  
  ranPalStroke(p1);
  line( x1, y1, x3, y3 );
  
  ranPalStroke(p1);
  line( x1, y1, x2, y2 );



  angle1 += alf;
  angle5 += alf;
  angle2 += alf*2;
  angle3 += 2;
  angle4++;

  ct += alf;

  if ( ct > maxCt ) {

    iHeartCO();

    exit();
  }
}

///////////////////////////////////
//  draw i HEART CO
//  and board frame
void iHeartCO() {

  float angle = 0;
  float x, y;
  float w = 210;
  float startX = 220; 
  float startY = 485;

  textFont( createFont( "Silom", 450 ) );
  smooth();
  fill(0);
  stroke(0);
  strokeWeight( 5 );

//  draw rectangle circle ( BOARD FRAME )

  while ( angle < 360 ) {

    x = startX - int( cos(radians(angle)) * w );
    y = startY - int( sin(radians(angle)) * w );

    smooth();

    
    if( angle == 90 ) {
      line( x, y, x+1000, y );
    }
    
    if( angle >= 90 && angle < 270 ) {
      
      x+=1000;
      
    } else if( angle == 270 ) {
      line( x+1000, y, x, y ); 

    }
    point( x, y );//, w, h );

    angle++;
    
  }

//  / BOARD FRAME

  text("I", 160, cY+180);
  bitHeart( 360, cY-125, false );
  text("CO", 700, cY+180);
}

/////////////////////////////////////////////////////////////////
//  spit out an 8bit heart
void bitHeart( float x, float y, boolean grid ) {

  int blockSize = 25;
  float htSize = 250;
  strokeWeight(.5);

  //  GRID
  if (grid) {
    stroke(#333333, 50);

    for ( int xx = 0 ; xx <= 13; xx++ ) {

      line( xx+(blockSize*xx), 0, xx+(blockSize*xx), height );
      line( 0, y+(blockSize*xx), width, y+(blockSize*xx) );
    }
  }
  //  GRID



  //  HEART
  stroke(#333333);

  //  white blocks
  fill(255);
  rect( x+(blockSize*2), y+blockSize, blockSize, blockSize );
  rect( x+(blockSize), y+(blockSize*2), blockSize, blockSize );

  fill(0);
  // TODO: make this smarter
  rect( x+(blockSize*2), y, blockSize, blockSize );
  rect( x+(blockSize*3), y, blockSize, blockSize );
  rect( x+(blockSize*4), y, blockSize, blockSize );

  rect( x+(blockSize*8), y, blockSize, blockSize );
  rect( x+(blockSize*9), y, blockSize, blockSize );
  rect( x+(blockSize*10), y, blockSize, blockSize );

  rect( x+(blockSize), y+blockSize, blockSize, blockSize );

  fill(#EF0000);
  rect( x+(blockSize*3), y+blockSize, blockSize, blockSize );
  rect( x+(blockSize*4), y+blockSize, blockSize, blockSize );
  rect( x+(blockSize*2), y+(blockSize*2), blockSize, blockSize );
  rect( x+(blockSize*3), y+(blockSize*2), blockSize, blockSize );
  rect( x+(blockSize*4), y+(blockSize*2), blockSize, blockSize );
  rect( x+(blockSize*5), y+(blockSize*2), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*2), blockSize, blockSize );
  rect( x+(blockSize*8), y+(blockSize*2), blockSize, blockSize );
  rect( x+(blockSize*9), y+(blockSize*2), blockSize, blockSize );
  rect( x+(blockSize*10), y+(blockSize*2), blockSize, blockSize );
  rect( x+(blockSize*11), y+(blockSize*2), blockSize, blockSize );

  rect( x+(blockSize), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*2), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*3), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*4), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*5), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*8), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*9), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*10), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*11), y+(blockSize*3), blockSize, blockSize );

  rect( x+(blockSize), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*2), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*3), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*4), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*5), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*8), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*9), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*10), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*11), y+(blockSize*4), blockSize, blockSize );

  rect( x+(blockSize*2), y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*3), y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*4), y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*5), y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*8), y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*9), y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*10), y+(blockSize*5), blockSize, blockSize );

  rect( x+(blockSize*2), y+(blockSize*6), blockSize, blockSize );
  rect( x+(blockSize*3), y+(blockSize*6), blockSize, blockSize );
  rect( x+(blockSize*4), y+(blockSize*6), blockSize, blockSize );
  rect( x+(blockSize*5), y+(blockSize*6), blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*6), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*6), blockSize, blockSize );
  rect( x+(blockSize*8), y+(blockSize*6), blockSize, blockSize );
  rect( x+(blockSize*9), y+(blockSize*6), blockSize, blockSize );
  rect( x+(blockSize*10), y+(blockSize*6), blockSize, blockSize );

  rect( x+(blockSize*3), y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*4), y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*5), y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*8), y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*9), y+(blockSize*7), blockSize, blockSize );

  rect( x+(blockSize*4), y+(blockSize*8), blockSize, blockSize );
  rect( x+(blockSize*5), y+(blockSize*8), blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*8), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*8), blockSize, blockSize );
  rect( x+(blockSize*8), y+(blockSize*8), blockSize, blockSize );

  rect( x+(blockSize*5), y+(blockSize*9), blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*9), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*9), blockSize, blockSize );

  rect( x+(blockSize*6), y+(blockSize*10), blockSize, blockSize );

  fill(0);




  rect( x+(blockSize*5), y+blockSize, blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*2), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize), blockSize, blockSize );


  fill(#EF0000);  
  rect( x+(blockSize*4), y+blockSize, blockSize, blockSize );
  rect( x+(blockSize*8), y+blockSize, blockSize, blockSize );
  rect( x+(blockSize*9), y+blockSize, blockSize, blockSize );
  rect( x+(blockSize*10), y+blockSize, blockSize, blockSize );
  rect( x+blockSize, y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*2), y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*3), y+(blockSize*8), blockSize, blockSize );
  rect( x+(blockSize*4), y+(blockSize*9), blockSize, blockSize );
  rect( x+(blockSize*5), y+(blockSize*10), blockSize, blockSize );  
  rect( x+(blockSize*6), y+(blockSize*11), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*10), blockSize, blockSize );
  rect( x+(blockSize*8), y+(blockSize*9), blockSize, blockSize );
  rect( x+(blockSize*9), y+(blockSize*8), blockSize, blockSize );
  rect( x+(blockSize*10), y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*11), y+(blockSize*5), blockSize, blockSize );

  fill(0);
  rect( x+(blockSize*11), y+blockSize, blockSize, blockSize );
  rect( x, y+(blockSize*2), blockSize, blockSize );
  rect( x, y+(blockSize*3), blockSize, blockSize );
  rect( x, y+(blockSize*4), blockSize, blockSize );
  rect( x, y+(blockSize*5), blockSize, blockSize );
  rect( x+blockSize, y+(blockSize*6), blockSize, blockSize );
  rect( x+blockSize, y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*2), y+(blockSize*8), blockSize, blockSize );
  rect( x+(blockSize*3), y+(blockSize*9), blockSize, blockSize );
  rect( x+(blockSize*4), y+(blockSize*10), blockSize, blockSize );
  rect( x+(blockSize*5), y+(blockSize*11), blockSize, blockSize );
  rect( x+(blockSize*6), y+(blockSize*12), blockSize, blockSize );
  rect( x+(blockSize*7), y+(blockSize*11), blockSize, blockSize );
  rect( x+(blockSize*8), y+(blockSize*10), blockSize, blockSize );
  rect( x+(blockSize*9), y+(blockSize*9), blockSize, blockSize );
  rect( x+(blockSize*10), y+(blockSize*8), blockSize, blockSize );
  rect( x+(blockSize*11), y+(blockSize*7), blockSize, blockSize );
  rect( x+(blockSize*11), y+(blockSize*6), blockSize, blockSize );

  rect( x+(blockSize*12), y+(blockSize*5), blockSize, blockSize );
  rect( x+(blockSize*12), y+(blockSize*4), blockSize, blockSize );
  rect( x+(blockSize*12), y+(blockSize*3), blockSize, blockSize );
  rect( x+(blockSize*12), y+(blockSize*2), blockSize, blockSize );
}




///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void exit() 
{

  artDaily("ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( pdeName() + "-" + getTimestamp()+".png" );
  }

  noLoop();
  System.gc();
  super.stop();
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
  float x, y;

  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    if ( angle % 10 == 0 ) {

      x = startX - int( cos(radians(angle)) * w );
      y = startY - int( sin(radians(angle)) * w );

      smooth();
      ellipse( x, y, w, h );
    }
    angle++;
  }
}

///////////////////////////////////////////////////////////////////////////
//  draw a circle of circles
void circle( float startX, float startY, float w, float h, float modAngle ) {

  float angle = 0;
  float x, y;

  while ( angle < 360 ) {

    // make circle draw faster by skipping angles
    if ( angle % modAngle == 0 ) {

      x = startX - int( cos(radians(angle)) * w );
      y = startY - int( sin(radians(angle)) * w );

      smooth();
      ellipse( x, y, w, h );
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

  fill(#676800);
  text( " "+dailyMsg, this.width-430, this.height-14);
  /*
float y = 0;
   while( y <= height ) {
   
   fill(#EFEFEF, y*.15);
   text( " "+dailyMsg, 5, y);
   y += 18; 
   }
   */
}

