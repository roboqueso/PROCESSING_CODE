//  SEE: https://ello.co/ericfickes/post/kbuluw5_mauc9bpgqkunfq
//  GOTO: https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);


//
//  Learning Processing CH6 EX 6-8 -> rand grid of squares
//

Boolean isFinal = true;
int alf = 45;

float shapeSize = 1000;
float minShapeSize = 2.5;

int cX;
int cY;

//  
color[] palette = { 
  #EF0000, #00EF00, #0000EF, #EFEFEF, #A59DA1, #D96D55, #F36613, #A9ABEA, #D23301, #F6FAFD, #AB6E9C, #D6F9FF, #F8751E, #768A00, #F05510, #FFEE51, #FFB02A, #D7D5FA
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
  background(9);
  fix.alpha(alf);
  //  setup variables
  cX = width/2;
  cY = height/2;

//  maxCt = int( (width*height)/shapeSize );

    noFill();
    strokeWeight(.5);
    smooth();
}


////////////////////////////////////////////////////
//

void draw()
{
  
  
 filter(INVERT);
  //  keep drawing smaller and smaller square grids

    x = y = ct = 0;
    maxCt = fix.getMax( shapeSize );    

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
      
      ct++;
    }
    

    // shrink the shape
//    shapeSize /= 2;
    shapeSize -= minShapeSize;


  if( shapeSize <= minShapeSize ) {
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
  fill(#EE0000);
  text( " "+dailyMsg, this.width*.45, this.height-18);
}
