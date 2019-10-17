//  see: https://forum.processing.org/two/discussion/23220/how-can-i-optimize-box-drawing
import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
PeasyCam camera;
PImage img;
float[][] z;
int step = 9; // Higher = Less precision but more speed
 
void setup() {
  size(800, 800, P3D);
  ambientLight(255, 255, 255, 0, 0, 0);
  img = loadImage("yr9-symbol-test1.png");
  camera = new PeasyCam(this, img.width/2, img.height/2, 0, 1000);
  img.loadPixels();
  
  //z[][] stores values of z for each pixel of the image
  z = new float[img.width][img.height];
  for (int i=0; i<img.width-1; i++) {
    for (int j=0; j<img.height; j++) {
      z[i][j] = map(brightness(img.pixels[j*img.width +i]), 0, 255, -25, 25);
    }
  }
  
  //Smooth the z values
  for (int i=1; i<img.width-1; i++) {
    for (int j=1; j<img.height-1; j++) {
      z[i][j] = (z[i-1][j-1]+z[i-1][j]+z[i-1][j+1]+z[i][j-1]+z[i][j+1]+z[i+1][j-1]+z[i+1][j]+z[i+1][j+1])/8;
    }
  }
  noStroke();
}

void draw() {
  background(0);
  for (int i=0; i<(img.width-step); i+=step) {
    beginShape(TRIANGLE_STRIP);
    
// debug
    stroke(random(255));

    for (int j=0; j<(img.height-step); j+=step) {
      fill(img.pixels[j*img.width +i]);
      vertex(i, j, z[i][j]);
      vertex(i+step, j, z[i+step][j]);
    }
    endShape();
  } 
}
