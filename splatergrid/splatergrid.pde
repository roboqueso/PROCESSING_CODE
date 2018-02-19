// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
public float x, y;
public int alf = 75, gridSize = 11, colWidth, rowHeight, maxCt;
public int[] nums = { 2,3,5,8,13,21,34 };

PImage b;
ArrayList p3, p4;

/////////////////////////////////////////////////////////
void setup() {
  background(#011223);
  size(1024, 768 );
  noFill();
  smooth();
  fix.alpha(alf);
  strokeWeight(11);
  
  colWidth = floor( width / gridSize );
  rowHeight = floor( height / gridSize );
  maxCt = 1024;
  
  
  b = loadImage("OrangishFletchFlying.jpg");  //"WhiteFlower.jpg");  //"fluoxetine.jpg");
  p4 = fix.getImgColors(b);
  
} 
/////////////////////////////////////////////////////////
void draw() {
  
  noFill();
  
  xySystem(x, y);
  
  strokeWeight(TWO_PI+random(gridSize) );
  point( x, y );
  
  strokeWeight(1);
  xySystem( y, x);
  point( y,x );
  
  if(frameCount%gridSize==0){
    curve( width/2-x, height/2-y, width-x, height-y, x, y, y-x, x-y );
  }

  // STOPPER
  if ( frameCount > maxCt )
  {
    fill(#EFEFEF);
    textFont( createFont( "Monospace", 11 ) );
    text("ERICFICKES.COM", width-100, height-11);

    if(isFinal){
      save( fix.pdeName() + fix.getTimestamp() + ".png");
    }
    noLoop();
    exit();
  }
}
/////////////////////////////////////////////////////////
void xySystem( float a, float b)
{
  //    randomly adjust globals x and y
  switch( int( random(4) ) )
  {
  case 0:
  case 2:
  case 3:
    {
      if ( a < width ) {
        x += colWidth;
      } 
      else {
        x = 0;
        y += rowHeight;
      }
    } 
    break;

  case 1:
    {
      if ( b < height ) {
        y += rowHeight*noise(frameCount);
      } 
      else {
        x += colWidth;
        y = 0;
      }
    }
    break;

  }
  //    ensure x & y are in screen
  if ( a > width || a < 0 ) {
//    stroke(random(255), alf*PI);
    fix.ranPalStroke100(p4);
    x = random(PI, width-x);
  }
  
  if ( b > height || b < 0 ) {
//    stroke(42,100);
    fix.ranPalStroke100(p4);
    y = random(PI, height-y);
  }
  
  
  //  always want to check for this condition
  if ( frameCount % int(768/TWO_PI) == 0 ) {
    
    //  resize grid
    gridSize = nums[ floor( random(nums.length) ) ]; //floor(random( 2, 10 ));
    colWidth = floor( width / gridSize );
    rowHeight = floor( height / gridSize );
    x = y = 0;
    stroke(random(42,242),gridSize, gridSize);

      textFont( createFont("monospace", alf*gridSize ) );
      fill(#034567,alf);
      text( gridSize,  width-a*cos(frameCount), height-b*sin(frameCount) );
      fill(#1975EF,alf);
      text( gridSize,  width-a*cos(frameCount)-11, height-b*sin(frameCount)-11 );

      noFill();
    
  }
  
  
}



