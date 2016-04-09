import de.voidplus.leapmotion.*;
LeapMotion leap;

ParticleManager pm;
HPixelColorist colors;

void setup() {
	size(1280, 1024, P3D);
	H.init(this).background(#ECECEC).use3D(true).autoClear(true);
	smooth();

	colors = new HPixelColorist("sunset.jpg").fillOnly();

	leap = new LeapMotion(this);

	pm = new ParticleManager();
}

void draw() {
	H.drawStage();

	for(Hand hand : leap.getHands() ) {
		for(Finger finger : hand.getFingers() ) {
			PVector finger_tip = finger.getPositionOfJointTip();

			int fingerType = finger.getType();

			switch (fingerType) {
				// thumb
				case 0:
				addParticleBurst(fingerType, finger_tip, colors.getColor( finger_tip.x, finger_tip.y ) );
				break;

				// index
				case 1:
				addParticleBurst(fingerType, finger_tip, colors.getColor( finger_tip.x, finger_tip.y ) );
				break;

				// middle
				case 2:
				addParticleBurst(fingerType, finger_tip, colors.getColor( finger_tip.x, finger_tip.y ) );
				break;

				// ring
				case 3:
				addParticleBurst(fingerType, finger_tip, colors.getColor( finger_tip.x, finger_tip.y ) );
				break;

				// pinky
				case 4:
				addParticleBurst(fingerType, finger_tip, colors.getColor( finger_tip.x, finger_tip.y ) );
				break;
			}
		}
	}

	pm.run();

}

void addParticleBurst(int i, PVector finger_tip, color clr ) {

	pm.createSystem( new ParticleSystem(i, finger_tip, clr) );

}















