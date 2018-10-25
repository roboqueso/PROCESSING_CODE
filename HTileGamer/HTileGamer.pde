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

String SAVE_TYPE = ".png";

String mainImgFile = "12PTQT.004.png";
String bgImgFile = "bg/12PTQT.004.JPG";
int gridX,gridY;
int colCt = 8;
int rowCt = colCt;  //  NOTE: remember to update this value
int colSpacing = 0;
int drawW, drawH; //  HDrawable Width / Height
int frmCt = 3;  //  stop after frameCount exceeds frmCt
PImage mainImg, bgImg, tmpSlice;

// PImage[] slices = {};
// int sliceIndex = 0;

HImage tmpImg;

boolean save_frame = true;




/* ------------------------------------------------------------------------- */

void  settings ()  {
    //  For best results, change size() to match dimensions of mainImgFile
    // size(1400,1400, P3D);  // TODO: follow image size for now. Come back and make sketch own sliced dimensions
    size(1920, 1920, P3D);

    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());

    mainImg = loadImage(mainImgFile);
    if(bgImgFile!="")
      bgImg = loadImage(bgImgFile);
}

/* ------------------------------------------------------------------------- */

void setup() {

  //  init VARIABLES
  drawW = (int)( (width-(colSpacing))/colCt)-colSpacing;
  drawH = (int)( (height-(colSpacing))/rowCt)-colSpacing;
  gridX = 0; //(drawW/2)+colSpacing; 
  gridY = 0; //(drawH/2)+colSpacing;

  // noFill();

  //  init HYPE
  H.init(this).background(-1).use3D(true).autoClear(true);
  
  // image(bgImg, 0,0,width,height);

// debug
// println("width: "+ width + " : " + mainImg.width + " : " + H.app().width );


  pool = new HDrawablePool(colCt*rowCt);
  pool.autoAddToStage();

  // if(bgImgFile!=""){
  //   H.add( new HImage( bgImg ) );
  // }
  //  SLICE IT UP
  
  // slices = new PImage[(rowCt*colCt)];

  //  OUTER ROW LOOP ( t - b ) 
  for( int row = 0; row < rowCt; row++)
  {
    //  INNER COLUMN LOOP ( l-r )  
    for( int col = 0; col < colCt; col++)
    {
      tmpSlice = mainImg.get( (drawW*col), (drawH*row), drawW, drawH);

      tmpImg = new HImage( tmpSlice );

      // // decorate the image slice
      // tmpImg.stroke(0xEF1975);
      // tmpImg.tint((int)random(255));
      // tmpImg.rotate(90*col);

      pool.add(tmpImg);

// TODO: if you save ou
      // slices[sliceIndex] = tmpSlice;

      // // track original slice positioning
      // sliceIndex ++;
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


    // .onRequest (
    //    new HCallback() {
    //     public void run(Object obj) {

    //       if(pool.currentIndex()==0){

    //         ((HImage)obj).rotation( random(360) );
    //       }

    //     }
    //   }
    // );


}





/* ------------------------------------------------------------------------- */
void draw() {

  H.add( new HImage(bgImg).rotation(frameCount*360) );
  pool.requestAll();  //  When would you call shuffleRequestAll()?

  H.drawStage();

  //  save frame
  if(save_frame){
    saveFrame( fix.pdeName() + "-" + fix.getTimestamp() + "_##"+SAVE_TYPE);  //  USE .TIF IF COLOR
  }

  pool.drain();

  if(frameCount>frmCt) {
    //  final frame clears stage
    //  and just spits out MAIN image
  // add stage background image
  

  mainImg.resize(width, height);
  bgImg.resize(width,height);

  bgImg.mask(mainImg);
  mainImg.mask(bgImg);

  H.add(new HImage(mainImg));

//  NOTE: can't seem to just reset background
//  H.backgroundImage(mainImg)

    //  NO grid
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

  save( fix.pdeName() + "-" + fix.getTimestamp()+"_FINAL"+SAVE_TYPE );    //  USE .TIF IF COLOR  
  
  //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
