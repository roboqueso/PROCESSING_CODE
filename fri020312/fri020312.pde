//  draw circles and stuff, save on exit
Boolean isFinal = true;

float r = 5;//  75; 
float theta = 0;

int cX = 0;
int cY = 0;

int alf = 100.00;

///////////////////////////////////////////////////////////
//  
void setup() {
  size( 1024, 768);
  background(19);
  smooth();

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
  smooth();
  
  stroke( 37, 37, 37, r );
  ellipse( x + cX, y + cY, r, theta ); // Adjust for center of windowstroke(  

  stroke( 75, 75, 75, theta );    
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
    exit();
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
save( fix.pdeName() + fix.getTimestamp()+".png" );
  }

  super.stop();
}
