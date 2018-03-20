// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

public Boolean isFinal = true;
int dWidth, dHeight, r,g,b,opacity,nSides,cx,cy;
float xx, yy;

boolean isPolygon = false;
float proportion;

void setup()
{
  dWidth = 1024;
  dHeight = 768;

  size(1024, 768);
  background(#EF2012);
frameRate(303);

  smooth();
  rectMode(CENTER);


  cx = dWidth/2;
  cy = dHeight/2;
}




void draw()
{
  nSides = int(random(5, 55));

  


  
  if(frameCount% int(random(13,42))==0){
    fill(#EFEFEF);
    strokeWeight(.42);
    line( xx, 0, xx, height );
  } else {
    noFill();
  }
  strokeWeight(random(PI));
  stroke( #EF2012 );  
  rect( xx, yy, nSides, nSides, proportion*frameCount);

  proportion = random(0.2, 0.8) * cos(PI / frameCount);
  
  strokeWeight(random(2));
  stroke(random(42));
  fill(random(42,255),42,42);
  fix.star(5, xx, yy, random(PI*proportion,21), proportion );
//  text(proportion, random(dWidth), random(dHeight) );
  //  }
  
  if( xx <= dWidth ){
    xx += 11;
  } else {
    xx = 0;
    yy += nSides*PI;
  }
  
  //  safety checker
  if( yy >= height ){
    yy = random(yy);
  }
  
  
  if(frameCount>dWidth+dHeight){
  
  

      textFont(createFont("Silom",37));
      
      fill(0);
      text("ERICFICKES.COM", 0, height-11 );  // 28
      fill(#424242);
      text("ERICFICKES.COM", 1, height-10 );  // 28
      fill(#EFEFEF);
      text("ERICFICKES.COM", 2, height-9 );  // 28

      if(isFinal){
        save( fix.pdeName() + fix.getTimestamp() + ".png" );
      }
      noLoop();
      exit();
  }
}

void polygon(int n, float cx, float cy, float r)
{
  float angle = 360.0 / n;

  beginShape();
  for (int i = 0; i < n; i++)
  {
    vertex(cx + r * cos(radians(angle * i)), 
    cy + r * sin(radians(angle * i)));
  }
  endShape(CLOSE);
}