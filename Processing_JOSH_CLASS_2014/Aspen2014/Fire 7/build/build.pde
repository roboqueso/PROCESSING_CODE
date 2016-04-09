import de.voidplus.leapmotion.*;

LeapMotion leap;

int sz = 100;

ArrayList<PVector> points = new ArrayList<PVector>();

PImage fire1, fire2, fire3, fire4;
PImage imgTexture = new PImage();

float   hand_roll;
float   hand_pitch;
float   hand_yaw;
float   hand_time;

void setup()
{
  size(1280, 1024, P3D);
  background(255);
  smooth();

  
  stroke(255);

  
  
  fire1 = loadImage("fire1.png");
  fire2 = loadImage("fire2.png");
  fire3 = loadImage("fire3.png");
  fire4 = loadImage("fire4.png");
    
  leap = new LeapMotion(this);
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

    texture(imgTexture);

    for( PVector pt : points ){
      

	  // pick the fire
	  if( int(pt.x)%5==0){
	  	imgTexture = fire1;
		// blue
		// tint( random(20,40), random(40,60), random(80,160) );
		tint(#1975EF);

	  } 
	  else if(int(pt.x)%6==0){
		imgTexture = fire2;

		// orange
		// tint( random(200, 225), random(120,140), random(21,42) );
		tint(#20EF14);
	  } 
	  else if(int(pt.x)%7==0){
		imgTexture = fire3;

		  tint(#EF1975);

	  } 
	  else {
		imgTexture = fire4;
		noTint();
	  }



      vertex(pt.x, pt.y, pt.z, random(imgTexture.width), random(imgTexture.height));

    }
  endShape();


  points.clear();  
  
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


