/*
DiamondMode - fn diamonds bro
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

int colCt = 8;//  2, 4, 8, 16

/* ------------------------------------------------------------------------- */
boolean dOffset = false;  // helper for diamond mode
int rowCt = colCt;  //  Maintains even 1:1 grid
int drawW, gridX, gridY; // slice dimensions, grid position
Fixlib fix = Fixlib.init(this);
HDrawablePool pool;
HGridLayout hgl;
HBox tmpB;
PImage p;
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
	drawW = (int) (width/colCt);

	gridX = (int) (drawW*.69);
	gridY = (int) (drawW*.69);

	p = loadImage("bigpixel.png");

p.resize(1200, 1200);
background(p);

  //  Generate filename containing sketch settings meta NOW
  //  NOTE: SUB STATEMENTS PAST rotateTiles
  SAVE_NAME = fix.pdeName() + "c"+colCt+ fix.getTimestamp();

  //  init HYPE
  H.init(this).backgroundImg(p).use3D(true);//.autoClear(true);
  
  pool = new HDrawablePool(colCt*rowCt);
  
    hgl = new HGridLayout()
    .startLoc(gridX, gridY)
    .spacing( drawW *.8 , drawW *.8  )
    .cols(colCt)
    .rows(rowCt);

  pool
	.autoAddToStage()
	.layout ( hgl );
/*
	//	Decorate boxes here and drop in pool
	for(int b = 1; b < (colCt*rowCt); b++){

			tmpB = new HBox();

			tmpB.noFill();

			pool.add(tmpB);

			// tmpB = null;
	}
*/
	pool.onCreate(
	    new HCallback() {
	    public void run(Object obj) {
	     //int i = pool.currentIndex();

	     HBox d = (HBox) obj;
	       // d.depth(drawW).width(drawW).height(drawW).rotationX(45).rotationY(45);
	       d.noFill();
	    }
   }
  );
  
    tmpB = new HBox();
    tmpB.noFill();
  pool.add( tmpB );
}





/* ------------------------------------------------------------------------- */
void draw() {

	pool.requestAll();

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
