/*
AllCylinders - roots from DiamondMode, now with more fixes and ONLY HCylinder

// TODO: confirm grid is equally centered across MODES 1, 2 and 3

// TODO: make smooth lines in P3D ( currently too jaggy )

// TODO: MOVE TO USING PGRAPHICS LIKE blending surface example online
// "The sketch has been automatically resized to fit the screen resolution"
//	Drawing to PGraphics allows control of output dimension

// BLEND = DEFAULT  so don't bother w/blendMode
// blendMode(DARKEST);  // only the darkest colour succeeds: C = min(A*factor, B)
// blendMode(EXCLUSION);	//	NOTE: causes a grey cloudy almost real diamond effect
// blendMode(MULTIPLY);	//	 multiply the colors, result will always be darker. makes things SUPER DARK to BLACK
// blendMode(REPLACE);	//	"inverts" colors - REPLACE - the pixels entirely replace the others and don't utilize alpha (transparency) values


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


/* ------------------------------------------------------------------------- */

/* ------------------------------------------------------------------------- */
String SAVE_NAME = "thisShouldBeDynamic"; //  MC HAMMER
String SAVE_TYPE = ".png"; //".tif";1

int MODE =  1; // 1-3
String SRC_FILE;  // image names get pulled from imgs
int numSides =  12;  //DEBUG 4; // MIN = 3
int mxNumSides = 12;  // 12 = Dodecahedron
float tRad = .86;
float bRad = .16;  //DEBUG 10; //7;
int colCt = 8;  //  HCylinder NOTE : only follow curated from mode1 engine sizes > 5, 6, 8, 10
float sw = 4;

// 0 DARKEST - see who survives, "Sorry for the DARKEST"

//  NOTE: This script now runs off of imgs[] to allow for multi-source image support
// String[] imgs = {"birdbird.jpg"}; // used for debug, should give you wireframes

String[] imgs = { 
"f2.png",
"f3.png",
"f4.png",
"f5.png",
"f6.png",
"f7.png",
"f8.png",
"f9.png",
"f10.png",
"f11.png",
"f12.png",
"f13.png",
"f14.png",
"f15.png",
"f16.png",
"f17.png",
"f18.png",
"f19.png",
"f20.png",
"f21.png",
"f22.png",
"f23.png",
"f24.png",
"f25.png",
"f26.png",
"f27.png",
"f28.png",
"f29.png",
"f30.png",
"f31.png",
"f32.png",
"f33.png",
"f34.png",
"f35.png",
"f36.png",
"f37.png",
"f38.png",
"f39.png",
"f40.png",
"f41.png",
"f42.png",
"f43.png",
"f44.png",
"f45.png",
"f46.png",
"f47.png",
"f48.png",
"f49.png",
"f50.png",
"f51.png",
"f52.png",
"f53.png",
"f54.png",
"f55.png",
"f56.png",
"f57.png",
"f58.png",
"f59.png",
"f60.png",
"f61.png",
"f62.png",
"f63.png",
"f64.png",
"f65.png",
"f66.png",
"f67.png",
"f68.png",
"f69.png",
"f70.png",
"f71.png",
"f72.png",
"f73.png",
"f1.png",
"birdbird.jpg",
"wood.jpg"

  };



/* ------------------------------------------------------------------------- */
Fixlib fix = Fixlib.init(this);
int cSides = (int)(360/numSides);//(int)(360/numSides); NOTE : mode 1 can't handle 360/numSides
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

  // these hints fix HCylinder.noFill()
  if(fixNoFill)hint(ENABLE_DEPTH_SORT);
hint(DISABLE_DEPTH_TEST);
  //  init HYPE
  H.init(this).background(-1).use3D(true).autoClear(true);

  //  be safe
  if(colCt<2)colCt=2;

  //  init VARIABLES
  drawW = (int) ( TARGETW/colCt  );


  //  ROTATE MODE
      switch (MODE) {
        case 1:
          colSpacingX = drawW;
          colSpacingY = drawW;
          
          drawZ = H.CENTER;
// 	NOTE : re-run w/ numSides only
          // cSides = numSides;  //(int)(360/numSides);
          cSides = (int)(180/numSides);

        break;

        case 2: 
        
        drawW *= .55;

          colSpacingX = drawW*1.2 ;
          colSpacingY = drawW*1.2 ;
 
          drawZ = TARGETH/PI;
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

      //  NOTE: HCylinders don't work out like HBoxes
      //  this value may need to be adjusted
      //  Calculate HGrid's starting X,Y
      // gridX = drawW;//(int) ( (TARGETW/2) - (drawW/colCt) );
      gridX = (int) ( (TARGETW/2) - (((colCt-1)*drawW)/2) );
      gridY = (int) ( (TARGETW/2) - (((colCt-1)*drawW)/2) );


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
    srcImg = get();
  }


  // EF stamp
  String msg = "ERICFICKES.COM";
  HText lbl = new HText( msg, 24, createFont("Impact", 24) );
  if(srcImg!=null){
  	sClr = srcImg.get( (int)srcImg.width/2, (int)srcImg.height/2 );
  }
  else
  	sClr = 0;

    //  LEFT
    // lbl.fill(sClr).anchorAt(H.LEFT).loc( colCt, TARGETH-textAscent(), drawW+drawZ );
	  //  CENTERED
	  lbl.fill(sClr).anchorAt(H.CENTER).loc( (TARGETW/2), TARGETH-textAscent(), TARGETH );


