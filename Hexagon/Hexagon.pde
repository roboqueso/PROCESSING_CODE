//
//  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
//
Boolean isFinal = true;
float alf = 37;

int cX;
int cY;

int shapeSize = 50;
int gridWidth = 800+shapeSize;
int gridHeight;

// circle settings
int outerXX = 0;
int outerYY = 0;

int pad = 69;
int cubeSize = 333;

float angle = 0;
float maxAngle;
float radius = 150;
float outerRadius;

int offsetX = 0;
int offsetY = 0;

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

  strokeWeight(.5);

  gridHeight = height+shapeSize;
  
  xx = -cubeSize;
  yy = xx;  

  offsetX = int( cX+(shapeSize* 7.5) );
  offsetY = cY;

  //  max angle = where does the circle stop?
  maxAngle = angle + (360 * 3 );

  outerRadius = PI * pow( radius, 2 );

}

float xx = -shapeSize;
float yy = -shapeSize;
boolean gotGrid = false;

////////////////////////////////////////////////////
//
void draw()
{
  
    while( ! gotGrid ) {
      for( int ct = 0; ct <= width+height; ct++ ) {
        noFill();
        smooth();
    
    
        stroke(109, pow(alf,2) );
        rect( xx, yy, shapeSize, shapeSize );
    
        stroke(#EF0000, pow(alf,3) );
        hexagon( xx, yy, shapeSize );
    
        stroke( 109, pow(alf,2) );    
    //    stroke(#0000EF,alf);
        ellipse( xx, yy, shapeSize, shapeSize );
    
        if( ct % 15 == 0 ) {
          xx = 0;
          yy += shapeSize;
        } else {
          xx += shapeSize;
        }
        
      }
      gotGrid = true;
    }

  // draw cirle on the right
    smooth();
    noFill();
  
    xx = ( offsetX - int( cos(radians(angle)) * radius ) );
    yy = ( offsetY - int( sin(radians(angle)) * radius ) );
  
    outerXX = ( offsetX + int( cos(radians(angle)) * outerRadius ) );
    outerYY = ( offsetY - int( sin(radians(angle)) * outerRadius ) );


    strokeWeight( .5 );

    if( frameCount % 12 == 0 ) {
        stroke(#1996EF, alf*2);
        line( xx, yy, outerXX, outerYY);
    } else {
        stroke(#EFEFEF, alf);
        ellipse( xx, yy, shapeSize, shapeSize);
    }

    angle += 1.5;

  if ( angle >= maxAngle )
  {    
    exit();
  }

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

  fill( #696969, 666 );
  text( " "+dailyMsg, this.width-185, this.height-15);
}
