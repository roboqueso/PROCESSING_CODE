import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HColorPool colors;
HPath d;

void setup() {
  size(640, 640);
  H.init(this).background(#111111).autoClear(true);
  smooth();

  colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #ff3300, #ff3300, #242424, #333333, #666666);

  int starScale = 800;
  int starOffest = 15;

  for (int i=0; i<53; ++i) {
    
    HPath d = (HPath) H.add( new HPath().drawLissajous(5, 0.5, 90) )
      .size(starScale)
      .noStroke()
      .fill( colors.getColor() )
      .anchorAt(H.CENTER)
      .locAt(H.CENTER)
    ;
    

    new HOscillator()
      .target(d)
      .property(H.ROTATION)
      .range(-20, 20)
      .speed(0.4)
      .freq(8)
      .currentStep(i)
    ;

    starScale -= starOffest;
  }
}

void draw() {
  H.drawStage();
}




void keyPressed(){

  if( keyCode == ESC ){
  
    save(fix.pdeName()+fix.getTimestamp()+".png");
    noLoop();
    super.exit();
  }


}