//  SEE:   https://ello.co/ericfickes/post/hesjjhnhdadcytrklq8jzg
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;
Fixlib fix = Fixlib.init(this);


float x,y,z,rot;



void settings(){
  size(displayWidth, displayHeight, P3D);
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}



void setup() {
  frameRate(666);
  background(#ef69ef);

  rectMode(CENTER);
  noFill();
  strokeWeight(PI);

  x = width/2;
  y = height/2;

}


void draw() {
  
  
  translate(x,y,z);
  rotate(radians(rot));
  
  // this one is touchy
  strokeWeight(rot/z/PI);
  
  rect(0,0, rot*PI, rot*PI, -z*TWO_PI);    //  fun
  //rect(0,0, rot*PI, rot*PI, z*TWO_PI);    // standard
  
  stroke(frameCount%2==0?0:255);
  
  z+=TWO_PI;
  
  
  if(z>width){
    z=0;
    rot += TWO_PI;
  }
  
  
  if( (rot*PI)>width){
  	save(fix.pdeName()+fix.getTimestamp()+".png");
    exit();
  }
}
