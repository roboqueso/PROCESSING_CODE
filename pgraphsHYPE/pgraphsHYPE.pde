import nervoussystem.obj.*;

//  FIGURE OUT HOW TO EXPORT HYPE SKETCHES

// COOL SHAPES

boolean record;

void setup() {
  size(800, 800,P3D);
  smooth();
}

void draw() {
  background(0);
  
  if (record) {
    beginRecord("nervoussystem.obj.OBJExport", "filename.obj");
  }
  
  translate(width/2, height/2);
  box( width, width/2,100);
  
  sphere(width/4);
  
  if (record) {
    endRecord();
    record = false;
  }
}

void keyPressed()
{
  if (key == 'r') {
    record = true;
  }
}
