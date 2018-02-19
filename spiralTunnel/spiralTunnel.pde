// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

// circles
Boolean isFinal = true;
int ctMAIN = 0;
int alf = 13;

int cX;
int cY;
int xx = 0;
int yy = 0;

int outerXX = 0;
int outerYY = 0;

int cubeSize = 25;

float angle = 360;
float maxAngle;
float maxCir;
float radius = 25;
float outerRadius;

int offsetX = 0;
int offsetY = 0;

////////////////////////////////////////////////////
//
void setup() {
  // size to match image
  size(1024, 768);
  frameRate(303);
  background(-1);

  //  -------------------------------------------


  smooth();

  cX = int( this.width / 2 );
  cY = int( this.height / 2 );

  xx = -cubeSize;
  yy = xx;  

  offsetX = cX;
  offsetY = cY;

  //  max angle = where does the circle stop?
  maxAngle = 360 * 30;  //125;
  maxCir = 360 * 4;

  outerRadius = pow(radius, PI);  //pow( radius, 2 );

  noFill();
  
  strokeWeight(1.5);
    
//  drawCore( offsetX, offsetY, int(maxAngle) );


  stroke( #EF0000, alf );
}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();
  xx = ( offsetX - int( cos(radians(angle)) * radius ) );
  yy = ( offsetY - int( sin(radians(angle)) * radius ) );

  outerXX = ( offsetX - int( cos(radians(angle)) * outerRadius ) );
  outerYY = ( offsetY - int( sin(radians(angle)) * outerRadius ) );



  if( angle > maxCir ) 
  {


    if( frameCount % 2 == 0 ) {
      stroke( #EFEF32, alf );
      line( xx, yy, outerXX, outerYY );
    } else {
      stroke( #EF1975, alf );
      line( yy, xx, outerYY, outerXX );
    }
  
    angle++;
  
  } 
  else 
  {
    
    if( frameCount % 4 == 0 ) {    
      stroke( #75EF19, alf );
      ellipse( xx, yy, radius, radius );  
    } else {
      stroke( #191919, alf );
      ellipse( xx, yy, radius, radius );  
    }

    angle++;
      
  }
//  }

  if( angle % 359 == 0 )
  {
    
    fix.heart( cX, cY, (int)radius, (int)radius );
    
    cubeSize  += radius/2 + alf;
    radius    += radius/2;
    angle     += 3;
    outerRadius    += 3;
    
    xx++;
    outerXX++;

    stroke( #EF0000, alf );//    stroke( #75EF19, alf*2 );
  }

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
  artDaily("ERICFICKES.COM" );


  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + fix.getTimestamp() + ".png" );
  }

  noLoop();
  exit();
}


///////////////////////////////////////////////////////////////
//  stroke a random color out of loaded image
void zigzagLine( float x1, float y1, float x2, float y2, float zag ) {

// DEBUG
//zag = 3;

  //  split line in the middle, and zag over a bit then completing the line
  float midX = ( x1+zag );
  float midY = ( y1+zag );

  float zagX = (midX+zag);
  float zagY = (midY+zag);

  float endX = x2 + zag;
  float endY = y2 + zag;
  
//  strokeWeight( 20 );
  
  stroke( #FF0000, zag );
  line( x1, y1, midX, midY );
  fix.randFill();
text( x1 +","+ y1 +","+ midX +","+ midY, x1, y1 );
  
  //  ZAG!
  stroke( #00FF00, zag );
  line( midX, midY, zagX, zagY );
text( midX +","+ midY +","+ zagX +","+ zagY, midX, midY );
  
  stroke( #0000FF, zag );  
  line( zagX, zagY, endX, endY );
text( zagX +","+ zagY +","+ endX +","+ endY, zagX, zagY);
}





///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  PFont font = createFont( "Silom", 15 );
  textFont( font );
  strokeWeight(1);

  stroke( #75EF19, 666 );
  text( " "+dailyMsg, this.width-185, this.height-18);
}