//	Nine years was enough thanks
//  see: https://ello.co/ericfickes/post/awpoowut22qsm2yx48rwsq 
import nervoussystem.obj.*;

ArrayList<Hex> hexes;
PImage grad;
Boolean itson = false;


void setup() {
	size(1728, 828, P3D);
	background(0);

	// grad = loadImage("../../../data/grad_sweep2.png");
grad = loadImage("Sunny2.png");

	hexes = new ArrayList<Hex>();

	float hexRadius = 75.0;

	int numCols = 8;
	int numRows = 8;

	float startX = hexRadius;
	float startY = hexRadius;

	float sqrt3 = sqrt(3);
	float hSpacingX = sqrt3 * hexRadius;
	float hSpacingY = hexRadius * 2;

	for (int j = 0; j < numRows; j++) {
		for (int i = 0; i < numCols; i++) {
			float x = startX + i * hSpacingX;
			if (j%2 == 0) {
				x += hSpacingX/2.0;
			}
			float y = startY + j * (hSpacingY*0.75);

			int lookupX = (int) map(x, 0, width, 0, grad.width);
			int lookupY = (int) map(y, 0, height, 0, grad.height);


			color myColor = grad.get(floor(lookupX), floor(lookupY));
			float bright = map(brightness(myColor), 0.0, 255.0, 0.0, 1.0);
			float myRad = map(bright, 1.0, 0.0, 0.0, 27.0) + 9.0;

			float myRotation = map(bright, 1.0, 0.0, 0.0, 30.0);

			Hex h = new Hex(x, y, myRad, hexRadius);
			h.rotation(myRotation);

			hexes.add(h);
		}
	}
}

void draw() {
	// background(0);
	// lights();


	pushMatrix();
		translate(width/2, height/2);
		rotateX(map(mouseY, 0, height, -(TWO_PI/2), TWO_PI/2));
		rotateY(map(mouseX, 0, width, -(TWO_PI/2), TWO_PI/2));
		translate(-width/2, -height/2);

		for (Hex h : hexes) {
			h.render();
		}

	popMatrix();


	if(itson){
		endRecord();
		save(this+".png");
		exit();
	}
}


void mouseClicked(){
	println("MOUSE CLICKED!");
	beginRecord("nervoussystem.obj.OBJExport", this+".obj");
	itson = true;
}
