import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import drop.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class DropLoadImage extends PApplet {

/**
 * loading an image from the web or the harddisk with sDrop.
 */



SDrop drop;

PImage m;

int dropCt = 0;

public void setup() {
  
  frameRate(30);
  drop = new SDrop(this);
}

public void draw() {
  background(frameCount%255);
  if(m !=null) 
  {
    loop();

    if(m !=null && dropCt == 11) 
    {
      image(m,10,10);


      // NOTE: colors don't fully load until a handful of cycles through draw() 
      println("[draw]  m.pixels.length: "+m.pixels.length);

      noLoop();

    }
    else
    {
      dropCt++;
    }
  }
}

public void dropEvent(DropEvent theDropEvent) {
  loop();
  println("");
  println("isFile()\t"+theDropEvent.isFile());
  println("isImage()\t"+theDropEvent.isImage());
  println("isURL()\t"+theDropEvent.isURL());
  
  // if the dropped object is an image, then 
  // load the image into our PImage.
  if(theDropEvent.isImage()) {
    println("### loading image ...");
    m = theDropEvent.loadImage();

    dropCt = 1;
    loop();
  }
}
  public void settings() {  size(400,400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "DropLoadImage" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
