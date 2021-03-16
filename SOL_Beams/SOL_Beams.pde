Boolean isFinal = true;
int ctMAIN = 0;
int alf = 13;

int cX;
int cY;
int xx = 0;
int yy = 0;

int outerXX = 0;
int outerYY = 0;

int pad = 4;
int cubeSize = 10;

float angle = 0;
float maxAngle;
float radius = 50;
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

  noFill();

  cX = int( this.width / 2 );
  cY = int( this.height / 2 );

  xx = -cubeSize;
  yy = xx;  

  strokeWeight( .5 );

  offsetX = 400;
  offsetY = 400;
  
  //  max angle = where does the circle stop?
  maxAngle = angle + (360 * cubeSize );

  outerRadius = PI * pow( radius, 2 );
}


////////////////////////////////////////////////////
//
void draw()
{


  xx = ( offsetX - int( cos(radians(angle)) * radius ) );
  yy = ( offsetY - int( sin(radians(angle)) * radius ) );
  
  outerXX = ( offsetX - int( cos(radians(angle)) * outerRadius ) );
  outerYY = ( offsetY - int( sin(radians(angle)) * outerRadius ) );


if( frameCount % 3 == 0 ) {
  
    if( angle < 360 )
    {    
      strokeWeight( 8 );
      stroke( #EFEFEF, alf );
    }
    else if( angle < 720 )
    {    
      strokeWeight( 6 );
      stroke( #EFEF00, alf );
    }
    else
    {
      strokeWeight( 2 );
      stroke( #EF0000, alf );
    }
    
    line( xx, yy, outerXX, outerYY );
}



  if( angle < 360 )
    angle++;
  else if ( angle < 720 )
    angle += 1.5;
  else
    angle += 2;

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



///////////////////////////////////////////////////////////
//  
//  draw heart
void heart( int x, int y, int w, int h ) 
{
  ellipseMode(RADIUS);
  smooth();

//  stroke(#EF1975, alf);  // 37
  stroke(#EF1111, alf);  // 37

  strokeWeight(2);
//  noFill();
  
  //  bubbles
  //  ellipse(x, y, width, height)
  ellipse( x-w, y, w, w);
  ellipse( x+w, y, w, w);
  //  ellipseMode(MODE)
  //  MODE	Either CENTER, RADIUS, CORNER, or CORNERS
  
  //  FILL SHAPE
  
  //  lines	
  //  line(x1, y1, x2, y2)
  //stroke(#19EF75);
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
