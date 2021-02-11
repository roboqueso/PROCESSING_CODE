//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);


Boolean isFinal = true;
int ctMAIN = 0;
int alf = 15;

int cX;
int cY;
int xx = 0;
int yy = 0;

int outerXX = 0;
int outerYY = 0;

int pad = 69;
int cubeSize = 333;

float angle = 1.5;
float maxAngle;
float radius = 150;
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
  maxAngle = angle + (360 * 24 );

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
      stroke( #EFEF69, alf );
      line( xx, yy, random(outerXX), random(outerYY) );
    }
    else if ( angle < 720 )
    {         
      strokeWeight( 20 );
      stroke( #EE0000, alf );
      line( xx, yy, outerXX+pad, outerYY+pad);
    }
    else
    {
      strokeWeight( .5 );
      stroke( #EFEF19, alf);

      if ( angle % 3 == 0 ) {
        strokeWeight( .9 );
        stroke( #75EF19, alf );
        rect( xx, yy, outerXX, outerYY);
        rect( yy, xx, outerXX, outerYY);

        strokeWeight( 9 );
      } 
      else {
        strokeWeight( .3 );
        rect( xx, yy, outerXX, outerYY);
        rect( yy, xx, outerXX, outerYY);

//        stroke( #1975EF, alf );
        fix.randStroke();
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


/*
///////////////////////////////////////////////////////////
//  draws circle from supplied x, y
void drawCore( int XX, int YY, int maxSize ) {

  float r = 1;  // 75;
  float theta = 0;

  int alf = 20;
  float x;
  float y;

  smooth();
  strokeWeight(.13);

  while ( theta <= maxSize )
  {    
    x = (PI*r) * cos(theta);
    y = (PI*r) * sin(theta);

    if (x%2==0)stroke(255, alf);
    else if (x%3==0) stroke(255, 0, 0, alf);
    else stroke( 109, 109, 109, alf);

    // "dots"
    ellipse( int(XX+x), int(YY+y), x, x );

    fix.heart( int(YY+y), int(XX+x), int(y), int(y) );

    theta+= 0.25;

    if ( frameCount%2==0) {
      r++;
      theta+=.5;
    }
  }
}*/



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
