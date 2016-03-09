 public float xx = 0, yy = 0;
Boolean isFinal = true;
/////////////////////////////////////////////////////////
void setup() {
  background(0);
  size(1024, 768 );
  noFill();
  smooth();
} 
/////////////////////////////////////////////////////////
void draw() {

  xySystem(xx, yy);

  strokeWeight(random(HALF_PI, TWO_PI));
  point( xx, yy );
  

  // STOPPER
  if ( frameCount > (1024+768)*PI )
  {
    fill(#EFEFEF);
    textFont( createFont( "Monospace", 11 ) );
    text("ERICFICKES.COM", 11, height-11);

    if(isFinal){
      save( pdeName() + getTimestamp() + ".png");
    }
    noLoop();
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
    stroke(42, random(255), 42);
    xx = random(PI, width-xx);
  }
  if ( b > height || b < 0 ) {
    stroke(42,random(42, 242), 42,random(222));
    yy = random(PI, height-yy);
  }
}




String getTimestamp() {
  return ""+month()+day()+year()+hour()+second()+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
String pdeName() {
  return split( this.toString(), "[")[0];
}

