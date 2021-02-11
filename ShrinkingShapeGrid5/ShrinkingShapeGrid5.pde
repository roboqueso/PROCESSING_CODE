//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);


//
//  Taking the concept behind shrinking shape grid and invert it, and use fibonacci
//  - start small, maxShapeSize, maxCt = fibonacci

Boolean isFinal = true;
int alf = 11;

int shapeSize = 2;  //10000;
float minShapeSize = 2;
float maxShapeSize = 2000;

int cX;
int cY;


color[] palette = { 
#D89054,#4A1A08,#F9DA9B,#955029,#E4B58B,#B59F88,#F5D7C9,#DCD3BC,#DCEED2,#C3C6AA,#877D60,#DDEEEE,#AA7C64,#D9BBBC,#F6DDEE,#C9CDCC,#879285,#DDDDDD,#B9B9BC,#FFFFFF,#FFFFEE,#77665E,#FFFFDD,#FFFFC1,#FFEEC4,#FFEEDD,#EEEEDD,#EEEEC6,#FFEEEF,#EEFFE9,#EEFFFF,#EEEEEE
};

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
  //  keep drawing BIGGER AND BIGGER fibonacci powerred grids

  while( shapeSize <= maxShapeSize ) 
  {
    //  re-init loop vars
    x = y = ct = -5;

    maxCt = fix.getMax( shapeSize );    

    //  square grid1
    while( ct < maxCt ) {

      fix.ranPalStroke(palette);
      ellipse( x, y, shapeSize, shapeSize );

      fix.ranPalStroke(palette);
      fix.hexagon( x, y, shapeSize );

      fix.ranPalStroke(palette);
//      rect( x, y, shapeSize, shapeSize );


      if( x >= width ) {
        x = -5;
        y += shapeSize; 
      } else {
        x += shapeSize;
      }
      
      ct++;
    }
    

    // shrink the shape
    shapeSize += fix.nextFib( shapeSize );
  }

//  stroke( #EFEFEF, alf*2);
//  fix.drawFrame();

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
  fix.ranPalFill(palette);
  text( " "+dailyMsg, this.width*.45, this.height-18);
}

