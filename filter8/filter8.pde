/*
filter8  : square one starting point P5/HYPE template sketch
* BLOOD-DRAGON : 1920 x 1071
* size(displayWidth, displayHeight, P3D)
* HDR w, h is 2x1 EX: 2048, 1024

- create HDR from f360 output
  rabbithead2_merged.png > HImage

- import into P5
* HGridLayout - Column per Processing filter() 
  see: https://processing.org/reference/filter_.html for 8 filters
- 1 row

- Get( image, 1-8, colWidth, height ).filter( 1-x )

- save HDR dimensions from P5

* back into PS & LR for HOTNESS
* bring into f360
- reRender RabbitHead1




*/

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import fixlib.*;

/* ------------------------------------------------------------------------- */
Fixlib fix = Fixlib.init(this);
HDrawablePool pool;


/*
1 = vertical ( slices go top down )
2 = horizontal -> OG filter8, slices go left to right
*/
int MODE = 1;
Boolean do_both_modes = true;	// run 1, then 2, then bounce
String SRC_FILE = "f8_FXinP5.png";
int gridX,gridY, colCt,rowCt,drawW, drawH;	//	"INTERNALS" -> set by MODE

// TODO: fix clearStage
int colSpacing = 43;


PImage pImg, imgSlice;

//	TODO: fix SCALE

int iScale = -1;	//	-1 inverts slices
					//	1 keeps normal



/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(displayWidth, displayHeight, P3D); // matching dimensions of pImg for best results
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */

void setup() {

	background(-1);

  //	load source image
	if(null==pImg)	pImg = loadImage(SRC_FILE);

  //	pre-HYPE MODE specific calculations
	switch(MODE)
	{
		case 1:	//"vert":
		{
			colCt = 1;
			rowCt = 8;	//	NOTE: remember to update this value

			drawW = width;
			drawH = (int)(height/rowCt)-colSpacing;	//( (height-(colSpacing))/rowCt)-colSpacing;
//	TODO: does this need to be tweaked?
//	BECAUSE H.CENTER?
			// gridX = 0;	//(drawW/2)+colSpacing;
			// gridY = height/2;	//(drawH/2)+colSpacing;
		}

		break;

		case 2:	//"horizontal":
		{
			colCt = 8;
			rowCt = 1;	//	NOTE: remember to update this value
			drawW = (int)( (width-(colSpacing))/colCt)+colSpacing;
			drawH = height;	//(int)( (height-(colSpacing))/rowCt)-colSpacing;
			// gridX = (drawW/2)+colSpacing;
			// gridY = (drawH/2)+colSpacing;
		}
		break;
	}



  //  init HYPE
  H.init(this).background(-1).autoClears(true);

  pool = new HDrawablePool(colCt*rowCt);
  pool.autoAddToStage()
    
    .add (
      // swap this out with something else
      new HImage()
    )

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


  //	pre-HYPE MODE specific calculations
	switch(MODE)
	{
		case 1:	//"vert":
		{
			// get imgSlice pimg.get(x, y, w, h)
			imgSlice = pImg.get( 0, (pool.currentIndex()*drawH), drawW, drawH );	//	NOT height
		}

		break;

		case 2:	//"horizontal":
		{
			// get imgSlice pimg.get(x, y, w, h)
			imgSlice = pImg.get( (pool.currentIndex()*drawW), 0, drawW, drawH );	//	NOT height
		}
		break;
	}


		//	apply 1 of 8 filters
		switch(pool.currentIndex()){
			//	THRESHOLD
			//	Converts the image to black and white pixels depending if they are above or below the threshold defined by the level parameter. The parameter must be between 0.0 (black) and 1.0 (white). If no level is specified, 0.5 is used.
			case 0:
				imgSlice.filter(THRESHOLD, 1);	//, random(0,1));
			break;
			
			// GRAY
			// Converts any colors in the image to grayscale equivalents. No parameter is used.
			case 1:
				imgSlice.filter(GRAY);
			break;
			
			//	INVERT - Sets each pixel to its inverse value. No parameter is used.
			case 2:
				imgSlice.filter(INVERT);
			break;

			// OPAQUE - Sets the alpha channel to entirely opaque. No parameter is used.
			case 3:
				imgSlice.filter(OPAQUE);
			break;

			// POSTERIZE
			// Limits each channel of the image to the number of colors specified as the parameter. The parameter can be set to values between 2 and 255, but results are most noticeable in the lower ranges.
			case 4:
				imgSlice.filter(POSTERIZE, 8);
			break;

			// BLUR
			// Executes a Guassian blur with the level parameter specifying the extent of the blurring. If no parameter is used, the blur is equivalent to Guassian blur of radius 1. Larger values increase the blur.
			case 5:
				imgSlice.filter(BLUR,8);	// TODO: what is filter(BLUR) range?
			break;

			// ERODE
			// Reduces the light areas. No parameter is used.			
			case 6:
				imgSlice.filter(ERODE);
			break;
			
			// DILATE
			// Increases the light areas. No parameter is used.
			case 7:
				imgSlice.filter(DILATE);
			break;

		}

        //	assign the slice to HImage
        //	NOTE: .scale(-1) inverts slice
		HImage ii = (HImage) obj;
		ii
			.image(imgSlice)
        	.scale(iScale)
			.height(drawH)
			.width(drawW);
        	// .anchorAt(H.LEFT);
        }
      }
    )

   .requestAll()
  ;

	H.drawStage();
	doExit();
}





/* ------------------------------------------------------------------------- */
void draw() {

  
  	H.clearStage();
  	pImg = null;
  	imgSlice = null;
  	pool = null;
  	MODE=2;
  	setup();

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
  text(msg, (width-textWidth(msg))-(textAscent()/3), height-textAscent());

  save( fix.pdeName() + "_" + SRC_FILE + "_" + MODE + "_" + fix.getTimestamp()+".png" );

  if(do_both_modes && MODE == 1){

  	redraw();
 	

  } else {
	  //  cleanup
	  fix = null;
	  
	  noLoop();
	  exit();
	  System.gc();
	  System.exit(1);
  }
}
