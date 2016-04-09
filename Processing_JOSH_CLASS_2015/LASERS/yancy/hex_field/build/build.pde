HDrawablePool pool;
HDrawablePool pool2;
HDrawablePool pool3;
// HColorPool colors;
HColorField colors;
HColorField colors2;
HColorField colors3;
HColorField colors4;



HRotate rot;

int rotation =0;

void setup(){
	size(1000,1500);
	H.init(this).background(#202020);
	smooth();

	colors = new HColorField(width, height)  //
		.addPoint(0, height/2, #6600FF, 1.5f)  // orange #ff3300
		.addPoint(width, height/2, #FF0099, 1.5f)  //teal #0095a8
		// .fillOnly()
	;	

	colors2 = new HColorField(width, height)
		.addPoint(width/2, height, #FF6600, 1.5f)  // orange
		.addPoint(width/2, 0, #0099FF, 1.5f)  //teal
		// .fillOnly()
	;	

	// colors3 = new HColorField(width, height)
	// 	.addPoint(0, 0, #00FF66, 1.5f)  // orange
	// 	.addPoint(width, height, #99FF00, 1.5f)  //teal
	// 	// .fillOnly()
	// ;

	colors4 = new HColorField(width, height)
		.addPoint(width, 0, #6600FF, 1.5f)  // orange
		.addPoint(0, height, #0099FF, 1.5f)  //teal
		// .fillOnly()
	;	

  HCanvas c = new HCanvas().autoClear(true); //.fade(16).filter(BLUR, 1);
    H.add(c);

	pool = new HDrawablePool(5096); //19 //168  1027
	pool.autoParent(c)
		.add( new HPath() )

		.layout(
			new HHexLayout()
			.spacing(24)
			.offsetX(24)
			.offsetY(0)
		)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();
					HPath d = (HPath) obj;
					d
						.polygon(6)
						.size(24)
						.anchorAt(H.CENTER)
						.fill(#000000, 255)
						// .stroke(#191919)
						.noStroke()
						//.noFill()
					;		
					colors2.applyColor(d);
					d.scale( (int) random(-1,3) );
				}
			}
		)
		.requestAll()
	;

	pool = new HDrawablePool(5096); //19 //168  1027
	pool.autoParent(c)
		.add( new HPath() )

		.layout(
			new HHexLayout()
			.spacing(24)
			.offsetX(0)
			.offsetY(0)
		)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();
					HPath d = (HPath) obj;
					d
						.polygon(6)
						.size(24)
						.anchorAt(H.CENTER)
						.fill(#000000, 175)
						// .stroke(#191919)
						.noStroke()
						//.noFill()
					;		
					colors4.applyColor(d);
					d.scale( (int) random(-1,3) );
				}
			}
		)
		.requestAll()
	;

	pool = new HDrawablePool(5096); //19 //168  1027
	pool.autoParent(c)
		.add( new HPath() )

		.layout(
			new HHexLayout()
			.spacing(24)
			.offsetX(12)
			.offsetY(20)
		)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();
					HPath d = (HPath) obj;
					d
						.polygon(6)
						.size(24)
						.anchorAt(H.CENTER)
						.fill(#000000, 100)
						// .stroke(#191919)
						.noStroke()
						//.noFill()
					;		
					colors.applyColor(d);
					d.scale( (int) random(-1,3) );
				}
			}
		)
		.requestAll()
	;

}
 
void draw(){

/*
	float orbitRadius= 1550;
	float xpos= cos(radians(rotation))*orbitRadius;
	float zpos= sin(radians(rotation))*orbitRadius;

	camera(
		xpos, 0, zpos,
		width/2, height/2, 0,
		0, -1, 0
	);
*/
	//rotation++;
	//translate(width/2, 0);
	//rotate( radians(rotation) );
	// rotation = rotation + 4;




	H.drawStage();

	if(frameCount % 2 == 0 && frameCount >=0 && frameCount < 3){
		saveFrame("image-#####.png");
	}

 }

