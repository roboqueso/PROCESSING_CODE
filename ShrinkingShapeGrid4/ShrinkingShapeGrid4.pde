//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);


//
//  Taking the concept behind shrinking shape grid and invert it, and use fibonacci
//  - start small, maxShapeSize, maxCt = fibonacci

Boolean isFinal = true;
int alf = 9;

float shapeSize = 42;  //10000;
float minShapeSize = alf;
float maxShapeSize = 2013;

int cX;
int cY;


color[] palette = { 
#69EF19, #00EE00, #00EF00, #004200, #001768, #007500,
#B00B13, #EFADED
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
  ellipseMode(CENTER);
  rectMode(CENTER);
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

    //  re-init loop vars
    x = y = 13;
    ct = 0;

    maxCt = fix.nextFib( (int)shapeSize );    

    //  square grid1
    while( ct < maxCt ) {

      fix.ranPalStroke(palette);
      fix.circle( x, y, shapeSize, shapeSize );

//      fix.ranPalStroke(palette);
//      hexagon( x, y, shapeSize );
      
      
      
      if( x >= width ) {
        x = 0;
        y += shapeSize; 
      } else {
        x += shapeSize;
      }
      
      ct+= 42;
    }

  // shrink the shape
  shapeSize += minShapeSize;

  if( shapeSize >= maxShapeSize ) {
    stroke(0);
    fix.drawFrame();
  
    doExit();
  }
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
  fill(#00EE00);
  text( " "+dailyMsg, this.width*.45, this.height-18);
}

