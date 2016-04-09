import processing.pdf.*;

HDrawablePool pool1;

int myRadius = 300;

void setup(){
	size(1024,768,P3D);
	H.init(this).background(#999999).use3D(true);
	smooth();

	pool1 = new HDrawablePool(10);
	pool1.autoAddToStage()
		.add(new HShape("hex_master_1.svg"))
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d.anchorAt(H.CENTER).loc(width/2, height/2);
					HOrbiter3D dOrb3D = new HOrbiter3D(width/2, height/2, 0).zSpeed(random(-2,2)-0.1).ySpeed(random(-2,2)-0.1).radius(myRadius).zAngle( (int)random(360) ).yAngle( (int)random(360) );
					d.extras( new HBundle().num("w", d.width() ).num("h", d.height()).obj("o", dOrb3D) );
				}
			}
		)
		.requestAll()
	;
}
 
void draw() {
	for(HDrawable d : pool1) {
			HBundle dExtras = d.extras();
			HOrbiter3D o = (HOrbiter3D) dExtras.obj("o");
			float        w = (float)dExtras.num("w");
			float        h = (float)dExtras.num("h");
			o._run();
			float zToScale = (float)map(o.z(), -myRadius, myRadius, 0.25, 1.25);
			d.x(o.x()).y(o.y());
			d.size(w*zToScale,h*zToScale);

	}

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






