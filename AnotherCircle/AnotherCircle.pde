//  see: https://ello.co/ericfickes/post/7vk8ayth5wao2k_xglbnuq
// goto: https://github.com/ericfickes/FIXLIB
import fixlib.*; 

Fixlib fix = Fixlib.init(this);


Boolean isFinal = true;
int ctMAIN = 0;
int alf = 256;

//  art frame settings
int outerRectX;
int outerRectY;
int outerRectWidth = 256;  //227;
int outerRectHeight = 45;  //37;

int cX = int( 1024 / PI );
int cY = int( 768 / PI );

float px, py, px2, py2;
float angle = 41;
float angle2;
float radius = 69;
float frequency = 13;
float frequency2 = 9;
float x, x2;

int xx;
int yy;
int goodVar = 15;

void settings(){
  size(displayWidth, displayHeight);
  smooth(8);
}

////////////////////////////////////////////////////
//
void setup(){
  //size(1024, 768 );
  background (36);
  fix.alpha(alf);
}


////////////////////////////////////////////////////
//
void draw(){
  
  smooth();

  fill(255);
//  strokeWeight( random(1.1) );


  // rotates rectangle around circle
  px = width/8 + cos(radians(angle))*(radius/2);
  py = 75 + sin(radians(angle))*(radius/2);
  rectMode(CENTER);

  fill(0);
  //draw rectangle
//  rect (px, py, 5, 5);
  heart( int(px), int(py), int(angle), int(angle) );
  
  if( frameCount % goodVar == 0 ) {    //  <-------- good var to tweak
  
    // draw ellipse around a circle
    for (int i = 0; i <= 360; i++)
    {
  
      xx = cX + int( cos(radians(angle)) * radius );
      yy = cY + int( sin(radians(angle)) * radius );

      if( i % 4 == 0 )
      {
        stroke( #EFEFEF, 10 );  // 5
      }
      else
      {
        strokeWeight( .1 );
        stroke( #EF1975, 5 );  // .1
      }

      smooth();
      ellipse( xx+px, yy+py, radius, radius );
      ellipse( yy+py, xx+px, radius, radius );

      //angle += frequency;
      angle = fix.nextFib( (int)angle );
      
    } 
  }

  // send small ellipse along sine curve
  // to illustrate relationship of circle to wave

  angle -= frequency;
  radius += 0.75;
  x = fix.nextFib( (int)x );

  // when little ellipse reaches end of window
  // reinitialize some variables
  if (x >= width-radius) {
    x = 0;
    angle = 0;
    radius++;
  }



  if( px >= 1080 )
  {
    doExit();
  }
}


///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{   
  artDaily("ericfickes.com");


  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp() + ".png" );
  }

  noLoop();
  exit();
}




///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {
  //fill( #EFEFEF, 100 );
  fill( #45EF20 );
  
  PFont font = createFont( "Silom", 11 );
  textFont( font );
  
  text( " "+dailyMsg, 11, height-11);
}


///////////////////////////////////////////////////////////
//  
//  draw heart
void heart( int x, int y, int w, int h ) 
{
  ellipseMode(RADIUS);
  smooth();
  
  if( x % 2 == 0 )
    stroke(#75EF19, 75 );
  else if( x % 3 == 0 )
    stroke(#1975EF, 69 );
  else
    stroke(#EF1975, 69 );
  
  strokeWeight(random(1));
//  scale( random(2) );
  
  noFill();
  
  //  bubbles
  //  ellipse(x, y, width, height)
  ellipse( x-w, y, w, w );
  ellipse( x+w, y, w, w );
  //  ellipseMode(MODE)
  //  MODE	Either CENTER, RADIUS, CORNER, or CORNERS
  
  //  FILL SHAPE
  
  //  lines	
  //  line(x1, y1, x2, y2)
  //stroke(#19EF75);
  line( x-(w*2), y, x, y + w*PI);
  line( x+(w*2), y, x, y + w*PI);
  
}
