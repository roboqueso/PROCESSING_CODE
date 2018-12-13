/*
AllCylinders - roots from DiamondMode, now with more fixes and ONLY HCylinder


*/
import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import fixlib.*;

import javafx.scene.canvas.*;
import javafx.scene.effect.*;
import javafx.scene.paint.*;
import javafx.scene.shape.*;
import javafx.scene.text.*;

/* ------------------------------------------------------------------------- */

/* ------------------------------------------------------------------------- */
String SAVE_NAME = "thisShouldBeDynamic"; //  MC HAMMER
String SAVE_TYPE = ".png";  //".tif";1
int MODE = 3; //   1 - 3
String SRC_FILE;  // image names get pulled from imgs


//  NOTE: This script now runs off of imgs[] to allow for multi-source image support
//  BG image is still static ATM
String[] imgs = { 
"e2.png",
"e3.png",
"e4.png",
"e5.png",
"e6.png",
"e7.png",
"e8.png",
"e9.png",
"e10.png",
"e11.png",
"e12.png",
"e13.png",
"e14.png",
"e15.png",
"e16.png",
"e17.png",
"e18.png",
"e19.png",
"e20.png",
"e1.png",
"e21.png",
"e22.png",
"e23.png",
"e24.png",
"e25.png",
"e26.png",
"e27.png",
"e28.png",
"e29.png",
"e30.png",
"e31.png",
"e32.png",
"e33.png",
"e34.png",
"e35.png",
"e36.png",
"e37.png",
"e38.png",
"e39.png",
"e40.png",
"e41.png",
"e42.png",
"e43.png"
};

int numSides = 6; // MIN = 3
int mxNumSides = 8;
int colCt = 10;  //  HCylinder NOTE : only follow curated from mode1 engine sizes > 5, 6, 8, 10
float sw = 1;



/* ------------------------------------------------------------------------- */
Fixlib fix = Fixlib.init(this);

boolean fixNoFill = true; //  switch to make noFill() work and give the wireframe effect on HCylinder
float drawZ;
int imgIdx = 0; // multi image indexer
int baseNumSides = numSides; // MC HAMMER - this MUST equal numSides for multi image support to work
int rowCt = colCt;  //  Maintains even 1:1 grid
HDrawablePool pool;
HGridLayout hgl;
HCylinder tmpB;
float colSpacingX,colSpacingY;
float drawW, gridX, gridY;
color sClr;
PImage srcImg, tmpImg;

//  NOTE: Processing on OSX and PC have different interpretations of dimensions
int TARGETW = 1600;
int TARGETH = 1600;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    size( 1600, 1600, P3D);
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */
void setup() {

  background(H.CLEAR);
  noFill();

  // blendMode(SUBTRACT);

  // these hints fix HCylinder.noFill()
  if(fixNoFill)hint(ENABLE_DEPTH_SORT);
  //  be safe
  if(colCt<2)colCt=2;

  //  init VARIABLES
  drawW = (int) ( TARGETW/colCt  );
  // drawW *= .85;

  //  ROTATE MODE
      switch (MODE) {
        case 1:
          colSpacingX = drawW;  //(drawW * 1.41);
          colSpacingY = drawW;  //(drawW * 1.63 );
          drawZ = H.CENTER; //drawW;
        break;

        case 2:
          colSpacingX = drawW *  HALF_PI;
          colSpacingY = drawW / HALF_PI;  //HALF_PI;
 
          drawZ = drawW;//TARGETH/TWO_PI;
        break;

        case 3:
          colSpacingX = drawW*.65;
          colSpacingY = drawW*.65;
          drawZ = H.CENTER;
        break;

        case 4:
        break;

        case 5:
        break;

        case 6:
        break;
    
    case 7:
    break;

        default :
          println("unknown MODE: "+  MODE);

        break;  
      }

  //  center HGL
  gridX = (int) ( (TARGETW/2) - (((colCt-1)*colSpacingX)/2) );
  gridY = (int) ( (TARGETW/2) - (((colCt-1)*colSpacingY)/2) );

  // multi image support : set current image
  SRC_FILE = imgs[imgIdx];

  //  Generate filename containing sketch settings meta NOW
  SAVE_NAME = SRC_FILE + "_m"+MODE + "_s"+numSides + ((sw>0)?"sw"+sw:"") + (fixNoFill?"":"_F") + "_"+ colCt;

// if(srcImg==null){
  if(SRC_FILE!=""){
    try{
      srcImg = loadImage(SRC_FILE);
      srcImg.resize(TARGETW, TARGETH);
// debug note
// println("DISABLED image("+SRC_FILE+") call");
      image(srcImg,0,0);
    } catch( Exception e){
      // be safe in case SRC_FILE doens't load
      println("LOADER: "+e);
      // SRC_FILE ="";
      srcImg = get(0,0,TARGETW, TARGETH);
      // sw=(sw<=0)?HALF_PI:sw;
    }
  } else {
    //  If srcImg doesn't load, hard code strokeWeight so you still see output
    sw=(sw<=0)?HALF_PI:sw;
  }
// }

  //  init HYPE
  H.init(this).background(H.CLEAR).use3D(true).autoClear(true);

  pool = new HDrawablePool(colCt*colCt);
  
    hgl = new HGridLayout()
      .cols(colCt)
      .rows(colCt)
      .startLoc(gridX, gridY) 
      .spacing( colSpacingX, colSpacingY, drawZ  );

  pool.autoAddToStage();

  //  SLICE IT UP

  //  create box to hold slice
  tmpB = new HCylinder();

  tmpB.width(drawW).height(drawW);

  if(SRC_FILE!=""){
    //  OUTER ROW LOOP ( t - b ) 
    for( int row = 0; row < rowCt; row++)
    {
      //  INNER COLUMN LOOP ( l-r )  
      for( int col = 0; col < colCt; col++)
      {
        //  get image slice
        // tmpImg = srcImg.get( (int)(drawW*col),  (int)(drawW*(row+col)),  (int)drawW,  (int)drawW);
        tmpImg = get( (int)(drawW*col),  (int)(drawW*(row+col)),  (int)drawW,  (int)drawW);

        // debug
        if(col%colCt==0)tmpImg.filter(INVERT);
/// NOTE: tmpImg isn't working
//  texture(tmpImg) shows white
//  sClr below is always white
        //  same 
        tmpB.sides(numSides)
            .texture(srcImg)  //  HACK
            .drawBottom(false)
            .drawTop(false)
            .topRadius(HALF_PI)
            .bottomRadius(sqrt(colCt/PI));

            // .topRadius(sqrt(drawW/colCt))
            // .bottomRadius(sqrt(drawW/PI));

        if(sw >0 )
        {
          //  Grab color from the current tmpImg
          sClr = get( (int)random(tmpImg.width), (int)random(tmpImg.height) );
          //  stroke it
          tmpB.strokeSides(true).strokeWeight(sw).stroke( sClr );
// debug
println("sClr: "+sClr);
        }

      }
    }
  } else {
        tmpB.sides(numSides)
            .drawBottom(false)
            .drawTop(false)
            .topRadius(sqrt(drawW/TWO_PI))
            .bottomRadius(sqrt(drawW/PI));

        if(sw >0 )
        {

          //  stroke it
          tmpB.strokeSides(true).strokeWeight(sw).stroke( 0 );
        }

  }


  //  drop it in the pool
  pool.add( tmpB );

  tmpB = null;
  tmpImg = null;
  sClr = -1;

  pool
    .layout ( hgl )
    .onCreate(
      new HCallback() {
          public void run(Object obj) 
          {
          tmpB = (HCylinder) obj;

          //  ROTATE MODE
          switch (MODE) {
            case 1:
              tmpB.depth(drawW).z(drawZ).rotationY(90).rotationZ(90);
            break;

            case 2:
                tmpB.depth(drawW).z(drawZ).rotationX(90).rotationZ(45);
            break;

            case 3:
              tmpB.depth(drawW/HALF_PI).z(drawZ).rotationX(90);
            break;

            case 4:
            break;

            case 5:
            break;

            case 6:
            break;

            case 7:
            break;

            default :
            println("unknown MODE: "+  MODE);

            break;  
          }

        }
    }
  );




}





