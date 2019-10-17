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
  "fs14 copy.png",
"fs16 copy 2.png"
  };
  /*
"fs16 copy.png",
"fs19 copy 3.png",
"fs19.png",
"fs20 copy 2.png",
"fs23 copy 2.png",
"fs23 copy 3.png",
"fs23.png",
"fs28 copy 2.png",
"fs28 copy 3.png",
"fs3 copy 3.png",
"fs3 copy.png",
"fs3.png",
"fs31 copy 3.png",
"fs31 copy.png",
"fs31.png",
"fs39 copy 2.png",
"fs39 copy.png",
"fs39.png",
"fs40 copy.png",
"fs40.png",
"fs41 copy.png",
"fs42 copy 2.png",
"fs42 copy.png",
"fs44 copy 2.png",
"fs44 copy 3.png",
"fs44 copy.png",
"fs44.png",
"fs45 copy 2.png",
"fs46.png",
"fs49 copy 2.png",
"fs49 copy 3.png",
"fs49 copy.png",
"fs49.png",
"fs52 copy.png",
"fs54 copy.png",
"fs60 copy 3.png",
"fs60.png",
"fs68 copy 2.png",
"fs68 copy 3.png",
"fs68 copy.png",
"fs68.png",
"fs74 copy 2.png",
"fs74 copy 3.png",
"fs74 copy.png",
"greens1 copy.png",
"greens1.png",
"greens12 copy.png",
"greens12.png",
"greens13 copy.png",
"greens13.png",
"greens14 copy.png",
"greens15.png",
"greens16 copy.png",
"greens16.png",
"greens2 copy.png",
"greens2.png",
"greens20 copy.png",
"greens20.png",
"greens3 copy.png",
"greens3.png",
"greens4 copy.png",
"greens4.png",
"greens5 copy.png",
"greens5.png",
"greens7 copy.png",
"greens7.png",
"greens8 copy.png",
"greens8.png",
"greens9 copy.png",
"localTestlow copy 10.png",
"localTestlow copy 11.png",
"localTestlow copy 12.png",
"localTestlow copy 14.png",
"localTestlow copy 18.png",
"localTestlow copy 19.png",
"localTestlow copy 2.png",
"localTestlow copy 20.png",
"localTestlow copy 21.png",
"localTestlow copy 22.png",
"localTestlow copy 23.png",
"localTestlow copy 24.png",
"localTestlow copy 25.png",
"localTestlow copy 26.png",
"localTestlow copy 27.png",
"localTestlow copy 9.png",
"localTestlow copy.png",
"localTestlow.png",
"merge1.png",
"merge2.png",
"pinks1 copy.png",
"pinks2 copy.png",
"pinks2.png",
"pinks3 copy.png",
"pinks3.png",
"pinks4 copy.png",
"pinks4.png",
"pinks6 copy.png",
"pinks6.png",
"pinks7 copy.png",
"pinks7.png",
"pinks8 copy.png",
"pinks8.png",
"pinks9 copy.png",
"pinks9.png",
"Texture0 copy 11.png",
"Texture0 copy 12.png",
"Texture0 copy 15.png",
"Texture0 copy 16.png",
"Texture0 copy 2.png",
"Texture0 copy 3.png",
"Texture0 copy 6.png",
"Texture0 copy 8.png",
"Texture11 copy 10.png",
"Texture11 copy 11.png",
"Texture11 copy 13.png",
"Texture11 copy 14.png",
"Texture11 copy 16.png",
"Texture11 copy 5.png",
"Texture11 copy 6.png",
"Texture11 copy 7.png",
"Texture11 copy 9.png",
"Texture14 copy 10.png",
"Texture15 copy 10.png",
"Texture15 copy 11.png",
"Texture15 copy 12.png",
"Texture15 copy 13.png",
"Texture15 copy 14.png",
"Texture15 copy 16.png",
"Texture15 copy 2.png",
"Texture15 copy 3.png",
"Texture15 copy 6.png",
"Texture15 copy 7.png",
"Texture15 copy 9.png",
"Texture4 copy 11.png",
"Texture4 copy 14.png",
"Texture4 copy 21.png",
"Texture4 copy 6.png",
"Texture5 copy 4.png",
"Texture7 copy 11.png",
"Texture7 copy 12.png",
"Texture7 copy 3.png",
"Texture7 copy 4.png",
"Texture7 copy 5.png",
"Texture7 copy 6.png",
"Texture7 copy 7.png",
"Texture7 copy 8.png",
"Texture7 copy 9.png",
"Texture8 copy 12.png",
"Texture8 copy 13.png",
"Texture8 copy 3.png",
"Texture8 copy 5.png",
"yellow11 copy.png",
"yellow13 copy.png",
"yellow13.png",
"yellow15 copy.png",
"yellow17 copy.png",
"yellow17.png",
"yellow18 copy.png",
"yellow18.png",
"yellow19 copy.png",
"yellow20 copy.png",
"yellow20.png",
"yellow21.png",
"yellow22 copy.png",
"yellow22.png",
"yellow23 copy.png",
"yellow23.png",
"yellow24 copy.png",
"yellow24.png",
"yellow26 copy.png",
"yellow26.png",
"yellow3 copy.png",
"yellow4 copy.png",
"yellow7 copy.png",
"yellow7.png"
  };
*/

boolean saveFrame = true;
boolean saveLast = true; // NOTE: this switch is hit or miss depending on your source image.

//  MODES
boolean p5Filters = false;
boolean rotateTiles = false;

// boolean p5Filters = true;
// boolean rotateTiles = false;

