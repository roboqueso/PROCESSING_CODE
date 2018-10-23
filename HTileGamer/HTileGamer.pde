/*
HTileGamer  : take an image and slice into a slide game

TODO: 

- re-visit logic and confirm
** is memory safe?
** is re-assemble logic the smartest?


  load image

  devaskation-logo-flat.png
  1400 x 1400

  slice to grid

animate

reassemble

*/

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import fixlib.*;

/* ------------------------------------------------------------------------- */
Fixlib fix = Fixlib.init(this);
HDrawablePool pool;

String mainImgFile = "fickes_small.png"; //"devaskation-logo-flat.png"
int gridX,gridY;
int colCt = 10;
int rowCt = colCt;  //  NOTE: remember to update this value
int colSpacing = 0;
int drawW, drawH; //  HDrawable Width / Height
int frmCt = 0;  //  stop after frameCount exceeds frmCt
PImage mainImg, tmpSlice;

PImage[] slices = {};

HImage tmpImg;

boolean save_frame = true;
boolean lastRun = false;
boolean debug = false;

int sliceIndex = 0;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    //  For best results, change size() to match dimensions of mainImgFile
    // size(1400,1400, P3D);  // TODO: follow image size for now. Come back and make sketch own sliced dimensions
    size(896, 666, P3D);

    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());

    mainImg = loadImage(mainImgFile);
}

/* ------------------------------------------------------------------------- */

void setup() {

  //  init VARIABLES
  drawW = (int)( (width-(colSpacing))/colCt)-colSpacing;
  drawH = (int)( (height-(colSpacing))/rowCt)-colSpacing;
  gridX = 0;  //(drawW/2)+colSpacing; 
  gridY = 0;  //(drawH/2)+colSpacing;

  noFill();

  //  init HYPE
  H.init(this).background(-1).use3D(true).autoClear(true);

  pool = new HDrawablePool(colCt*rowCt);
  pool.autoAddToStage();

  
  //  SLICE IT UP
  
  slices = new PImage[(rowCt*colCt)];

  //  OUTER ROW LOOP ( t - b ) 
  for( int row = 0; row < rowCt; row++)
  {
    //  INNER COLUMN LOOP ( l-r )  
    for( int col = 0; col < colCt; col++)
    {
      tmpSlice = mainImg.get( (drawW*col), (drawH*row), drawW, drawH);

      tmpImg = new HImage( tmpSlice );
      pool.add(tmpImg);

      slices[sliceIndex] = tmpSlice;

      // debug
      if(debug){
        textSize(69);
        image(tmpSlice, (drawW*col), (drawH*row) );
        text(sliceIndex, (drawW*col), (drawH*row) );

        println("ctr: "+ sliceIndex );
      }
      // track original slice positioning
      sliceIndex ++;
    }
  }


pool
    .layout (
      new HGridLayout()
      .startLoc(gridX, gridY)
      .spacing( drawW+colSpacing, drawH+colSpacing, colSpacing )
      .cols(colCt)
      .rows(rowCt)
    )

    .onRequest (
       new HCallback() {
        public void run(Object obj) {

          //  DO STUFF HERE

          if(lastRun){

// debug
println("LAST RUN: "+ pool.currentIndex() );

          HImage d = (HImage) obj;

          tmpSlice = slices[pool.currentIndex()];

          image(tmpSlice, d.x(), d.y());

          }


        }
      }
    )
  ;


}





/* ------------------------------------------------------------------------- */
void draw() {

  pool.shuffleRequestAll();
  H.drawStage();

  //  save frame
  if(save_frame){
    saveFrame( fix.pdeName() + "-" + fix.getTimestamp() + "_##.png");  //  USE .TIF IF COLOR
  }

  pool.drain();

  if(frameCount>frmCt) {

    //  TODO: rebuild mainImg slices into original positioning
    //  so FINAL is always the original piece
    lastRun = true;
    H.clearStage();

    //  trigger LAST RUN code
    pool.requestAll();

    doExit();
  }
}







/* ------------------------------------------------------------------------- */
/*  NON - P5 BELOW  */
/* ------------------------------------------------------------------------- */

/**
  End of sketch closer
*/
void doExit(){
  String msg = "ERICFICKES.COM";
  //  stamp bottom right based on textSize
  fill(#EF1975);  //colors.getColor());

  textFont( createFont("Bitwise", 24));
  textSize(13);
  text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());

  save( fix.pdeName() + "-" + fix.getTimestamp()+"_FINAL.tif" );    //  USE .TIF IF COLOR  
  
  //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
