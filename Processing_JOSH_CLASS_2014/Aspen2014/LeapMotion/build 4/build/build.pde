import de.voidplus.leapmotion.*;
LeapMotion leap;

void setup() {
  size(900,900, P3D);
  background(#EF3900);
  smooth();

  leap = new LeapMotion(this);
}


PVector hand_position, finger_tip, finger_dip, finger_pip, finger_mcp;
float curZ;


void draw() {


// fill(#ECECEC,5);
// rect(0,0,width/2, height);
// noFill();

background(#ECECEC);


	// HAND TIME
	for(Hand hand : leap.getHands() )
	{

		hand_position = hand.getPosition();
		
		// FINGER TIME
		for( Finger finger : hand.getFingers() ){

			finger_tip = finger.getPositionOfJointTip();

			strokeWeight(9); stroke(#FF3300); noFill();

			pushMatrix();
				
				curZ = map(finger_tip.z, 0, 100, 300, -300);

				translate( finger_tip.x, finger_tip.y, curZ );

				ellipse(0,0,20,20);

			popMatrix();
		}

	}



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

