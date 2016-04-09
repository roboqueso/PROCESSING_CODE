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
	// fill(random(255),5);
	// rect(0,0, width/2, height );
	// stroke(random(random(255)));
	

	// HAND TIME
	for(Hand hand : leap.getHands() )
	{

		hand_position = hand.getPosition();
		curZ = map( hand_position.z, -25, 100, 500, -500 );
		stroke(curZ);

fill(#19ef75);
		pushMatrix();
			translate( hand_position.x, hand_position.y, curZ );
		  
			rotateX( radians( map( hand.getRoll(), -100, 100, 180, -180 ) ) );
			rotate( radians( map( hand.getPitch(), -100, 100, 180, -180 ) ) );

			// sphereDetail((int)random(curZ));
			sphere(50);

		popMatrix();


		// FINGER TIME
		for( Finger finger : hand.getFingers() ){

			finger_dip = finger.getPositionOfJointDip();
			finger_pip = finger.getPositionOfJointPip();
			finger_tip = finger.getPositionOfJointTip();
			finger_mcp = finger.getPositionOfJointMcp();

			noStroke(); fill(#FF9900);			
			pushMatrix();
				translate( finger_dip.x, finger_dip.y );
				sphere(20);
			popMatrix();

			noStroke(); fill(#FF4500);
			pushMatrix();
				translate( finger_tip.x, finger_tip.y );
				sphere(20);
			popMatrix();

			noStroke(); fill(#FF1500);
			pushMatrix();
				translate( finger_pip.x, finger_pip.y );
				sphere(20);
			popMatrix();

			noStroke(); fill(#EF1975);
			pushMatrix();
				translate( finger_mcp.x, finger_mcp.y );
				sphere(20);
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

