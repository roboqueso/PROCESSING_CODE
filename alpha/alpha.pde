/*
ALPHA  : square one starting point P5/HYPE template sketch

SECTIONS:

- LIBS / INIT
  * HYPE
  * FIXLIB


- TOP
    native P5
- BOTTOM 
    non system P5 code

*/

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import fixlib.*;

//  https://github.com/ericfickes/FIXLIB
Fixlib fix = Fixlib.init(this);



HDrawablePool pool;

void setup() {
  // size(2048,1024);  //   .hdr dimensions
  size(1024,768, P3D);  //  big:  1024x768
  
  H.init(this).background(#202020);
  smooth();

  pool = new HDrawablePool(576);
  pool.autoAddToStage()
    .add (
      new HRect()
      .rounding(4)
    )

    .layout (
      new HGridLayout()
      .startX(21)
      .startY(21)
      .spacing(26,26)
      .cols(24)
    )

    .onCreate (
       new HCallback() {
        public void run(Object obj) {
          HDrawable d = (HDrawable) obj;
          d
            .noStroke()
            .fill( #ECECEC )
            .anchorAt(H.CENTER)
            .size( 25 )
          ;
        }
      }
    )

    .requestAll()
  ;

  H.drawStage();

}

void draw() {

  if(frameCount>43)doExit();

}




/*  NON - P5 BELOW  */


void doExit(){
  
  fill(0xEF2018);
  textSize(11);
  text("ericfickes.com", 0, height-11);
  
  //  TODO: fix this line of code to save in same folder as PDE on PC & MAC
  save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
 
  noLoop();
  exit();
}
