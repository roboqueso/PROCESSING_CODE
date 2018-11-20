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

int colCt = 1;//  2, 4, 8, 16

int maxCt = 12; // max frame count, increment colCt until maxCt is hit

//  diamond MODE = which rotation pattern is applied
int MODE = 5; // 1, 2, 3, 4, 5



/* ------------------------------------------------------------------------- */
float sw = PI;
int rowCt = colCt;  //  Maintains even 1:1 grid
int drawW, gridX, gridY;
Fixlib fix = Fixlib.init(this);
HDrawablePool pool;
HGridLayout hgl;
HBox tmpB;
boolean fixNoFill = true; //  switch to make noFill() work and give the wireframe effect on HBox
float colSpacing;

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

  // these hints fix HBox.noFill()
  if(fixNoFill)hint(ENABLE_DEPTH_SORT);


  strokeCap(PROJECT);
  strokeJoin(MITER);
	noFill();

	//  init VARIABLES
	drawW = (int) ( width/colCt  );
  colSpacing = drawW *.5;

// TODO: fix gridX/gridY to always center hgl regardless of colCt 
  gridX = gridY = (int) ( (width/2) - (((colCt-1)*colSpacing)/2) );

  //  Generate filename containing sketch settings meta NOW
  SAVE_NAME = fix.pdeName() + (fixNoFill?"":"FILLED") + MODE + "_"+ colCt;

  //  init HYPE
  H.init(this).use3D(true).autoClear(true).background(-1);
  
  pool = new HDrawablePool(colCt*colCt);
  
  hgl = new HGridLayout()
    .cols(colCt)
    .rows(colCt)
    .startLoc(gridX, gridY)
    .spacing( colSpacing ,colSpacing  );

  pool
	.autoAddToStage()
  // .add( new HBox() )
	.add( new HBox() )
	.layout ( hgl )
	.onCreate(
    new HCallback() {
	    public void run(Object obj) 
	    {

			tmpB = (HBox) obj;
      tmpB.depth(drawW).width(drawW).height(drawW).z(-420).noFill().strokeWeight(sw);

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
          tmpB.rotateX(45);
          tmpB.rotateY(35.264);
          tmpB.rotateZ(0);
        break;

        case 5:
          //  HOT DIAMONDS "snowflakes"
          tmpB.rotation(45);
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


  H.drawStage();


  //  multi runs for testing
  if(colCt>maxCt)
  {
  	doExit();
  } else {
    save( SAVE_NAME+SAVE_TYPE );    //  USE .TIF IF COLOR
    colCt++;
    pool.drain();
    H.clearStage();
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

  save( SAVE_NAME+SAVE_TYPE );    //  USE .TIF IF COLOR  

    //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
