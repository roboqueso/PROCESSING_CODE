import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class MovieMover extends PApplet {


Movie myMovie;

public void setup() {
  
  frameRate(69);
  // myMovie = new Movie(this, "tex2.mov");
  myMovie = new Movie(this, "ShapePrimitivesDXF_2018-Feb-26_04-21-31AM-000_CustomizedView50218821407.mp4");
  // Prints the duration of the movie
  println(myMovie.duration());
  myMovie.loop();
}

public void draw() {
  if (myMovie.available()) {
    myMovie.read();
  }

// tint(random(255),random(255),random(255), 75);
//   image(myMovie, ((frameCount*200)%width), (frameCount%height));

// myMovie.filter(INVERT);
// image(myMovie, 0,0);

	scale(-1, 1); // this will flip everything! (read: also the coordinates)
  image(myMovie, width,0);

}

public void movieEvent(Movie myMovie) {
  myMovie.read();
}

public void mousePressed() {
  myMovie.jump(random(myMovie.duration()));
}
  public void settings() {  size(1024, 768); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "MovieMover" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
