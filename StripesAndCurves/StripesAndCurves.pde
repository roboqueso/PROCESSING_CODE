//  SEE:   https://ello.co/ericfickes/post/dw61udqegchqdchcqpij5w
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);


Boolean isFinal = true;
int alf = 69;

int cX;
int cY;

float x,y, t;

color[] p2 = { #A59DA1,#D96D55,#F36613,#A9ABEA,#D23301,#F6FAFD,#AB6E9C,#D6F9FF,#F8751E,#768A00,#F05510,#FFEE51,#FFB02A,#D7D5FA,
#EF0000, #EFEF11, #36EF75, #EF7535, #FF1234, #EF3619 };

color[] p1 = { #EFEFEF, #C0C0C0, #a1a1a1, #1C31C3, #B3B3B3, #C4C4C4, #C5C5C5, #C6C6C6, #C1C1C1 };


float angle = 0;
float xx, yy, startX, startY;
float w = 20; //40;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(displayWidth, displayHeight);
  frameRate(666);
  background(#dcef69);
  smooth(8);
  pixelDensity(displayDensity());

  //  setup variables
  cX = width/2;
  cY = height/2;

  startX = cX;
  startY = cY;
  
  xx = yy = -( w/2 );
  
    // white scan lines
//  stroke(111, alf ); // 255
alf = 50;
  for ( int ll = 0; ll <= width; ll += 2 ) 
  {  
    strokeWeight( random(1.1) );
    fix.ranPalStroke(p1);
    
    line( 0, ll, random(width), ll );
    line( ll, 0, ll, random(height) );
  }

alf = 5;;
}


////////////////////////////////////////////////////
//
void draw()
{

//    randStroke();
    noFill();
    
    if( frameCount % 4 == 0 ) {
      fix.ranPalStroke( p2 );
      fix.drawLissajous( xx, yy, 15 );
    }
if( yy > height ) {
  doExit();
}

t++;

  if( xx > width ) {
    xx = -( w/2 );
    yy += w;
  } else {
    xx += w; 
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
   save( fix.pdeName()+fix.getTimestamp()+".png" );
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

  fill(#EFEFEF);
  text( " "+dailyMsg, this.width-303, this.height-14);
}
