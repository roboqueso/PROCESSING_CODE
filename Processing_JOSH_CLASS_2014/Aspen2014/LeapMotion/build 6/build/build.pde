import de.voidplus.leapmotion.*;
LeapMotion leap;

void setup() {
  size(900,900, P3D);
  background(255);
  smooth();

  leap = new LeapMotion(this);
}


PVector hand_position, finger_tip, finger_dip, finger_pip, finger_mcp, finger_front_tip;
Finger finger_front;
float curZ;


void draw() {

// if(frameCount%11==0){
// fill(#ECECEC, 5);
// noStroke();
// rect(0,0,width, height);
// }
// noFill();

background(255);


	// HAND TIME
	for(Hand hand : leap.getHands() )
	{


		hand_position = hand.getPosition();


		// FINGER TIME
		for( Finger finger : hand.getFingers() ){


			finger_tip = finger.getPositionOfJointTip();
			finger_front = leap.getFrontFinger();
			finger_front_tip = finger_front.getPositionOfJointTip();


			// only color the forward most fingle
			if( finger_tip.z == finger_front_tip.z )
			{

				switch( finger.getType() )
				{
					case 0:
					// thumb
					styleFinger( finger_tip, #EF3300 );

					break;

					case 1:
					// index
					styleFinger( finger_tip, #EF6600 );
					break;

					case 2:
					// middle
					styleFinger( finger_tip, #EF9900 );
					break;

					case 3:
					// ring
					styleFinger( finger_tip, #EFCC00 );
					break;

					case 4:
					// pinky
					styleFinger( finger_tip, #EFEF14 );
					break;
				}
			}
		}



	}



}





void styleFinger(PVector finger_tip, color clr)
{
	strokeWeight(9); stroke(clr); noFill();

	pushMatrix();
		
		curZ = map(finger_tip.z, 0, 100, 900, -900);

		translate( finger_tip.x, finger_tip.y, curZ );

		ellipse(0,0,20,20);

	popMatrix();	

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

