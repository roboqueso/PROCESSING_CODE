import de.voidplus.leapmotion.*;

LeapMotion leap;
Finger finger_front;
Hand hand;
Finger finger;
HPixelColorist colors;


HFollow mf;
HRect d;
HOrbiter o;
ParticleManager pm;
PShape s;

int numShapes;
int handCt;

int mouseZ = 0;
boolean zFwd = true;

ArrayList texList;
PImage tex1, tex2, tex3;
PVector tp1, tp2, tp3;
PImage[] pickedTex;

int[] texScale = {75, 150, 200};
int pickedTexScale = texScale[0];


void setup() {
	size(1000,900,P3D);
	H.init(this).background(#EFEFEF).autoClear(false);
	smooth();

	leap = new LeapMotion(this);

	s = loadShape("layout2.svg");
	numShapes = s.getChildCount();
	
	texList = new ArrayList();
	tex1 = loadImage("1.png");
	tex2 = loadImage("2.png");
	tex3 = loadImage("3.png");
	texList.add(tex1);
	texList.add(tex2);
	texList.add(tex3);


	colors = new HPixelColorist("e_and_k.png").fillOnly();
	pm = new ParticleManager();
	pickedTex = new PImage[numShapes];

	for (int i = 0; i < numShapes; ++i) {
		pickedTex[i] = (PImage)texList.get( (int)random( texList.size() ) );
	}

	leap = new LeapMotion(this);

	pm = new ParticleManager();
}

void draw() {
	H.drawStage();


	if( leap.getHands().size() > 0 )
	{
		hand = leap.getHands().get(0);

		finger = hand.getFrontFinger();

		if(finger != null)
		{
			// GET THE TIP
			PVector finger_tip = finger.getPositionOfJointTip();

			addParticleBurst(finger.getType(), finger_tip, colors.getColor( finger_tip.x, finger_tip.y ) );


		if(frameCount% 60 == 0 ){
			for (int i = 0; i < numShapes; ++i) {
				buildVertex( s.getChild(i), i, mouseZ );
			}
		}


		} else {

			text("null finger", random(width), random(height) );
		}

	}


	mouseZ++;
	
	if(mouseZ>100) mouseZ = 0;


	pm.run();

}


void buildVertex(PShape curShape, int triNum, int z) {

	noStroke(); noFill();

	tp1 = new PVector(0,0, random(frameCount) );
	tp2 = new PVector(pickedTexScale, 0, random(frameCount) );
	tp3 = new PVector(0, pickedTexScale, random(frameCount) );

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
		rotate(i);
		vertex(v.x, v.y, random(-42,42), texPos.x, texPos.y);

}
	endShape();

}


void addParticleBurst(int i, PVector finger_tip, color clr ) {

	pm.createSystem( new ParticleSystem(i, finger_tip, clr) );

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












