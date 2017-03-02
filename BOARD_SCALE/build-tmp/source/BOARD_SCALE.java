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

public class BOARD_SCALE extends PApplet {

PImage bg;

public void setup()
{
  // size(8192,2391, P3D);	//	1/8 = 1024, 298
  
  
  //	shrink template
  bg = loadImage("deck_template.png");
  bg.resize(width,height);

  background( bg );
  // scale(.5);
}

public void draw () 
{
	// scale(2);
	ellipse( random(width), random(height), frameCount%33, frameCount%33);

}
  public void settings() {  size(1024,298,P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "BOARD_SCALE" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
