Boolean isFinal = true;
int ctMAIN = 0;
float alf = 50;

//  art frame settings
int outerRectX;
int outerRectY;
int outerRectWidth = 227;
int outerRectHeight = 37;

int cX = int( 1024 / PI );
int cY = int( 768 / PI );

float px, py, px2, py2;
float angle = 45;
float angle2;
float radius = 50;
float frequency = 11;
float frequency2 = 11;
float x, x2;

int xx;
int yy;


////////////////////////////////////////////////////
//
void setup(){
  size(1024, 768 );
  background (36);
}


////////////////////////////////////////////////////
//
void draw(){
  
  smooth();

  fill(255);
//  strokeWeight( random(1.1) );


  // rotates rectangle around circle
  px = width/8 + cos(radians(angle))*(radius/2);
  py = 75 + sin(radians(angle))*(radius/2);
  rectMode(CENTER);

  fill(0);
  //draw rectangle
//  rect (px, py, 5, 5);
  heart( int(px), int(py), int(angle), int(angle) );
  
  if( frameCount % 11 == 0 ) {    //  <-------- good var to tweak
  
    // draw ellipse around a circle
    for (int i = 0; i <= 360; i++)
    {
  
      xx = cX + int( cos(radians(angle)) * radius );
      yy = cY + int( sin(radians(angle)) * radius );

      if( i % 4 == 0 )
      {
        stroke( #EFEFEF, 5 );
      }
      else
      {
        strokeWeight( .1 );
        stroke( #EF1975, 1 );
      }

      smooth();
      ellipse( xx+px, yy+py, radius, radius );
      ellipse( yy+py, xx+px, radius, radius );

      //angle += frequency;
      angle = nextFib( (int)angle );
      
    } 
  }

  // send small ellipse along sine curve
  // to illustrate relationship of circle to wave

  angle -= frequency;
  radius += 0.75;
  x = nextFib( (int)x );

  // when little ellipse reaches end of window
  // reinitialize some variables
  if (x >= width-radius) {
    x = 0;
    angle = 0;
    radius++;
  }



  if( px >= 1080 )
  {
    exit();
  }
}


///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void exit() 
{   
  artDaily("ericfickes.com");


  //  if final, save output to png
  if ( isFinal )
  {
save( split( this.toString(), "[")[0] + "-" + month()+day()+year()+hour()+minute()+second()+millis() + ".png" );
  }

  super.stop();
}

///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randFill()    {  fill( random(255), random(255), random(255), random(100) );  }
void randStroke()  {  stroke( random(255), random(255), random(255), random(100) );  }

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {
  fill( #EFEFEF, 100 );
  
  PFont font = createFont( "Silom", 11 );
  textFont( font );
  
  text( " "+dailyMsg, 11, height-11);
}

//////////////////////////
int f0 = 0;
int f1 = 1;
//int f2 = 1;

int nextFib( int f2)
{
//   int result = f2;
   f0 = f1;
   f1 = f2;
   f2 = f0 + f1;
   
   return f0 + f1;
}


///////////////////////////////////////////////////////////
//  
//  draw heart
void heart( int x, int y, int w, int h ) 
{
  ellipseMode(RADIUS);
  smooth();
  
  if( x % 2 == 0 )
    stroke(#75EF19, 75 );
  else if( x % 3 == 0 )
    stroke(#1975EF, 69 );
  else
    stroke(#EF1975, 69 );
  
  strokeWeight(random(1));
//  scale( random(2) );
  
  noFill();
  
  //  bubbles
  //  ellipse(x, y, width, height)
  ellipse( x-w, y, w, w );
  ellipse( x+w, y, w, w );
  //  ellipseMode(MODE)
  //  MODE	Either CENTER, RADIUS, CORNER, or CORNERS
  
  //  FILL SHAPE
  
  //  lines	
  //  line(x1, y1, x2, y2)
  //stroke(#19EF75);
  line( x-(w*2), y, x, y + w*PI);
  line( x+(w*2), y, x, y + w*PI);
  
}

