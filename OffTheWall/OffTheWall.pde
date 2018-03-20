//  Vans sole

//  SKETCH SETTINGS
Boolean isFinal = true;
int alf = 75;

//  GRID SETTINGS

//  grid starting point
PVector tileStart = new PVector( 5, 5 );
float offsetX = 0;
float offsetY = 0;

//  art frame settings
int outerRectX;
int outerRectY;
int outerRectWidth = 212;
int outerRectHeight = 30;

int xx = 0;
int yy = 0;

int ct = 33;

int endXX = 0;
int endYY = 0;

///////////////////////////////////////////////////////////
//  
void setup() {
  size( 1024, 768);
  background(19);
  smooth();
  stroke(255, alf);

//  strokeWeight(5);

}

///////////////////////////////////////////////////////////
//  
void draw() {

  //  LEFT TO RIGHT DIAGONAL
  xx = 0;
  yy = this.height;
  endXX = 0;
  endYY = this.height;

  while( yy >= 0 )
  {
    line( xx, yy, endXX, endYY );
    yy -= ct;
    endXX += ct;
  }
  endYY = this.height;

  while( xx <= this.width )
  {
    line( xx, yy, endXX, endYY );
    
    xx += ct;
    endXX += ct;
  }


  //  RIGHT TO LEFT DIAGONAL
  xx = this.width;
  yy = this.height;
  endXX = this.width;
  endYY = this.height;

  while( yy >= 0 )
  {
    line( xx, yy, endXX, endYY );
    
    yy -= ct;
    endXX -= ct; 
  }
  
  while( xx >= 0 )
  {
    line( xx, yy, endXX, endYY );
    
    xx -= ct;
    endXX -= ct;
  }


  //  VERTICAL LINES
  xx = endXX = 0;
  yy = ct*5;
  endYY = yy*2;
  while(xx <= this.width)
  {
    if( xx % 2 == 0 )
      strokeCap(ROUND);
    else if( second() % 3 == 0 )
      strokeCap(SQUARE);
    else
      strokeCap(PROJECT);

    strokeWeight( random(yy) );
    
    randStroke();
    
    line( xx, yy, endXX, endYY);
    
    xx += ct;
    endXX += ct;
  }



  
  //
  exit();


}


///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{
  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
save( fix.pdeName() + fix.getTimestamp() + ".png" );
  }

  super.stop();
}

///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randFill()    {  fill( random(255), random(255), random(255), random(alf) );  }
void randStroke()  {  stroke( random(255), random(255), random(255), random(alf) );  }

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {
  
  noFill();
  strokeWeight(2);
  stroke(255, alf);

  randStroke();
  rect( this.width-220, this.height-120, outerRectWidth, outerRectHeight );
  
  randStroke();
  rect( this.width-217, this.height-117, outerRectWidth-6, outerRectHeight-6 );

  randStroke();
  fill(1, 100);
  rect( this.width-214, this.height-114, outerRectWidth-12, outerRectHeight-12 );

//  randFill();
  fill(255);
  text( " "+dailyMsg, this.width-211, this.height-100, 100 );
}
