/*
DBP_HTG = Double Brother Programmer _ HTileGamer  : take an image and slice into a slide game

TODO: 

- DBP collab warmup exercise ( JBro is 40 )
- 1600x1600
- 40 columns
- 40 spacing?

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
String SAVE_TYPE = ".png";  // ".tif";


//  NOTE: bgImgFile is now the currently loaded mainImg
// String bgImgFile = "yellow.png";  //  Background and final frame mask source

//  NOTE: This script now runs off of imgs[] to allow for multi-source image support
//  BG image is still static ATM
String[] imgs = { 
  "1105181739_HDR.png",
"31072808_1696208240499157_595604027132084224_n.png",
"31479083_194491831181308_9001346902238691328_n.png",
"31556541_247711505975550_582329545940533248_n.png",
"31687039_212631472849944_8365292739968892928_n.png",
"31928344_2182387455119621_6067759740853682176_n.png",
"31988241_2134981873392406_420650119172456448_n.png",
"32070087_236587906951284_2817059536093839360_n.png",
"33437799_170936116935358_4004192899049717760_n.png",
"33854635_180741109302577_5728555644861022208_n.png",
"34909436_1851943948441225_1084318193851301888_n.png",
"35998568_208815186410004_8287469135156215808_n copy.png",
"37531110_1821332557974573_4104769574149292032_n copy.png",
"37827983_285189088907272_4267313371675623424_n.png",
"37845878_2031712867142328_8164740032356155392_n.png",
"38476234_1779974815390821_5559926827864031232_n.png",
"39051607_2141563766115550_3848291491784949760_n.png",
"39232782_217415815797338_7188576287613517824_n.png",
"39361458_1922919411101445_2032897103113486336_n.png",
"40011264_313892282498243_2485700905964362307_n.png",
"40525653_1861769830798809_5902229266213932991_n.png",
"41632019_1112225808935718_2167177626454627288_n.png",
"41729497_246684622711092_4148039929102666660_n.png",
"41837591_482185818935400_1476219301125118940_n.png",
"42003433_272311743403990_5289754078164690032_n.png",
"42521432_2138024223131066_6090490027188122268_n.png",
"42569021_551058805337432_1460685744538500959_n.png",
"42727530_528811540863628_2433517337225997818_n.png",
"43051262_317821839007888_8508907820087643336_n.png",
"43820604_332319867578445_88187674726571710_n.png",
"43914940_125923755060549_2443048337172945731_n.png",
"44589490_326552867895178_1394337883709928185_n.png",
"BROKEN_GLASS.png",
"HONEY_COMB_SPIRAL.png",
"imagejpeg_0.png",
"tester.png"
  };


boolean saveFrame = true;
boolean saveLast = false; // NOTE: this switch is hit or miss depending on your source image.
boolean stroke = false;	//	stroke the box

//  MODES
// boolean p5Filters = false;
// boolean rotateTiles = false;

// boolean p5Filters = true;
// boolean rotateTiles = false;

// boolean p5Filters = false;
// boolean rotateTiles = true;

boolean p5Filters = true;
boolean rotateTiles = true;
//  END MODES

//  NOTE : each of these rotate vars require rotateTiles = true
boolean diamond = false;

boolean rotateWacky = false;  // requires rotateTiles = true
boolean rotateX = false;  // Rotates each tile's X axis
boolean rotateY = false;  // Rotates each tile's Y axis
boolean rotateZ = false;  // Rotates each tile's Z axis




int frmCt = 1;//  2, 4, 8, 16  //7;  //  NOTE: saving starts @ 0.  7 gets you 8 frames and 1 FINAL
int colCt = 8;//  2, 4, 8, 16
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
HBox tmpBox;

int imgIdx = 0;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    //  For best results, change size() to match dimensions of mainImgFile
    size(1600, 1600, P3D);
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

  //  Generate filename containing sketch settings meta NOW
  //  NOTE: SUB STATEMENTS PAST rotateTiles
  SAVE_NAME = imgs[imgIdx] + "" +colCt+"x"+colSpacing + (p5Filters ? "P5F": "" )+ (rotateTiles ? "ROTATE" + (rotateWacky ? "WACKY": "" )
               + (rotateX ? "rX": "" ) + (rotateY ? "rY": "" ) + (rotateZ ? "rZ": "" ) : "" ) +  (diamond ? "DMND": "" ) ;

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
      //  get image slice
      tmpImg = new HImage( mainImg.get( (drawW*col), (drawH*row), drawW, drawH) );
      tmpImg.anchorAt(H.CENTER);
      
      //  create box to hold slice
      tmpBox = new HBox();
      tmpBox.width(drawW).height(drawH);
      tmpBox
        .depth( drawW+drawH )
        .z( random( -drawW, drawW ) * (colSpacing+colCt+col+row) );

        if(stroke)
        {

    			tmpBox.stroke( (int)(drawW*col*TWO_PI)%255, 
    							(int)(drawH*col*PI)%255, 
    							(int)(colSpacing+colCt+col+row*TWO_PI)%255 );
        }
        else 
        {
        	tmpBox.noStroke();
        }


//  general rotation
    if( !rotateX && !rotateY && !rotateZ ){
      tmpBox.rotation( rotateWacky ? ( (row+col)*random(15,90) ) : (90* (row+col) ) );
    }

    //  individual axis rotations
    if(rotateX) tmpBox.rotationX( rotateWacky ? ( (row+col) * random(5,150) ) : (90 * random(4)+(row+col) ) );
    if(rotateY) tmpBox.rotationY( rotateWacky ? ( (row+col) * random(5,150) ) : (90 * random(4)+(row+col) ) );
    if(rotateZ) tmpBox.rotationZ( rotateWacky ? ( (row+col) * random(5,150) ) : (90 * random(4)+(row+col) ) );



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

        if(rotateTiles && diamond){

        	tmpBox
            .rotationX(135)
        	 .rotationY(135);


        }else if(rotateTiles && !diamond){

              //  general rotation
              if( !rotateX && !rotateY && !rotateZ ){
                tmpBox.rotation( rotateWacky ? ( pool.currentIndex()*random(15,90) ) : (90* pool.currentIndex() ) );
              }

              //  individual axis rotations
              if(rotateX) tmpBox.rotationX( rotateWacky ? ( pool.currentIndex() * random(5,150) ) : (90 * random(4)+pool.currentIndex() ) );
              if(rotateY) tmpBox.rotationY( rotateWacky ? ( pool.currentIndex() * random(5,150) ) : (90 * random(4)+pool.currentIndex() ) );
              if(rotateZ) tmpBox.rotationZ( rotateWacky ? ( pool.currentIndex() * random(5,150) ) : (90 * random(4)+pool.currentIndex() ) );

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

    // translate( gridX, gridY, frameCount );
    rotateX(-HALF_PI/PI);
    rotateY(-HALF_PI/TWO_PI);

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

  bgImg.filter(INVERT);
  bgImg.filter(OPAQUE);
  
  mainImg.filter(INVERT);
  mainImg.filter(OPAQUE);

//  FINAL FRAME IS PRETTY SKETCH ATM

        //  MASK
        tmpSlice.mask(bgImg);
        tmpSlice.mask(mainImg);

    }catch(Exception exc ){
      println("EXCEPTION: "+ exc.getMessage());
    }

    //  give it back to HYPE
    H.add(new HImage(tmpSlice));
    H.clearStage();

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