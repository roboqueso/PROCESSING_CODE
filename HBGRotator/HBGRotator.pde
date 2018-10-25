/*
HBGRotator - slap down a background image, then rotate every draw() or H.drawStage()

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
int frmCt = 2;  //  stop after frameCount exceeds frmCt
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
      bgImg = loadImage(bgImgFile);
}

/* ------------------------------------------------------------------------- */

void setup() {

  //  init VARIABLES
  drawW = (int)( (width-(colSpacing))/colCt)-colSpacing;
  drawH = (int)( (height-(colSpacing))/rowCt)-colSpacing;
  gridX = 0; //(drawW/2)+colSpacing; 
  gridY = 0; //(drawH/2)+colSpacing;

  //  init HYPE
  H.init(this).background(-1).use3D(true).autoClear(false);
  
  tmpImg = new HImage( bgImg );
  tmpImg.anchorAt(H.CENTER).loc(width/2, height/2);

  H.add(tmpImg);
}





/* ------------------------------------------------------------------------- */
void draw() {

  //  rotate obj already known by HYPE
  tmpImg.rotateZ(frameCount*90);

  H.drawStage();

  //  save frame
  if(save_frame){
    saveFrame( fix.pdeName() + "-" + fix.getTimestamp() + "_##"+SAVE_TYPE);  //  USE .TIF IF COLOR
  }

  // pool.drain();

  if(frameCount>frmCt) {
    //  final frame clears stage
    //  and just spits out MAIN image
  // add stage background image

  mainImg.resize(width, height);
  bgImg.resize(width,height);

  //  get desktop
  tmpSlice = get(0,0, width,height);
  tmpSlice.filter(INVERT);
  
  bgImg.mask(tmpSlice);

  //  OG MASK ACTION
  bgImg.mask(mainImg);
  mainImg.mask(bgImg);

  H.add(new HImage(mainImg));

    //  NO grid
    // H.clearStage();
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
