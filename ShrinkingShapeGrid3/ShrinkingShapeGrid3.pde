
// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);
//
//  Learning Processing CH6 EX 6-8 -> Grid of shapes where the shapeSize shrinks
//  maxCt based on fibonacci numbers instead of w*h/shapeSize

Boolean isFinal = true;
int alf = 42;

float shapeSize = 10000;
float minShapeSize = alf;

int cX;
int cY;


color[] palette = { 
#69EF19, #00EE00, #00EF00, #004200, #001768, #007500,
#A59DA1, #D96D55, #F42613, #A9ABEA, #D23301, #F6FAFD, #AB6E9C, #D6F9FF, #F8751E, #768A00, #F05510, #FFEE51, #FFB02A, #D7D5FA
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
  //  keep drawing smaller and smaller square grids

    //  re-init loop vars
    x = y = ct = 0;

    maxCt = fix.nextFib( (int)shapeSize );    

    //  square grid1
    while( ct < maxCt ) {

      fix.ranPalStroke(palette);
      rect( x, y, shapeSize, shapeSize );

      fix.ranPalStroke(palette);
      ellipse( x, y, shapeSize, shapeSize );
      
      if( x >= width ) {
        x = 0;
        y += shapeSize; 
      } else {
        x += shapeSize;
      }
      
      ct+=11;
    }
    

    // shrink the shape
    shapeSize -= minShapeSize;
  if( shapeSize <= minShapeSize ) 
  {
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

