import de.voidplus.leapmotion.*;
LeapMotion leap;

void setup() {
  size(900,900, P3D);
  background(#EF3900);
  smooth();

  leap = new LeapMotion(this);
}


PVector hand_position;
float curZ;

void draw() {


// FAKE BACKGROUND FILL
fill(#EF3900, 5);
rect(0,0 , width/2, height);

  
  for(Hand hand : leap.getHands() ){

    hand_position = hand.getPosition();
    curZ = map( hand_position.z, -25, 100, 500, -500 );

    pushMatrix();

      fill(hand_position.x - curZ);
      translate( hand_position.x, hand_position.y, curZ );
      box(curZ);

    popMatrix();



    stroke(0);
    strokeWeight(4);
    line( hand_position.y, hand_position.x - curZ , hand_position.x, hand_position.y );
    
    stroke(hand_position.x - curZ);
    strokeWeight(2);
    line( hand_position.y, hand_position.x - curZ , hand_position.x, hand_position.y );



    pushMatrix();

      fill(hand_position.x - curZ);
      translate( hand_position.y, hand_position.x, curZ );
      sphereDetail((int)random(curZ));
      sphere(curZ);

    popMatrix();


  }


fill(#EFEF00, 11);
rect(width*.75,0 , width*.25, height);


}
