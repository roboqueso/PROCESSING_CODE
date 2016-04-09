import de.voidplus.leapmotion.*;
LeapMotion leap;
PImage iTip, iDip, iPip, iMcp;


void setup() 
{
  size(900,900, P3D);
  background(255);
  smooth();


  leap = new LeapMotion(this);

	iTip = loadImage("cross.png");
	iDip = loadImage("dip.png");
	iPip = loadImage("pip.png");
	iMcp = loadImage("mcp.png");

}


PVector hand_position, finger_tip, finger_dip, finger_pip, finger_mcp;
float curZ;

ArrayList<PVector> tips = new ArrayList<PVector>();


void draw() 
{
// background(255);

	// HAND TIME
	for(Hand hand : leap.getHands() )
	{
		
		hand_position = hand.getPosition();

		// FINGER TIME
		for( Finger finger : hand.getFingers() )
		{
			// store finger tip
			tips.add(finger.getPositionOfJointTip());
			tips.add(finger.getPositionOfJointDip());
			tips.add(finger.getPositionOfJointPip());
			tips.add(finger.getPositionOfJointMcp());
		}

		// store hand
		tips.add(hand_position);
	}



	beginShape(TRIANGLE_STRIP);

		texture(iMcp);

		for( PVector pv : tips )
		{
			// curveVertex( pv.x, pv.y, pv.z );

			tint(random(255), random(255), random(255));
			vertex( pv.x, pv.y, frameCount, random(iMcp.width), random(iMcp.height) );
		}

	endShape();

	tips.clear();


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

