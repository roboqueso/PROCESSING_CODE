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

public class wtf extends PApplet {

public void setup()
{
  size(1024, 768 );
  
}

public void draw(){

  fill( random(255),  random(255),  random(255) );
  
  text( "WTF", random(width), random(height) );


}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "wtf" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
