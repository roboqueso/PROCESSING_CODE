//
//  This is a PRocessing sketch
//
Boolean isFinal = true;
float alf = 11;
int shapeSize = 75;
int strokeSize = 10;

int cX;
int cY;

int cc = 0;
int maxCC = 275;

//  #D89054,#4A1A08,#F9DA9B,#955029,#E4B58B,#B59F88,#F5D7C9,#DCD3BC,#DCEED2,#C3C6AA,#877D60,#DDEEEE,#AA7C64,#D9BBBC,#F6DDEE,#C9CDCC,#879285,#DDDDDD,#B9B9BC,#FFFFFF,#FFFFEE,#77665E,#FFFFDD,#FFFFC1,#FFEEC4,#FFEEDD,#EEEEDD,#EEEEC6,#FFEEEF,#EEFFE9,#EEFFFF,#EEEEEE 
color[] palette = { 
#A59DA1,#D96D55,#F36613,#A9ABEA,#D23301,#F6FAFD,#AB6E9C,#D6F9FF,#F8751E,#768A00,#F05510,#FFEE51,#FFB02A,#D7D5FA
  };

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(16);

  //  setup variables
  cX = width/2;
  cY = height/2;

    smooth();
    noFill();
    strokeWeight( strokeSize );
}


float xx = 0;
float yy = 0;
////////////////////////////////////////////////////
//
void draw()
{
  if( cc >= maxCC ) {
/*
    // vertical
    for( int ll = 0; ll <= width; ll += (shapeSize*2) ) {
      smooth();
      randStrokeUser();
      strokeWeight( shapeSize );
      line( ll, 0, ll, height );
    }
*/
    // horizontal
    for( int ll = 0; ll <= height; ll += (shapeSize*2) ) {
      smooth();
      randStrokeUser();
      strokeWeight( shapeSize );
      
      line( 0, ll, width, ll );
    }
    
    
    exit();
  } else {

    randStrokeUser();
    ellipse( xx, yy, shapeSize, shapeSize );
    
//    randStrokeUser();
//    rect( xx, yy, shapeSize, shapeSize );
    
    randStrokeUser();
    hexagon( xx, yy, shapeSize );
    
    if( xx >= (width-shapeSize) ) {
      xx = 0;
      yy += shapeSize;
    } else { 
      xx += shapeSize;
    }

  }
cc++;
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
  
  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( this + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
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

////////////////////////////////////////////////////
//  Randomly stroke using image from color list
void randStrokeUser()
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ] , alf );
}
void randFillUser()
{
  fill( palette[ int(random( palette.length-1 )) ] , alf );
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
  fill(#EFEFEF, pow(alf,3) );
  text( " "+dailyMsg, this.width-225, this.height-15);
  
//  fill( #003600 , 666 );
  fill(#CADDAC, pow(alf,3) );
  text( " "+dailyMsg, this.width-226, this.height-16);
}