H.add( new HImage(srcImg) );
H.add(lbl);

    pool = new HDrawablePool(colCt*colCt);
 
    hgl = new HGridLayout()
      .cols(colCt)
      .rows(colCt)
      .startLoc(gridX, gridY) 
      .spacing( colSpacingX, colSpacingY, drawZ  );

  


  //  create box to hold slice
  tmpB = new HCylinder();
        tmpB
        	.sides( cSides )
          .drawTop(false)
          .drawBottom(false)
// RADIUS IN TESTING
          .topRadius(tRad)
          .bottomRadius(bRad)
          .texture( H.app().g );

  //  drop it in the pool
  pool.add( tmpB );

  tmpB = null;
  tmpImg = null;
  sClr = -1;

  pool
    .layout ( hgl )
    .autoAddToStage()
    .onCreate(
      new HCallback() {
          public void run(Object obj) 
          {
            tmpB = (HCylinder) obj;

            //  spicey size
            tmpB.anchorAt(H.CENTER).depth(drawW).z(drawZ).width( drawW ).height( drawW );

// debug
println("run(): "+  pool.currentIndex() );
tmpB.texture( get() );

      			//	ADD FORMATTING AND PIZAZZ HERE
      			if(srcImg!=null)
      			{


// if(pool.currentIndex() < (pool.count()/2) ){
// 	// HACK : .texture() works here NOT above
// 	tmpImg = srcImg.get( (int)tmpB.x(),  (int)tmpB.y(),  (int)drawW,  (int)drawW );

// } else {
	//  META : Use HYPE's PGraphics as texture
	//tmpB.texture( H.app().g );	
// }

						

		              if(sw >0 )
		              {
		                //  Grab color from the current tmpImg
		                sClr = H.app().g.get( (int) random(tmpImg.width/2), (int)random(tmpImg.height/2) );
		                //  stroke it
		                tmpB.strokeSides(true).strokeWeight(sw).stroke( sClr );
		              }
      			}
      			else
      			{
	              sClr = 0;
	              //  stroke it
	              tmpB.texture( H.app().g ).strokeSides(sw>0).strokeWeight(sw).stroke( sClr );
      			}



          //  ROTATE MODE
          switch (MODE) {
            case 1:
             // if(pool.currentIndex()%2==0)
             //    tmpB.rotation( 135  ).rotationY(45);
             //  else
             //    tmpB.rotation( -45  ).rotationY(-45);
             if(pool.currentIndex()%2==0)
                tmpB.rotation( pool.currentIndex()*125  ).rotationY(35*pool.currentIndex());
              else
                tmpB.rotation( -pool.currentIndex()* 45  ).rotationY(-35*pool.currentIndex());

            break;

            case 2:

              // if(pool.currentIndex()%2==0)
              //   tmpB.rotationX(45).rotationY(15*(numSides*pool.currentIndex()));
              // else
              //   tmpB.rotationX(-45).rotationY(-15*(numSides*pool.currentIndex()));

            break;

            case 3:
              	// if(pool.currentIndex()%2==0)
               //    tmpB.depth(drawW).z(drawZ).rotation((numSides*colCt)*8);
               //  else
               //    tmpB.depth(drawW).z(drawZ).rotation(-(numSides*colCt)*8);
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

sphereDetail(numSides);

  if(srcImg!=null){
    srcImg.filter(POSTERIZE, cSides);

     // p5 on osx isn't masking????
    tmpImg = srcImg.get(0,0, TARGETW, TARGETH );
    tmpImg.resize( TARGETW, TARGETH );
    srcImg.resize( TARGETW, TARGETH );


    image(tmpImg,0,0, TARGETW, TARGETH/2);
    // FLIP THE SCRIPT
    translate(TARGETW/2, TARGETH/2, H.CENTER );
    scale(-1, -1);
    image(tmpImg,-TARGETW/2, -TARGETH/2, TARGETW, TARGETH/2);
  } 

  translate(width/2, width/2, drawZ);


  //  flip source image and set as background before HYPE draws
  H.backgroundImg(get());




  pool.shuffleRequestAll();

// debug
println("H.drawStage()! " + SRC_FILE + " : " + imgIdx +" : "+ (imgs.length-1) +" : "+ numSides +" : "+ mxNumSides );




  lights();
  camera();
  ortho();



  H.drawStage();


//debug
// stroke(#EF2018);
// line(width/2, 0, width/2, height);

//  TODO : looking to find the perfect numSides

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

/* ------------------------------------------------------------------------- */
//  GC HELPER
void cleanup(){
    //  MAKING ART WITH GARBAGE
    pool.drain();
    H.background(-1);
    H.backgroundImg(null);
    H.clearStage();
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
