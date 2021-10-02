//  see: https://ello.co/ericfickes/post/-xbc6guqiambpb4ckvtoig

//  SKETCH SETTINGS
Boolean isFinal = true;
int alf = 100;

//  GRID SETTINGS

//  grid starting point
PVector tileStart = new PVector( 5, 5 );
float offsetX = 0;
float offsetY = 0;

//  loop vars
float padX = 0;
float padY = 0;



//  art frame settings
int outerRectX;
int outerRectY;
int outerRectWidth = 212;
int outerRectHeight = 30;

int xx = 0;
int yy = 0;

int ct = 0;

int endXX = 0;
int endYY = 0;

///////////////////////////////////////////////////////////
//  
void setup() {
  size( displayWidth, displayHeight );
  background(19);
  smooth();
  stroke(255);
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
  ct = 0;
  
  while( yy >= 0 )
  {
    line( xx, yy, endXX, endYY );
    
    ct += 1;
    yy -= ct;
    endXX += ct; 
  }
  ct = 0;
  while( xx <= this.width )
  {
    randStroke();
    line( xx, yy, endXX, endYY );
    
    ct += 1;
    xx += ct;
    endXX += ct;
  }


  //  RIGHT TO LEFT DIAGONAL
  xx = this.width;
  yy = this.height;
  endXX = this.width;
  endYY = this.height;
  ct = 0;
  while( yy >= 0 )
  {
    line( xx, yy, endXX, endYY );
    
    ct++;
    yy -= ct;
    endXX -= ct; 
  }
  
  ct = 0;
  while( xx >= 0 )
  {
    line( xx, yy, endXX, endYY );
    
    ct++;
    xx -= ct;
    endXX -= ct;
  }

  //  VERTICAL LINES
  
  //
  doExit();


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
save( this + ".png" );
  }

  exit();
}

///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randFill()    {  fill( random(255), random(255), random(255), random(alf) );  }
void randStroke()  {  stroke( random(255), random(255), random(255), random(alf) );  }

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {
  
    //  FRAME THE MESSAGE
  noFill();
  stroke(255);
  strokeWeight(2);
  
  randStroke();
  rect( this.width-220, this.height-120, outerRectWidth, outerRectHeight );
  
  randStroke();
  rect( this.width-217, this.height-117, outerRectWidth-6, outerRectHeight-6 );

randStroke();
fill(10);
  rect( this.width-214, this.height-114, outerRectWidth-12, outerRectHeight-12 );

//    randFill();
fill(69);
    text( " "+dailyMsg, this.width-211, this.height-100 );
}
