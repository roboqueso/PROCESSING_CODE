/*
EXPORT HYPE TO OBJ TEST

DON'T F WITH LOGIC, JUST GET EXPORT WORKING

*/
// import processing.opengl.*;
// import processing.dxf.*;

import nervoussystem.obj.*;

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import fixlib.*;



/* ------------------------------------------------------------------------- */

/* ------------------------------------------------------------------------- */
String SAVE_NAME = "thisShouldBeDynamic"; //  MC HAMMER
String SAVE_TYPE = ".png"; //".tif";1

int MODE = 1; // 1-3
String SRC_FILE;  // image names get pulled from imgs
int numSides = 8; // MIN = 3
int mxNumSides = 11; //7;
int colCt = 8;  //  HCylinder NOTE : only follow curated from mode1 engine sizes > 5, 6, 8, 10
float sw = PI;

//  NOTE: This script now runs off of imgs[] to allow for multi-source image support
// String[] imgs = {"j1.png", "j2.png", "j3.png","j4.png", "j5.png"}; // used for debug, should give you wireframes
String[] imgs = { "" };

// TODO: run all modes
/*
String[] imgs = { 
"PQRASST.0041.jpg",
"PQRASST.0031.jpg",
"PQRASST.0061.jpg",
"A100ASST.0101.jpg",
"XYZASST.0041.jpg",
"PQRASST.0123.jpg",
"VWXLQTZ.0162.jpg",
"A100ASST.0081.jpg",
"A100ASST.0111.jpg",
"12PTQT.004.JPG",
"12PTQT.005.JPG",
"WFNT.0032.jpg"
};
*/


/* ------------------------------------------------------------------------- */
Fixlib fix = Fixlib.init(this);
int cSides = (int)(180/numSides);//(int)(360/numSides); NOTE : mode 1 can't handle 360/numSides
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
    pixelDensity(displayDensity());
    smooth(8);  //  smooth() can only be used in settings();
}

/* ------------------------------------------------------------------------- */
void setup() {
  background(-1);

  hint(ENABLE_OPTIMIZED_STROKE);
  hint(ENABLE_STROKE_PERSPECTIVE);
  hint(ENABLE_TEXTURE_MIPMAPS);
  hint(ENABLE_STROKE_PURE);
  // these hints fix HCylinder.noFill()
  if(fixNoFill)hint(ENABLE_DEPTH_SORT);

  //  init HYPE
  H.init(this).background(-1).use3D(true).autoClear(true);

  //  be safe
  if(colCt<2)colCt=2;

  //  init VARIABLES
  drawW = (int) ( TARGETW/colCt  );


  //  ROTATE MODE
      switch (MODE) {
        case 1:
          // drawW *= .87;
          colSpacingX = drawW;
          colSpacingY = drawW;
          drawZ = H.CENTER;
          
          // NOTE : mode 1 can't handle 360/numSides
          // cSides = numSides;  //(int)(120/numSides);
          cSides = (int)(160/numSides);
          // cSides = (int)(270/numSides);

          // NOTE: mode 1 currently looks the same for ALL numSides, so just MAX it out
          // numSides = mxNumSides;
        break;

        case 2:
          colSpacingX = drawW*.96;
          colSpacingY = drawW;
 
          drawZ = TARGETH/TWO_PI;
        break;

        case 3:
          colSpacingX = drawW;
          colSpacingY = drawW;
          drawZ = drawW;
          cSides = (int)(180/numSides);
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

  if(SRC_FILE!=""){
    try{
      srcImg = loadImage(SRC_FILE);
      srcImg.resize(TARGETW, TARGETH);

    } catch( Exception e){
      // be safe in case SRC_FILE doens't load
      println("LOADER: "+e);
      srcImg = null;
    }
  } else {
    //  If srcImg doesn't load, hard code strokeWeight so you still see output
    sw=(sw==0)?HALF_PI:sw;
  }


    pool = new HDrawablePool(colCt*colCt);
 
    hgl = new HGridLayout()
      .cols(colCt)
      .rows(colCt)
      .startLoc(gridX, gridY) 
      .spacing( colSpacingX, colSpacingY, drawZ  );

  pool.autoAddToStage();

  //  SLICE IT UP
println("sides() in DEBUG MODE!!");


  //  create box to hold slice
  tmpB = new HCylinder();
        tmpB
        	.sides( cSides )
          .drawBottom(false)
          .drawTop(false)
          .topRadius(QUARTER_PI)
          .bottomRadius(sqrt(colCt/PI))
          .anchorAt(H.CENTER)
          .width(drawW).height(drawW);

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

// debug
println("run(): "+  pool.currentIndex() );

      			//	ADD FORMATTING AND PIZAZZ HERE
      			if(srcImg!=null)
      			{
      				// HACK : .texture() works here NOT above
              tmpImg = srcImg.get( (int)tmpB.x(),  (int)tmpB.y(),  (int)(drawW),  (int)(drawW) );

      				// if(pool.currentIndex()%2==0) tmpImg.filter(INVERT);

        	    tmpB.texture(tmpImg);

              if(sw >0 )
              {
                //  Grab color from the current tmpImg
                sClr = tmpImg.get( (int) random(tmpImg.width/2), (int)random(tmpImg.height/2) );
                //  stroke it
                tmpB.strokeSides(true).strokeWeight(sw).stroke( sClr );
              }
      			}
      			else
      			{
              sClr = 0;
              //  stroke it
              tmpB.strokeSides(sw>0).strokeWeight(sw).stroke( sClr );
      			}



          //  ROTATE MODE
          switch (MODE) {
            case 1:
              	tmpB.depth(drawW).z(drawZ).rotationX(90).rotationY(90*(numSides*pool.currentIndex()));
            break;

            case 2:
                  
              if(pool.currentIndex()%2==0)
                tmpB.depth(drawW).z(drawZ).rotationZ(15*(numSides*pool.currentIndex()));
              else
                tmpB.depth(drawW).z(drawZ).rotationZ(15*-(numSides*pool.currentIndex()));
            break;

            case 3:
              	if(pool.currentIndex()%2==0)
                  tmpB.depth(drawW).z(drawZ).rotation((numSides*colCt)*PI);
                else
                  tmpB.depth(drawW).z(drawZ).rotation(-(numSides*colCt)*PI);
            break;

            default :
            println("unknown MODE: "+  MODE);

            break;  
          }

        }
    }
  );


  // EF stamp
  String msg = "ERICFICKES.COM";
  HText lbl = new HText( msg, 24, createFont("Impact", 24) );
  if(srcImg!=null)
  	sClr = srcImg.get( (int)random(srcImg.width), (int)random(srcImg.height) );
  else
  	sClr = 0;

    //  LEFT
    // lbl.fill(sClr).anchorAt(H.LEFT).loc( colCt, TARGETH-textAscent(), drawZ*2 );
	  //  CENTERED
	  lbl.fill(sClr).anchorAt(H.CENTER).loc( (TARGETW/2), TARGETH-textAscent(), drawZ*2 );

  H.add(lbl);

}





