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

* BLOOD-DRAGON : 1920 x 1071
* size(displayWidth, displayHeight, P3D)
* HDR w, h is 2x1 EX: 2048, 1024
*/


import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import fixlib.*;

//  https://github.com/ericfickes/FIXLIB
/* ------------------------------------------------------------------------- */
Fixlib fix = Fixlib.init(this);
HDrawablePool pool;

int gridX,gridY;
int colCt = 10;
int rowCt = colCt;
int colSpacing = 10;
int drawW, drawH; //  HDrawable Width / Height

/* ------------------------------------------------------------------------- */

void setup() {

  //  init PROCESSING
  size(1024,768, P3D);
  smooth(8);  


  //  init VARIABLES
//TODO: get scale and fit logic dialed in with squares
  drawW = (int)( (width-(colSpacing*2))/colCt)-colSpacing;
  drawH = (int)( (height-(colSpacing*2))/rowCt)-colSpacing;
  gridX = (int)(drawW*.75);
  gridY = (int)(drawH*.75);

  //  init HYPE
  H.init(this).background(-1).use3D(true);

  pool = new HDrawablePool(colCt*colCt);
  pool.autoAddToStage()
    .add (
      new HRect()
    )

    .layout (
      new HGridLayout()
      .startX(gridX)
      .startY(gridY)
      .spacing( drawW+colSpacing, drawH+colSpacing, colSpacing )
      .cols(colCt)
      .rows(rowCt)
    )

    .onCreate (
       new HCallback() {
        public void run(Object obj) {

          HDrawable d = (HDrawable) obj;
          d
            .size( drawW, drawH )
            .stroke((int)random(255))
            .fill( (int) d.x()%255, (int) d.y()%255, (int) d.z()%255 )
            .anchorAt(H.CENTER)
          ;
        }
      }
    )

    .requestAll()
  ;

  H.drawStage();

}





/* ------------------------------------------------------------------------- */
void draw() {

  /*
  // 3D code
  hint(DISABLE_DEPTH_TEST);
  camera();
  lights(); //    because P3D

  ambientLight(ct,ct,ct);
  emissive(ct,ct,ct);
  specular(ct,ct,ct);
  */

  if(frameCount>43)doExit();

}







/* ------------------------------------------------------------------------- */
/*  NON - P5 BELOW  */
/* ------------------------------------------------------------------------- */

void doExit(){
  
  fill(0xEF2018);
  textSize(11);
  text("ericfickes.com", 0, height-11);
  
  //  TODO: fix this line of code to save in same folder as PDE on PC & MAC
  save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  
  //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
