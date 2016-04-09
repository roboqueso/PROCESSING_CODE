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

  strokeWeight(PI);
  stroke(255);
  
  fire1 = loadImage("fire1.png");
  fire2 = loadImage("fire2.png");
  fire3 = loadImage("fire3.png");
  fire4 = loadImage("fire4.png");
    
  leap = new LeapMotion(this);
}

void draw(){
  fill(0, 200);

  int fps = leap.getFrameRate();
  

if(frameCount%15==0)
{
  // HANDS
  for(Hand hand : leap.getHands()){

    
    hand_roll        = hand.getRoll();
    hand_pitch       = hand.getPitch();
    hand_yaw         = hand.getYaw();
    hand_time        = hand.getTimeVisible();

    float   sphere_radius    = hand.getSphereRadius();

    points.add( hand.getPosition() );
    points.add( hand.getSpherePosition() );

    // FINGERS
    for(Finger finger : hand.getFingers()){
      
      points.add( finger.getPosition() );
      points.add( finger.getStabilizedPosition() );

    }
    
    
  }


  // pick the fire
  if(frameCount%5==0){
  	imgTexture = fire1;
  } 
  else if(frameCount%6==0){
	imgTexture = fire2;
  } 
  else if(frameCount%7==0){
	imgTexture = fire3;
  } 
  else {
	imgTexture = fire4;
  }

  // draw with points
  beginShape();

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


