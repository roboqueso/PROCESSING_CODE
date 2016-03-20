//  draw circles and stuff, save on exit
//String outputFileName = "SAT020412";  //don't add extension
Boolean isFinal = true;

float r = 5;  // 75;
float theta = 0;

int cX = 0;
int cY = 0;

float alf = 100.00;

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
  float x = (PI*r) * cos(theta);
  float y = (PI*r) * sin(theta);

//  translate( cX, cY );

  noFill();
  smooth();

  if( y % 2 == 0 )
    stroke( 255, 1, 11, 10);
  else if ( y % 3 == 0 )
    stroke( 255, 255, 255, 10 );
  else
    stroke ( 1, 255, 1, 10 );

  ellipse( cX-x, cY-y, theta+r, theta+r );

  theta ++;

  //
  if( theta == 1666 )
  {
save(this+".png");
    exit();
  }

}

//  
//  Helper to random(255) stroke
void randStroke()
{
    stroke( random(255), random(255), random(255) );
}

///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void exit() 
{
  fill(0, 255, 0, 100 );

  //NOTE : the translate call above makes the x,y jacked up
  text( "ERICFICKES.COM", 0, height-11 );


  //  if final, save output to png
  if( isFinal )
  {
    save( split( this.toString(), "[")[0] + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
  }

  super.stop();
}
