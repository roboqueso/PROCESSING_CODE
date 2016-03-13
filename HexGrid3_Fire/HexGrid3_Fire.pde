//
//  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
//
//  Increment angle in larger chunks
//  Get bigger flames with less noise
//  get good flame colors
Boolean isFinal = true;
float alf = 11;


//  color[] palette = {0xFF0000, 0x00FF00, 0x0000FF };

int cX;
int cY;

int shapeSize = 10;
int gridWidth;
int gridHeight;

// circles
int cirXX;
int cirYY;
int startX = 0;
int startY = 0;
float angle      = 6; 
float radius     = 69;  //100;
int circleSize   = 2;
int cc = 0;

int maxCC = 0;
int hexCoreSize = 35;

////////////////////////////////////////////////////
//
void setup() {

  // setup core sketch settings items
  size(1024, 768);//);
  frameRate(303);
  background(1);

  //  setup variables
  cX = width/2;
  cY = height/2;

  startX = cX;
  startY = cY;

  gridHeight = height;
  gridWidth  = width;
  
  maxCC = width*10;

}

float xx = 0;
float yy = cY;


////////////////////////////////////////////////////
//
void draw()
{
  
  while( cc <= maxCC )
  {

noFill();
smooth();

      cirXX = startX - int( cos(radians(angle)) * radius );
      cirYY = startY - int( sin(radians(angle)) * radius );
      

      stroke( #676800, alf );  // FA7680, FA9187
      strokeWeight( random(shapeSize) );  
      hexagon( xx, yy, shapeSize );

      //  points 
      strokeWeight( random(shapeSize) );
      stroke(#EFEF00, alf);
      point( random(xx), random(yy) );//, shapeSize );

stroke( #1975EF, alf );
strokeWeight(1);
point( xx, cirXX);

/*
stroke( #007007, alf );  // EF1975
strokeWeight(1);
point( yy, cirYY );
*/

      stroke( #FF0000, alf );  
      strokeWeight(.75);
      line( xx, yy, cirXX, cirYY );

    //  center circle
    strokeWeight(2);
    ellipse( cirXX, cirYY, hexCoreSize, hexCoreSize );

    if( cc % 5 == 0) {
      stroke( #FA7680, pow(alf,2) );  
      ellipse( cirXX, cirYY, hexCoreSize, hexCoreSize );  
    } else {
    
      stroke( #CeCe00, (alf*4) );
    
    }

      if( xx >= width )
      {
          xx = -shapeSize;
          yy += shapeSize;
          radius++;
        
      } else {
        xx += shapeSize*.5;
      }
  

    angle += 4;
    cc++;
  }
  

  exit();  

}

//////////////////////////////////////////////////////////////////////////
//  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
void hexagon( float startX, float startY, float shapeSize ) {

  line( startX, startY+(shapeSize*.5), startX+(shapeSize*.25), startY );
  line( startX+(shapeSize*.25), startY, startX+(shapeSize*.75), startY );
  line( startX+(shapeSize*.75), startY, startX+(shapeSize), startY+(shapeSize*.5) );

  line( startX+(shapeSize), startY+(shapeSize*.5), startX+(shapeSize*.75), startY+shapeSize );
  line( startX+(shapeSize*.75), startY+shapeSize, startX+(shapeSize*.25), startY+shapeSize );
  line( startX+(shapeSize*.25), startY+shapeSize, startX, startY+(shapeSize*.5) );
}




///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void exit() 
{   
  artDaily("ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( this + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
  }

  super.stop();
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
  //PFont font = loadFont( "Silom-20.vlw" );
  
  smooth();
  textFont( font );
  strokeWeight(1);

  fill( #6976EF , 666 );
  text( " "+dailyMsg, this.width-185, this.height-5);
}
