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
  "different_strokes.png"
  };

boolean saveFrame = true;
boolean saveLast = true; //  save final frame

//  MODES
// boolean p5Filters = false;
// boolean rotateTiles = false;
  
// boolean p5Filters = true;
// boolean rotateTiles = true;

  // boolean p5Filters = true;
  // boolean rotateTiles = false;

boolean p5Filters = false;
boolean rotateTiles = false;
//  END MODES

//  NOTE : each of these rotate vars require rotateTiles = true
boolean rotateWacky = false;  // requires rotateTiles = true
boolean rotateX = false;  // Rotates each tile's X axis
boolean rotateY = false;  // Rotates each tile's Y axis
boolean rotateZ = true;  // Rotates each tile's Z axis


int frmCt = 1;//  2, 4, 8, 16  //7;  //  NOTE: saving starts @ 0.  7 gets you 8 frames and 1 FINAL
int colCt = 16;//  2, 4, 8, 16
int colSpacing = 16;
/* ------------------------------------------------------------------------- */

int rowCt = colCt;  //  Maintains even 1:1 grid
int drawW, drawH, gridX, gridY; // slice dimensions, grid position
PImage mainImg, bgImg, tmpSlice;

Fixlib fix = Fixlib.init(this);
HDrawablePool pool;
HImage tmpImg, bgHImg;  //  background image reference

HShape hShp;
PShape pShp;
HBox tmpBox;

int imgIdx = 0;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    //  For best results, change size() to match dimensions of mainImgFile
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
  //  NOTE: SUB STATEMENTS PAST rotateTiles
  SAVE_NAME = fix.pdeName() + "-"+ imgs[imgIdx] + "" +colCt+"x"+colSpacing + (p5Filters ? "-P5F": "" ) + (rotateTiles ? "-ROTATE" + (rotateWacky ? "WACKY": "" )
               + (rotateX ? "rX": "" ) + (rotateY ? "rY": "" ) + (rotateZ ? "rZ": "" ) : "" );

  //  init HYPE
  H.init(this).background(-1).use3D(true);
  
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
      //  get image slice
      tmpImg = new HImage( mainImg.get( (drawW*col), (drawH*row), drawW, drawH) );
      tmpImg.anchorAt(H.CENTER);
      
      //  create box to hold slice
      tmpBox = new HBox();
      tmpBox.width(drawW).height(drawH);
      tmpBox
        .depth( random( -(drawH+drawW), (drawH+drawW)*TWO_PI ) )
        .z( random( -(colSpacing+colCt+col+row)*PI, (colSpacing+colCt+col+row)*PI ) );
// .noStroke()

      //  ROTATE slice before putting in the pool?
      if(rotateTiles){

        //  general rotation
        if( !rotateX &&  !rotateY &&  !rotateZ ){
          tmpImg.rotation( rotateWacky ? ( (row+col)*random(15,90) ) : (90* (row+col) ) );
          tmpBox.rotation( rotateWacky ? ( (row+col)*random(15,90) ) : (90* (row+col) ) );
        }

        //  TODO: does this make much difference?
        if(rotateX) tmpImg.rotationX( rotateWacky ? ( (row+col)*random(180) ) : (90* (row+col) ) );
        if(rotateY) tmpImg.rotationY( rotateWacky ? ( (row+col)*random(180) ) : (90* (row+col) ) );
        if(rotateZ) tmpImg.rotationZ( rotateWacky ? ( (row+col)*random(180) ) : (90* (row+col) ) );


        //  individual axis rotations
        if(rotateX) tmpBox.rotationX( rotateWacky ? ( (row+col)*random(180) ) : (90* (row+col) ) );
        if(rotateY) tmpBox.rotationY( rotateWacky ? ( (row+col)*random(180) ) : (90* (row+col) ) );
        if(rotateZ) tmpBox.rotationZ( rotateWacky ? ( (row+col)*random(180) ) : (90* (row+col) ) );

     // tmpBox.depth( (drawW+drawH) ).width(drawW).height(drawH).noStroke().z(-500).rotationZ(33);

        //  TODO - are there better rotate combos to be had?
      }



      //  APPLY P5 FILTERS?
      if(p5Filters){
          tmpImg.image().filter(OPAQUE);
          // POSTERIZE
          // Limits each channel of the image to the number of colors specified as the parameter. The parameter can be set to values between 2 and 255, but results are most noticeable in the lower ranges.
          tmpImg.image().filter(POSTERIZE, 8 );

        tmpBox.textureFront( tmpImg.image() );

          // tmpImg.image().filter(INVERT);
        tmpBox.textureTop( tmpImg.image() );

          // tmpImg.image().filter(GRAY);
        tmpBox.textureBottom( tmpImg.image() );

          // tmpImg.image().filter(INVERT);
        tmpBox.textureBack( tmpImg.image() );

          tmpImg.image().filter(GRAY);
        tmpBox.textureLeft( tmpImg.image() );

          tmpImg.image().filter(INVERT);
        tmpBox.textureRight( tmpImg.image() );


      } else {

      //  assign HBox texture
      tmpBox.texture(tmpImg.image());
      //  TODO: expand to setting individual textures per box side ( )
        
      }

      //  drop it in the pool
      pool.add( tmpBox );
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


 // pointLight(255, 51,  0,    0, height/2, -300); // orange
 // pointLight(0,  149, 168,  width, height/2, -300); // teal
 // pointLight(255, 204,  0, width/2, height/2, -400); // yellow

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

// TODO: GET MASKING CODE WORKING
// bgImg.filter(DILATE);
// bgImg.filter(ERODE);
// bgImg.filter(INVERT);
// bgImg.filter(GRAY);
bgImg.filter(POSTERIZE,4);
//  FINAL FRAME IS PRETTY SKETCH ATM

        //  MASK
        tmpSlice.mask(bgImg);
        tmpSlice.mask(mainImg);

    }catch(Exception exc ){
      println("EXCEPTION: "+ exc.getMessage());
    }

    //  give it back to HYPE
    // H.add(new HImage(mainImg));
    H.add(new HImage(tmpSlice));

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

  if(saveFinal) save( SAVE_NAME+"_FINAL"+SAVE_TYPE );    //  USE .TIF IF COLOR  
}


void doExit(){
    //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}