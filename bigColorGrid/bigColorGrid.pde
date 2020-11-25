//  SEE:   https://ello.co/ericfickes/post/wiy1i1chupkyzfxkulqsiq
//  GOTO:  https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
int alf = 185;
int shapeSize = 303;

int cX;
int cY;

//  
color[] palette = { 
  //#CCEF20, #2069EF, #EF0000, #00EF00, #0000EF, #EFEFEF, #A59DA1, #D96D55, #F42613, #A9ABEA, #D23301, #F6FAFD, #AB6E9C, #D6F9FF, #F8751E, #768A00, #F05510, #FFEE51, #FFB02A, #D7D5FA,
  //#DEFDAD, #420DAD, #757575, #242424, #ef1975, #ACEDEF, #45EF20
  #EF1975, #19EF75, #1975EF,
  #EF2020, #20EF20, #2020EF,
  #EFB00B, #B0EF0B, #B00BEF,
  #EFCC20, #CCEF20, #20CCEF  
  
};

int x = 0;
int y = 0;

int ct = 0;
int maxCt = 0;


/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(displayWidth, displayHeight, P3D);//, P3D, P2D, FX2D  NOTE: P2D throwing tesselation errors
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
  background(#EFB00B);
  frameRate(303);

  fix.alpha(alf);
  //  setup variables
  cX = width/2;
  cY = height/2;

  maxCt = int( (width*height)/shapeSize );
  
  //noStroke();
  strokeWeight(QUARTER_PI);
}


////////////////////////////////////////////////////
//

void draw()
{

  
  while( ct < maxCt ) {

    smooth();

    fix.randFill();
  
    rect( x, y, shapeSize, shapeSize );
    
    if( x >= width ) {
      x = 0;
      y += shapeSize; 
    } else {
      x += shapeSize;
    }
    
    ct++;
  }

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
    save( fix.pdeName() + "-"+shapeSize+"-"+fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
}



///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 42 ) );
  smooth();

  //  stroke(#EFEFEF);
  fill(#CCEF69);
  text( " "+dailyMsg, this.width*.45, this.height-18);
}
