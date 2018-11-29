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

int colCt = 8;	//	MIN 2
int MODE = 7; // 1, 2, 3, 4, 5, 6, 7


/* ------------------------------------------------------------------------- */

float drawZ;
float sw = 2;	//PI;
int rowCt = colCt;  //  Maintains even 1:1 grid
Fixlib fix = Fixlib.init(this);
HDrawablePool pool;
HGridLayout hgl;
HBox tmpB;
boolean fixNoFill = true; //  switch to make noFill() work and give the wireframe effect on HBox
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
	drawW = (int) ( width/colCt*2    );	//	*2 since colSpacing cuts drawW in half

	colSpacingX = colSpacingY = (drawW * .5);


	//	MAGIC : resize box size after calculating grid spacing for zoomage
	switch(MODE){
		case 1:
			drawW = drawW * 1.75;
			drawZ = height/2;	//drawW;	//-420;	//(drawW+colSpacing)*colCt;
		break;
		
		case 2:
			drawW = drawW * 1.25;
			drawZ = height/PI;	//drawW;	//-420;	//(drawW+colSpacing)*colCt;
		break;
		
		case 3:
			drawW = drawW * HALF_PI;	//1.5;
			drawZ = height/PI ;	//drawW;	//-420;	//(drawW+colSpacing)*colCt;
		break;

		case 4:
			colSpacingX *= .75;
			colSpacingY *= .75;
			drawZ = 0;
		break;

		case 5:
			// drawW = drawW * .85;	//HALF_PI;	//1.125;	//1.5;
			drawZ = height/2 ;	//drawW;	//-420;	//(drawW+colSpacing)*colCt;
		break;

		//  RECODE THE ONLINE SAMPLES
		case 6:
			drawW = drawW * .5;	//HALF_PI;	//1.125;	//1.5;
			drawZ = height/2 ;	//drawW;	//-420;	//(drawW+colSpacing)*colCt;

		break;

		case 7:

			//	TODO: case 7: -> PROFESSIONAL
			colSpacingX *= .75;
			colSpacingY *= .75;
			drawZ = 0;


		break;

		default:


		break;
	}


	
	//	center HGL
	gridX = (int) ( (width/2) - (((colCt-1)*colSpacingX)/2) );
	gridY = (int) ( (width/2) - (((colCt-1)*colSpacingY)/2) );

	//  Generate filename containing sketch settings meta NOW
	SAVE_NAME = fix.pdeName() + (fixNoFill?"":"FILLED") + MODE + "_"+ colCt;

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


      //  ROTATE COMBOs


	/*
	- // equation 2
	if you look at the Front Ortho of the image there is the triangle ABC. 
	Length B is the side of the cube L, 
	length A is the length of a faces diagonal L * sqrt(2) (basic pythagoras). 

	The tangent of angle alpha will be L / (L * sqrt(2)) or 
	1 / sqrt(2) atan of which equates to 35.2644 degrees. 

	The rotation_euler XYZ (45, 35.264, 0)

	The length of the longest diagonal C is L * sqrt(3), Once again from pythagoras. 

	If the origin is in the middle of the cube translate the cube L * sqrt(3) / 2 to put it on its point.

	Interestinglythe volume can be calculated using C**3 / (3*sqrt(3))

	- see: http://petercollingridge.appspot.com/3D-tutorial/rotating-objects

	*/


	//	ROTATE MODE
      switch (MODE) {
        case 1:
          //  3D SQUARES
          tmpB.rotateX(90);
        break;

        case 2:
          //  SIDE PLAID
          tmpB.rotateX(45);
          tmpB.rotateZ(90);
        break;

        case 3:
          // equation 1
          // To perform this rotation type in 3D view: ry=atan(1/sqrt(2))*180/pi. This will give you a perfectly oriented cube.
          tmpB.rotateY( atan(1/sqrt(2))*180/PI );
        break;

        case 4:
          tmpB.rotationX( 45 );
          tmpB.rotationY( 36 );
          tmpB.rotationZ( 0 );

        break;

        case 5:
          //  HOT DIAMONDS "snowflakes"
          tmpB.rotation(45);
        break;

        case 6:
          	//  RECODE THE ONLINE SAMPLES
          	tmpB.rotateX(45);
			tmpB.rotateY(45);
        break;
		
		case 7:

          // TODO: case 7 = PROFESSIONAL
          	tmpB.rotateX( 90 );
          	tmpB.rotateY( 45 );

          	tmpB.rotateZ( 90 );


		break;

        default :
          println("unknown MODE: "+  MODE);

        break;  
      }






	    }
		}
	)
	.requestAll();




}





/* ------------------------------------------------------------------------- */
void draw() {


	//	TODO: how do you "auto zoom" so hgl is always shrink wrapped to screen?
	//	https://processing.org/reference/camera_.html
	// camera(width/2, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);


pushMatrix();

  H.drawStage();

popMatrix();

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
