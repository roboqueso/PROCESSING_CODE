import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import fixlib.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class BullseyeGrid extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

// make the vert system shakier
public float xx=0, yy=0;

public boolean isFinal = true, flip = false, wobble = false;

public int gridSize=5, shapeSize = 100;
public float colWidth, rowHeight;
public int tmp;

//////////////////////////////////////////////////////////////////////
public void setup() {
    background(0xff012345);
    

    ellipseMode(CENTER);
    rectMode(CENTER);
    
    noFill();
    colWidth = PApplet.parseInt(width/gridSize);
    rowHeight = PApplet.parseInt(height/gridSize);
} 
//////////////////////////////////////////////////////////////////////
public void draw() {

    
//  XY SYSTEM
    
    if( xx < width ) {
      
      xx += shapeSize;

      if(wobble) {
        yy -= 1+random(-PI,PI);
      }
      
    } else {
      
      xx = 0;
      yy += shapeSize/2;
      
    if(wobble) {
      if(flip)
        xx = random(-shapeSize/2,shapeSize/2);
      else
        xx = -shapeSize/2;

      flip = !flip;
    }
    

    }
    
    
  if(frameCount%2==0)
    fix.bullsEye( xx, yy, shapeSize );  
  else
    fix.rectEye( xx, yy, shapeSize );

    
    
  
  
   if(xx > width && yy > height){
        fill(255);
        text("ERICFICKES.COM", 11, height-11);
        if(isFinal){
          save( fix.pdeName() + fix.getTimestamp() + ".png");
        }
        noLoop();
        exit();
    }

}
//////////////////////////////////////////////////////////////////////
public void vertSys( float a, float b ){
    if( b > random(75) ){
        yy -= 2;
        
        if(frameCount%2==0)
          xx -= random(TWO_PI);
        else
          xx += random(TWO_PI);

    } else {
        yy = random(xx, height);
    }
    //    XX safety check
    if( a < -11 ) xx = random(width);
}
  public void settings() {  size(1024,768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "BullseyeGrid" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
