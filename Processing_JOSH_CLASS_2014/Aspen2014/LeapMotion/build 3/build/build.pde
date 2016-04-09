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

background(255);
// fill(255,5);
// rect(0,0,width/2,height);

noFill();
	// HAND TIME
	for(Hand hand : leap.getHands() )
	{

		hand_position = hand.getPosition();
		
		// FINGER TIME
		for( Finger finger : hand.getFingers() ){

			finger_mcp = finger.getPositionOfJointMcp();
			finger_pip = finger.getPositionOfJointPip();
			finger_dip = finger.getPositionOfJointDip();
			finger_tip = finger.getPositionOfJointTip();

			strokeWeight(9); stroke(#FFCC00); noFill();
			line( finger_dip.x, finger_dip.y, finger_dip.z, finger_tip.x, finger_tip.y, finger_tip.z );

			strokeWeight(9); stroke(#FF9900); noFill();
			line( finger_pip.x, finger_pip.y, finger_pip.z, finger_dip.x, finger_dip.y, finger_dip.z );
			
			strokeWeight(9); stroke(#FF6600); noFill();
			line( finger_mcp.x, finger_mcp.y, finger_mcp.z, finger_pip.x, finger_pip.y, finger_pip.z );
			
			strokeWeight(9); stroke(#FF3300); noFill();
			line( hand_position.x, hand_position.y, hand_position.z, finger_mcp.x, finger_mcp.y, finger_mcp.z );


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

