//  draw circles and stuff, save on exit
//String outputFileName = "SAT-PT2020412";  //don't add extension
Boolean isFinal = true;

float r = 1;  // 75;
float theta = 0;

int cX = 0;
int cY = 0;

int alf = 100.00;

//color[] colors = { #EFEFEF, #1975EF, #19EF75, #EF1975 };

float ranX = 0;
float ranY = 0;

///////////////////////////////////////////////////////////
//  
void setup() {
  size( 1024, 768);
  background(19);
  smooth();

  cX = width/2;
  cY = height/2;
  
  fill(#1975EF, 100);

  //NOTE : the translate call above makes the x,y jacked up
  text( "ERICFICKES.COM", 0, height-11 );

}

///////////////////////////////////////////////////////////
//  
void draw() {

  
    // Polar to Cartesian conversion
    float x = (TWO_PI*r) * cos(theta*r);
    float y = (TWO_PI*r) * sin(theta*r);

    ranX = random(cX - 255);
    ranY = random(cY - 255);

    noFill();

    
    stroke( #EFEFEF, random(100) );
    rotate(r);
    rect( cX-x, cY-y, ranY, ranY );

    stroke( random(255), 0, 0, random(100) );
    ellipse( cX-x, cY-y, ranX, ranX );


  theta += 0.5;  
  r += 0.2;

  //
  if( theta == 1000 )
  {
save(fix.pdeName()+fix.getTimestamp()+".png");
    exit();
  }

}

//  
//  Helper to random(255) stroke
void randStroke()
{
    stroke( random(255), random(255), random(255), 100 );
}

///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{

  //  if final, save output to png
  if( isFinal )
  {
save( fix.pdeName() + fix.getTimestamp()+".png" );
  }

  super.stop();
}
