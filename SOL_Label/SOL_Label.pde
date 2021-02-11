//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
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

float angle = 1.5;
float maxAngle;
float radius = 65;
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


if( frameCount % 3 == 0 ) {
  
    if( angle < 360 )
    {    
      strokeWeight( random(20) );
      stroke( #19EF75, alf );
      line( xx, yy, random(outerXX), random(outerYY) );
    }
    else if( angle < 720 )
    {    
      strokeWeight( 15 );
      stroke( #19EF19, alf );
      line( xx, yy, outerXX+pad, outerYY+pad);
    }
    else
    {
      stroke( #EFEF11, alf);
      strokeWeight( .5 );
      
      if( angle % 3 == 0 ) {
        strokeWeight( .9 );
        stroke( #75EF19, alf );
        rect( xx, yy, outerXX, outerYY);
        strokeWeight( 9 );
      } else {
        strokeWeight( .3 );
        stroke( #19EF57, alf );
        ellipse( xx, yy, outerXX, outerYY);
        strokeWeight( 30 );
      }
    }
    
    line( xx, yy, outerXX, outerYY);
}


  if( angle < 360 )
    angle += alf;
  else if ( angle < 720 )
    angle++;
  else
    angle += 1.5;

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
    save( fix.pdeName() + fix.getTimestamp() + ".png" );
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
  text( " "+dailyMsg, this.width-150, this.height-cubeSize*2.75);
}
