/*
HTileGamer  : take an image and slice into a slide game.
This is the NEWER version of concept DS_tileGame.pde

TODO: 

- re-visit DS_tileGame.pde for any tips
* add saving of slices to disk for asset loading into P5

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
HColorPool    colors;

String SAVE_NAME = "thisShouldBeDynamic";
String SAVE_TYPE = ".png";  // ".tif";

String mainImgFile = "devaskation-logo-small.png";
int gridX,gridY;
int colCt = 11;
int rowCt = colCt;  //  NOTE: remember to update this value
int colSpacing = 1; //  keep this at 1 as minimum
int drawW, drawH; //  HDrawable Width / Height
int frmCt = 2;  //  stop after frameCount exceeds frmCt
int bgColor;
PImage mainImg, tmpSlice;

PImage[] slices = {};

HImage tmpImg;

boolean saveFrames = true;
boolean tintTiles = true;

int sliceIndex = 0;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    //  For best results, change size() to match dimensions of mainImgFile
    // size(1400,1400, P3D);  // TODO: follow image size for now. Come back and make sketch own sliced dimensions
    size(720,700, P3D);

    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());

    mainImg = loadImage(mainImgFile);
}

/* ------------------------------------------------------------------------- */

void setup() {

  //  init VARIABLES
  drawW = (int)( (width-(colSpacing*2))/colCt);
  drawH = (int)( (height-(colSpacing*2))/rowCt);
  gridX = colSpacing; //(drawW/2)+colSpacing; 
  gridY = colSpacing; //(drawH/2)+colSpacing;

  //  init HYPE
  H.init(this).background(-1).use3D(true).autoClear(true);
//  .backgroundImg(mainImg)
// debug
// println("width: "+ width + " : " + mainImg.width + " : " + H.app().width );

  colors = new HColorPool(#000000, #ED7100, #315D15, #3D107B, #E35205, #FFFFFF);

  pool = new HDrawablePool(colCt*rowCt);
  pool.autoAddToStage();

  //  rando bgColor
  if(tintTiles)
    bgColor = #FFFFFF;
  else
    bgColor = colors.getColor();

// manual runs
  // bgColor = #000000;
  // bgColor = #ED7100;
  // bgColor = #315D15;
  // bgColor = #3D107B;
  // bgColor = #E35205;



  //  Generate filename containing sketch settings meta NOW
  SAVE_NAME = fix.pdeName() + "-TINT_"+ tintTiles + "-"+fix.getTimestamp();

  background(bgColor);
  H.background(bgColor);
  
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

      // // decorate the image slice
      // tmpImg.stroke(0xEF1975);
      // tmpImg.tint((int)random(255));
      tmpImg.rotate(90*col);

      pool.add(tmpImg);

      slices[sliceIndex] = tmpSlice;

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


    .onCreate(
      new HCallback() {
        public void run(Object obj) {

//  NOTE: this sketch is currently image only mode
          HImage d = (HImage) obj;
          //  NOTE: if you remove hard coding and go with scale, colSpacing no work
          // d.width(drawW).height(drawH);

          //  pull color from DS color pool
          if(tintTiles)
            d.tint(colors.getColor());
          else
            noTint();
          

        }
      }
      );


}





/* ------------------------------------------------------------------------- */
void draw() {


  pool.requestAll();  //  When would you call shuffleRequestAll()?

  H.drawStage();

  //  save frame
  if(saveFrames){
    saveFrame( SAVE_NAME + "_##" + SAVE_TYPE);  //  USE .TIF IF COLOR
  }

  pool.drain();

  if(frameCount>frmCt) {
    //  final frame clears stage
    //  and just spits out MAIN image
  // add stage background image
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

void stampIt(){
  String msg = "DEVASKATION x ERICFICKES";
  //  stamp bottom right based on textSize
  // fill(#EF1975);  //colors.getColor());
  fill(colors.getColor());

  textFont( createFont("AMCAP Eternal", 24));
  textSize(13);
  text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());
}

/**
  End of sketch closer
*/
void doExit(){
  stampIt();

  save( SAVE_NAME+"_FINAL"+SAVE_TYPE );    //  USE .TIF IF COLOR  
  
  //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
