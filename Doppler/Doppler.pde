// https://github.com/ericfickes/FIXLIB	
import fixlib.*;

Fixlib fix = Fixlib.init(this);
Boolean isFinal = true;
int alf = 37;
float strokeSize = 20;
int cX;
int cY;

boolean flip = false;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(16);

  //  setup variables
  cX = width/2;
  cY = height/2;


}


////////////////////////////////////////////////////
//
void draw()
{

  int cc = 0;
  
//  stroke( #123456, alf );

  strokeWeight(strokeSize);
  noFill();
  
  float tmpX;
  
  while( cc <= width*1.2 ) {

    smooth();
    tmpX = cc-(cc*.006);

    if( flip ) {
      flip = false;
      stroke( #75EF19, alf );
    } else {
      flip = true;
      stroke( #ACE069, alf );
    }

    ellipse( cX, cY, cc, cc );

    stroke( #ACE069, alf );
    line( tmpX, 0, tmpX, height );
    
//    stroke( #EF1975, alf );
    line( 0, cc, width, cc );
  //  line( 0, cc*1.5, width, cc*1.5 );
    
    cc += 50; 
  }
  
  
  

  exit();
}



///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void exit() 
{   
  artDaily("ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( this + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
  }

  super.stop();
}

///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randFill() {  
  fill( random(255), random(255), random(255), alf );
}
void randStroke() {  
  stroke( random(255), random(255), random(255), alf );
}
void randStroke100() {  
  stroke( random(255), random(255), random(255), 100 );
}


///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  PFont font = createFont( "Silom", 15 );
  //PFont font = loadFont( "Silom-20.vlw" );
  
  smooth();
  textFont( font );
  strokeWeight(1);

  stroke( #75EF19, 666 );
  text( " "+dailyMsg, this.width-240, this.height-20);
}
