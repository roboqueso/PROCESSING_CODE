import de.voidplus.leapmotion.*;

LeapMotion leap;

int sz = 100;

ArrayList<PVector> points = new ArrayList<PVector>();

float   hand_roll;
float   hand_pitch;
float   hand_yaw;
float   hand_time;

void setup()
{
  size(1280, 1024, P3D);
  background(255);
  smooth();

  strokeWeight(2);
  stroke(255);
  
  // ...
    
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

  // draw with points
  beginShape(POLYGON);

    for( PVector pt : points ){
      


      vertex( pt.x + hand_roll, pt.y + hand_pitch, pt.z + hand_yaw );

    }
  endShape(CLOSE);


  points.clear();  
  
  }

}


