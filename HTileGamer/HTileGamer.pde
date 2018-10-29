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
String SAVE_NAME = "thisShouldBeDynamic"; //  MC HAMMER
String SAVE_TYPE = ".tif";  // ".tif";


String bgImgFile = "bg.png";  //  Background and final frame mask source

//  NOTE: This script now runs off of imgs[] to allow for multi-source image support
//  BG image is still static ATM
String[] imgs = { 
"NOTHINGSEXY19.png"
};

//  MODES

  boolean p5Filters = false;
  boolean rotateTiles = false;

  // boolean p5Filters = true;
  // boolean rotateTiles = true;

  // boolean p5Filters = false;
  // boolean rotateTiles = true;

  // boolean p5Filters = true;
  // boolean rotateTiles = false;

//  END MODES


int frmCt = 3;  //7;  //  NOTE: saving starts @ 0.  7 gets you 8 frames and 1 FINAL
boolean saveFrame = true;
int colCt = 4;
int colSpacing = 1; //  keep this at 1 as minimum
/* ------------------------------------------------------------------------- */

int rowCt = colCt;  //  Maintains even 1:1 grid
int drawW, drawH, gridX, gridY; // slice dimensions, grid position
PImage mainImg, bgImg, tmpSlice;

Fixlib fix = Fixlib.init(this);
HDrawablePool pool;
HImage tmpImg, bgHImg;  //  background image reference



int imgIdx = 0;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    //  For best results, change size() to match dimensions of mainImgFile
    // size(1400,1400, P3D);  // TODO: follow image size for now. Come back and make sketch own sliced dimensions
    size(1920, 1080, P3D);

    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());

    bgImg = loadImage(bgImgFile);
}

/* ------------------------------------------------------------------------- */

void setup() {

  //  init VARIABLES
  drawW = (int)( (width-(colSpacing*2))/colCt);
  drawH = (int)( (height-(colSpacing*2))/rowCt);
  gridX = colSpacing; //(drawW/2)+colSpacing; 
  gridY = colSpacing; //(drawH/2)+colSpacing;

  mainImg = loadImage( imgs[imgIdx] );

  //  Generate filename containing sketch settings meta NOW
  SAVE_NAME = fix.pdeName() + "-"+ imgs[imgIdx] + (p5Filters ? "-P5F": "" ) + (rotateTiles ? "-ROTATE": "" );  //fix.getTimestamp();

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

      //  ROTATE slice before putting in the pool?
      if(rotateTiles){
        tmpImg.rotate(90*col);
      }
          
      //  APPLY P5 FILTERS?
      if(p5Filters){
        tmpImg.image().filter(INVERT);
        tmpImg.image().filter(OPAQUE);
      }

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

  // Bernard Purdie would shuffle it
  pool.shuffleRequestAll();

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

//  TODO: get() is now erroring out with
//  HTileGamer.pde:178:0:178:0: ArrayIndexOutOfBoundsException

    //  get stage
    tmpSlice = get(0,0, width,height);
    //  resize for masking
    mainImg.resize(width, height);
    bgImg.resize(width,height);
    tmpSlice.resize(width,height);

try{
    //  MASK
    mainImg.mask(bgImg);
    mainImg.mask(tmpSlice);

}catch(Exception exc ){
  println("EXCEPTION: "+ exc.getMessage());
}
    //  give it back to HYPE
    H.add(new HImage(mainImg));

    //  NO grid, just the final frame image
    H.clearStage();
    H.drawStage();

    stampAndSave();
    if(imgIdx < imgs.length-1 )
    {
      imgIdx++;
      setup();  
    }
    else
    {
      doExit();
    }

  }
}







/* ------------------------------------------------------------------------- */
/*  NON - P5 BELOW  */
/* ------------------------------------------------------------------------- */

/**
  End of sketch closer
*/
void stampAndSave(){
  String msg = "ERICFICKES.COM";
  //  stamp bottom right based on textSize
  fill(#EF1975);  //colors.getColor());

  textFont( createFont("Bitwise", 43));
  textSize(13);
  text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());

  save( SAVE_NAME+"-FINAL"+SAVE_TYPE );    //  USE .TIF IF COLOR  
}


void doExit(){
    //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}