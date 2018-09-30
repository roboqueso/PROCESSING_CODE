import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.colorist.HColorPool;

HColorPool    colors;
HDrawablePool pool;


/*****************************************************************************/
void  settings ()  {
    size(displayWidth, displayHeight);//, P3D, P2D, FX2D	NOTE: P2D throwing tesselation errors
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}



/*****************************************************************************/
void setup() 
{
	background(#000000);

	H.init(this).background(#000000);

	colors = new HColorPool(#000000, #ED7100, #315D15, #3D107B, #E35205).fillOnly();//


	pool = new HDrawablePool(121);
	pool.autoAddToStage()
		.add(new HShape("skateboard.svg").anchorAt(H.CENTER))// .strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape("shield-noskaters.svg").anchorAt(H.CENTER))// .strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape("hockey.svg").anchorAt(H.CENTER))// .strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape("inline.svg").anchorAt(H.CENTER))// .strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape("derby.svg").anchorAt(H.CENTER))// .strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape("devaskation.svg").anchorAt(H.CENTER))// .strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))

//	TODO: add ALPHA gridCol gridRow logic
		.layout( new HGridLayout().startX(75).startY(13).spacing( (width/11),(height/11)).cols(11) )

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
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



					
					// size up small assets
					if(d.height()<100){
						d.scale(1.1);
					}
					else if(d.height()>100){
						d.scale(.69);
					}
// d.z(d.x());
					// d.strokeWeight(1).rotation( ((int)random(4)) * 90 );
					d.strokeWeight(1).stroke(#FFFFFF);
					d.randomColors(colors);
				}
			}
		)
		.requestAll()
	;


	H.drawStage();
	noLoop();
}

void draw() {

}
