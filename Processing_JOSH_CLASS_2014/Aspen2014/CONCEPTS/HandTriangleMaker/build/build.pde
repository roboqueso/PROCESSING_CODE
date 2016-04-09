import de.voidplus.leapmotion.*;
LeapMotion leap;


void setup() 
{
  size(900,900, P3D);
  background(255);
  smooth();
  strokeWeight(HALF_PI);

  leap = new LeapMotion(this);

}


PVector hand_position, finger_tip, finger_dip, finger_pip, finger_mcp;
float curZ;

ArrayList<PVector> tips = new ArrayList<PVector>();


void draw() 
{

// STAGGER DRAWING TO STAGE
if(frameCount%30==0){



	// HAND TIME
	for(Hand hand : leap.getHands() )
	{
		
		hand_position = hand.getPosition();

		// FINGER TIME
		for( Finger finger : hand.getFingers() )
		{
			// store finger tip
			switch( finger.getType() )
			{
				case 0:
				case 2:
				case 4:
					tips.add(finger.getPositionOfJointTip());
				break;
			}
			
		}

		// store hand
		// tips.add(hand_position);
		// ellipse( hand_position.x, hand_position.y, 20, 20 );
	}



	beginShape(TRIANGLE);

		for( PVector pv : tips )
		{
			vertex( pv.x, pv.y, pv.z );
			// tint(random(255), random(255), random(255));
			// vertex( pv.x, pv.y, frameCount, random(iMcp.width), random(iMcp.height) );
		}

	endShape();

	tips.clear();
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

