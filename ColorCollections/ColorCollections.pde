//  SEE:   https://ello.co/ericfickes/post/_wsilmm5ags0q7xlabmr_w
//  GOTO:  https://github.com/ericfickes/FIXLIB

import fixlib.*;
Fixlib fix = Fixlib.init(this);



//  color collection examples

final int SKETCH_HEIGHT  = displayWidth;
final int SKETCH_WIDTH   = displayHeight;


Boolean isFinal = true;
int alf = 24;

int cX;
int cY;

int shapeSize = 69;

// circles
int cirXX;
int cirYY;
int startX = 0;
int startY = 0;
float angle      = 0; 
float radius     = 99;  //100;
int circleSize   = 9;
int cc = 0;

int maxCC = 0;
color theLook;

////////////////////////////////////////////////////
color[] palette = { #EF0000, #00EF00, #0000EF, #CECE00, #FA7680, #EF1975, #007007, #EFEF00, #FA9187, #007007, #109109,#EFEF00, #1975EF, #EFEFEF, #75EF19 };




void settings(){
  size(displayWidth, displayHeight, P3D);
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}

////////////////////////////////////////////////////
//  Randomly stroke using image from color list
void randStrokeUser()
{
  stroke( palette[ int(random( palette.length-1 )) ] , alf );
}
void randFillUser()
{
  fill( palette[ int(random( palette.length-1 )) ] , alf );
}

////////////////////////////////////////////////////
//
void setup() {

  frameRate(666);
  theLook = palette[(int)random(palette.length)];
  background( theLook );

  //  setup variables
  cX = width/2;
  cY = height/2;

  startX = cX;
  startY = cY;

  maxCC = height*11;

}

float xx = 0;
float yy = cY;


////////////////////////////////////////////////////
//
void draw()
{  
  
    noFill();

    
    cirXX = startX - int( cos(radians(angle)) * radius );
    cirYY = startY - int( sin(radians(angle)) * radius );
    
    randStrokeUser();
    strokeWeight( random(shapeSize) );  
    hexagon( xx, yy, shapeSize );
    

    strokeWeight( random(shapeSize) );
    randStrokeUser();
    point( random(xx), random(yy) );//, shapeSize );

    randStrokeUser();
    strokeWeight(1);
    point( xx, cirXX);


    randStrokeUser();
    strokeWeight(2);
    line(cirYY-radius, xx, yy-radius, cirXX);
    strokeWeight(.25);
    randStrokeUser();
    line(cirYY+cX, cirXX, yy+cX, xx);

    randStrokeUser();
    strokeWeight(.75);
    line(cirYY-radius, cirXX, xx, yy);

    //  center circle
    strokeWeight(1.5);
    //stroke(#66EF33, alf*2);
    stroke(  theLook, 110 );
    ellipse( cirXX, cirYY, shapeSize, shapeSize );

    if( cc % 5 == 0) {
      ellipse( cirXX, cirYY, shapeSize, shapeSize );  
    } else {
      randStrokeUser();  
    }

      if( xx >= width )
      {
          xx = -shapeSize;
          yy += shapeSize;
          radius++;
        
      } else {
        xx += shapeSize*.5;
      }
  
  // 360
    if( cc > ( maxCC - 540 ) ) {
      shapeSize++;
    }

    angle += 15;//4;
    cc++;

  
  if( cc >= maxCC )
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
    
    String saveName = fix.pdeName() + "-" + fix.getTimestamp();
    save( saveName +".tif" );
    save( saveName +".png" );

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

  strokeWeight(1);
  fill( #6976EF , 666 );
  text( " "+dailyMsg, this.width-190, this.height-5);
}
