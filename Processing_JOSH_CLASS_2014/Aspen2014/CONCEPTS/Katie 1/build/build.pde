PShape s;

int numShapes;

ArrayList texList;
PImage tex1, tex2, tex3;
PVector tp1, tp2, tp3;
PImage[] pickedTex;

int[] texScale = {50, 100, 200};
int pickedTexScale = texScale[0];

void setup() {
	size(1000,900,P3D);
	background(#FFFFFF);
	smooth();

	s = loadShape("layout2.svg");
	numShapes = s.getChildCount();
	
	texList = new ArrayList();
	tex1 = loadImage("1.png");
	tex2 = loadImage("2.png");
	tex3 = loadImage("3.png");
	texList.add(tex1);
	texList.add(tex2);
	texList.add(tex3);

	pickedTex = new PImage[numShapes];

	for (int i = 0; i < numShapes; ++i) {
		pickedTex[i] = (PImage)texList.get( (int)random( texList.size() ) );
	}
}

void draw() {
	// background(#FFFFFF);

	for (int i = 0; i < numShapes; ++i) {
		buildVertex( s.getChild(i), i );
	}
}


void buildVertex(PShape curShape, int triNum) {
	noStroke(); noFill();

	tp1 = new PVector(0,0);
	tp2 = new PVector(pickedTexScale, 0);
	tp3 = new PVector(0, pickedTexScale);

	beginShape(TRIANGLES);
	texture( pickedTex[triNum] );

	for (int i = 0; i < curShape.getVertexCount(); ++i) {
		PVector v = curShape.getVertex(i);
		PVector texPos = new PVector();

		switch (i) {
			case 0:
			texPos = tp1;
			break;

			case 1:
			texPos = tp2;
			break;

			case 2:
			texPos = tp3;
			break;
		}

		vertex(v.x, v.y, v.z, texPos.x, texPos.y);

}
	endShape();

}



////// S SAVE HANDLER /////////

void keyPressed(){
switch(key){

	case '1':
	pickedTexScale = texScale[0];
	break;

	case '2':
	pickedTexScale = texScale[1];
	break;

	case '3':
	pickedTexScale = texScale[2];
	break;

	case 's':
		save(pdeName() + getTimestamp() + ".png");
	break;

	case ESC:
		save(pdeName() + getTimestamp() + ".png");
		stop();
	break;
}

}

public String getTimestamp() {
	return ""+month()+day()+year()+hour()+minute()+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
public String pdeName() {
	return split( this.toString(), "[")[0];
}