/* ------------------------------------------------------------------------- */
void draw() {

  // EF stamp
  String msg = "ERICFICKES.COM";
  HText lbl = new HText( msg, 43, createFont("Silom", 43) );
  sClr = srcImg.get( (int)(srcImg.width/2), (int)(srcImg.height/2) );
  lbl.fill(sClr).anchorAt(H.CENTER).loc( (TARGETW/2), TARGETH-textAscent(), drawW+drawZ );

  H.add(lbl);

  pool.requestAll();

  ortho();
  H.drawStage();

  if(SRC_FILE!=""){
    //  NOTE: if image() isn't dropped here, font background is color, not image()
    // font bg hack
    image(srcImg,0,0);

    //  p5 on osx isn't masking????
    tmpImg = get();
    tmpImg.resize( TARGETW, TARGETH );
    tmpImg.filter(GRAY);

    try{
      srcImg.mask(tmpImg);  
      tmpImg.mask(srcImg);
    } catch(Exception e){

      println("e: "+e);
      println("tmpImg.width : " + tmpImg.width +", "+ tmpImg.height );
      println("srcImg.width : " + srcImg.width +", "+ srcImg.height );
    }

  // FLIP THE SCRIPT
  translate(TARGETW/2, TARGETH/2, 0);
    scale(-1, -1);
    image(srcImg,-TARGETW/2, -TARGETH/2, TARGETW, TARGETH);


  } 

//debug
// stroke(#EF2018);
// line(width/2, 0, width/2, height);

//  TODO : looking to find the perfect numSides
    if( imgIdx == imgs.length-1 && numSides == mxNumSides){
      doExit();
    } else {
      save( SAVE_NAME+SAVE_TYPE );
      //  MAKING ART WITH GARBAGE
      tmpB = null;
      srcImg = null;
      tmpImg = null;
      H.clearStage();
      pool.drain();
      fix = null;
      pool = null;
      hgl = null;

      background(H.CLEAR);
      
      //  incrementer
      if(numSides < mxNumSides)
        numSides++;
      else
      {
        numSides = baseNumSides; // reset
        imgIdx++; // next image
      }

      //  restar sketch
      setup();
    }

}







/* ------------------------------------------------------------------------- */
/*  NON - P5 BELOW  */
/* ------------------------------------------------------------------------- */

/**
  End of sketch closer
*/
void doExit(){

  save( SAVE_NAME+SAVE_TYPE );    //  USE .TIF IF COLOR  

    //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}


