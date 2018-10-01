import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.colorist.HColorPool;
import fixlib.*;

/* ------------------------------------------------------------------------- */
Fixlib fix = Fixlib.init(this);

HColorPool    colors;
HDrawablePool pool;


// DS_attachSVG
// * run background spiral pattern
// * 11 columns on top
// * D E V A S K A T I O N  ( 11 LETTERS, one for each column )

/*****************************************************************************/
void  settings ()  {
    size(displayWidth, displayHeight);//, P3D, P2D, FX2D	NOTE: P2D throwing tesselation errors
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}



/*****************************************************************************/
void setup() 
{
	H.init(this);//.background(#E35205);

	colors = new HColorPool(#000000, #ED7100, #315D15, #3D107B, #E35205);//.fillOnly();//


	background(colors.getColor());
	H.background(colors.getColor());

	pool = new HDrawablePool(121);
	pool.autoAddToStage()
	/*
		.add(new HShape("skateboard.svg").anchorAt(H.CENTER))// .strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape("shield-noskaters.svg").anchorAt(H.CENTER))// .strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape("hockey.svg").anchorAt(H.CENTER))// .strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape("inline.svg").anchorAt(H.CENTER))// .strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape("derby.svg").anchorAt(H.CENTER))// .strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape("devaskation.svg").anchorAt(H.CENTER))// .strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
*/

//	SLICES
// .add(new HImage("slices/slice_r0c0.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r0c1.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r0c10.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r0c2.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r0c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r0c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r0c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r0c6.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r0c7.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r0c8.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r0c9.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r10c0.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r10c1.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r10c10.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r10c2.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r10c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r10c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r10c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r10c6.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r10c7.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r10c8.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r10c9.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r1c0.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c1.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c10.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c7.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c8.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r1c9.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r2c0.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c1.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c10.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c7.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c8.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r2c9.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c0.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c1.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c10.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c7.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c8.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r3c9.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c0.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c1.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c10.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c7.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c8.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r4c9.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c0.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c1.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c10.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c7.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c8.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r5c9.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c0.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c1.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c10.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c7.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c8.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r6c9.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r7c0.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c1.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r7c10.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c7.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c8.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r7c9.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r8c0.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r8c1.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r8c10.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r8c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r8c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r8c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r8c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r8c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r8c7.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r8c8.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r8c9.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r9c0.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r9c1.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r9c10.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r9c2.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r9c3.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r9c4.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r9c5.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r9c6.png").anchorAt(H.CENTER))
.add(new HImage("slices/slice_r9c7.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r9c8.png").anchorAt(H.CENTER))
// .add(new HImage("slices/slice_r9c9.png").anchorAt(H.CENTER))


//	TODO: add ALPHA gridCol gridRow logic
		.layout( new HGridLayout().startX(75).startY(13).spacing( (width/11),(height/11)).cols(11) )
		// .layout( new HGridLayout().startX(75).startY(13).spacing( 100, 100 ).cols(11) )

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HImage d = (HImage) obj;
					// HShape d = (HShape) obj;
//	debug
// println("d.height(): "+d.height());
/*
Current DS 6 SVG heights
	169.9
	130.1
	115.2
	99.8
	50.6
	9.9
*/
// d.scale(.9);

					d.strokeWeight(1).stroke(#FFFFFF);
					d.tint(colors.getColor());


/*
					
					// size up small assets
					if(d.height()<100){
						d.scale(1.1);
					}
					else if(d.height()>100){
						d.scale(.69);
					}
					// d.randomColors(colors);
*/
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
  String msg = "ericfickes.com";
  //  stamp bottom right based on textSize
  fill(0);
  textSize(16);
  text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());

  save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );    //  USE .TIF IF COLOR  
  
  //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
