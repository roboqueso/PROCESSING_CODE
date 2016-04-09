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

  strokeWeight(2);
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


  // 

  // draw with points
  beginShape();

    texture(fire1);

    for( PVector pt : points ){
      
      vertex(pt.x, pt.y, pt.z, random(fire1.width), random(fire1.height));

    }
  endShape();


  points.clear();  
  
  }

}


