// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);
Boolean isFinal = true;
int ctMAIN = 0;
int alf = 13;

int cX;
int cY;
int xx = 0;
int yy = 0;

int outerXX = 0;
int outerYY = 0;

int pad = 69;
int cubeSize = 50;

float angle = 0;
float maxAngle;
float radius = 16;
float outerRadius;

int offsetX = 0;
int offsetY = 0;


////////////////////////////////////////////////////
//
void setup() {
  size(1024, 768 );
  
  fix.alpha(alf);
  background (18);

  smooth();
  noFill();

  cX = int( this.width / 2 );
  cY = int( this.height / 2 );

  xx = -cubeSize;
  yy = xx;  

  strokeWeight( .5 );

  offsetX = 400;
  offsetY = 400;
  
  //  max angle = where does the circle stop?
  maxAngle = angle + (360 * 12 );

  outerRadius = PI * pow( radius, 2 );

}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();
  noFill();
  
  xx = ( offsetX - int( cos(radians(angle)) * radius ) );
  yy = ( offsetY - int( sin(radians(angle)) * radius ) );
  
  outerXX = ( offsetX - int( cos(radians(angle)) * outerRadius ) );
  outerYY = ( offsetY - int( sin(radians(angle)) * outerRadius ) );


if( frameCount % 6 == 0 ) {
  
      strokeWeight( random(alf) );
      stroke( #1975EF, alf );
      ellipse( xx, yy, random(outerXX), random(outerYY) );

      strokeWeight( alf+alf );
      stroke( #19EF19, alf );
      line( xx, yy, outerXX+angle, outerYY+angle);

      stroke( #19EF57, alf );
      strokeWeight( 30 );

    line( xx, yy, outerXX, outerYY);
    line( yy, xx, outerYY, outerXX);
}

if( angle % 360 == 0 ) {
      radius *= 2;
      outerRadius += alf;
}



  if( angle < 768 ) {
    angle++;
  } else if ( angle < 1200 )
    angle+=2;
  else
    angle += 3;

  if ( angle >= maxAngle )
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
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  PFont font = createFont( "Silom", 15 );
  textFont( font );
  strokeWeight(1);

  stroke( #75EF19, 666 );
  text( " "+dailyMsg, this.width-175, this.height-15);
}
