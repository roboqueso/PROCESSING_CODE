/*
DBP_HTG = Double Brother Programmer _ HTileGamer  : take an image and slice into a slide game

TODO: 

- DBP collab warmup exercise ( JBro is 40 )

- BUG : diamond most isn't completely right


- this sketch is about to be scrapped

- run Salidas through PS actions, then bring back for dicing

*/

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import fixlib.*;

/* ------------------------------------------------------------------------- */

/* ------------------------------------------------------------------------- */
String SAVE_NAME = "thisShouldBeDynamic"; //  MC HAMMER
String SAVE_TYPE = ".tif";  //".tif";


//  NOTE: bgImgFile is now the currently loaded mainImg
// String bgImgFile = "yellow.png";  //  Background and final frame mask source

//  NOTE: This script now runs off of imgs[] to allow for multi-source image support
//  BG image is still static ATM
String[] imgs = { 
"gm68.png",
"gm3.png",
"gm33.png",
"gm52.png",
"gm1.png",
"gm66.png",
"gm40.png",
"gm12.png",
"gm18.png",
"gm54.png",
"gm0.png",
"gm62.png",
"gm46.png",
"gm37.png",
"gm20.png",
"gm34.png",
"gm50.png",
"gm7.png",
"gm71.png",
"gm53.png",
"gm72.png",
"gm4.png",
"gm56.png",
"gm60.png",
"gm64.png",
"gm38.png",
"gm44.png",
"gm5.png",
"gm30.png",
"gm32.png",
"gm6.png",
"gm48.png",
"gm13.png",
"gm70.png",
"gm22.png",
"gm49.png",
"gm47.png",
"gm63.png",
"gm9.png",
"gm59.png",
"gm51.png",
"gm61.png",
"gm16.png",
"gm69.png",
"gm36.png",
"gm29.png",
"gm27.png",
"gm41.png",
"gm67.png",
"gm65.png",
"gm26.png",
"gm35.png",
"gm31.png",
"gm43.png",
"gm55.png",
"gm15.png",
"gm57.png",
"gm10.png",
"gm39.png",
"gm17.png",
"gm8.png",
"gm19.png",
"gm24.png",
"gm2.png",
"gm21.png",
"gm23.png",
"gm42.png",
"gm45.png",
"gm25.png",
"gm14.png",
"gm11.png",
"gm28.png",
"gm58.png"
  };


boolean saveFrame = true;
boolean saveLast = true; // NOTE: this switch is hit or miss depending on your source image.
boolean stroke = false;	//	stroke the box

//  MODES
  // boolean p5Filters = false;
  // boolean rotateTiles = false;

  boolean p5Filters = false;
  boolean rotateTiles = true;

  // boolean p5Filters = true;
  // boolean rotateTiles = false;

  // boolean p5Filters = true;
  // boolean rotateTiles = true;
//  END MODES

  //  NOTE : each of these rotate vars require rotateTiles = true

// boolean diamond = true;
boolean diamond = false;


boolean rotateX = false;  // Rotates each tile's X axis
boolean rotateY = false;  // Rotates each tile's Y axis
boolean rotateZ = false;  // Rotates each tile's Z axis


int frmCt = 1;//  2, 4, 8, 16  //7;  //  NOTE: saving starts @ 0.  7 gets you 8 frames and 1 FINAL
int colCt = 4;//  2, 4, 8, 16
int colSpacing = 0;

/* ------------------------------------------------------------------------- */
boolean dOffset = false;  // helper for diamond mode
int rowCt = colCt;  //  Maintains even 1:1 grid
int drawW, drawH, gridX, gridY; // slice dimensions, grid position
PImage mainImg, bgImg, tmpSlice;

Fixlib fix = Fixlib.init(this);
HDrawablePool pool;
HImage tmpImg, bgHImg;  //  background image reference

HShape hShp;
PShape pShp;
HBox tmpBox;
HGridLayout hgl;
int imgIdx = 0;
color sClr;
/* ------------------------------------------------------------------------- */

