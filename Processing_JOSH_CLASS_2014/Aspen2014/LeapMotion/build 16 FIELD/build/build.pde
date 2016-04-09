import de.voidplus.leapmotion.*;
LeapMotion leap;

ParticleManager pm;
HColorField colors;
HPixelColorist pixC;


void setup() {
	size(1280, 1024, P3D);
	H.init(this).background(#ECECEC).use3D(true).autoClear(false);
	smooth();

	pixC = new HPixelColorist("sunset.jpg").strokeOnly();

	colors = new HColorField(width,height)
	.addPoint(0, height/2, #EF1975, 0.5f)
	.addPoint(width, height/2, #1975EF, 0.5f)
	.fillOnly();

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
				addParticleBurst(fingerType, finger_tip, #EF1975 );
				break;

				// index
				case 1:
				addParticleBurst(fingerType, finger_tip, pixC.getColor( finger_tip.x, finger_tip.y ) );
				break;

				// middle
				case 2:
				addParticleBurst(fingerType, finger_tip, pixC.getColor( finger_tip.x, finger_tip.y ) );
				break;

				// ring
				case 3:
				addParticleBurst(fingerType, finger_tip, pixC.getColor( finger_tip.x, finger_tip.y) );
				break;

				// pinky
				case 4:
				addParticleBurst(fingerType, finger_tip, pixC.getColor( finger_tip.x, finger_tip.y ) );
				break;
			}
		}
	}

	pm.run();

}

void addParticleBurst(int i, PVector finger_tip, color clr ) {

	pm.createSystem( new ParticleSystem(i, finger_tip, clr) );

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




















