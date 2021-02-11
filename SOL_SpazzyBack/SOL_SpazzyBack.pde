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

int pad = 10;  //69;
int cubeSize = 200;

float angle = 1.5;
float maxAngle;
float radius = 100;
float outerRadius;

int offsetX = 0;
int offsetY = 0;


////////////////////////////////////////////////////
//
void setup() {
  size(1024, 768);
  frameRate(303);
  background(3);
  fix.alpha(alf);


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


  //  drop some scan lines
  for ( int ll = 0; ll <= this.height; ll += pad )
  {
    stroke(#EF7519, alf*3);
    line( 0, ll, this.width, ll );
  }

  fix.drawCore( offsetX, offsetY, int(radius*1.25) );


  //exit();
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


  if ( frameCount % 6 == 0 ) {

    if ( angle < 360 )
    {    
      strokeWeight( random(20) );
      stroke( #EFEF75, alf );
      line( xx, yy, random(outerXX), random(outerYY) );
    }
    else if ( angle < 720 )
    {         
      strokeWeight( 20 );
      stroke( #EFEF00, alf );
      line( xx, yy, outerXX+pad, outerYY+pad);
    }
    else
    {
      strokeWeight( .5 );
      stroke( #EFEF11, alf);

      if ( angle % 3 == 0 ) {
        strokeWeight( .9 );
        stroke( #436EEE, alf );
        rect( xx, yy, outerXX, outerYY);
        rect( yy, xx, outerXX, outerYY);

        strokeWeight( 9 );
      } 
      else {
        strokeWeight( .3 );
        rect( xx, yy, outerXX, outerYY);
        rect( yy, xx, outerXX, outerYY);

        stroke( #1975EF, alf );
        ellipse( xx, yy, outerXX, outerYY);
        strokeWeight( 30 );
      }
    }

    line( xx, yy, outerXX, outerYY);
  }


  if ( angle < 360 )
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
  text( " "+dailyMsg, this.width-165, this.height-30);
}