
// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);
//
Boolean isFinal = true;
int alf = 13;
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
float radius = 10;
float outerRadius = 40;

int offsetX = 0;
int offsetY = 0;
float _lerp = 0.01;

int ct = 0;
int maxCt = 0;
boolean flip = false;

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

  maxCt = 360 * 72;

  // white scan lines
  stroke(255, 25 );
  for ( int ll = 0; ll <= width; ll += 2 ) 
  {  
    strokeWeight( random(1.1) );

    line( 0, ll, random(width), ll );
    line( ll, 0, ll, random(height) );
  }
}


////////////////////////////////////////////////////
//

void draw()
{
  smooth();
  strokeWeight( random(5.5) );
  stroke( random(6), alf);
  noFill();

  xx = ( offsetX - int( cos(radians(angle)) * radius ) );
  yy = ( offsetY - int( sin(radians(angle)) * radius ) );

  outerXX = ( offsetX - int( cos(radians(angle)) * outerRadius ) );
  outerYY = ( offsetY - int( sin(radians(angle)) * outerRadius ) );

  strokeWeight(.5);
  line(outerXX, outerYY, offsetX, offsetY);
  point(xx, yy);
  
  strokeWeight( random(5) );

//  stroke( #90DEFA , alf*2);
  
  point( outerXX, outerYY );
  point( random(xx, outerXX), random( yy, outerYY ) );
  point( lerp(xx, outerXX, _lerp ), lerp( yy, outerYY, _lerp ) );

  if( flip ) {
    
//    stroke( #75EF19 , alf*2);
    stroke( random(9), alf );
    ellipse( lerp(xx, outerXX, _lerp ), lerp( yy, outerYY, _lerp ), shapeSize, alf );
    
  } else {
    stroke( #90DEFA , alf*2);
    ellipse( lerp(xx, outerXX, _lerp ), lerp( yy, outerYY, _lerp ), alf, alf );
  }


  point( random(lerp(xx, outerXX, _lerp )), random(lerp( yy, outerYY, _lerp )) );//, shapeSize, shapeSize );

//  line( outerXX, outerYY, random(xx, outerXX), random( yy, outerYY ) );
//  line( random(xx, outerXX), random( yy, outerYY ), shapeSize, shapeSize );


  
  if ( angle >= maxCt ) {
    doExit();
  }

  if( _lerp < 1 ) {
    _lerp += 0.05;
  } else {
    _lerp = 0.01;
  }


//  if ( angle % 1080 == 0 ) {
if( frameCount % frameRate == 0 ) {
    flip = !flip;
    angle  += 6;
    radius += 6;

    offsetY = (int)random(height);
    offsetX = (int)random(width);

    strokeWeight(2);
    stroke(#EF0000, alf*2);

    line( outerXX, outerYY, offsetX, offsetY );
    line( offsetX, offsetY, xx, yy );


    strokeWeight( random(6.9) );
  } 
  else {
    angle += 6;
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

