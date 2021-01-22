//  SEE:   https://ello.co/ericfickes/post/tgb4egbb21osid4ubudnqg
//  GOTO:  https://github.com/ericfickes/FIXLIB

import fixlib.*;
Fixlib fix = Fixlib.init(this);


Boolean isFinal = true;
int alf = (int)random(69,96);
float shapeSize = random(420,720);

int cX, xx, yy;
int cY;

//  
color[] palette = { 
  #EF0000, #00EF00, #0000EF, #EFEFEF, #A59DA1, #D96D55, #F36613, #A9ABEA, #D23301, #F6FAFD, #AB6E9C, #D6F9FF, #F8751E, #768A00, #F05510, #FFEE51, #FFB02A, #D7D5FA
};

int outerXX = 0;
int outerYY = 0;

float angle = 0;
float maxAngle;
float radius = random(11,45);
float outerRadius = random(90,180);

int offsetX = 0;
int offsetY = 0;


int ct = 0;
int maxCt = 0;


void settings(){
  size(displayWidth, displayHeight, P3D );
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}

//
void setup() {

  frameRate(303);
  background(   palette[(int)random(palette.length)]  );
  fix.alpha(alf);

  //  setup variables
  cX = width/2;
  cY = height/2;

  offsetX = cX;
  offsetY = cY;

  maxCt = 4200;	//36000;// * 72;


}


////////////////////////////////////////////////////
//

void draw()
{
  smooth();


  xx = ( offsetX - int( cos(radians(angle)) * radius ) ) ;
  yy = ( offsetY - int( sin(radians(angle)) * radius ) ) %height;

  outerXX = ( offsetX - int( cos(radians(angle)) * outerRadius ) ) ;
  outerYY = ( offsetY - int( sin(radians(angle)) * outerRadius ) ) %height;

  strokeWeight( alf );
  stroke( (frameCount*1.01)%255, alf*4 );
  point( xx, yy );
  point( outerXX, outerYY );

  strokeWeight( alf/4 );
  stroke( frameCount%255, alf*4 );
  point( xx, yy );
  point( outerXX, outerYY );


  strokeWeight( random(3, 36) );
  stroke( random(alf, 255), alf );
  point( yy, xx );  
  point( outerYY, outerXX );

  if ( angle >= maxCt ) {
    doExit();
  }
  
  if ( angle % 6 == 0 ) {
    smooth();  
    strokeWeight( 6);
    point( xx, yy );
//    stroke(#00EF00, alf);
    fix.ranPalStroke100(palette);
    line( xx, yy, outerXX, outerYY );
    point( outerXX, outerYY );
  }
  
  if ( angle % 720 == 0 ) {

    angle  += 3;//6;
    radius += 3;//6;

    offsetY = (int)random(cY, height);
    offsetX = (int)random(cX, width);

    strokeWeight(13);
    stroke(#EF1111, alf*2);

//    line( outerXX, outerYY, offsetX, offsetY );
//    line( offsetX, offsetY, xx, yy );


    strokeWeight( random(36) );
  } 
  else {
    angle++;
    outerRadius++;

    if( radius > width+height )
      radius = 36;
    else
      radius = fix.nextFib( int(radius) );
  }
}



///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    String saveName = fix.pdeName() + "-" + fix.getTimestamp();
    save( saveName +".tif" );
    save( saveName +".png" );
  }

  noLoop();
  exit();
}



///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 18 ) );
  smooth();

  //  stroke(#EFEFEF);
  fill(#EE0000);
  text( " "+dailyMsg, this.width*.45, this.height-18);
}
