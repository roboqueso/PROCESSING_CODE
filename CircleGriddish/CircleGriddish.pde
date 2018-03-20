
// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);
//
//  go smaller

Boolean isFinal = true;
int alf = 42;


int shapeSize = 10000;
float minShapeSize = 10;
//float maxShapeSize = 100;

int cX;
int cY;


color[] palette = { 
  #197500,
#D89054,#4A1A08,#F9DA9B,#955029,#E4B58B,#B59F88,#F5D7C9,#DCD3BC,#DCEED2,#C3C6AA,#877D60,#DDEEEE,#AA7C64,#D9BBBC,#F6DDEE,#C9CDCC,#879285,#DDDDDD,#B9B9BC,#77665E,#FFFFDD,#FFFFC1,#FFEEC4,#FFEEDD,#EEEEDD,#EEEEC6 };

int x = 0;
int y = 0;

int ct = 0;
float maxCt = 0;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(alf);
  fix.alpha(alf);
  noFill();
  strokeWeight(.5);
  smooth();

}


////////////////////////////////////////////////////
//

void draw()
{
  //  get small

  while( shapeSize >= minShapeSize ) 
  {
    //  re-init loop vars
    x = y = ct = (int)-alf;

    maxCt = fix.getMax( shapeSize );
    strokeWeight( shapeSize*.01 );

    fix.ranPalStroke(palette);
      
    while( ct < maxCt ) {

      smooth();
    
      fix.circle( x, y, shapeSize, shapeSize );

      fix.hexagon( x, y, shapeSize );

      rect( x, y, shapeSize, shapeSize );

      ellipse( x, y, shapeSize, shapeSize );

      

      if( x >= width ) {
        x = (int)-alf;
        y += shapeSize; 
      } else {
        x += shapeSize;
      }
      
      ct++;
    }
    

    // shrink the shape
    shapeSize = int(shapeSize/2);
  }

stroke( 0, pow(alf,2) );
fix.drawFrame();

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
    save( fix.pdeName() + fix.getTimestamp() + ".png" );
  }
  
  noLoop();
  exit();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 18 ) );
  smooth();

  //  stroke(#EFEFEF);
//  fill(#EE0000);
  //fill(#00EE00);
  fill(#EFEFEF);
  text( " "+dailyMsg, this.width*.45, this.height-18);
}

