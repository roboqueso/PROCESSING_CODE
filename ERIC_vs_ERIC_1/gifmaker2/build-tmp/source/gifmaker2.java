import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import gifAnimation.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class gifmaker2 extends PApplet {



GifMaker gifExport;
float xx, sz;

/* Vertical bars drawing left to right across the stage */

public void setup() 
{
  
  background(255);
  
  //  frameRate(12);
  frameRate(32);

  gifExport = new GifMaker(this, "export.gif");
  gifExport.setRepeat(0);             // make it an "endless" animation
  //  SCRIVNER: multiples of 16 frames
//  gifExport.setTransparent(0,0,0);    // black is transparent
  gifExport.setTransparent(255);    // white is transparent

  strokeWeight(PI);
  sz=PI+2;
  noFill();

}



public void draw() 
{
    stroke(frameCount);
    line( xx, 0, xx, height );


    if( xx < width )
    {
      gifExport.setDelay(1);
      gifExport.addFrame();
      
      xx += sz;
    }
    else
    {
      gifExport.finish();  // write file
      stop();
    }


}

  public void settings() {  size(250,250);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "gifmaker2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
