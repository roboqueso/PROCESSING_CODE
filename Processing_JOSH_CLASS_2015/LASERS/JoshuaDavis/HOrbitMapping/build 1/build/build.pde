import processing.pdf.*;

HDrawablePool pool1;

void setup(){
	size(1024,768);
	H.init(this).background(#FFFFFF).autoClear(true);
	smooth();

	pool1 = new HDrawablePool(1);
	pool1.autoAddToStage()
		.add(new HShape("hex_master_1.svg"))
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.anchorAt(H.CENTER)
						.loc(width/2, height/2)
					;
				}
			}
		)
		.requestAll()
	;
}
 
void draw(){
	H.drawStage();
}

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






