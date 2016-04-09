import de.voidplus.leapmotion.*;
LeapMotion leap;

ParticleManager pm;

PImage[] imgs = new PImage[4];

PGraphics container;

void setup() {
	size(1280, 1024, P3D);
	H.init(this).background(#ECECEC).use3D(true).autoClear(false);
	smooth();

	container = createGraphics( width/2, height, P3D );

	leap = new LeapMotion(this);

	pm = new ParticleManager();

	// load images into array
	imgs[0] = loadImage("1kate.png");
	imgs[1] = loadImage("2ash.png");
	imgs[2] = loadImage("3jeremy.png");
	imgs[3] = loadImage("4momdad.png");

	// DIABLE Z-BUFFER
	hint(DISABLE_DEPTH_TEST);

}

PVector finger_tip;

void draw() {
	H.drawStage();

	for(Hand hand : leap.getHands() ) {
		for(Finger finger : hand.getFingers() ) {
			finger_tip = finger.getPositionOfJointTip();

			int fingerType = finger.getType();

			switch (fingerType) {
				// thumb
				// case 0:
				// addParticleBurst(fingerType, finger_tip, #FF3300);
				// break;

				// index
				case 1:
				addParticleBurst(fingerType, finger_tip, #B378D3);
				break;

				// middle
				case 2:
				addParticleBurst(fingerType, finger_tip, #008000);
				break;

				// ring
				case 3:
				addParticleBurst(fingerType, finger_tip, #0000ff);
				break;

				// pinky
				case 4:
				addParticleBurst(fingerType, finger_tip, #551a8b);
				break;
			}
		}
	}

	pm.run();


	image( container, 0,0 );

	pushMatrix();
		scale(-1,1);
		translate(-width, 0);
		image(container, 0,0);
	popMatrix();

}

void addParticleBurst(int i, PVector finger_tip, color clr ) {
	ParticleSystem ps = new ParticleSystem(i, finger_tip, clr);
	pm.createSystem(ps);
}









////// S SAVE HANDLER /////////

void keyPressed(){
switch(key){
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









