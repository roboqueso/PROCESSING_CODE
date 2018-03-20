//
//  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
//
//  Increment angle in larger chunks
//  Get bigger flames with less noise
//  get good flame colors
Boolean isFinal = true;
int alf = 5;

int cX;
int cY;

int shapeSize = 11;
int gridWidth;
int gridHeight;

// circles
int cirXX;
int cirYY;
int startX = 0;
int startY = 0;
float angle      = 6; 
float radius     = 69;  //100;
int circleSize   = 2;
int cc = 0;

int maxCC = 0;
int hexCoreSize = 35;

////////////////////////////////////////////////////
//color[] palette = { #EF0000, #00EF00, #0000EF, #CECE00, #FA7680, #EF1975, #007007, #EFEF00, #FA9187 };
color[] palette = { #EFEF00, #1975EF, #EFEFEF, #75EF19 };

////////////////////////////////////////////////////
//  Randomly stroke using image from color list
void randStrokeUser()
{
  stroke( palette[ int(random( palette.length-1 )) ] , alf );
}
void randFillUser()
{
  fill( palette[ int(random( palette.length-1 )) ] , alf );
}

////////////////////////////////////////////////////
//
void setup() {

  // setup core sketch settings items
  size(1024, 768);//);
  background(1);
  frameRate(303);
  //  setup variables
  cX = width/2;
  cY = height/2;

  startX = cX;
  startY = cY;

  gridHeight = height;
  gridWidth  = width;
  
  maxCC = width*10;

}

float xx = 0;
float yy = cY;


////////////////////////////////////////////////////
//
void draw()
{  
  
  while( cc <= maxCC )
  {

    noFill();
    smooth();
    
    cirXX = startX - int( cos(radians(angle)) * radius );
    cirYY = startY - int( sin(radians(angle)) * radius );
    
    randStrokeUser();
    strokeWeight( random(shapeSize) );  
    hexagon( xx, yy, shapeSize );
    
/*
    strokeWeight( random(shapeSize) );
    stroke(#109109, alf);
    point( random(xx), random(yy) );//, shapeSize );

    stroke(#007007, alf);
    strokeWeight(1);
    point( xx, cirXX);
*/

    stroke(#aa1111,alf);
    strokeWeight(2);
    line(cirYY-radius, cirXX, yy-radius, xx);
    line(cirYY+cX, cirXX, yy+cX, xx);

    randStrokeUser();
    strokeWeight(.75);
    line(cirYY-radius, cirXX, xx, yy);
    line( xx-radius, yy, cirXX-radius, cirYY );

    //  center circle
    strokeWeight(2);
    ellipse( cirXX, cirYY, hexCoreSize, hexCoreSize );

    if( cc % 5 == 0) {
      stroke(#66EF33, alf);
      ellipse( cirXX, cirYY, hexCoreSize, hexCoreSize );  
    } else {
      randStrokeUser();  
    }

      if( xx >= width )
      {
          xx = -shapeSize;
          yy += shapeSize;
          radius++;
        
      } else {
        xx += shapeSize*.5;
      }
  

    angle += 15;//4;
    cc++;
  }
  

  exit();  

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
  artDaily("ERICFICKES.COM" );

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
  fill( random(255), random(255), random(255), alf );
}
void randStroke() {  
  stroke( random(255), random(255), random(255), alf );
}
void randStroke100() {  
  stroke( random(255), random(255), random(255), 100 );
}





///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

PFont font = createFont( "Silom", 15 );
//  PFont font = loadFont( "Silom-20.vlw" );
  
  smooth();
  textFont( font );
  strokeWeight(1);

  fill( #6976EF , 666 );
  text( " "+dailyMsg, this.width-185, this.height-5);
}
