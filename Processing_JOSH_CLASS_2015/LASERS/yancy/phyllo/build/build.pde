import processing.pdf.*;

HColorPool colors;
HDrawablePool pool;

boolean record = true;

void setup() {
	size(1200,1200);
	H.init(this).background(#202020);
	smooth();

	pool = new HDrawablePool(588);
	pool.autoAddToStage()
		.add (new HShape("teardrop.svg").anchorAt(H.CENTER))

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.noStroke()
						.fill(#FFFFFF)
						.anchor(0,i*3)
						.loc(width/2, height/2)
						.scale(0.0005*i)
						.rotation(137.5*i);
					;
				}
			}
		)
		.requestAll()
	;

}


void draw(){
	H.drawStage();

	if(frameCount % 3 == 0 && frameCount < 181){
		// saveFrame("image-#####.gif");
	}
}

// pause, restart, advance 1 / with key presses

// spacebar = pause and restart animation
// +        = redraw() advances 1 iteration in the animation
// r        = render to PDF
// c        = recolor and redraw() advances 1 iteration in the animation

void keyPressed() {
	if (key == ' ') {
		if (paused) {
			loop();
			paused = false;
		} else {
			noLoop();
			paused = true;
		}
	}

	if (key == '+') {
		redraw();
	}

	if (key == 'p') {
		savePNG();
	}

	if (key == 'r') {
		record = true;
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


void savePNG() {
	saveFrame("render_#####.png");
}



