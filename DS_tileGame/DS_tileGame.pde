import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.colorist.HColorPool;
//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);



HColorPool    colors;
HDrawablePool pool;
String SAVE_NAME = "thisShouldBeDynamic";
String SAVE_TYPE = ".png";	// ".tif";

boolean tintTiles = false;	//	TRUE : tint tiles from DS color pool, FALSE : use color from assets, noTint();

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
    size(1920, 1080, FX2D);//, P3D, P2D, FX2D	NOTE: P2D throwing tesselation errors
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

	H.init(this);//.background(#E35205);

	colors = new HColorPool(#000000, #ED7100, #315D15, #3D107B, #E35205, #FFFFFF);

	//  Generate filename containing sketch settings meta NOW
	SAVE_NAME = fix.pdeName() + "-TINT_"+ tintTiles + "-"+fix.getTimestamp();

	//	rando bgColor
	if(tintTiles)
		bgColor = #FFFFFF;
	else
		// bgColor = colors.getColor();
// manual runs
	// bgColor = #000000;
	// bgColor = #ED7100;
	// bgColor = #315D15;
	// bgColor = #3D107B;
	// bgColor = #E35205;
	// bgColor = #FFFFFF;

//	faves no Tint manual
bgColor = #FFFFFF;	//	white
// bgColor = #3D107B;	//	purple


	background(bgColor);
	H.background(bgColor);

	pool = new HDrawablePool(121);
	pool.autoAddToStage()

//	SLICES
/* - GROUP1
// .add(new HImage("tiles/slice_r0c0.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r0c1.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r0c10.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r0c2.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r0c3.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r0c4.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r0c5.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r0c6.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r0c7.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r0c8.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r0c9.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r10c0.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r10c1.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r10c10.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r10c2.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r10c3.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r10c4.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r10c5.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r10c6.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r10c7.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r10c8.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r10c9.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r1c0.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r1c1.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r1c10.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r1c2.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r1c3.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r1c4.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r1c5.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r1c6.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r1c7.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r1c8.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r1c9.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r2c0.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r2c1.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r2c10.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r2c2.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r2c3.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r2c4.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r2c5.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r2c6.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r2c7.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r2c8.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r2c9.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r3c0.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r3c1.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r3c10.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r3c2.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r3c3.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r3c4.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r3c5.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r3c6.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r3c7.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r3c8.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r3c9.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r4c0.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r4c1.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r4c10.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r4c2.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r4c3.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r4c4.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r4c5.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r4c6.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r4c7.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r4c8.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r4c9.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r5c0.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r5c1.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r5c10.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r5c2.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r5c3.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r5c4.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r5c5.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r5c6.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r5c7.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r5c8.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r5c9.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r6c0.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r6c1.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r6c10.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r6c2.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r6c3.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r6c4.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r6c5.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r6c6.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r6c7.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r6c8.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r6c9.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r7c0.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r7c1.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r7c10.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r7c2.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r7c3.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r7c4.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r7c5.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r7c6.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r7c7.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r7c8.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r7c9.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r8c0.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r8c1.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r8c10.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r8c2.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r8c3.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r8c4.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r8c5.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r8c6.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r8c7.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r8c8.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r8c9.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r9c0.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r9c1.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r9c10.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r9c2.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r9c3.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r9c4.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r9c5.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r9c6.png").anchorAt(H.CENTER))
.add(new HImage("tiles/slice_r9c7.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r9c8.png").anchorAt(H.CENTER))
// .add(new HImage("tiles/slice_r9c9.png").anchorAt(H.CENTER))
*/

//	HOT PINK
//	https://www.devaskation.com/image/data/Logos/devaskation-logo-2-pink-800.png
.add(new HImage("slices/slice_r0c0.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r0c1.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r0c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r0c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r0c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r0c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r0c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r0c7.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r0c8.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r0c9.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r0c10.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c0.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c1.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c7.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c8.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c9.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c10.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c0.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c1.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c7.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c8.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c9.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c10.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c0.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c1.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c7.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c8.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c9.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c10.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c0.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c1.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c7.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c8.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c9.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c10.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c0.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c1.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c7.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c8.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c9.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c10.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c0.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c1.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c7.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c8.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c9.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c10.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c0.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c1.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c7.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c8.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c9.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c10.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r8c0.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r8c1.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r8c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r8c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r8c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r8c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r8c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r8c7.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r8c8.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r8c9.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r8c10.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r9c0.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r9c1.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r9c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r9c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r9c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r9c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r9c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r9c7.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r9c8.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r9c9.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r9c10.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r10c0.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r10c1.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r10c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r10c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r10c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r10c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r10c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r10c7.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r10c8.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r10c9.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r10c10.png").anchorAt(H.CENTER))

		.layout( new HGridLayout()
				      .startLoc(gridX, gridY)
				      .spacing( drawW+colSpacing, drawH+colSpacing)	//, colSpacing
				      .cols(colCt)
				      .rows(rowCt)
					)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {

//	NOTE: this sketch is currently image only mode
					HImage d = (HImage) obj;
					//	NOTE: if you remove hard coding and go with scale, colSpacing no work
					d.width(drawW).height(drawH);

					//	pull color from DS color pool
					if(tintTiles)
						d.tint(colors.getColor());
					else
						noTint();
					

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

  textFont( createFont("AMCAP Eternal", 24));
  textSize(13);
  text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());

  save(SAVE_NAME+SAVE_TYPE); //  USE .TIF IF COLOR  
  
  //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
