/*
AllCylinders - roots from DiamondMode, now with more fixes and ONLY HCylinder

// TODO: confirm grid is equally centered across MODES 1, 2 and 3

// TODO: make smooth lines in P3D ( currently too jaggy )

// TODO: MOVE TO USING PGRAPHICS LIKE blending surface example online
// "The sketch has been automatically resized to fit the screen resolution"
//	Drawing to PGraphics allows control of output dimension

// BLEND = DEFAULT  so don't bother w/blendMode
// blendMode(DARKEST);
// blendMode(EXCLUSION);	//	NOTE: causes a grey cloudy almost real diamond effect
// blendMode(MULTIPLY);	//	makes things SUPER DARK to BLACK
// blendMode(REPLACE);	//	"inverts" colors

	// test
// textureWrap(REPEAT);
// textureMode(NORMAL);
// hint(ENABLE_STROKE_PURE);

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
String SAVE_TYPE = ".png"; //".tif";1
int MODE = 2; // 1-3
// TODO : MODE 2 needs some love
String SRC_FILE;  // image names get pulled from imgs


//  NOTE: This script now runs off of imgs[] to allow for multi-source image support
//	String[] imgs = {""}; // used for debug, should give you wireframes
String[] imgs = {""};//{ "e5.png" };
/*
String[] imgs = { 

"e1.png",
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
*/
int numSides = 6; // MIN = 3
int mxNumSides = 8;
int colCt = 10;  //  HCylinder NOTE : only follow curated from mode1 engine sizes > 5, 6, 8, 10
float sw = PI;



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


  // these hints fix HCylinder.noFill()
  if(fixNoFill)hint(ENABLE_DEPTH_SORT);

  background(H.WHITE);
  noFill();

  //  init HYPE
  H.init(this).background(H.WHITE).use3D(true).autoClear(true);

hint(ENABLE_STROKE_PERSPECTIVE);
strokeJoin(ROUND);
strokeCap(SQUARE);


  //  be safe
  if(colCt<2)colCt=2;

  //  init VARIABLES
  drawW = (int) ( TARGETW/colCt  );

  //  ROTATE MODE
      switch (MODE) {
        case 1:
          colSpacingX = drawW;  //(drawW * 1.41);
          colSpacingY = drawW;  //(drawW * 1.63 );
          drawZ = H.CENTER; //drawW;
        break;

        case 2:

        drawW *= .75;


          colSpacingX = drawW;
          colSpacingY = drawW;
 
          drawZ = TARGETH/TWO_PI;
        break;

        case 3:
          colSpacingX = drawW*.69;
          colSpacingY = drawW*.85;
          drawZ = drawW;	//H.CENTER;
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

  if(SRC_FILE!=""){
    try{
      srcImg = loadImage(SRC_FILE);
      srcImg.resize(TARGETW, TARGETH);

    } catch( Exception e){
      // be safe in case SRC_FILE doens't load
      println("LOADER: "+e);
      srcImg = get(0,0,TARGETW, TARGETH);
    }
  } else {
    //  If srcImg doesn't load, hard code strokeWeight so you still see output
    sw=(sw<=0)?HALF_PI:sw;
  }



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
        tmpB.texture(tmpImg)
        	// .sides( numSides )
        	.sides( (int)(360/numSides) )	//	DEBUG : use when tweaking modes
            .drawBottom(false)
            .drawTop(false)
            .topRadius(QUARTER_PI)
            .bottomRadius(sqrt(colCt/PI))
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
		// debug
		println("sClr: "+sClr);
		        }
			}
			else
			{
	          sClr = 0;
	          //  stroke it
	          tmpB.strokeSides(sw >0 ).strokeWeight(sw).stroke( sClr );
			}





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


  // EF stamp
  String msg = "ERICFICKES.COM";
  HText lbl = new HText( msg, 24, createFont("Silom", 24) );
  if(srcImg!=null)
  	sClr = srcImg.get( (int)random(srcImg.width), (int)random(srcImg.height) );
  else
  	sClr = 0;

  //  LEFT
  lbl.fill(sClr).anchorAt(H.LEFT).loc( colCt, TARGETH-textAscent(), drawW+drawZ );
	  //  CENTERED
	  // lbl.fill(sClr).anchorAt(H.CENTER).loc( (TARGETW/2), TARGETH-textAscent(), drawW+drawZ );

  H.add(lbl);

}





/* ------------------------------------------------------------------------- */
void draw() {

  pool.requestAll();

  ortho();
  H.drawStage();

  if(SRC_FILE!=""){
    //  NOTE: if image() isn't dropped here, font background is color, not image()
    // font bg hack
    image(srcImg,0,0);

    //  p5 on osx isn't masking????
    tmpImg = get(0,0, TARGETW, TARGETH );
    tmpImg.resize( TARGETW, TARGETH );
    tmpImg.filter(GRAY);
    // tmpImg.filter(INVERT);

    try{
		tmpImg.mask(srcImg);
		srcImg.mask(tmpImg);  
    } catch(Exception e){

      println("MASKER: "+e);
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

      background(H.WHITE);
      
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


