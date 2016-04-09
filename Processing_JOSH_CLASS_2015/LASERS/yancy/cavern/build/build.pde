HDrawablePool pool;

float scalar = 1;

boolean record = false;

void setup() {
	size(1200,800);
	H.init(this).background(#202020).use3D(false).autoClear(false);
	smooth();


	pool = new HDrawablePool(30);
	pool.autoAddToStage()
		.add (
			new HEllipse()
			.size(1,1)


		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {


					int i = pool.currentIndex();
					HDrawable d = (HDrawable) obj;
					d
						.noStroke()
						.fill(#FFFFFF)
						.loc( width/2 , height/2 )
					;

					if (i < 20 ){
						d.size(0);
					}


					new HOscillator()
						.target(d)
						.property(H.DROTATION)
						.range(317.5, 137.5)
						.speed( 0.13 )
						.freq(0.11)
						.currentStep(i % 21)
					;

				}
			}
		).requestAll()
	;

}

void draw() {


	int i = 0;
	for (HDrawable d : pool) {
		d.anchor(scalar,i);
		scalar = scalar + 0.0075;
		i++;
	}


	H.drawStage();
	blend(1, 1, width-1, height-1, 0, 0, width, height, LIGHTEST);
}

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

}




void savePNG() {
	saveFrame("render_#####.png");
}

