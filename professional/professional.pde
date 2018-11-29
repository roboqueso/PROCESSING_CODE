/*
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

// String SRC_FILE = "S11.jpg";
// String SRC_FILE = "S10.jpg";
// String SRC_FILE = "S9.jpg";
// String SRC_FILE = "S8.jpg";
String SRC_FILE = "S7.jpg";
// String SRC_FILE = "S6.jpg";
// String SRC_FILE = "S5.jpg";
// String SRC_FILE = "S4.jpg";
// String SRC_FILE = "S3.jpg";
// String SRC_FILE = "S2.jpg";
// String SRC_FILE = "S1.jpg";

int colCt = 24;	//	MIN 2
//	2,3,5,8,13 ,21,34,55

/* ------------------------------------------------------------------------- */

float drawZ;
float sw = HALF_PI;	//PI;
int rowCt = colCt;  //  Maintains even 1:1 grid
Fixlib fix = Fixlib.init(this);
HDrawablePool pool;
HGridLayout hgl;
HBox tmpB;
boolean fixNoFill = true; //  switch to make noFill() work and give the wireframe effect on HBox
float colSpacingX,colSpacingY;
float drawW, gridX, gridY;
color sClr;
PImage srcImg, tmpImg;

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
	noFill();

	// these hints fix HBox.noFill()
	if(fixNoFill)hint(ENABLE_DEPTH_SORT);
	//	be safe
	if(colCt<2)colCt=2;

	//  init VARIABLES
	drawW = (int) ( width/colCt  );
	colSpacingX = (drawW * 1.41);
	colSpacingY = (drawW * 1.63 );

	drawZ = drawW;

	//	center HGL
	gridX = (int) ( (width/2) - (((colCt-1)*colSpacingX)/2) );
	gridY = (int) ( (width/2) - (((colCt-1)*colSpacingY)/2) );

	//  Generate filename containing sketch settings meta NOW
	SAVE_NAME = SRC_FILE + (fixNoFill?"":"FILLED") + "_"+ colCt;

	srcImg = loadImage(SRC_FILE);
	srcImg.resize(width, height);

	//  init HYPE
	H.init(this).use3D(true).autoClear(true).background(-1);
  
	pool = new HDrawablePool(colCt*colCt);
  
  	hgl = new HGridLayout()
	    .cols(colCt)
	    .rows(colCt)
	    .startLoc(gridX, gridY) 
	    .spacing( colSpacingX, colSpacingY, drawZ  );

	pool.autoAddToStage();

  //  SLICE IT UP

  //  OUTER ROW LOOP ( t - b ) 
  for( int row = 0; row < rowCt; row++)
  {
    //  INNER COLUMN LOOP ( l-r )  
    for( int col = 0; col < colCt; col++)
    {
      //  get image slice
      tmpImg = srcImg.get( (int)(drawW*col),  (int)(drawW*row),  (int)drawW,  (int)drawW);
      
      //  create box to hold slice
      tmpB = new HBox();

      tmpImg = srcImg.get( (int)(drawW*col),  (int)(drawW*row),  (int)drawW,  (int)drawW);
      tmpB.textureFront(tmpImg);
      tmpB.textureLeft(tmpImg);
      tmpB.textureBack(tmpImg);

      tmpImg = srcImg.get( (int)(drawW*row),  (int)(drawW*col),  (int)drawW,  (int)drawW);
      tmpB.textureTop(tmpImg);
      tmpB.textureRight(tmpImg);
      tmpB.textureBottom(tmpImg);

      //  drop it in the pool
      pool.add( tmpB );
    }
  }

	pool
		.layout ( hgl )
		.onCreate(
			new HCallback() {
			    public void run(Object obj) 
			    {
					tmpB = (HBox) obj;

					tmpB.depth(drawW).width(drawW).height(drawW).z(drawZ).strokeWeight(sw);


          //  Grab color from the current tmpImg
          sClr = srcImg.get( (int)tmpB.x(), (int)tmpB.y() );
          //  stroke it
          tmpB.stroke( sClr );

					tmpB.rotationX(55);
					tmpB.rotationZ(45);
			    }
		}
	)
	.requestAll();




}





/* ------------------------------------------------------------------------- */
void draw() {

srcImg.filter(POSTERIZE,8);

	ortho();
	H.drawStage();
	
	image(srcImg,0,0);

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
