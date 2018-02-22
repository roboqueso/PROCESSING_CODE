
// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);
//
Boolean isFinal = true;
int alf = 42;
float shapeSize = 400;

int cX,cY;
float xx, yy;

//  
color[] palette = { 
  #EF0000, #00EF00, #0000EF, #EFEFEF, #A59DA1, #D96D55, #F36613, #A9ABEA, #D23301, #F6FAFD, #AB6E9C, #D6F9FF, #F8751E, #768A00, #F05510, #FFEE51, #FFB02A, #D7D5FA
};

int outerXX = 0;
int outerYY = 0;

float angle = 0;
float maxAngle;
float radius = 5;
float outerRadius = 1;

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

  maxCt = 3600;// * 72;


}


////////////////////////////////////////////////////
//

void draw()
{
  smooth();

  stroke( random(25, 255), alf);
  noFill();

  xx = ( offsetX - int( cos(radians(angle)) * radius ) );
  yy = ( offsetY - int( sin(radians(angle)) * radius ) );

  outerXX = ( offsetX - int( cos(radians(angle)) * outerRadius ) );
  outerYY = ( offsetY - int( sin(radians(angle)) * outerRadius ) );

fix.ranPalStroke(palette);
  strokeWeight( alf );
  point( xx, yy );
  point( outerXX, outerYY );


  strokeWeight( random(3, 36) );
  point( yy, xx );  
  point( outerYY, outerXX );

  if ( angle >= maxCt ) {
    doExit();
  }
  
  if ( angle < 720 ) {
line( xx, yy, outerXX, outerYY );
  }
  
  if ( angle % 720 == 0 ) {

        smooth();  
    strokeWeight( 6);
    point( xx, yy );
//    stroke(#00EF00, alf);
    fix.ranPalStroke(palette);
    line( xx, yy, outerXX, outerYY );
    point( outerXX, outerYY );
    
    
    angle  += 2;//6;
    radius += 2;//6;

    offsetY += (int)random(PI, PI+height);
    offsetX = (int)random(PI, PI+width);

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