void  settings ()  {
    //  For best results, change size() to match dimensions of mainImgFile
    size( 1200, 1200, P3D);
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */

void setup() {

  //  init VARIABLES
  if(diamond)
  {
    //  SQUARE BOXES
    drawW = (int) (width/rowCt);
    drawH = drawW;

    gridX = (int) (drawW/HALF_PI);
    gridY = (int) (drawH/HALF_PI);

  } else {
    drawW = (int)( (width/colCt)-colSpacing);
    drawH = (int)( (height/rowCt)-colSpacing);  

    gridX = (int) (drawW/2)+colSpacing;
    gridY = (int) (drawH/2)+colSpacing;
    // gridX = (int) (drawW/PI);
    // gridY = (int) (drawH/PI);
  }

  // NOTE: this might not work for NON DIAMOND


  mainImg = loadImage( imgs[imgIdx] );
  
//  hard coding ARTBUS as BG
  bgImg = loadImage( imgs[imgIdx] );  //  force load
  // bgImg = loadImage( "ART_BUS.png" ); //imgs[imgIdx] );  //  force load

  //  Generate filename containing sketch settings meta NOW
  //  NOTE: SUB STATEMENTS PAST rotateTiles
  SAVE_NAME = imgs[imgIdx] + "" +colCt+"x"+colSpacing + (p5Filters ? "P5F": "" )+ (rotateTiles ? "ROTA" + 
               (rotateX ? "rX": "" ) + (rotateY ? "rY": "" ) + (rotateZ ? "rZ": "" ) : "" ) +  ( diamond ? "DMND": "" ) ;

  //  init HYPE
  H.init(this).background(-1).use3D(true).autoClear(true);
  
  //  BACKGROUND IMAGE
  bgHImg = new HImage( bgImg );
  bgHImg.anchorAt(H.CENTER).loc(width/2, height/2).z(-drawW);
  H.add(bgHImg);
  
    //  NOTE : DO NOT USE bgImg anywhere past this line.  Use bgHImg instead
    bgImg = null;

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
      tmpBox.width(drawW).height(drawH).z(drawH+row+col);
		
		if(diamond)
	    {
	      tmpBox.depth( drawW+col+row );//.z( drawW+col+row ); //  random( -drawW, drawW ) + ( TWO_PI * (colSpacing+colCt+col+row) ) );
	    }
	    else 
	    {
	      tmpBox.depth(drawH+row+col).z(drawH+row+col);
	    }

        if(stroke)
        {
          //  Grab color from the current tmpImg
          sClr = mainImg.get( (drawW*col), (drawH*row) );
          //  stroke it
          tmpBox.stroke( sClr );
          tmpBox.strokeWeight(1);
        }
        else 
        {
        	tmpBox.noStroke();
        }


      //  APPLY Texture here
      if(p5Filters)
      {
        tmpBox.textureBottom( tmpImg.image() );
          tmpImg.image().filter(INVERT);
        tmpBox.textureTop( tmpImg.image() );
			tmpImg.image().filter(OPAQUE);
        tmpBox.textureFront( tmpImg.image() );


        tmpBox.textureLeft( bgHImg.image() );
			bgHImg.image().filter(OPAQUE);
        tmpBox.textureRight( bgHImg.image() );
        tmpBox.textureBack( bgHImg.image() );

      } else {

      //  assign HBox texture
      tmpBox.texture(tmpImg.image());
        
      }


      //  drop it in the pool
      pool.add( tmpBox );
    }
  }

  //  adjust Grid Layout     
  if(diamond)
  {
    hgl = new HGridLayout()
    .startLoc(gridX, gridY)
    .spacing( drawW*.8, drawH, 0 )
    .cols(colCt)
    .rows(rowCt);
  } 
  else
  {
    hgl = new HGridLayout()
    .startLoc(gridX, gridY)
    .spacing( drawW+colSpacing, drawH+colSpacing, colSpacing )
    .cols(colCt)
    .rows(rowCt);
  }
  

  pool
      .layout ( hgl )
      .onCreate(
         new HCallback() {
          public void run(Object obj) {
           
           tmpBox = (HBox) obj;

//  TODO: figure out better offsetter
          // diamond row off setter
          if( ( pool.currentIndex()>1) &&  pool.currentIndex()%colCt==0){
            dOffset = !dOffset;
          }

        if(diamond){


          tmpBox
              .rotationX(45)
              .rotationY(45);

              if(dOffset){
                // tmpBox.x( tmpBox.x() + (drawW/PI) );
                // tmpBox.y( tmpBox.y() + (drawH/HALF_PI) );
              }

        } else if(rotateTiles){

              //  general rotation
              if( !rotateX && !rotateY && !rotateZ ){
                tmpBox.rotation( 90* pool.currentIndex() );
              }

              //  individual axis rotations
              if(rotateX) tmpBox.rotationX( 90 * pool.currentIndex() );
              if(rotateY) tmpBox.rotationY( 90 * pool.currentIndex() );
              if(rotateZ) tmpBox.rotationZ( 90 * pool.currentIndex() );

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

  
  if(p5Filters)
  {
    // NOTE: this section is kind of ok, not super dope

    ortho();
    rotateX(HALF_PI/PI);
    // rotateY(-HALF_PI/PI);


  } else {
    perspective();
  }

  H.drawStage();

  //  save frame
  if(saveFrame){
    stampAndSave(false);
    saveFrame( SAVE_NAME + "##"+SAVE_TYPE);  //  USE .TIF IF COLOR
  }

  pool.drain();

  //  Move to next image every time frameCount HITS the "(frmCt)"th mark
  if(frameCount%frmCt==0) {

    perspective();

    //  FINAL FRAME
    //  Grab images, do some magic, clear stage, slap down final frame

    //  get stage
    tmpSlice = null;
    tmpSlice = get(0,0, width,height);
    

    //  resize for masking
    mainImg.resize(width,height);
    bgHImg.image().resize(width,height);
    tmpSlice.resize(width,height);

    try{

// TODO: GET MASKING CODE WORKING  
  mainImg.filter(INVERT);
  mainImg.filter(OPAQUE);

//  FINAL FRAME IS PRETTY SKETCH ATM

        //  MASK
        tmpSlice.mask(bgHImg.image());
        tmpSlice.mask(mainImg);

    }catch(Exception exc ){
      println("EXCEPTION: "+ exc.getMessage());
    }

    //  give it back to HYPE
    tmpImg = new HImage(tmpSlice);
    H.add(tmpImg);
    H.clearStage();

    //  NO grid, just the final frame image
    H.drawStage();
    stampAndSave(saveLast);


    if(imgIdx < imgs.length-1 )
    {
      imgIdx++;

      //  fully reset stage before calling setup()
      H.remove(bgHImg);
      H.remove(tmpImg);
      H.clearStage();

      mainImg = null;
      bgHImg = null;
      tmpImg = null;
      tmpSlice = null;

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

  textFont( createFont("Bitwise", 43));

  // sClr = get( width/2, height/2 );
  // //  fill color from image
  // fill( sClr );
  fill( #242424 );

  textSize(36);
  //  OG BOTTOM RIGHT STAMP
  //text(msg, width-(textWidth(msg)+textAscent())+24, height-textAscent()+24);
  //  NEW RIGHT VERTICAL STAMP
  textAlign(CENTER,BOTTOM);
  pushMatrix();
    translate(width-TWO_PI, (height/2));
    rotate(-HALF_PI);
    text(msg,0,0);
  popMatrix();



  if(saveFinal) save( SAVE_NAME+"_FNL"+SAVE_TYPE );    //  USE .TIF IF COLOR  
}


void doExit(){
    //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}