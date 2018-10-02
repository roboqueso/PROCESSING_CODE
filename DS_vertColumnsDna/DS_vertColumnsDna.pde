/*
DS_attachSVG : assets in 11 columns concept

	Think DNA ART ( the vertical rectangle bars )

	https://www.dna11.com/images-gallery

	* needs better assets or combination?
	* more shine, JFX shadows?

*/


import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.colorist.HColorPool;
import fixlib.*;

/* ------------------------------------------------------------------------- */
Fixlib fix = Fixlib.init(this);

HColorPool    colors;
HDrawablePool pool;
String SAVE_NAME = "thisShouldBeDynamic";

int bgColor;
int gridX,gridY;
int colCt = 11;
int rowCt = colCt;  //  NOTE: remember to update this value
int colSpacing = 0;
int drawW, drawH; //  HDrawable Width / Height

// DS_attachSVG
// * run background spiral pattern
// * 11 columns on top
// * D E V A S K A T I O N  ( 11 LETTERS, one for each column )

/*****************************************************************************/
void  settings ()  {
    size(1920,1080, FX2D);
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}



/*****************************************************************************/
void setup() 
{

  //  init VARIABLES
  drawW = (int)( (width-(colSpacing))/colCt)-colSpacing;
  drawH = (int)( (height-(colSpacing))/rowCt)-colSpacing;
  gridX = (drawW/2)+colSpacing;
  gridY = (drawH/2)+colSpacing;

	H.init(this);

	colors = new HColorPool(#000000, #ED7100, #315D15, #3D107B, #E35205, #FFFFFF);

	//  Generate filename containing sketch settings meta NOW
	SAVE_NAME = fix.pdeName() + "-"+ fix.getTimestamp();

// manual runs
	// bgColor = #000000;
	// bgColor = #ED7100;
	// bgColor = #315D15;
	// bgColor = #3D107B;
	// bgColor = #E35205;
	// bgColor = #FFFFFF;


	bgColor = colors.getColor();


	background(bgColor);
	H.background(bgColor);

	pool = new HDrawablePool(121);
	pool.autoAddToStage()

	//	SKATERS no logo
	//	TODO: does ".strokeJoin(ROUND).strokeCap(ROUND))" make any difference?

		.add(new HShape("skateboard.svg").anchorAt(H.CENTER).strokeJoin(ROUND).strokeCap(ROUND))
		.add(new HShape("hockey.svg").anchorAt(H.CENTER).strokeJoin(ROUND).strokeCap(ROUND))
		.add(new HShape("inline.svg").anchorAt(H.CENTER).strokeJoin(ROUND).strokeCap(ROUND))
		.add(new HShape("derby.svg").anchorAt(H.CENTER).strokeJoin(ROUND).strokeCap(ROUND))
		.add(new HShape("shield-noskaters.svg").anchorAt(H.CENTER).strokeJoin(ROUND).strokeCap(ROUND))


//	MAIN SHIELD
// .add(new HShape("devaskation-logo-4.svg").anchorAt(H.CENTER))

		.layout( new HGridLayout()
				      .startLoc(gridX, gridY)
				      .spacing( drawW+colSpacing, drawH+colSpacing)	//, colSpacing
				      .cols(colCt)
				      .rows(rowCt)
					)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					//	SVG ZONE
					//	DS ASSETS
					HShape d = (HShape) obj;
					d.randomColors(colors);
					// d.scale(1.3);
					d.strokeWeight(1);

					//	LARGE SHIELD
					// d.strokeWeight(PI);
					// d.scale(.11);


					

				}
			}
		)
		.requestAll()
	;


	H.drawStage();


	doExit();
}

void draw() {
}



/* ------------------------------------------------------------------------- */
/*  NON - P5 BELOW  */
/* ------------------------------------------------------------------------- */

/**
  End of sketch closer
*/
void doExit(){
  String msg = "DEVASKATION x ERICFICKES";
  //  stamp bottom right based on textSize
  fill(#EF1975);  //colors.getColor());

  textFont( createFont("AMCAP Eternal.ttf", 24));
  textSize(13);
  text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());

  save(SAVE_NAME+".png"); //  USE .TIF IF COLOR  
  
  //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
