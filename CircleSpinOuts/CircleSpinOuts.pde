// https://github.com/ericfickes/FIXLIB	
import fixlib.*;

Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
int alf = 42;
float shapeSize = 420;

int cX, xx, yy;
int cY;

//  
color[] palette = { 
  #EF0000, #00EF00, #0000EF, #EFEFEF, #A59DA1, #D96D55, #F36613, #A9ABEA, #D23301, #F6FAFD, #AB6E9C, #D6F9FF, #F8751E, #768A00, #F05510, #FFEE51, #FFB02A, #D7D5FA
};

int outerXX = 0;
int outerYY = 0;

float angle = 0;
float maxAngle;
float radius = 10;
float outerRadius = 100;

int offsetX = 0;
int offsetY = 0;


int ct = 0;
int maxCt = 0;

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

  offsetX = cX;
  offsetY = cY;

  maxCt = 4200;	//36000;// * 72;


}


////////////////////////////////////////////////////
//

void draw()
{
  smooth();


  xx = ( offsetX - int( cos(radians(angle)) * radius ) ) ;
  yy = ( offsetY - int( sin(radians(angle)) * radius ) ) %height;

  outerXX = ( offsetX - int( cos(radians(angle)) * outerRadius ) ) ;
  outerYY = ( offsetY - int( sin(radians(angle)) * outerRadius ) ) %height;

  strokeWeight( alf );
  stroke( (frameCount*1.01)%255, alf*4 );
  point( xx, yy );
  point( outerXX, outerYY );

  strokeWeight( alf/4 );
  stroke( frameCount%255, alf*4 );
  point( xx, yy );
  point( outerXX, outerYY );


  strokeWeight( random(3, 36) );
  stroke( random(alf, 255), alf );
  point( yy, xx );  
  point( outerYY, outerXX );

  if ( angle >= maxCt ) {
    doExit();
  }
  
  if ( angle % 6 == 0 ) {
    smooth();  
    strokeWeight( 6);
    point( xx, yy );
//    stroke(#00EF00, alf);
    fix.ranPalStroke100(palette);
    line( xx, yy, outerXX, outerYY );
    point( outerXX, outerYY );
  }
  
  if ( angle % 720 == 0 ) {

    angle  += 3;//6;
    radius += 3;//6;

    offsetY = (int)random(cY, height);
    offsetX = (int)random(cX, width);

    strokeWeight(13);
    stroke(#EF1111, alf*2);

//    line( outerXX, outerYY, offsetX, offsetY );
//    line( offsetX, offsetY, xx, yy );


    strokeWeight( random(36) );
  } 
  else {
    angle++;
    outerRadius++;

    if( radius > width+height )
      radius = 36;
    else
      radius = fix.nextFib( int(radius) );
  }
}


void fix.textLines() {


  textFont( createFont( "Helvetica", 300 ) );

  fill(10, pow(alf, 1.5) );//, (alf*4) );
  // MAKE TEXT BIG
  fill(#210000, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.3 );
  fill(#000021, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.3 );
  //  & curve
  fill(#210000, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.49 );
  fill(#000021, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.49 );
  //  & quad
  fill(#210000, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.65 );
  fill(#000021, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.65 );

  //  & triangle
  fill(#210000, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.85 );
  fill(#000021, pow(alf, 1.5) );//, (alf*4) );
  text("lines.lines.lines.lines.lines", 0, height*.85 );
}


///////
//  draw frame
void drawFrame() {

  rectMode(CORNER);

  strokeWeight( 100 );
  rect( 0, 0, width, height);

  strokeWeight( 5 );
  rect( 64, 65, width-128, height-129 );

  strokeWeight( 15 );
  rect( 84, 85, width-168, height-168 );

  //  dashed line
  strokeWeight(6);
  int x = 110;
  int y = 110;

  strokeCap(PROJECT);

  for ( int pp = 0; pp <= (width*height); pp++ ) { 

    if ( x <= (width-110) ) {
      // top row    
      point( x, y );
      //  bottom row
      point( x, 790 );

      x += 10;
    } 
    else if ( y <= 780 ) {

      // left row    
      point( (width-110), y );
      //  right row
      point( 110, y );
      y += 10;
    }
  }

  strokeWeight( 5 );
  rect( 122, 122, width-245, height-245 );
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

