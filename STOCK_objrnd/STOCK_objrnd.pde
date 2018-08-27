/**
 * Load and Display an OBJ Shape. 
 * 
 * The loadShape() command is used to read simple SVG (Scalable Vector Graphics)
 * files and OBJ (Object) files into a Processing sketch. This example loads an
 * OBJ file of a rocket and displays it to the screen. 
 */


PShape rocket;

float ry;
  
public void setup() {
  size(640, 360, P3D);
    
  rocket = loadShape("rocket.obj");
}

public void draw() {
  background(0);
  lights();
  
  translate(width/2, height/2 + 100, -200);
  rotateZ(PI);
  rotateY(ry);
  rocket.disableStyle();  // Ignore the colors in the SVG
  fill(0, 102, 153);    // Set the SVG fill to blue
  stroke(255); 
  shape(rocket);
  
  ry += 0.02;
}
