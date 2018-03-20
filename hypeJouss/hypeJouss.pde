import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

//  HPath d = (HPath) H.add( new HPath().drawLissajous( col*200+120, row*200+120, starOffest ) )

HColorPool colors;
  int starScale = 200;
  int starOffest = 20;

void setup() {
  size(1024, 768);
  H.init(this).background(#202020).autoClear(false);
  smooth();

  colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600);

  for(int i = 0; i<9; ++i) {
    int ranEdges = round(random(5, 10));
    float ranDepth = random(0.2, 0.6);
    
    for (int j = 0; j<9; ++j) {
      int row = (int) Math.floor(i / 3);
      int col = i % 3;

      HPath d = (HPath) H.add( new HPath().drawLissajous(col*200+120, row*200+120, starScale ) )
        .size(starScale)
        .noStroke()
        .fill( colors.getColor() )
        .anchorAt(H.CENTER)
        .loc(col*200+120, row*200+120);
      ;

      new HOscillator()
        .target(d)
        .property(H.ROTATION)
        .range(-20, 20)
        .speed(0.4)
        .freq(8)
        .currentStep(j)
      ;

      starScale -= starOffest;
    }
    starScale = 200;
  }
}

void draw() {
  
  H.drawStage();

//if(frameCount%starOffest==0){
  stroke(random(255));
  strokeWeight(frameCount%TWO_PI);
  drawLissajous( width*.75, frameCount%height, starScale );
//}

}

//////////////////////

//////////////////////////////////////////////////////
//
void drawLissajous( float a, float b, float amp )
{
  float x, y;
 
  for ( float t = 0; t <= 360; t+=.2)  //t+=.2 )
  {
    x = a - amp * sin(a * t * PI/180);
    y = b - amp * sin(b * t * PI/180);

    point(x, y);

  }

}



void keyPressed(){

  if( keyCode == ESC ){
  
    save(fix.pdeName()+fix.getTimestamp()+".png");
    noLoop();
    super.exit();
  }


}