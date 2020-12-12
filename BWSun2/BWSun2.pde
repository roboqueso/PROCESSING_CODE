//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB

import fixlib.*;
Fixlib fix = Fixlib.init(this);




Boolean isFinal = true;

//  
//  Black and White
//  Tatoo / Asian style sun
//  Use HOTmess3 as background
//  
//  B&W sunbeams slowly alpha out?
//  
int alf = 45;

//  circle vars
float angle1 = 0, xx1, yy1, startX1, startY1, radius1 = alf;
float angle2 = 0, xx2, yy2, startX2, startY2, radius2 = alf*4;
float angle3 = 0, xx3, yy3, startX3, startY3, radius3 = alf*8;
float angle4 = 0, xx4, yy4, startX4, startY4, radius4 = alf*12;

int cX;
int cY;

color[] palette = { #EF0000, #00EF00, #0000EF, #CECE00, #FA7680, #EF1975, #007007, #EFEF00, #FA9187, #007007, #109109 };
PImage b;
ArrayList p3;


void settings(){
  size(displayWidth, displayHeight, P3D);
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}


void setup() {

  frameRate(303);//);
  fix.alpha(alf);

//b = loadImage("HOTmess3.png");
//p3 = getImgColors(b);
//background(b);
  background(255);
fill(#EFEFEF,alf*PI);
  //  setup variables
  cX = width/2;
  cY = height/2;

  startX1 = startX2 = startX3 = startX4 = 0;  //cX;
  startY1 = startY2 = startY3 = startY4 = 0;  //cY;
  
  stroke(0);
  strokeWeight(.37);
}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();

  xx1 = startX1 - int( cos(radians(angle1)) * radius1 );
  yy1 = startY1 - int( sin(radians(angle1)) * radius1 );
  
  xx2 = startX2 - int( cos(radians(angle2)) * radius2 )+noise(xx1);
  yy2 = startY2 - int( sin(radians(angle2)) * radius2 )+noise(yy1);
  
  xx3 = startX3 - int( cos(radians(angle3)) * radius3 )+noise(xx2);
  yy3 = startY3 - int( sin(radians(angle3)) * radius3 )+noise(yy2);
  
  xx4 = startX4 - int( cos(radians(angle4)) * radius4 )+noise(xx3);
  yy4 = startY4 - int( sin(radians(angle4)) * radius4 )+noise(yy3);
  
  //  -------------
//  strokeWeight(random(alf/TWO_PI));
//  ellipse( xx1, yy1, alf, alf );
//  ellipse( xx2, yy2, alf, alf );
//  ellipse( xx3, yy3, alf, alf );  
  xx4 += random(noise(xx4))+TWO_PI;//random(TWO_PI);
  yy4 += random(noise(yy4))+TWO_PI;//+random(TWO_PI);
  


translate( cX, cY, 0);
pushMatrix();

//  sun beams
fix.drawLissajous( xx4, yy4, alf/PI );


  beginShape(TRIANGLES);

    vertex( xx1, yy1 );
    vertex( xx2, yy2 );
    vertex( xx3, yy3);
    vertex( xx4, yy4 );

  endShape();
popMatrix();

  angle1 += 3;
  angle2 += 5;
  angle3 += 7;
  angle4 += 9;

if( frameCount % 90 == 0 ) {
  radius1 -= 9;
  radius2 -= 15;
  radius3 -= 21;
  radius4 += 27; 
}

/*
//  FILL
if( frameCount < 360 && frameCount > 69 ) {
  evenOddFill(#EF0000);  
} else if( frameCount < 720 && frameCount > 360 ) {
  evenOddFill(#0000EF);
} else {
  evenOddFill(#EFEFEF); 
}
*/


  //
  //  STOP
  //  
  if ( frameCount > height*alf || xx4 > width)
  {    
    doExit();
  }
}



///////////////////////////////////////////////////////////
//  
//  End handler, saves png
void doExit() 
{

  artDaily("ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
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

  fill(#676800);
  text( " "+dailyMsg, displayWidth-230, displayHeight-14);
}
