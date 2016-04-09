HShapeLayout hsl;

int numAssets = 500;
PVector xPos, section4, section3, section2, section1;

HDrawablePool pool;

void setup(){
	size(1600,700);
	H.init(this).background(#111111).autoClear(true);
	smooth();

	section4 = new PVector(1176, 1600,  5);
	section3 = new PVector(800,  1175, 10);
	section2 = new PVector(426,   800, 25);
	section1 = new PVector(0,     425,  0);

	HImage hitObj = new HImage("shape.png");
	H.add(hitObj);

	hsl = new HShapeLayout().target(hitObj);

	pool = new HDrawablePool(numAssets);
	pool.autoAddToStage()
		.add(new HShape("flower1c.svg"))
		.add(new HShape("flower2c.svg"))
		.add(new HShape("flower3c.svg"))
		.add(new HShape("flower4c.svg"))
		.add(new HShape("flower5c.svg"))
		
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.stroke(#000000)
						.fill(#ECECEC)
						.size(25)
						.anchorAt(H.CENTER)
						.rotation(45)
					;
					xPos = hsl.getNextPoint();
					checkLayoutPosition(d);
				}
			}
		)
		.requestAll()
	;
}
 
void draw(){ H.drawStage(); }

void checkLayoutPosition(HDrawable d) {
	if (xPos.x >= section4.x && xPos.x <= section4.y) {
		if (section4.z==0) {
			xPos = hsl.getNextPoint();
			checkLayoutPosition(d);
		} else {
			d.loc(xPos.x, xPos.y);
			section4.z -= 1;
		}
	} else if (xPos.x >= section3.x && xPos.x <= section3.y) {
		if (section3.z==0) {
			xPos = hsl.getNextPoint();
			checkLayoutPosition(d);
		} else {
			d.loc(xPos.x, xPos.y);
			section3.z -= 1;
		}
	} else if (xPos.x >= section2.x && xPos.x <= section2.y) {
		if (section2.z==0) {
			xPos = hsl.getNextPoint();
			checkLayoutPosition(d);
		} else {
			d.loc(xPos.x, xPos.y);
			section2.z -= 1;
		}
	} else {
		d.loc(xPos.x, xPos.y);
	}
}

void keyPressed() { if (key == 'r') saveVector(); }

void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "render.pdf");
	if (tmp == null) H.drawStage();
	else             H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha
	endRecord();
}








