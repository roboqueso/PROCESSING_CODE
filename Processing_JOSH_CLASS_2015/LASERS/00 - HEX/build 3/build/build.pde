import processing.pdf.*;

int poolMax = 225;
HDrawablePool pool;

float hexScale = 0.5;
float hexSize = 306 * hexScale;

void setup(){
	size(1700,800);
	H.init(this).background(#111111).autoClear(true);
	smooth();

	pool = new HDrawablePool(poolMax);
	pool.autoAddToStage()
		.add(new HShape("hex_master_1.svg"))
		.add(new HShape("hex_master_2.svg"))
		.add(new HShape("hex_master_3.svg"))
		.add(new HShape("hex_master_4.svg"))
		.add(new HShape("hex_master_5.svg"))
		.add(new HShape("hex_master_6.svg"))
		.layout(new HHexLayout().spacing((hexSize/2)).offsetX(0).offsetY(0))
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.noStroke()
						.fill(#666666)
						.anchorAt(H.CENTER)
					;

					// d.size(d.width()*hexScale,d.height()*hexScale);
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








