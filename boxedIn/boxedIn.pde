float x,y,z,rot;

void setup() {
  size(1024, 768,P3D);
  x = width/2;
  y = height/2;
  rectMode(CENTER);
  noFill();
  smooth();
  strokeWeight(PI);
  frameRate(420);
}


void draw() {
  
  translate(x,y,z);
  rotate(radians(rot));
  
  strokeWeight(rot/z+(HALF_PI));
  
  rect(0,0, rot*PI, rot*PI, z);
  
  stroke(frameCount%2==0?0:255);
  
  z+=TWO_PI;
  
  
  if(z>width){
    z=0;
    rot += TWO_PI;
  }
  
  
  if( (rot*PI)>width){
  	save(fix.pdeName()+fix.getTimestamp()+".png");
    noLoop();
  }
}

