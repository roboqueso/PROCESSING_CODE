//  Vans sole

//  SKETCH SETTINGS
Boolean isFinal = true;
int alf = 100;

//  GRID SETTINGS

//  grid starting point
PVector tileStart = new PVector( 5, 5 );
//  diamond settings
float offsetX = 55;
float offsetY = 60;
int diamondStroke = 5;



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
  constrain(0,0,0);
  size( 1024, 768);
  background(19);
  smooth();
  stroke(255, alf);

  strokeWeight(diamondStroke);

}

///////////////////////////////////////////////////////////
//  
void draw() {
/*
  //  LEFT TO RIGHT DIAGONAL
  xx = 0;
  yy = this.height;
  endXX = 0;
  endYY = this.height;

  while( yy >= 0 )
  {
    line( xx, yy, endXX, endYY );
    yy -= offsetY;
    endXX += offsetX;
  }
  endYY = this.height;

  while( xx <= this.width )
  {
    line( xx, yy, endXX, endYY );
    
    xx += offsetX;
    endXX += offsetY;
  }


  //  RIGHT TO LEFT DIAGONAL
  xx = this.width;
  yy = this.height;
  endXX = this.width;
  endYY = this.height;

  while( yy >= 0 )
  {
    line( xx, yy, endXX, endYY );
    
    yy -= offsetY;
    endXX -= offsetX; 
  }
  
  while( xx >= 0 )
  {
    line( xx, yy, endXX, endYY );
    
    xx -= offsetX;
    endXX -= offsetX;
  }

/*
  //  VERTICAL LINES
  xx = endXX = 0;
  yy = int(offsetY);
  endYY = yy*2;

  while(xx <= this.width)
  {
    strokeWeight( diamondStroke );
    
    line( xx, yy, endXX, endYY);
    
    xx += offsetX;
    endXX += offsetX;
  }
*/

textSize(30);
text( "REWRITE THIS TO DRAW DIAMONDS IN A GRID, NOT SEPARATE LOOPS", 30,30);
  
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

//  randStroke();
  rect( this.width-220, this.height-120, outerRectWidth, outerRectHeight );
  
//  randStroke();
  rect( this.width-217, this.height-117, outerRectWidth-6, outerRectHeight-6 );

//  randStroke();
  fill(0,0,0, alf);
  rect( this.width-214, this.height-114, outerRectWidth-12, outerRectHeight-12 );

//  randFill();
  fill(255, 0, 0, alf );
  text( " "+dailyMsg, this.width-211, this.height-100, 100 );
}
