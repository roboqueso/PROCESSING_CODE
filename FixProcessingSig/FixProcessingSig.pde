void setup(){
  size(1024,768);
}
void draw(){
  fill(random(255),random(255),random(255),11);
  rect(0,0,width,height);
  textAlign(CENTER);
  textSize(frameCount % (height/2) );
  fill(frameCount%height);
  text("PROCESSING",width/2,height/2);
}
