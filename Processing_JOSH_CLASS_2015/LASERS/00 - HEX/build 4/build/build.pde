import processing.pdf.*;

int poolMax = 225;
HDrawablePool pool;
HColorPool colors;

float hexScale = 0.5;
float hexSize = 306 * hexScale;

void setup(){
	size(1700,800);
	H.init(this).background(#111111).autoClear(true);
	smooth();

	colors = new HColorPool(#333333,#494949,#5F5F5F,#707070,#7D7D7D,#888888,#949494,#A2A2A2,#B1B1B1,#C3C3C3,#D6D6D6,#EBEBEB,#FFFFFF,#FF3300 );

	pool = new HDrawablePool(poolMax);
	pool.autoAddToStage()
		.add(new HShape("hex_master_1.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.add(new HShape("hex_master_2.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.add(new HShape("hex_master_3.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.add(new HShape("hex_master_4.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.add(new HShape("hex_master_5.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.add(new HShape("hex_master_6.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.layout(new HHexLayout().spacing((hexSize/2)).offsetX(0).offsetY(0))
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d.strokeWeight(1).stroke(#000000).fill(colors.getColor());

					if ( (int)random(2)==0 ) d.size(d.width()*hexScale,d.height()*hexScale);
				}
			}
		)
		.shuffleRequestAll()
	;

}
 
void draw(){
	H.drawStage();
}

// void mouseReleased() {
// 	pool.drain();
// 	pool.shuffleRequestAll();
// }

void keyPressed() {
	if (key == 'r') {
		saveVector();
	}

}

void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "render_#####.pdf");

	if (tmp == null) {
		H.drawStage();
	} else {
		H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha
	}

	endRecord();
}








