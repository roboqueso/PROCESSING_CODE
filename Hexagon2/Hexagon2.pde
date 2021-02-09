//  SEE:     
//  GOTO:  https://github.com/ericfickes/FIXLIB

import fixlib.*;
Fixlib fix = Fixlib.init(this);




Boolean isFinal = true;
int alf = 37;

int cX;
int cY;

int shapeSize = 69;
int gridWidth = 800+shapeSize;
int gridHeight;

// circle settings
int outerXX = 0;
int outerYY = 0;

int pad = 69;
int cubeSize = 345;

float angle = 0;
float maxAngle;
float radius = 36;
float outerRadius;

int offsetX = 0;
int offsetY = 0;


void settings(){
  size(displayWidth, displayHeight, P3D);
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}

////////////////////////////////////////////////////
//
void setup() {

  // setup core sketch settings items

  frameRate(303);
  background(25);

  //  setup variables
  cX = width/2;
  cY = height/2;

  strokeWeight(.5);

  gridHeight = height+shapeSize;
  gridWidth = width + shapeSize;
  
  xx = -cubeSize;
  yy = xx;  

  offsetX = int( width-(shapeSize*1.5) );
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
      for( int ct = 0; ct <= gridWidth; ct++ ) {
        noFill();
        smooth();
    
    
        stroke(109, pow(alf,2) );
        rect( xx, yy, shapeSize, shapeSize );
    
        stroke(#EF0000, pow(alf,3) );
        hexagon( xx, yy, shapeSize );
    
        stroke( 109, pow(alf,2) );    
    //    stroke(#0000EF,alf);
        ellipse( xx, yy, shapeSize, shapeSize );
    
        if( ct % 26 == 0 ) {
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

    if( frameCount % 15 == 0 ) {
        stroke(#1996EF, alf*2);
        ellipse( xx, yy, shapeSize, shapeSize);
    } else {
        stroke(#EFEFEF, alf);
        line( xx, yy, outerXX, outerYY);
    }

    angle += 1.5;

  if ( angle >= maxAngle )
  {    
    doExit();
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
void doExit() 
{   
  artDaily("ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {

    String saveName = fix.pdeName() + "-" + fix.getTimestamp();
    save( saveName +".png" );
    save( saveName +".tif" );
  }

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
  //PFont font = loadFont( "Silom-20.vlw" );
  
  smooth();
  textFont( font );
  strokeWeight(1);

  fill( #696969, 666 );
  text( " "+dailyMsg, this.width-185, this.height-15);
}
