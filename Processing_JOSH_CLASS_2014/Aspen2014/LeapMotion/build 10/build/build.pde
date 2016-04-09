import de.voidplus.leapmotion.*;
LeapMotion leap;


// DRAW() vars
PVector hand_position, finger_tip, finger_dip, finger_pip, finger_mcp;
float curZ;
int fingerType;

ArrayList<ParticleSystem> systems = new ArrayList<ParticleSystem>();

///////////////////////////////////////////////////////////////////////////////
void setup() {
  size(900,900, P3D);
  background(255);
  smooth();

  leap = new LeapMotion(this);

}


///////////////////////////////////////////////////////////////////////////////
void draw() {

  // background(255);


	// HAND TIME
	for(Hand hand : leap.getHands() )
	{

		hand_position = hand.getPosition();
		
		// FINGER TIME
		for( Finger finger : hand.getFingers() ){

			finger_tip = finger.getPositionOfJointTip();

			fingerType = finger.getType();

			switch( fingerType )
			{
				case 0:
				// thumb
				addParticleBurst( fingerType, finger_tip, #EF1975 );
				break;

				case 1:
				// index
				addParticleBurst( fingerType, finger_tip, #FF3300 );
				break;

				case 2:
				// middle
				addParticleBurst( fingerType, finger_tip, #EFEF00 );
				break;

				case 3:
				// ring
				addParticleBurst( fingerType, finger_tip, #20EF14 );
				break;

				case 4:
				// pinky
				addParticleBurst( fingerType, finger_tip, #1975EF );
				break;
			}




		}

	}

	// moved to ParticleSystem
	for( ParticleSystem ps : systems ){
		ps.run();
	}

}

///////////////////////////////////////////////////////////////////////////////
void addParticleBurst(int whichFinger, PVector finger_tip, color clr)
{
	systems.add( new ParticleSystem( whichFinger, finger_tip, clr ));
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

