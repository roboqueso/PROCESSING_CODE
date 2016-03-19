//  draw circles and stuff, save on exit

Boolean isFinal = true;

float r = 5;//  75; 
float theta = 0;

int cX = 0;
int cY = 0;

float alf = 100.00;

///////////////////////////////////////////////////////////
//  
void setup() {
  size( 1024, 768);
  background(36);
  smooth();
  stroke( 255, 255, 255 );
  
  cX = width/2;
  cY = height/2;
}

///////////////////////////////////////////////////////////
//  
void draw() {
  
  // Polar to Cartesian conversion
  float x = r * cos(theta);
  float y = r * sin(theta);
  
  
  //  color adjuster
  if( r <= 300 )
  {
    stroke( 255, random(255), random(255), alf );
  }
  else if( r <= 600 )
  {
    stroke( random(255), 255, random(255), alf );
  }
  else
  {
    stroke( random(255), random(255), 255, alf );
  }
    
  noFill();
  
  //  circle
  ellipse( x + cX, y + cY, r, r ); // Adjust for center of windowstroke(  


  theta += 1;
  r += 1;

  if( r % 6 == 0 )
  {
    alf -= 0.5;
  }

  //
  if( r >= 1000 )
  {
    exit();
  }
  
}



///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void exit() 
{
  fill(#EFEFEF);
  text( "ERICFICKES.COM", 0, height-11 );

  //  if final, save output to png
  if( isFinal )
  {
    save( "RainbowCircleMess-" + month()+day()+year()+hour()+minute()+millis()+".png" );
  }

  super.stop();
}
