//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;

//  
int alf = 42;

//  circle vars
float angle1 = 0, xx1, yy1, startX1, startY1, radius1 = alf;
float angle2 = 0, xx2, yy2, startX2, startY2, radius2 = alf*5;
float angle3 = 0, xx3, yy3, startX3, startY3, radius3 = alf*7;
float angle4 = 0, xx4, yy4, startX4, startY4, radius4 = alf*9;

int cX;
int cY;

color[] p1 = { #EF0000, #00EF00, #0000EF, #CECE00, #FA7680, #EF1975, #007007, #EFEF00, #FA9187, #007007, #109109 };
PImage b;
ArrayList p3;

//  VECTOR ACTION - http://processing.org/reference/PVector.html
PVector v1, v2;


////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  background(alf);
  fix.alpha(alf);
b = loadImage("white-flower.jpg");//  "white-flower.jpg"
p3 = fix.getImgColors(b);

  //  setup variables
  cX = width/2;
  cY = height/2;

//  startX1 = startX2 = startX3 = startX4 = cX;
//  startY1 = startY2 = startY3 = startY4 = cY;
  
  v1 = new PVector(cX, cY, alf);
  v2 = new PVector(cX, cY-alf, alf); 
  
  stroke(0);
  strokeWeight(.75);
  xx1 = yy1 = -alf;
  noFill();
}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();

fix.ranPalStroke(p3);
  fix.ranPalFill(p3);
  ellipse(v1.x, v1.y, alf, alf);

fix.ranPalStroke(p3);
  fix.ranPalFill(p3);
  ellipse(v2.x, v2.y, frameCount, frameCount);
  v2.add(v1);

fix.ranPalStroke(p3);
  fix.ranPalFill(p3);
  ellipse(v2.x, v2.y, frameCount-alf, frameCount-alf);

noFill();

fix.evenOddStroke(#EFEFEF);
line( xx1+random(noise(xx1)), 0, xx1+random(noise(xx1)), height );


fix.drawLissajous( xx1, yy1, PI+random(TWO_PI)/( noise(xx1) + noise(yy1) ) );
//  point( xx1, yy1 );
//  point( yy1, xx1 );

//evenOddFill(#EF2012);

scale(0.75);

for (float p = 0.9; p < 5; p += 0.1) 
{
  fix.ranPalStroke(p3);
  fix.ranPalFill(p3);

  pushMatrix();
  translate ( width * p-xx1, height * p-yy1);
  
  beginShape();

  fix.ranPalStroke(p3);
  vertex(  random(150)*noise(p), random(450)*noise(p));//1

  fix.ranPalStroke(p3);
  vertex( v2.x*noise(p), v2.y*noise(p));
 
  fix.ranPalStroke(p3);
  vertex( v1.x*noise(p), v1.y*noise(p));

fix.  ranPalStroke(p3); 
  vertex( xx1*noise(p), yy1*noise(p));//10
  
  endShape(CLOSE);
  
  popMatrix();
}






if( xx1 < width ) {
 
 xx1 += alf;

} else {

 xx1 = -alf;
 yy1 += alf*3;
}

 //  vector
 v1.x = xx1;
 v1.y = yy1+noise(yy1);
 
 v2.x = v1.x;
 v2.y = v1.y+noise(v1.y);





  //
  //  STOP
  //  
  if ( xx1 > width && yy1 > height )
  {    
    doExit();
  }
 
}



///////////////////////////////////////////////////////////
//  
//  End handler, saves png
void doExit() 
{

  artDaily("ERICFICKES.COM");

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

  textFont( createFont( "Silom", 37 ) );  //  "AnonymousPro"
  smooth();

  fill(alf);
  text( dailyMsg, 0, height-10 );
  fill(0);
  text( dailyMsg, 0, height-5 );
  fill(255);
  text( dailyMsg, 0, height );
}