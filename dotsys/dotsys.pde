//  SEE:   https://ello.co/ericfickes/post/g1aidr_jjvr3uiohx1th5a
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);

public float xx = 0, yy = 0;

Boolean isFinal = true;
/////////////////////////////////////////////////////////
void setup() {

  background(-1);
  size(displayWidth, displayHeight, P3D);
  pixelDensity(displayDensity());
  frameRate(666);
  smooth(8);
  noFill();

} 
/////////////////////////////////////////////////////////
void draw() {

  xySystem(xx, yy);

  strokeWeight(random(QUARTER_PI, TWO_PI));
  point( xx, yy );
  

  // STOPPER
  if ( frameCount > (1024+768)*4.2 )
  {
    fill(#EFEFEF);
    textFont( createFont( "Monaco", 11 ) );
    text("ERICFICKES.COM", 11, height-11);

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
  switch( int( random(3) ) )
  {
  case 0:
    {
      if ( a < width ) {
        xx += 13;
      } 
      else {
        yy -= 13;
        xx = random(width);
      }
    } 
    break;

  case 1:
    {
      if ( b < height ) {
        yy += 13;
      } 
      else {
        xx += HALF_PI;
        yy = random(height);
      }
    }
    break;

  case 2:
    {
      if ( b > 0 ) {
        yy -= 13;
      } 
      else {
        xx += HALF_PI;
        yy = random(height);
      }
    }
    break;

  default:{
    xx += noise(b)*a;
    yy += noise(a)*b;
    rect(xx,yy, a, b, xx/yy);
  }break;

  }
  //    ensure x & y are in screen
  if ( a > width || a < 0 ) {
    stroke(46, random(255), 46);
    xx = random(PI, width-xx);
  }
  if ( b > height || b < 0 ) {
    stroke(46,random(46, 242), 46,random(222));
    yy = random(PI, height-yy);
  }
}
