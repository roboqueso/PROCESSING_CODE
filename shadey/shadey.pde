PShader toon;

void setup() {
  size(1400, 360, P3D);
  noStroke();
  fill(204);
  toon = loadShader("ToonFrag.glsl", "ToonVert.glsl");
  toon.set("fraction", 1.0);  //  UNIFORM inside glsl
  
}

void draw() {
  shader(toon);
  background(frameCount);
  
  float dirY = (mouseY / float(height) - 0.5) * 2;
  float dirX = (mouseX / float(width) - 0.5) * 2;
  
  directionalLight(204, 204, 204, -dirX, -dirY, -1);
  translate(frameCount%width/2, height/2);
  sphere(width/2);
  
  //directionalLight(204, 204, 204, -dirX, -dirY, -1);
  //translate(width/3, 7);
  //sphere(120);
  
}