import de.voidplus.leapmotion.*;
LeapMotion leap;

ParticleManager pm;

void setup() {
	size(1280, 1024, P3D);
	H.init(this).background(#ECECEC).use3D(true).autoClear(true);
	smooth();

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


	if( key == 'x') 
	{ 
		H.autoClear(false); 
	} 
	else if( key == 'z') 
	{ 
		H.autoClear(true); 
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








