// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

// circles
Boolean isFinal = true;
int ctMAIN = 0;
int alf = 11;

int cX;
int cY;
int xx = 0;
int yy = 0;

int outerXX = 0;
int outerYY = 0;

int pad = 1;
int cubeSize = 50;

float angle = 1;
float maxAngle;
float radius = 50;
float outerRadius;

int offsetX = 0;
int offsetY = 0;

////////////////////////////////////////////////////
//
void setup() {
  // size to match image
  size(1024, 768);
  frameRate(303);
  background(21);

  //  -------------------------------------------
  fix.alpha(alf);

  smooth();
//  noFill();

  cX = int( this.width / 2 );
  cY = int( this.height / 2 );

  xx = -cubeSize;
  yy = xx;  



  offsetX = 400;
  offsetY = 400;

  //  max angle = where does the circle stop?
  maxAngle = 360 * 6;

  outerRadius = pow(radius,2);  //pow( radius, 2 );
  noFill();
    strokeWeight(2);
//  drawCore( offsetX, offsetY, int(maxAngle) );
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

///////// FIGURE OUT ZIGZAGLINE
if( frameCount % 15 == 0 ) {

  //stroke( #EFEF00, alf );
  stroke( #EFEFEF, alf );

  ellipse( xx, yy, angle, angle );

//  stroke( #EF0000, alf );
  stroke( #1919EF, alf );
  zigzagLine(xx,yy,outerXX,outerYY, angle);
  ellipse( yy, xx, angle, angle ); 
}

////////////////////////////////

  angle+=0.5;


  if( angle % 60 == 0 )
  {
    radius++;
    outerRadius++;
    alf++;
  }

  if ( angle >= maxAngle )
  {    
    doExit();
  }

}



///////////////////////////////////////////////////////////
//  draws circle from supplied x, y
// void drawCore( int XX, int YY, int maxSize ) {

//   float r = 1;  // 75;
//   float theta = 0;

//   int alf = 10;
//   float x;
//   float y;

//   smooth();
//   strokeWeight(.13);

//   while ( theta <= maxSize )
//   {    
//     x = (PI*r) * cos(theta);
//     y = (PI*r) * sin(theta);

//     if (x%2==0)stroke(255, alf);
//     else if (x%3==0) stroke(255, 0, 0, alf);
//     else stroke( 109, 109, 109, alf);

//     ellipse( int(XX+x), int(YY+y), x, x );

//     heart( int(YY+y), int(XX+x), int(y), int(y) );

//     theta+= 0.25;

//     if ( frameCount%2==0) {
//       r++;
//       theta+=.5;
//     }
//   }
// }



///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{   
  artDaily("ERICFICKES.COM" );


  //  if final, save output to png
  if ( isFinal )
  {
    // save( this + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
    save( fix.pdeName()+fix.getTimestamp() );
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



///////////////////////////////////////////////////////////
//  
//  draw heart
void heart( int x, int y, int w, int h ) 
{
  ellipseMode(RADIUS);
  smooth();

  //  stroke(#EF7519, alf);  // 37
  stroke(#EF1111, alf);  // 37

  strokeWeight(2);
  //  noFill();

  //  bubbles
  ellipse( x-w, y, w, w);
  ellipse( x+w, y, w, w);
  //  ellipseMode(MODE)
  //  MODE	Either CENTER, RADIUS, CORNER, or CORNERS


  //  lines	
  line( x-(w*2), y, x, y + w*PI);
  line( x+(w*2), y, x, y + w*PI);
}
