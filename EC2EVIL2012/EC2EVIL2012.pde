
// https://github.com/ericfickes/FIXLIB	
import fixlib.*;

Fixlib fix = Fixlib.init(this);
Boolean isFinal = true;

int alf = 13;

//  circle vars
float angle1 = 0, xx1, yy1, startX1, startY1, radius1 = alf;
float angle2 = 0, xx2, yy2, startX2, startY2, radius2 = alf*5;
float angle3 = 0, xx3, yy3, startX3, startY3, radius3 = alf*7;
float angle4 = 0, xx4, yy4, startX4, startY4, radius4 = alf*9;

int cX;
int cY;

color[] palette = { 
  #EF0000, #00EF00, #0000EF, #CECE00, #FA7680, #EF1975, #007007, #EFEF00, #FA9187, #007007, #109109
};
PImage b;
ArrayList p3, p4;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768 );


  b = loadImage("OrangishFletchFlying.jpg");  //"WhiteFlower.jpg");  //);
  p3 = fix.getImgColors(b);

  b = loadImage("WhiteFlower.jpg");	//fluoxetine.jpg");
  p4 = fix.getImgColors(b);
  fix.alpha(alf);
  //  background(b);
  background(0);
  fix.paletteGrid(p3);
  fix.paletteGrid(p4);
  //  setup variables
  cX = width/2;
  cY = height/2;

  startX1 = startX2 = startX3 = startX4 = cX;
  startY1 = startY2 = startY3 = startY4 = cY;

  stroke(0);
  strokeWeight(.37);
  noFill();
}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();

  xx1 = startX1 - int( cos(radians(angle1)) * radius1 );
  yy1 = startY1 - int( sin(radians(angle1)) * radius1 );

  xx2 = startX2 - int( cos(radians(angle2)) * radius2 );
  yy2 = startY2 - int( sin(radians(angle2)) * radius2 );

  xx3 = startX3 - int( cos(radians(angle3)) * radius3 );
  yy3 = startY3 - int( sin(radians(angle3)) * radius3 );

  xx4 = startX4 - int( cos(radians(angle4)) * radius4 );
  yy4 = startY4 - int( sin(radians(angle4)) * radius4 );

  //  -------------
  strokeWeight(random(alf/TWO_PI));
  ellipse( xx1, yy1, alf, alf );
  ellipse( xx2, yy2, alf, alf );
  ellipse( xx3, yy3, alf, alf );  
  
  xx4 += random(noise(xx4))+TWO_PI;//random(TWO_PI);
  yy4 += random(noise(yy4))+TWO_PI;//+random(TWO_PI);


  strokeWeight(1);

  fix.ranPalStroke100(p4);
  //fix.drawLissajous( xx4, yy4, alf/TWO_PI );
  fix.ranPalFill(p4);
  fix.circle(xx4, yy4, alf/TWO_PI, alf/TWO_PI);


  
  beginShape();
	fix.ranPalStroke(p3);
	fix.ranPalFill(p3);

  curveVertex( xx1, yy1 );

  curveVertex( xx2, yy2 );
  curveVertex( xx3, yy3);
  curveVertex( xx2, yy2 );    
  curveVertex( xx3, yy3);
  curveVertex( xx4, yy4 );


  endShape();

  stroke(random(11), alf);
  strokeWeight(random(11));
  point( xx1, yy1 );
  point( xx2, yy2 );
  point( xx3, yy3);
  point( xx2, yy2 );    
  point( xx3, yy3);
  point( xx4, yy4 );


  angle1 ++;
  angle2 +=2;
  angle3 +=PI;
  angle4 +=TWO_PI;


  //  WORK ON A MORE GRADUAL DEGREDATION
  radius1 --;
  radius2 -=2;
  radius3 -=PI;
  radius4 -=TWO_PI;

  //  evenOddFill(#373737);

  if ( radius1 < -width) {
    radius1 = alf*QUARTER_PI;
    radius2 = alf*HALF_PI;
    radius3 = alf*PI;
    radius4 = alf*TWO_PI;
  }

  //
  //  STOP
  //  frameCount > height*alf || 
  if ( frameCount > height+width)
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

  //  PDF
  if ( isFinal ) {
    endRecord();
  }

  noLoop();
  exit();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 11 ) );
  smooth();

  fill(random(255),random(255),random(255),100);
  text( dailyMsg, 0, height);
  /*
float y = 0;
   while( y <= height ) {
   
   fill(#EFEFEF, y*.15);
   text( " "+dailyMsg, 5, y);
   y += 18; 
   }
   */
}

