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



int colCt = 4;//  2, 4, 8, 16

/* ------------------------------------------------------------------------- */
float sw = PI;
boolean dOffset = false;  // helper for diamond mode
int rowCt = colCt;  //  Maintains even 1:1 grid
int drawW, gridX, gridY; // slice dimensions, grid position
Fixlib fix = Fixlib.init(this);
HDrawablePool pool;
HGridLayout hgl;
HBox tmpB;
PImage p;

String MODE = "SNOWFLAKES";
// String MODE = "SQUARES";

/* ------------------------------------------------------------------------- */

void  settings ()  {
    //  For best results, change size() to match dimensions of mainImgFile
    size( 1600, 1600, P3D);
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */

void setup() {
  
  // these hints fix HBox.noFill()
  hint(ENABLE_DEPTH_SORT);
  //  hint(DISABLE_DEPTH_TEST);

  strokeCap(PROJECT);
  strokeJoin(MITER);
	noFill();

	//  init VARIABLES
	drawW = (int) ( width/colCt  );

  //  NOTE: this formula is specific to HBOX
  // gridX = gridY = (int) ( drawW*1.25 );
  // double m = 1.00+(1.00 / colCt);
  gridX = gridY = (int) ( drawW * (1.00+(1.00 / colCt)) );

// p = loadImage("galixy.png");

  //  Generate filename containing sketch settings meta NOW
  SAVE_NAME = fix.pdeName() + "_"+colCt + "_"+ MODE +"_"+fix.getTimestamp();

  //  init HYPE
  H.init(this).use3D(true).autoClear(true);
  
  pool = new HDrawablePool(colCt*rowCt);
  
  hgl = new HGridLayout()
    .cols(colCt)
    .rows(rowCt)
    .startLoc(gridX, gridY)
    .spacing( drawW *.5 ,drawW *.5 ,drawW  );

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
      tmpB.depth(drawW).width(drawW).height(drawW).z(-420);

      //  ROTATE COMBOs

      if( p != null ){
        tmpB.texture(p).noStroke();
      } else {
        tmpB.noFill().strokeWeight(sw);
      }

      switch (MODE) {
        case "SNOWFLAKES":
          //  HOT DIAMONDS "snowflakes"
          tmpB.rotation(45);
        break;

        case "SQUARES":
          //  3D SQUARES
          tmpB.rotateX(90);
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
/*
strokeWeight(TWO_PI);
stroke(#EF1975);
line(0,(height/2), width, (height/2));
line((width/2),0, (width/2), height); 
*/
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

  save( SAVE_NAME+SAVE_TYPE );    //  USE .TIF IF COLOR  

    //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
