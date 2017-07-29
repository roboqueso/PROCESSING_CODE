import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class shadey extends PApplet {

PShader toon;

public void setup() {
  
  noStroke();
  fill(204);
  toon = loadShader("ToonFrag.glsl", "ToonVert.glsl");
  toon.set("fraction", 1.0f);  //  UNIFORM inside glsl
  
}

public void draw() {
  shader(toon);
  background(frameCount);
  
  float dirY = (mouseY / PApplet.parseFloat(height) - 0.5f) * 2;
  float dirX = (mouseX / PApplet.parseFloat(width) - 0.5f) * 2;
  
  directionalLight(204, 204, 204, -dirX, -dirY, -1);
  translate(frameCount%width/2, height/2);
  sphere(width/2);
  
  //directionalLight(204, 204, 204, -dirX, -dirY, -1);
  //translate(width/3, 7);
  //sphere(120);
  
}
  public void settings() {  size(1400, 360, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "shadey" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
