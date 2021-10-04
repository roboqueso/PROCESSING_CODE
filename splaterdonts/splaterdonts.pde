//  SEE:   https://ello.co/ericfickes/post/vv6oxniq5jexrulp0qwutw
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);



public float x = 0, y = 0;
Boolean isFinal = true;
/////////////////////////////////////////////////////////
void setup() {
  background(#012345);
  size( displayWidth, displayHeight );
  noFill();
  pixelDensity(displayDensity());
  smooth(8);
} 
/////////////////////////////////////////////////////////
void draw() {

  xySystem(x, y);

  strokeWeight(random(42));
  point( x, y );
  
  strokeWeight(11);
  point( x-y, y );
  
  strokeWeight(random(PI));
  point( y, x );
  strokeWeight(random(PI));
  point( x, y );
  

  // STOPPER
  if ( frameCount > (1024+768)*TWO_PI )
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
  switch( int( random(12) ) )
  {
  case 0:
    {
      if ( a < width ) {
        x += PI;
      } 
      else {
        y -= TWO_PI;
        x = random(TWO_PI);
      }
    } 
    break;

  case 1:
    {
      if ( b < height ) {
        y += PI;
      } 
      else {
        x += HALF_PI;
        y = random(TWO_PI);
      }
    }
    break;
    
  case 2:
    {
      x --;
      y --;
    }
    break;

  case 3:
    {
      x -= PI;
      y --;
    }
    break;

  case 4:
    {
      x += TWO_PI;
      y -= TWO_PI;
    }
    break;

  case 5:
    {
      if ( a > 0 ) {
        x += random(11);
      } 
      else {
        y -= 11;
        x = random(a-b);
      }
    } 
    break;

  case 6:
    {
      if ( b > 0  ) {
        y -= 11;
        x += noise(a);
      } 
      else {
        x -= 11;
        y += random(11);
      }
    }
    break;
    
  case 7:
    {
      x += 11;
      y += 11;
    }
    break;

  case 8:
    {
      x += 11;
      y -= 11;
    }
    break;

  case 9:
    {
      x -= 11;
      y += 11;
    }
    break;

  case 10:
    {
      x -= cos(a)*noise(frameCount)*radians(a);
      y -= sin(b)*noise(frameCount)*radians(b);
    }
    break;
    
  case 11:
    {
      x -= cos(b)*noise(frameCount);
      y += sin(a)*noise(frameCount);
    }
    break;

  default:{
    x += noise(b)*a;
    y += noise(a)*b;
    rect(x,y, a, b);
  }break;

  }
  //    ensure x & y are in screen
  if ( x > width || x < 0 ) {
    stroke(random(169,227));
    x = random(PI, width-x);
  }
  if ( y > height || y < 0 ) {
    stroke(42,42,random(46, 256), random(256));
    y = random(PI, height-y);
  }
}
