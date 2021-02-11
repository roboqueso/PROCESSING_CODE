//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);


public Boolean isFinal = true;
int dWidth, dHeight, r,g,b,opacity,nSides,cx,cy;
float xx, yy;

boolean isPolygon = true;
float proportion;

void setup()
{
  dWidth = 1024;
  dHeight = 768;

  size(1024, 768);
  background(42);

  smooth();
  rectMode(CENTER);


  cx = dWidth/2;
  cy = dHeight/2;
}




void draw()
{
  nSides = int(random(5, 55));

  proportion = random(0.2, 0.8) * cos(PI / frameCount);

  if(proportion<=0.21) {
    strokeWeight(PI);
    stroke(11);
  } else {
    strokeWeight(proportion);
    stroke(random(111), random(111), nSides+proportion, 100);
  }
  noFill();
  fix.star(5, cx, cy, 11*cos(frameCount)*radians(-frameCount), proportion );
//  text(proportion, random(dWidth), random(dHeight) );
  //  }
  
  if( xx < dWidth ){
    xx += 11;
  } else {
    xx = 0;
    yy += 20*cos(frameCount)*radians(frameCount);
  }
  
  //  safety checker
  if( yy > height ){
    yy = random(yy);
  }
  
  
  if(frameCount>dWidth+dHeight){
  
  
      fill(11);
      textFont(createFont("Silom",23));
      
      //    TOP RIGHT CORNER-ISH ( between the time and the battery )
      text("ERICFICKES.COM", (dWidth/2)*1.2, 25 );  // 28

//      Bottom left corner
//      text("ERICFICKES.COM", -2, height-2 );

      if(isFinal){
        save( fix.pdeName() + fix.getTimestamp() + ".png" );
      }
      noLoop();
      exit();
  }
}