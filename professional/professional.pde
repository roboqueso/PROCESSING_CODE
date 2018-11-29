/*
DiamondMode - fn diamonds bro

HINT() FIXED NOFILL
	

TODO: gridX, gridY is not dynamically CENTERing HGridLayout

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

int colCt = 16;	//	MIN 2


/* ------------------------------------------------------------------------- */

float drawZ;
float sw = PI;	//PI;
int rowCt = colCt;  //  Maintains even 1:1 grid
Fixlib fix = Fixlib.init(this);
HDrawablePool pool;
HGridLayout hgl;
HBox tmpB;
boolean fixNoFill = false; //  switch to make noFill() work and give the wireframe effect on HBox
float colSpacingX,colSpacingY;
float drawW, gridX, gridY;


/* ------------------------------------------------------------------------- */

void  settings ()  {
    //  For best results, change size() to match dimensions of mainImgFile
    size( 1600, 1600, P3D);
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */
void setup() {

	background(-1);
	strokeCap(PROJECT);
	strokeJoin(MITER);
	noFill();

	// these hints fix HBox.noFill()
	if(fixNoFill)hint(ENABLE_DEPTH_SORT);
	//	be safe
	if(colCt<2)colCt=2;

	//  init VARIABLES
	drawW = (int) ( width/colCt  );
	colSpacingX = (drawW * 1.42);
	colSpacingY = (drawW * 1.62 );

	drawZ = 0;//drawW*1.25;

	//	center HGL
	gridX = (int) ( (width/2) - (((colCt-1)*colSpacingX)/2) );
	gridY = (int) ( (width/2) - (((colCt-1)*colSpacingY)/2) );

	//  Generate filename containing sketch settings meta NOW
	SAVE_NAME = fix.pdeName() + (fixNoFill?"":"FILLED") + "_"+ colCt;

	//  init HYPE
	H.init(this).use3D(true).autoClear(true).background(-1);
  
	pool = new HDrawablePool(colCt*colCt);
  
  	hgl = new HGridLayout()
	    .cols(colCt)
	    .rows(colCt)
	    .startLoc(gridX, gridY) 
	    .spacing( colSpacingX, colSpacingY, drawZ  );

	pool
		.autoAddToStage()
		.add( new HBox() )
		.layout ( hgl )
		.onCreate(
			new HCallback() {
			    public void run(Object obj) 
			    {
					tmpB = (HBox) obj;
			  
			  		tmpB.depth(drawW).width(drawW).height(drawW).z(drawZ).noFill().strokeWeight(sw);

          tmpB.rotationX(55);
          tmpB.rotationZ(45);


	    }
		}
	)
	.requestAll();




}





/* ------------------------------------------------------------------------- */
void draw() {

	ortho();
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
    translate(width-13, (height/2));
    rotate(-HALF_PI);
    text(msg,0,0);
  popMatrix();

  save( SAVE_NAME+SAVE_TYPE );    //  USE .TIF IF COLOR  

    //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
