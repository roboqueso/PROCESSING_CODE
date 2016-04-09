import de.voidplus.leapmotion.*;
import processing.pdf.*;


LeapMotion leap;
PVector hand_position, finger_tip, finger_dip, finger_pip, finger_mcp;
float curZ;
ArrayList<PVector> tips = new ArrayList<PVector>();

PVector fing1, fing2, fing3;

void setup() 
{
  size(1000,900);
  background(255);
  stroke(0);
  smooth();

  leap = new LeapMotion(this);
    

	beginRecord(PDF, "layout.pdf");
}




void draw() 
{



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
					fing1 = finger.getPositionOfJointTip();
				break;

				case 2:
					fing2 = finger.getPositionOfJointTip();
				break;

				case 4:
					fing3 = finger.getPositionOfJointTip();
				break;
			}			
		}


		triangle( fing1.x, fing1.y, fing2.x, fing2.y, fing3.x, fing3.y );

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
		endRecord();
		exit();
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