/* ------------------------------------------------------------------------- */
void draw() {

println("nervoussystem.obj.OBJExport >>>>>>>>>>>>>>>>>>>>>");
beginRecord("nervoussystem.obj.OBJExport", SAVE_NAME+".obj");

clear();
noStroke();
lights();
camera();
ortho();

  pool.requestAll();

// debug
println("H.drawStage()! " + SRC_FILE + " : " + imgIdx +" : "+ (imgs.length-1) +" : "+ numSides +" : "+ mxNumSides );

//  BEGIN RECORD
// println("beginRaw");
// beginRaw( DXF, SAVE_NAME +".dxf" );


  H.drawStage();


  if(srcImg!=null){
    //  NOTE: if image() isn't dropped here, font background is color, not image()
    // font bg hack
    image(srcImg,0,0);

println("no more masking action, just flip the script");
/*
    //  p5 on osx isn't masking????
    tmpImg = get(0,0, TARGETW, TARGETH );
    tmpImg.resize( TARGETW, TARGETH );
    tmpImg.filter(GRAY);
    tmpImg.filter(INVERT);

    try{
  		tmpImg.mask(srcImg);
  		srcImg.mask(tmpImg);  
    } catch(Exception e){

      println("MASKER: "+e);
    }
*/
  // FLIP THE SCRIPT
  translate(TARGETW/2, TARGETH/2, 0);
    scale(-1, -1);
    image(srcImg,-TARGETW/2, -TARGETH/2, TARGETW, TARGETH);
  } 


  //  SAVE EXPORT
  // endRaw();
  endRecord();

//  SAVE PNG      
      save( SAVE_NAME+SAVE_TYPE );


    if( imgIdx == imgs.length-1 && numSides == mxNumSides){
      doExit();
    } else {
      cleanup();
       
      //  incrementer
      if(numSides < mxNumSides)
        numSides++;
      else
      {
        numSides = baseNumSides; // reset
        imgIdx++; // next image
      }

      //  restart sketch
      setup();
    }

}

//  GC HELPER
void cleanup(){
      //  MAKING ART WITH GARBAGE
    H.clearStage();
    pool.drain();
    clear();
    tmpB = null;
    srcImg = null;
    tmpImg = null;
    fix = null;
    pool = null;
    hgl = null;
    background(-1);
}




/* ------------------------------------------------------------------------- */
/*  NON - P5 BELOW  */
/* ------------------------------------------------------------------------- */

/**
  End of sketch closer
*/
void doExit(){

  save( SAVE_NAME+SAVE_TYPE );    //  USE .TIF IF COLOR  

  noLoop();
  cleanup();
  exit();
  System.exit(1);
}
