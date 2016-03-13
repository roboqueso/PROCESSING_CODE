//
//  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
//
Boolean isFinal = true;
float alf = 37;

int cX;
int cY;

int shapeSize = 42;
int gridWidth = 800+shapeSize;
int gridHeight;


////////////////////////////////////////////////////
//
void setup() {

  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(25);

  //  setup variables
  cX = width/2;
  cY = height/2;

  gridHeight = height+shapeSize;
  gridWidth = width + shapeSize;
}

float xx = -shapeSize;
float yy = -shapeSize;
boolean gotGrid = false;

////////////////////////////////////////////////////
//
void draw()
{
  
  for( int cc = 0; cc <= width+height; cc ++ )
  {
    if( cc % 3 == 0 )
      stroke( #eeeeee, alf );
    else
      stroke( #696969, alf );
    
    smooth();

    hexagon( xx, yy, shapeSize );
    
    if( xx >= width )
    {
        xx = 0;
        yy += shapeSize*.25;
      
    } else {
      xx += shapeSize;
    }
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

  fill( #FF1111, 666 );
  text( " "+dailyMsg, this.width-185, this.height-15);
}
