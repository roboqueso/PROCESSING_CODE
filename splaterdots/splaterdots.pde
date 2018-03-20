// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

public float x = 0, y = 0;
Boolean isFinal = true;
/////////////////////////////////////////////////////////
void setup() {
  background(#000110);
  size(1024, 768 );
  noFill();

} 
/////////////////////////////////////////////////////////
void draw() {

  xySystem(x, y);

  strokeWeight(11);
  point( x, y );
  
  strokeWeight(random(22));
  point( x-y, y );
  
  strokeWeight(random(37));
  point( y, x );

  if ( frameCount > (width+height)*TWO_PI )
  {
    fill(#EFEFEF);
    textFont( createFont( "Silom", 11 ) );
    text("ERICFICKES.COM", 3, height-11);

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
        x += 11;
      } 
      else {
        y += 11;
        x = random(11);
      }
    } 
    break;

  case 1:
    {
      if ( b < height ) {
        y += 11;
      } 
      else {
        x += 11;
        y = random(11);
      }
    }
    break;
    
  case 2:
    {
      x ++;
      y --;
    }
    break;

  case 3:
    {
      x --;
      y --;
    }
    break;

  case 4:
    {
      x --;
      y ++;
    }
    break;

  case 5:
    {
      if ( a > 0 ) {
        x -= 11;
      } 
      else {
        y -= 11;
        x = random(11);
      }
    } 
    break;

  case 6:
    {
      if ( b > 0  ) {
        y -= 11;
      } 
      else {
        x -= 11;
        y = random(11);
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
    stroke(random(200,255), random(100));
    x = random(PI, width-x);
  }
  if ( y > height || y < 0 ) {
    stroke(random(150), random(100));
    y = random(PI, height-y);
  }
}