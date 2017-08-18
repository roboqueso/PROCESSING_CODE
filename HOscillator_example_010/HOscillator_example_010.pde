import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

color[] palette = { #333333, #666666, #999999, #CCCCCC, #F7F7F7 };

void setup() {
  size(640, 640);
  H.init(this).background(#202020).autoClear(false);
  smooth();

  int starScale = 200;
  int starOffest = 40;

  for (int i = 0; i<9; ++i) {
    for (int j = 0; j<5; ++j) {

      int row = floor(i/3.0);
      int col = i % 3;

      int ranEdges = HMath.randomInt(5, 10);
      float ranDepth = random(0.25, 0.75);

      HPath d = (HPath) H.add( new HPath().drawLissajous( col*200+120, row*200+120, ranEdges*ranDepth) )
        .size(starScale)
        .noStroke()
        .fill( palette[j] )
        .anchorAt(H.CENTER)
        .loc(col*200+120, row*200+120);
      ;

      new HOscillator()
        .target(d)
        .property(H.ROTATION)
        .range(-20, 20)
        .speed(0.2)
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
}






void keyPressed(){

  if( keyCode == ESC ){
  
    save(this+".png");
    noLoop();
    super.exit();
  }


}