/*
H3X9OBJ : 3x9 HYPE sphereDetails to OBJ concept 9 see the board )
* BLOOD-DRAGON : 1920 x 1071
* size(displayWidth, displayHeight, P3D)
* HDR w, h is 2x1 EX: 2048, 1024

if(color)
  GO TIFF
  TIFF = Tagged Image File Format. This is one of the most complex image formats, and it can hold more kinds and depth of information than almost any other format. The standard is owned and maintained by Adobe.
else
  PNG

*/

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import fixlib.*;

import processing.dxf.*;

/* ------------------------------------------------------------------------- */
Fixlib fix = Fixlib.init(this);
HDrawablePool pool;

int gridX,gridY;
int colCt = 3;	//	7 - ROYGBIV
int rowCt = 1;  //  NOTE: remember to update this value
int colSpacing = 1;
int drawW, drawH; //  HDrawable Width / Height
int sDetail = 1;  //  holder for dynamic sphereDetail value ( this gets set in code )
int sdInc = 34;	// sphereDetail( frameCount * sdInc )
// first 8 fibonacchis:	1,2,3,5,8,13,21,34
//	RENDER DARK RAINBOW ( ( 1-> diamond? ) ROYGBIV each of the numbers )
Boolean save_frame = false;


	 // * - `HConstants.LEFT`
	 // * - `HConstants.RIGHT`
	 // * - `HConstants.CENTER_X`
	 // * - `HConstants.TOP`
	 // * - `HConstants.BOTTOM`
	 // * - `HConstants.CENTER_Y`
	 // * - `HConstants.CENTER`
	 // * - `HConstants.TOP_LEFT`
	 // * - `HConstants.TOP_RIGHT`
	 // * - `HConstants.BOTTOM_LEFT`
	 // * - `HConstants.BOTTOM_RIGHT`
	 // * - `HConstants.CENTER_LEFT`
	 // * - `HConstants.CENTER_RIGHT`
	 // * - `HConstants.CENTER_TOP`
	 // * - `HConstants.CENTER_BOTTOM`

// int[] pos = { 
// 	HConstants.LEFT,
// 	HConstants.RIGHT,
// 	HConstants.TOP,
// 	HConstants.BOTTOM,
// };


/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(displayWidth, displayHeight, P3D); //"processing.opengl.PGraphics3D");
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */

void setup() {

  //  init VARIABLES
  drawW = (int)( (width-(colSpacing))/colCt)-colSpacing;
  drawH = (int)( (height-(colSpacing))/rowCt)-colSpacing;
  gridX = (drawW/2)+colSpacing;
  gridY = (drawH/2)+colSpacing;

  //  init HYPE
  H.init(this).background(-1).use3D(true).autoClear(false);

  pool = new HDrawablePool(colCt*rowCt);
  pool.autoAddToStage()
    
    .add ( new HSphere().size(drawW, drawH) )

    .layout (
      new HGridLayout()
      .startLoc(gridX, gridY)
      .spacing( drawW+colSpacing, drawH+colSpacing, colSpacing )
      .cols(colCt)
      .rows(rowCt)
    )

    .onCreate (
       new HCallback() {
        public void run(Object obj) {

          //  DO STUFF HERE
	

// TODO: remove?
sphereDetail(sdInc*pool.currentIndex());

        // println("typeof: "+typeof);
        HSphere hs = (HSphere)obj;
        hs
        .scale(.25)
        .strokeWeight( 1*noise(frameCount) )
        .noFill()
        .anchorAt( H.CENTER );
        //	adjust anchor



        }
      }
    )
  ;

}





/* ------------------------------------------------------------------------- */
void draw() {

//  calculate this frame's sphereDetail
sDetail = sdInc*(pool.currentIndex()+1);

if(frameCount>colCt)
  doExit();
else{



//  MULTI DXF OUTPUT
  println(frameCount + " > " + sDetail + " BEGIN RAW!!!!");
  beginRaw(DXF,  fix.pdeName() + "-" + fix.getTimestamp()+"-"+ sDetail + ".dxf" );

  

  // // 3D code
  // hint(DISABLE_DEPTH_TEST);
  // camera();
  // lights(); //    because P3D

  // ambientLight(pool.currentIndex()*TWO_PI,pool.currentIndex()*TWO_PI,pool.currentIndex()*TWO_PI);
  // emissive(pool.currentIndex()*TWO_PI,pool.currentIndex()*TWO_PI,pool.currentIndex()*TWO_PI);
  // specular(pool.currentIndex()*TWO_PI,pool.currentIndex()*TWO_PI,pool.currentIndex()*TWO_PI);


  	sphereDetail(sDetail);
    pool.request();
  	H.drawStage();

// if(frameCount<((int)colCt/2) ){
    //  One big fatty in the middle to house the smaller HSpheres in the HGrid
	pushMatrix();
		translate(width/2, height/2, frameCount);
		stroke(#4D4D4D);
		noFill();
		sphereDetail( (int)(sDetail/PI) );
		scale(0.75);

		sphere( drawW+(frameCount*sdInc) );
		box( drawW+(frameCount*sdInc) );

	popMatrix();
// }

//  save DXF
endRaw();

    //  save frame
    if(save_frame){
      saveFrame( fix.pdeName() + "-" + fix.getTimestamp()+"-"+ sDetail + "_##.png");  //  USE .TIF IF COLOR
    }
  }

}







/* ------------------------------------------------------------------------- */
/*  NON - P5 BELOW  */
/* ------------------------------------------------------------------------- */

/**
  End of sketch closer
*/
void doExit(){
  String msg = "ericfickes.com";
  //  stamp bottom right based on textSize
  fill(0);
  textSize(16);
  text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());

  save( fix.pdeName() + "-" + fix.getTimestamp()+"_FINAL.png" );    //  USE .TIF IF COLOR
  
  //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
