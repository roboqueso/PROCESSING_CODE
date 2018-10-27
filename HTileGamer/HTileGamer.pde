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
String SAVE_TYPE = ".png";  // ".tif";


String bgImgFile = "bg/jellybg.png";  //  Background and final frame mask source

String[] imgs = { 
  "Jelly1_oc13290.png",
  "Jelly1_oc13494.png",
  "Jelly1_oc13735.png",
  "Jelly1_oc13945.png",
  "Jelly1_oc14123.png",
  "Jelly1_oc45918.png",
  "Jelly2_oc13597.png",
  "Jelly2_oc13637.png",
  "Jelly2_oc13741.png",
  "Jelly2_oc13755.png",
  "Jelly2_oc13923.png",
  "Jelly2_oc13953.png",
  "Jelly2_oc13957.png",
  "Jelly2_oc13990.png",
  "Jelly2_oc14011.png",
  "Jelly2_oc14101.png",
  "Jelly2_oc14139.png",
  "Jelly2_oc14157.png",
  "Jelly2_oc14193.png",
  "Jelly2_oc14206.png",
  "Jelly2_oc14240.png",
  "Jelly2_oc14271.png",
  "Jelly2_oc14457.png",
  "Jelly2_oc14568.png",
  "Jelly2_oc14573.png",
  "Jelly2_oc14575.png",
  "Jelly2_oc14648.png",
  "Jelly2_oc14784.png",
  "Jelly2_oc14794.png",
  "Jelly2_oc14821.png",
  "Jelly2_oc14901.png",
  "Jelly2_oc14971.png",
  "Jelly2_oc15538.png",
  "Jelly2_oc16390.png",
  "Jelly3_oc10312.png",
  "Jelly3_oc10370.png",
  "Jelly3_oc10456.png",
  "Jelly3_oc10575.png",
  "Jelly3_oc10634.png",
  "Jelly3_oc10703.png",
  "Jelly3_oc10722.png",
  "Jelly3_oc10814.png",
  "Jelly3_oc10817.png",
  "Jelly3_oc10846.png",
  "Jelly3_oc10849.png",
  "Jelly3_oc10855.png",
  "Jelly3_oc10883.png",
  "Jelly3_oc10890.png",
  "Jelly3_oc10895.png",
  "Jelly3_oc10918.png",
  "Jelly3_oc10955.png",
  "Jelly3_oc11065.png",
  "Jelly3_oc11081.png",
  "Jelly3_oc11308.png",
  "Jelly3_oc11380.png",
  "Jelly3_oc11433.png",
  "Jelly3_oc11457.png",
  "Jelly3_oc11504.png",
  "Jelly3_oc11542.png",
  "Jelly3_oc11597.png",
  "Jelly3_oc11627.png",
  "Jelly3_oc11645.png",
  "Jelly3_oc11727.png",
  "Jelly3_oc11728.png",
  "Jelly3_oc11758.png",
  "Jelly3_oc11760.png",
  "Jelly3_oc11765.png",
  "Jelly3_oc11768.png",
  "Jelly3_oc11934.png",
  "Jelly3_oc11967.png",
  "Jelly3_oc12033.png",
  "Jelly3_oc12037.png",
  "Jelly3_oc12040.png",
  "Jelly3_oc12057.png",
  "Jelly3_oc12060.png",
  "Jelly3_oc12062.png",
  "Jelly3_oc12107.png",
  "Jelly3_oc12136.png",
  "Jelly3_oc12193.png",
  "Jelly3_oc12354.png",
  "Jelly3_oc12520.png",
  "Jelly3_oc12747.png",
  "Jelly3_oc12756.png",
  "Jelly3_oc12883.png",
  "Jelly3_oc14552.png",
  "Jelly3_oc14992.png",
  "Jelly3_oc15018.png",
  "Jelly3_oc15504.png",
  "Jelly3_oc15818.png",
  "Jelly3_oc15847.png",
  "Jelly3_oc15916.png",
  "Jelly3_oc15945.png",
  "Jelly3_oc16047.png",
  "Jelly3_oc16285.png",
  "Jelly3_oc16306.png",
  "Jelly3_oc16391.png",
  "Jelly3_oc16563.png",
  "Jelly3_oc16821.png",
  "Jelly3_oc16884.png",
  "Jelly3_oc16941.png",
  "Jelly3_oc16977.png",
  "Jelly3_oc17602.png",
  "Jelly3_oc4122.png",
  "Jelly3_oc4578.png",
  "Jelly3_oc4975.png" 
  };

//  MODES

  // boolean p5Filters = false;
  // boolean rotateTiles = false;

  // boolean p5Filters = true;
  // boolean rotateTiles = true;

  // boolean p5Filters = false;
  // boolean rotateTiles = true;

  boolean p5Filters = true;
  boolean rotateTiles = false;

//  END MODES


int frmCt = 0;  //7;  //  NOTE: saving starts @ 0.  7 gets you 8 frames and 1 FINAL
boolean saveFrame = true;
int colCt = 11;
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
    size(800, 800, P3D);

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
  SAVE_NAME = fix.pdeName() + "-"+ imgs[imgIdx] + (p5Filters ? "_P5F_": "" ) + (rotateTiles ? "_ROTATE_": "" );  //fix.getTimestamp();

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



    //  MASK
    mainImg.mask(bgImg);
    mainImg.mask(tmpSlice);

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

  save( SAVE_NAME+"_FINAL"+SAVE_TYPE );    //  USE .TIF IF COLOR  
}


void doExit(){
    //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}