class Hex {

int varSix = 6;	//	6

	PVector[] p = new PVector[varSix];
	PVector[] innerP = new PVector[varSix];

	PVector loc;

	float innerRad, outerRad;

	float innerRadOffset = radians(30);
	PVector offset;

	Hex(float locX, float locY, float iR, float oR) {
		loc = new PVector(locX, locY);
		innerRad = iR;
		outerRad = oR;

		float diff = (oR - iR);
		offset = new PVector(
			random(diff) - (diff/2.0),
			random(diff) - (diff/2.0)
		);
		setup();
	}

	void rotation(float r) {
		innerRadOffset = radians(30 + r);
		setup();
	}

	void setup() {
		float z = -36;

		float startAngle = radians(30);
		float twoPi6 = TWO_PI / varSix;

		for (int i = 0; i < varSix; i++) {
			float x = outerRad * cos(startAngle + (twoPi6 * i));
			float y = outerRad * sin(startAngle + (twoPi6 * i));
			p[i] = new PVector(x, y);

			x = offset.x + innerRad * cos(innerRadOffset + (TWO_PI/varSix) * i);
			y = offset.y + innerRad * sin(innerRadOffset + (TWO_PI/varSix) * i);
			
			innerP[i] = new PVector(x, y, z);
		}
	}

	void render() {
		// beginShape();
		// 	for (int i = 0; i < 6; i++) {
		// 		vertex(p[i].x, p[i].y);
		// 	}
		// endShape(CLOSE);

		// beginShape();
		// 	for (int i = 0; i < 6; i++) {
		// 		vertex(innerP[i].x, innerP[i].y);
		// 	}
		// endShape(CLOSE);

		pushMatrix();
			translate(loc.x, loc.y);

			beginShape(QUADS);
				for (int i = 0; i < varSix; i++) {

					if (i == 5) {
						vertex(p[i].x, p[i].y, 0);
						vertex(innerP[i].x, innerP[i].y, innerP[i].z);
						vertex(innerP[0].x, innerP[0].y, innerP[0].z);
						vertex(p[0].x, p[0].y, 0);
					} else {
						vertex(p[i].x, p[i].y, 0);
						vertex(innerP[i].x, innerP[i].y, innerP[i].z);
						vertex(innerP[i+1].x, innerP[i+1].y, innerP[i+1].z);
						vertex(p[i+1].x, p[i+1].y, 0);
					}
				}
			endShape();
		popMatrix();
	}
}
