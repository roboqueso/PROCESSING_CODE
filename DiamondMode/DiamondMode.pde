/*
DiamondMode - fn diamonds bro

HINT() FIXED NOFILL
			* roots from DBP_HTG

			Stop DBP_HTG

			New P5 HGridLayout DIAMOND mode like below

			Recreate this pic 
			- HText w/same font
			on top of
			- HGridLayout HBox rotated to make DAIAMONDs

			Screen 0,0 should be the CENTER point of the BOX, don’t show points



[ PROFESSIONAL ]
"Your conduit to success"

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
String SAVE_TYPE = ".png";  //".tif";


boolean saveFrame = true;
boolean stroke = false;	//	stroke the box

int colCt = 2;//  2, 4, 8, 16

/* ------------------------------------------------------------------------- */
boolean dOffset = false;  // helper for diamond mode
int rowCt = colCt;  //  Maintains even 1:1 grid
int drawW, gridX, gridY; // slice dimensions, grid position
Fixlib fix = Fixlib.init(this);
HDrawablePool pool;
HGridLayout hgl;
HBox tmpB;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    //  For best results, change size() to match dimensions of mainImgFile
    size( 1200, 1200, P3D);
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */

void setup() {
	
	noFill();
	//  init VARIABLES
	drawW = (int) ( ( width/colCt  ) * 1.25 );

	gridX = (int) (drawW*.4);
	gridY = (int) (drawW*.4);


  //  Generate filename containing sketch settings meta NOW
  //  NOTE: SUB STATEMENTS PAST rotateTiles
  SAVE_NAME = fix.pdeName() + "c"+colCt+ fix.getTimestamp();

  //  init HYPE
  H.init(this).background(HConstants.CLEAR).use3D(true).autoClear(true);
  
  pool = new HDrawablePool(colCt*rowCt);
  
    hgl = new HGridLayout()
    .startLoc(gridX, gridY)
    .spacing( drawW *.75 , drawW *.75  )
    .cols(colCt)
    .rows(rowCt);

  pool
	.autoAddToStage()
	.add( new HBox() )
	.layout ( hgl )
	.onCreate(
    new HCallback() {
	    public void run(Object obj) 
	    {

			tmpB = (HBox) obj;
			tmpB.depth(drawW).width(drawW).height(drawW).rotationX(45).rotationY(45).noFill().strokeWeight(PI);;
	    }
		}
	)
	.requestAll();

}





/* ------------------------------------------------------------------------- */
void draw() {

	// this hint fixes HBox.noFill()
	hint(ENABLE_DEPTH_SORT);
	H.drawStage();

	doExit();

}







/* ------------------------------------------------------------------------- */
/*  NON - P5 BELOW  */
/* ------------------------------------------------------------------------- */

/**
  End of sketch closer
*/
void doExit(){
  String msg = "ERICFICKES.COM";

  	textFont( createFont("Bitwise", 43));
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

  save( SAVE_NAME+"_FNL"+SAVE_TYPE );    //  USE .TIF IF COLOR  

    //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
