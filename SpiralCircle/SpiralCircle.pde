// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
int ctMAIN = 0;
int alf = 42;

//  art frame settings
int outerRectX;
int outerRectY;
int outerRectWidth = 212;
int outerRectHeight = 30;

//  circle settings

int registerX;
int registerY;



float randCirc = 0;

int x = 0;
int y = 0;
int xx;
int yy;

int startX = 0;
int startY = 0;

int cX = this.width / 2;
int cY = this.height / 2;

float angle      = 45; 
float radius     = 100;
float frequency  = 1;
int circleSize   = 100;

void setup()
{
  size( 1024,768,P3D );
  background(42);
  fix.alpha(alf);
    noFill();
    smooth();
}    



void draw()
{
     // draw ellipse around a circle
    for (int i = -10; i <= 3600; i++)
    {
  
      xx = startX - int( cos(radians(angle)) * radius );
      yy = startY - int( sin(radians(angle)) * radius );
      /*
      if( i <= 90
      {
        stroke( 255, 0,0 );      
      }
      else if( i <= 180 )
      {
        stroke( #75EF19 );      
      }
      else if( i <= 270 )
      {
        stroke( #EFEFEF );     
      }
      else if( i <= 360 )
      {
        */
//        stroke( #1975EF );      
      //}
      fix.randStroke();
      strokeWeight( 0.1 );
  
      ellipse( xx, yy, circleSize, circleSize );
  
      angle -= frequency;

      if( i % 9 == 0 )
      {
        startX += 3;
        startY += 3;
      }

    } 


  doExit();

}


///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{
  stroke( 255, 0,0,100);

   
  artDaily("ERICFICKES.COM");


  //  if final, save output to png
  if ( isFinal )
  {
save( fix.pdeName() + fix.getTimestamp() + ".png" );
  }

  noLoop();
  exit();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  rotate(0);
  strokeWeight(2);
  
  stroke(255, 100);
  fill( 255,0,0, 10);
  
//randStroke();

rect( this.width-220, this.height-120, outerRectWidth, outerRectHeight );
//heart( this.width-220, this.height-120, outerRectWidth, outerRectHeight);
  
//randStroke();
rect( this.width-217, this.height-117, outerRectWidth-6, outerRectHeight-6 );
//heart( this.width-217, this.height-117, outerRectWidth-6, outerRectHeight-6);

//randStroke();
rect( this.width-214, this.height-114, outerRectWidth-12, outerRectHeight-12 );
//  heart( this.width-214, this.height-114, outerRectWidth-12, outerRectHeight-12);

stroke( 255 );
fill( 255 );

  PFont font = createFont("Helvetica-Bold", 12); // createFont( installedFontName )
  textFont(font);
  text( " "+dailyMsg, this.width-211, this.height-100, 100 );
}

