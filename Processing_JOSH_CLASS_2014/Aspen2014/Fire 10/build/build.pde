import de.voidplus.leapmotion.*;

LeapMotion leap;

int sz = 100;

ArrayList<PVector> points = new ArrayList<PVector>();

PImage fire1, fire2, fire3, fire4;
PImage imgTexture = new PImage();

int colorTheme;

float   hand_roll;
float   hand_pitch;
float   hand_yaw;
float   hand_time;

void setup()
{
  size(1280, 1024, P3D);
  background(255);
  smooth();
  noFill();
  noStroke();

  
  fire1 = loadImage("fire1.png");
  fire2 = loadImage("fire2.png");
  fire3 = loadImage("fire3.png");
  fire4 = loadImage("fire4.png");
    
  leap = new LeapMotion(this);

  imgTexture = fire1;
}

void draw(){
  



if(frameCount%15==0)
{
  // HANDS
  for(Hand hand : leap.getHands()){

    
    hand_roll        = hand.getRoll();
    hand_pitch       = hand.getPitch();
    hand_yaw         = hand.getYaw();
    hand_time        = hand.getTimeVisible();

    // float   sphere_radius    = hand.getSphereRadius();


	points.add( hand.getPosition() );
	points.add( hand.getSpherePosition() );

    // FINGERS
    for(Finger finger : hand.getFingers()){
      
      points.add( finger.getPosition() );
      points.add( finger.getStabilizedPosition() );

    }
    
	points.add( hand.getStabilizedPosition() );
 
    
  }



  beginShape();



	switch(colorTheme)
	{

		case 1:
		imgTexture = fire1;
		// BLUE
		// tint( #1975EF );
		tint( random(20,40), random(40,60), random(80,160) );
		break;

		case 2:
		imgTexture = fire2;
		// tint(#39EF39);
		// red
		tint( random(145,156), random(22,42), random(11) );
		break;

		case 3:
		imgTexture = fire3;
		tint(#EF1975);
		break;

		case 4:
		imgTexture = fire4;
		tint( random(222,255), random(200,215), random(11));
		break;

		default:
			imgTexture = fire1;
			noTint();
		break;
	}

	texture(imgTexture);

    for( PVector pt : points ){
      vertex(pt.x, pt.y, pt.z, random(imgTexture.width), random(imgTexture.height));

    }
  endShape();


  points.clear();  
  
  }




}





////// S SAVE HANDLER /////////

void keyPressed(){
switch(key)
{


	case '1':
		colorTheme = 1;
	break;

	case '2':
		colorTheme = 2;
	break;

	case '3':
		colorTheme = 3;
	break;

	case '4':
		colorTheme = 4;
	break;

	case '5':
		colorTheme = 0;
	break;


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