// boolean p5Filters = true;
// boolean rotateTiles = true;

// boolean p5Filters = false;
// boolean rotateTiles = true;
//  END MODES

//  NOTE : each of these rotate vars require rotateTiles = true
boolean rotateWacky = false;  // requires rotateTiles = true
boolean rotateX = false;  // Rotates each tile's X axis
boolean rotateY = false;  // Rotates each tile's Y axis
boolean rotateZ = false;  // Rotates each tile's Z axis


int frmCt = 2;//  2, 4, 8, 16  //7;  //  NOTE: saving starts @ 0.  7 gets you 8 frames and 1 FINAL
int colCt = 8;//  2, 4, 8, 16
int colSpacing = 2;
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
    size(2048, 2048, P3D);
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
  gridX = colSpacing*2;
  gridY = colSpacing*2;

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
  H.init(this).background(-1).use3D(true).autoClear(true);
  
  //  BACKGROUND IMAGE
  bgHImg = new HImage( bgImg );
  bgHImg.anchorAt(H.CENTER).loc(0,0);	//width/2, height/2);
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
        .depth( random( -drawW, drawW ) )
        .noStroke()
        .z( (int) ( random(-(colSpacing+colCt+col+row), (colSpacing+colCt+col+row) )) );


        //  ROTATE before adding to pool
        if(rotateTiles){

          //  general rotation
          if( !rotateX &&  !rotateY &&  !rotateZ ){
            tmpBox.rotation( rotateWacky ? ( pool.currentIndex()*random(15,90) ) : (90* pool.currentIndex() ) );
          }

          //  individual axis rotations
          if(rotateX) tmpBox.rotationX( rotateWacky ? ( pool.currentIndex()*random(4,345) ) : (90* random(4)+pool.currentIndex() ) );
          if(rotateY) tmpBox.rotationY( rotateWacky ? ( pool.currentIndex()*random(4,345) ) : (90* random(4)+pool.currentIndex() ) );
          if(rotateZ) tmpBox.rotationZ( rotateWacky ? ( pool.currentIndex()*random(4,345) ) : (90* random(4)+pool.currentIndex() ) );
        }


      //  APPLY Texture here
      if(p5Filters){

          tmpImg.image().filter(INVERT);
          tmpImg.image().filter(OPAQUE);
        tmpBox.textureFront( tmpImg.image() );
      	tmpBox.textureBack( tmpImg.image() );
        tmpBox.textureBottom( tmpImg.image() );

          bgImg.filter(INVERT);
          bgImg.filter(OPAQUE);
        tmpBox.textureLeft( bgImg );
        tmpBox.textureRight( bgImg );
        tmpBox.textureTop( bgImg );



      } else {

      //  assign HBox texture
      tmpBox.texture(tmpImg.image());
        
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
      )

      .onCreate(
         new HCallback() {
          public void run(Object obj) {
           
           tmpBox = (HBox) obj;

            //  ROTATE slice before putting in the pool?
            if(rotateTiles)
            {

              //  general rotation
              if( !rotateX && !rotateY && !rotateZ ){
                tmpBox.rotation( rotateWacky ? ( pool.currentIndex()*random(15,90) ) : (90* pool.currentIndex() ) );
              }

              //  individual axis rotations
              if(rotateX) tmpBox.rotationX( rotateWacky ? ( pool.currentIndex() * random(4,345) ) : (90 * random(4)+pool.currentIndex() ) );
              if(rotateY) tmpBox.rotationY( rotateWacky ? ( pool.currentIndex() * random(4,345) ) : (90 * random(4)+pool.currentIndex() ) );
              if(rotateZ) tmpBox.rotationZ( rotateWacky ? ( pool.currentIndex() * random(4,345) ) : (90 * random(4)+pool.currentIndex() ) );

            }




          }
         }
        );

}





/* ------------------------------------------------------------------------- */
void draw() {

  // Bernard Purdie would shuffle it
  // pool.shuffleRequestAll();
  pool.requestAll();

  //  rotate obj already known by HYPE
  bgHImg.rotateZ( (frameCount+1)*90);

  
  if(p5Filters){
    /*
    Sets an orthographic projection and defines a parallel clipping volume. 
    All objects with the same dimension appear the same size, regardless of whether 
    they are near or far from the camera. The parameters to this function specify the 
    clipping volume where left and right are the minimum and maximum x values, top and bottom 
    are the minimum and maximum y values, and near and far are the minimum and maximum z values. 

    If no parameters are given, the default is used: ortho(-width/2, width/2, -height/2, height/2).
    */
    // ortho(left, right, bottom, top, near, far);
    ortho();
    // translate(width/2, height/2, frameCount );
    rotateX(-HALF_PI/6);
    rotateY(-HALF_PI/6);
    rotateZ(radians(8));

  } else {
    perspective();
  }

  H.drawStage();

  //  save frame
  if(saveFrame){
    stampAndSave(false);
    saveFrame( SAVE_NAME + "_##"+SAVE_TYPE);  //  USE .TIF IF COLOR
  }

  pool.drain();

  //  Move to next image every time frameCount HITS the "(frmCt)"th mark
  if(frameCount%frmCt==0) {

    perspective();

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
bgImg.filter(POSTERIZE,8);
//  FINAL FRAME IS PRETTY SKETCH ATM

        //  MASK
        tmpSlice.mask(bgImg);
        tmpSlice.mask(mainImg);

    }catch(Exception exc ){
      println("EXCEPTION: "+ exc.getMessage());
    }

    //  give it back to HYPE
    H.add(new HImage(tmpSlice));

    //  NO grid, just the final frame image
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