//color chart : http://www.december.com/html/spec/color1.html
    
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


//  SEE:    https://ello.co/ericfickes/post/tdkcnxdvxhlvv1spkot6xg
//  GOTO:  https://github.com/ericfickes/FIXLIB 
import fixlib.*;
Fixlib fix = Fixlib.init(this);
/* ------------------------------------------------------------------------- */
void  settings ()  {
    
    size(displayWidth, displayHeight, P2D);
    

    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}
/* ------------------------------------------------------------------------- */
void setup() {
  background (#031221);
  frameRate(420);


  background(37);
  //  ---------------------


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

  drawCore( offsetX, offsetY, int(radius*1.25) );


  //doExit();
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
      stroke( #FFFFFF, alf );
      line( xx, yy, random(outerXX), random(outerYY) );
    }
    else if ( angle < 720 )
    {   
      
      strokeWeight( 20 );
      stroke( #EF1919, alf );
      line( xx, yy, outerXX+pad, outerYY+pad);
    }
    else
    {
      strokeWeight( .5 );
      stroke( #EFEF11, alf);

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

        stroke( #69EF11, alf );
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
//  draws circle from supplied x, y
void drawCore( int XX, int YY, int maxSize ) {

  float r = 1;  // 75;
  float theta = 0;

  int alf = 99;
  float x;
  float y;

  smooth();
  strokeWeight(.25);
  //  stroke( #EEEE11, alf );  
  //noStroke();

  while ( theta <= maxSize )
  {    
    x = (PI*r) * cos(theta);
    y = (PI*r) * sin(theta);

    if (x%2==0)stroke(255, alf);
    else if (x%3==0) stroke(255, 0, 0, alf);
    else stroke( 109, 109, 109, alf);

    // "dots"
    ellipse( int(XX+x), int(YY+y), x, x );

    heart( int(YY+y), int(XX+x), int(y), int(y) );

    theta+= 0.25;

    if ( frameCount%2==0) {
      r++;
      theta+=.5;
    }
  }
}



///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{   
  artDaily("ERICFICKES.COM");

  save( fix.pdeName() + "-" + fix.getTimestamp()+".tif" );
  
  exit();


}

///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randFill() {  
  fill( random(255), random(255), random(255), alf );
}
void randStroke() {  
  stroke( random(255), random(255), random(255), alf );
}
void randStroke100() {  
  stroke( random(255), random(255), random(255), 100 );
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

/*
///////////////////////////////////////////////////////////
 //  
 //  Spits the installed list of fonts out in a grid
 void fontGrid() 
 {
 fill(255);
 stroke(255);
 String[] fontList = PFont.list();
 int x = 10;
 int y = 10;
 PFont font;
 
 for( int ct = 0; ct <= fontList.length-1; ct++ ){   
 
 
 // load it & show it
 font = createFont( fontList[ct], 18);
 textFont( font );
 
 text(fontList[ct], x, y);
 
 if( ct % 55 == 0)
 {
 x += 330;
 y = 0;
 }
 else
 {
 y += 20;
 }
 
 }
 
 }
 */
