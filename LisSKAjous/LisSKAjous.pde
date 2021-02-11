//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
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
int alf = 150;

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
  frameRate(303);//);

//  b = loadImage("HOTmess3.png");
//  p3 = getImgColors(b);
//  background(b);
background(255);
	fix.alpha(alf);
  //  setup variables
  cX = width/2;
  cY = height/2;

//  startX1 = startX2 = startX3 = startX4 = cX;
//  startY1 = startY2 = startY3 = startY4 = cY;
  
  stroke(0);
  strokeWeight(.37);
  xx1 = -alf/PI;
}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();



//  sun beams
fix.drawLissajous( xx1, yy1, alf/PI );
fix.evenOddFill(0);//  #EF2012


if( xx1 < width ) {
 
 xx1 += alf; 
 
} else if( xx1 > width && yy1 > height ) {
  alf -= TWO_PI;
  xx1 = -alf/TWO_PI;
  yy1 = alf/TWO_PI;
} else {

 xx1 = -alf/PI;
 yy1 += alf;
  
}



  //
  //  STOP
  //  frameCount > height*alf || 
  if ( frameCount > width)
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

  textFont( createFont( "Silom", 37 ) );
  smooth();

  fill(#EF2012);
  text( " "+dailyMsg, 0, height);
}

