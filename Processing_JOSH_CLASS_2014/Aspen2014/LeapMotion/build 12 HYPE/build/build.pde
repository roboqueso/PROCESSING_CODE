import de.voidplus.leapmotion.*;
LeapMotion leap;

ParticleManager pm;

void setup() {
	size(1280, 1024, P3D);
	H.init(this).background(#ECECEC).use3D(true).autoClear(false);
	smooth();

	leap = new LeapMotion(this);

	pm = new ParticleManager();
}

void draw() {

	H.drawStage();


// don't clear if 2 hands
// if( leap.getHands().size() > 1 )
// 	H.autoClear(false);
// else
// 	H.autoClear(true);





	for(Hand hand : leap.getHands() ) {
		for(Finger finger : hand.getFingers() ) {
			PVector finger_tip = finger.getPositionOfJointTip();

			int fingerType = finger.getType();

			switch (fingerType) {
				// thumb
				case 0:
				addParticleBurst(fingerType, finger_tip, #FF3300);
				break;

				// index
				case 1:
				addParticleBurst(fingerType, finger_tip, #FF6600);
				break;

				// middle
				case 2:
				addParticleBurst(fingerType, finger_tip, #FF9900);
				break;

				// ring
				case 3:
				addParticleBurst(fingerType, finger_tip, #FFCC00);
				break;

				// pinky
				case 4:
				addParticleBurst(fingerType, finger_tip, #FFFF00);
				break;
			}
		}
	}

	pm.run();

}

void addParticleBurst(int i, PVector finger_tip, color clr ) {
	ParticleSystem ps = new ParticleSystem(i, finger_tip, clr);
	pm.createSystem(ps);
}















