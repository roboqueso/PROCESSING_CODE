import processing.svg.*;

boolean record;

void setup() {
  size(500, 500, P3D);
}

void draw() {
  if (record) {
    beginRaw(SVG, "output.svg");
  }

  // Do all your drawing here
  background(204);
  translate(width/2, height/2, -200);
  rotateZ(0.2);
  rotateY(mouseX/500.0);
  box(200);

  if (record) {
    endRaw();
    record = false;
  }
}

// Hit 'r' to record a single frame
void keyPressed() {
  if (key == 'r') {
    record = true;
  }
}
