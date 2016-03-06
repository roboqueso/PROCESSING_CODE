float x,y,z,rot;

void setup() {
  size(1024, 768,P3D);
  x = width/2;
  y = height/2;
  rectMode(CENTER);
  noFill();
  smooth();

}

void draw() {
  
  translate(x,y,z);
  rotate(radians(rot));
  rect(0,0,rot+TWO_PI,rot+TWO_PI);
  
  stroke(frameCount%2==0?0:255);
  
  z+=TWO_PI;
  
  
  if(z>width){
    z=z%height;
    rot += TWO_PI;
  }
  
  
  if(rot>width){
    noLoop();
  }
}


