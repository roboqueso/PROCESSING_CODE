import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

//.drawLissajous( 50,50, 6 )
HDrawablePool pool;
int poolSz = 64;

void setup() {
  size(640,640);
  H.init(this).background(#202020).autoClear(false);
  smooth();

  pool = new HDrawablePool(poolSz);
  pool.autoAddToStage()
    .add (
      new HPath()
    )

    .colorist( new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600).fillOnly() )

    .layout (
      new HGridLayout()
      .startX(40)
      .startY(40)
      .spacing(80,80)
      .cols(8)
    )

    .onCreate (
      new HCallback() {
        
        public void run(Object obj) {
          int ranEdges = round(random(5, 10));
          float ranDepth = random(0.25, 0.75);

          HPath path = (HPath) obj;

          
          path
            .drawLissajous( path.x(), path.y() , poolSz )
            .size(64)
            .noStroke()
            .anchorAt(H.CENTER)
            .rotation( path.x()*path.y() )
          ;
        }
      }
    )

    .requestAll()
  ;

  H.drawStage();
  noLoop();
}

void draw() {}





void keyPressed(){

  if( keyCode == ESC ){
  
    save(this+".png");
    noLoop();
    super.exit();
  }


}