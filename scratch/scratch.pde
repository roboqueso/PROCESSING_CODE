PShape can;
float angle;
PShader colorShader;

void setup() {
  size(1024, 768, P3D);
  
}

void draw() {    
  //background(0);
  translate(frameCount%width, frameCount%(height/2));

can = createCan(100, 200, (int)angle);

  rotateY(angle);  
  rotateX(frameCount%360);
  rotateZ(frameCount%180);

  shape(can);  
  angle += 0.01;
}

PShape createCan(float r, float h, int detail) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);
  sh.stroke(255);
  sh.fill(frameCount%255,frameCount%255,frameCount%255);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;

    sh.normal(x, 0, z);
    sh.vertex(x * r, -h/2, z * r, u, 0);
    sh.vertex(x * r, +h/2, z * r, u, 1);

  }
  sh.endShape(); 
  return sh;
}