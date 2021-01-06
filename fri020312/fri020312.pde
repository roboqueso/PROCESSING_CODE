//  SEE:   https://ello.co/ericfickes/post/ppnsxhf77krh5hci76wfsa
//  GOTO:  https://github.com/ericfickes/FIXLIB

import fixlib.*;
Fixlib fix = Fixlib.init(this);

//  draw circles and stuff, save on exit
Boolean isFinal = true;

float r = 5;//  75; 
float theta = 0;

int cX = 0;
int cY = 0;

int alf = 100;


void settings(){
  size(displayWidth, displayHeight, P3D);
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}

///////////////////////////////////////////////////////////
//  
void setup() {

  background(19);

  cX = width/2;
  cY = height/2;
}

///////////////////////////////////////////////////////////
//  
void draw() {
  
  // Polar to Cartesian conversion
  float x = r * cos(theta);
  float y = r * sin(theta);

  noFill();
  
  stroke( x+45, y+45, r+45, r );
  ellipse( x + cX, y + cY, r, theta ); // Adjust for center of windowstroke(  

  stroke( x-75, y-75, r-75, theta );    
  ellipse( x + cX, y + cY, theta, r ); // Adjust for center of windowstroke(  

  theta += 1;
  r += 1;

  if( r % 6 == 0 )
  {
    alf -= 0.5;
  }

  //
  if( r >= 768 )
  {
    doExit();
  }

}



///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{
  stroke(255, 0, 0);
  int x = 0;
  int alf = 50;

  //  square out
  while( x < this.width ) {

    if( x % 2 == 0 )
      stroke( 55, 55, 255, alf ); 
    else if ( x % 3 == 0 )
      stroke( 255, 55, 55, alf );

    if( x > 1260 ) {
      alf -= 5;
    }

    rect( x, 829, 13, 13 );

    x += 5;
  }
  
  fill( 255, 255, 255 );
  text( "ERICFICKES.COM", 0, height-11);

  //  if final, save output to png
  if( isFinal )
  {
    String saveName = fix.pdeName() + "-" + fix.getTimestamp();
    save( saveName +".png" );
  }

  super.stop();
  exit();
}
