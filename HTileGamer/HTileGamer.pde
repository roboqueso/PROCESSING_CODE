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

// TODO: add shapeJousT to FIXLIB

        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /**
         * HYPE port of FIXLIB'S Lissajous PShape maker
         * @param a     X coordinate
         * @param b     Y coordinate
         * @param amp   Amplitude or size
         * @param inc   Loop magic incrementer [ 1 - 36 supported ]. (360 / inc) = number of points in returned PShape
         * @param textImg PImage to use as shape texture
         * @return  PShape containing vertices in the shape of a lissajous pattern

        public HPath hypeJuice( float a, float b, float amp, int inc, PImage textImg )
        {
          int juicePts = 160; //  160 is the NEW hotness -> slightly less points, no blank frames 9-36
          int z = 0;

          //  PROTOTYPING : trying to locate universal ideal INCrementor for lisajouss loop
          //  Ideal range is someplace between 1 and 36
          if( ( inc < 1 ) || ( inc > 36 ) ) {
            inc = 1;
          }
          
          float x, y;
          // PShape shp = createShape();
          HPath hp = new HPath();
          
          hp.beginPath();
          hp.texture(textImg);


          for ( int t = 0; t <= juicePts  ; t+=inc)
          {
            //  NEW HOTNESS!
            x = a - amp * PApplet.cos((a * t * TWO_PI)/360);
            y = b - amp * PApplet.sin((b * t * TWO_PI)/360);

            //  give shapes up and down Z-depth
            z = ( t < (juicePts*.5) ) ? t : juicePts-t;

            hp.vertexUV(x, y, x, y );
          }

          hp.endPath();

          return hp;
        }
         */

/* ------------------------------------------------------------------------- */
String SAVE_NAME = "thisShouldBeDynamic"; //  MC HAMMER
String SAVE_TYPE = ".png";  // ".tif";


//  NOTE: bgImgFile is now the currently loaded mainImg
// String bgImgFile = "yellow.png";  //  Background and final frame mask source

//  NOTE: This script now runs off of imgs[] to allow for multi-source image support
//  BG image is still static ATM
String[] imgs = { 
  "i1.png",
"i10.png",
"i11.png",
"i12.png",
"i13.png",
"i14.png",
"i15.png",
"i16.png",
"i17.png",
"i18.png",
"i19.png",
"i2.png",
"i20.png",
"i21.png",
"i22.png",
"i23.png",
"i24.png",
"i25.png",
"i26.png",
"i3.png",
"i4.png",
"i5.png",
"i6.png",
"i7.png",
"i8.png",
"i9.png"
};

boolean saveFrame = true;
boolean saveLast = true; //  save final frame


boolean rotateWacky = true;  // requires rotateTiles = true

//  MODES
  // boolean p5Filters = true;
  // boolean rotateTiles = false;

  // boolean p5Filters = false;
  // boolean rotateTiles = false;

  // boolean p5Filters = true;
  // boolean rotateTiles = true;

boolean p5Filters = false;
boolean rotateTiles = true;

//  END MODES


int frmCt = 1;//  2, 4, 8, 16  //7;  //  NOTE: saving starts @ 0.  7 gets you 8 frames and 1 FINAL
int colCt = 16;//  2, 4, 8, 16
int colSpacing = 0;
/* ------------------------------------------------------------------------- */

int rowCt = colCt;  //  Maintains even 1:1 grid
int drawW, drawH, gridX, gridY; // slice dimensions, grid position
PImage mainImg, bgImg, tmpSlice;

Fixlib fix = Fixlib.init(this);
HDrawablePool pool;
HImage tmpImg, bgHImg;  //  background image reference

HShape hShp;
PShape pShp;

int imgIdx = 0;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    //  For best results, change size() to match dimensions of mainImgFile
    // size(1400,1400, P3D);  // TODO: follow image size for now. Come back and make sketch own sliced dimensions
    size(1920, 1080, P3D);
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */

void setup() {

  //  init VARIABLES
  // drawW = (int)( (width-(colSpacing*2))/colCt);
  // drawH = (int)( (height-(colSpacing*2))/rowCt);
  drawW = (int)( (width/colCt)-colSpacing);
  drawH = (int)( (height/rowCt)-colSpacing);
  gridX = colSpacing; //(drawW/2)+colSpacing; 
  gridY = colSpacing; //(drawH/2)+colSpacing;

  mainImg = loadImage( imgs[imgIdx] );
  bgImg = mainImg;

/*
  if(bgImg==null){
    // just load background once
    bgImg = loadImage(bgImgFile);
  }
*/
  //  Generate filename containing sketch settings meta NOW
  SAVE_NAME = fix.pdeName() + "-"+ imgs[imgIdx] + "-"+colCt+"col" + (p5Filters ? "-P5F": "" ) + (rotateTiles ? "-ROTATE": "" ) + (rotateWacky ? "WACKY": "" );  //fix.getTimestamp();

  //  init HYPE
  H.init(this).background(-1).use3D(true).autoClear(false);
  
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
      // tmpSlice = mainImg.get( (drawW*col), (drawH*row), drawW, drawH);      
//  TODO: move to using HSprite instead
      tmpImg = new HImage( mainImg.get( (drawW*col), (drawH*row), drawW, drawH) );
      tmpImg.anchorAt(H.CENTER);


      //  ROTATE slice before putting in the pool?
      if(rotateTiles){

        //  RANDOM PIE vs 90
        tmpImg.rotate( rotateWacky ? ( (row+col)*45 ) : (90*col) );

        //  TODO - are there better rotate combos to be had?
      }
          
      //  APPLY P5 FILTERS?
      if(p5Filters){

        tmpImg.image().filter(OPAQUE);        
        // POSTERIZE
        // Limits each channel of the image to the number of colors specified as the parameter. The parameter can be set to values between 2 and 255, but results are most noticeable in the lower ranges.
        tmpImg.image().filter(POSTERIZE, 8 );
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
  // pool.shuffleRequestAll();
  pool.requestAll();

  //  rotate obj already known by HYPE
  bgHImg.rotateZ( (frameCount+1)*90);

  H.drawStage();

  //  save frame
  if(saveFrame){
    saveFrame( SAVE_NAME + "_##"+SAVE_TYPE);  //  USE .TIF IF COLOR
  }

  pool.drain();

  //  Move to next image every time frameCount HITS the "(frmCt)"th mark
  if(frameCount%frmCt==0) {
    //  FINAL FRAME
    //  Grab images, do some magic, clear stage, slap down final frame

//  TODO: get() is now erroring out with
//  HTileGamer.pde:178:0:178:0: ArrayIndexOutOfBoundsException
//  F.P5 V3.4 -> debug deez nutz

//  TODO: re-run in P5 3.3.7

    //  get stage
    tmpSlice = null;
    tmpSlice = get(0,0, width,height);
    

    //  resize for masking
    mainImg.resize(width,height);
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

    stampAndSave(saveLast);


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
void stampAndSave(boolean saveFinal){
  String msg = "ERICFICKES.COM";
  //  stamp bottom right based on textSize
  fill(#EF1975);  //colors.getColor());

  textFont( createFont("Bitwise", 43));
  textSize(13);
  text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());

  if(saveFinal) save( SAVE_NAME+"-FINAL"+SAVE_TYPE );    //  USE .TIF IF COLOR  
}


void doExit(){
    //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}