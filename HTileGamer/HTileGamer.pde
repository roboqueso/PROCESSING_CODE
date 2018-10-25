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

String SAVE_NAME = "thisShouldBeDynamic";
String SAVE_TYPE = ".png";  // ".tif";

String mainImgFile = "12PTQT.004.png";
String bgImgFile = "bg/12PTQT.004.JPG";
boolean saveFrame = true;
boolean rotateTiles = true;

int gridX,gridY;
int colCt = 8;
int rowCt = colCt;  //  NOTE: remember to update this value
int colSpacing = 0;
int drawW, drawH; //  HDrawable Width / Height
int frmCt = 3;  //  stop after frameCount exceeds frmCt
PImage mainImg, bgImg, tmpSlice;


HImage tmpImg, bgHImg;  //  background image reference





/* ------------------------------------------------------------------------- */

void  settings ()  {
    //  For best results, change size() to match dimensions of mainImgFile
    // size(1400,1400, P3D);  // TODO: follow image size for now. Come back and make sketch own sliced dimensions
    size(1920, 1920, P3D);

    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());

    mainImg = loadImage(mainImgFile);
      bgImg = loadImage(bgImgFile);
}

/* ------------------------------------------------------------------------- */

void setup() {

  //  init VARIABLES
  drawW = (int)( (width-(colSpacing*2))/colCt);
  drawH = (int)( (height-(colSpacing*2))/rowCt);
  gridX = 0; //(drawW/2)+colSpacing; 
  gridY = 0; //(drawH/2)+colSpacing;

  //  Generate filename containing sketch settings meta NOW
  SAVE_NAME = fix.pdeName() + "-rotate"+ rotateTiles + "-"+fix.getTimestamp();

  //  init HYPE
  H.init(this).background(-1).use3D(true).autoClear(true);
  
  //  BACKGROUND IMAGE
  bgHImg = new HImage( bgImg );
  bgHImg.anchorAt(H.CENTER).loc(width/2, height/2);
  H.add(bgHImg);


  pool = new HDrawablePool(colCt*rowCt);
  pool.autoAddToStage();

  //  SLICE IT UP

  //  OUTER ROW LOOP ( t - b ) 
  for( int row = 0; row < rowCt; row++)
  {
    //  INNER COLUMN LOOP ( l-r )  
    for( int col = 0; col < colCt; col++)
    {
      tmpSlice = mainImg.get( (drawW*col), (drawH*row), drawW, drawH);

      tmpImg = new HImage( tmpSlice );

      //  rotate ?
      if(rotateTiles)
          tmpImg.rotate(90*col);

      pool.add(tmpImg);
    }
  }


  pool
      .layout (
        new HGridLayout()
        .startLoc(gridX, gridY)
        .spacing( drawW+colSpacing, drawH+colSpacing, colSpacing )
        .cols(colCt)
        .rows(rowCt)
      );

}





/* ------------------------------------------------------------------------- */
void draw() {



  pool.requestAll();

  //  rotate obj already known by HYPE
  bgHImg.rotateZ( (frameCount+1)*90);

  H.drawStage();

  //  save frame
  if(saveFrame){
    saveFrame( SAVE_NAME + "_##"+SAVE_TYPE);  //  USE .TIF IF COLOR
  }

  pool.drain();

  if(frameCount>frmCt) {
    //  FINAL FRAME
    //  Grab images, do some magic, clear stage, slap down final frame

    //  resize for masking
    mainImg.resize(width, height);
    bgImg.resize(width,height);

    //  get stage
    tmpSlice = get(0,0, width,height);

    //  MASK
    mainImg.mask(bgImg);
    mainImg.mask(tmpSlice);

    //  give it back to HYPE
    H.add(new HImage(mainImg));

    //  NO grid, just the final frame image
    H.clearStage();
    H.drawStage();

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

  textFont( createFont("Bitwise", 43));
  textSize(13);
  text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());

  save( SAVE_NAME+"_FINAL"+SAVE_TYPE );    //  USE .TIF IF COLOR  
  
  //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
