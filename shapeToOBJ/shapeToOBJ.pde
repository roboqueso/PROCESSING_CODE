import nervoussystem.obj.*;

// dead simple OBJ exporter
// Run sketch > press R > spits out OBJ

boolean record;

void setup() {
  size(800, 800,P3D);
  smooth();
}

void draw() {
  background(0);
  
  if (record) {
    beginRecord("nervoussystem.obj.OBJExport", "filename"+frameCount+".obj");
  }
  
  translate(width/2, height/2);
  box( random(width), random(height),100);
  
  sphere( random(width/4) );
  
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
