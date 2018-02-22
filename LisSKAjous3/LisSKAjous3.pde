
// https://github.com/ericfickes/FIXLIB	
import fixlib.*;

Fixlib fix = Fixlib.init(this);
Boolean isFinal = true;

//  
//  Black and White
//  Tatoo / Asian style sun
//  Use HOTmess3 as background
//  
//  B&W sunbeams slowly alpha out?
//  
int alf = 37;

//  circle vars
float angle1 = 0, xx1, yy1, startX1, startY1, radius1 = alf;
float angle2 = 0, xx2, yy2, startX2, startY2, radius2 = alf*5;
float angle3 = 0, xx3, yy3, startX3, startY3, radius3 = alf*7;
float angle4 = 0, xx4, yy4, startX4, startY4, radius4 = alf*9;

int cX;
int cY;

color[] palette = { #EF0000, #00EF00, #0000EF, #CECE00, #FA7680, #EF1975, #007007, #EFEF00, #FA9187, #007007, #109109 };
PImage b;
ArrayList p3;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);  //);
  fix.alpha(alf);
  background(alf);

  stroke(0);
  strokeWeight(.37);

//  yy1 = cY;
//  yy2 = cY;
xx1 = yy1 = -alf*2.5;
xx2 = yy2 = -alf*2.5;

}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();


fix.evenOddStroke(#a1a1a1);
fix.drawLissajous( xx1, yy1, alf );


//evenOddStroke(#EF2012);
//circle( xx1, yy2, frameCount, frameCount );


  if( yy1 < height ) { 
    yy1 += alf*2.5;
  } else {
    yy1 = -alf*2.5; 
    xx1 += alf*2.5;
  }
  
  if( xx2 < width ) { 
    xx2 += alf*2.5;
  } else {
    xx2 = -alf*2.5; 
    yy2 += alf*2.5;
  }

  //
  //  STOP
  //  
  if ( xx1 > width )
  {    
    doExit();
  }
  
  
}

///////////////////////////////////////////////////////////
//  
//  End handler, saves png
void doExit() 
{

  artDaily("ERICFICKES.COM" );

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

  textFont( createFont( "Silom", 18 ) );
  smooth();

  fill(#EF2012);
  text( " "+dailyMsg, 0, height );

}

