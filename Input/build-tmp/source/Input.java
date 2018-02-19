import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import fixlib.*; 
import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Input extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);





Minim minim;
AudioInput in;
int y, x, cx, cy;
float l1,r1, sw;

public void setup()
{
  //fullScreen(P3D);
  
//  NOTE: 
//  default engine renders higher quality, but SUPER SLOW
//  P3D renders fast but crunchy


  // Pulling the display's density dynamically
  
  background(255);
  
  
  
 

  
  rectMode(CENTER);

  cx = PApplet.parseInt(height/2);
  cy = PApplet.parseInt(width/2);

  minim = new Minim(this);
  
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
}



public void draw()
{
 //<>//
  x = (frameCount%width);
  y = (frameCount%height);
  

  // draw the waveforms so we can see what we are monitoring
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    l1 = in.left.get(i);
    r1 = in.right.get(i);

    sw = (11*l1*r1); 
    if( sw < 0 ) sw = 11;
    
////////
    stroke(  (x*l1*r1),
             (i*l1*r1),
             (y*l1*r1) );
    strokeWeight( sw );
    point( i, l1*100 - y );
    point( i, r1*100 + y );


////////    
    stroke(i, x%255,y%200);
    strokeWeight(in.left.level()*11);
    point( i, l1*100 - y );
    
    strokeWeight(in.right.level()*11);
    point( i, r1*100 + y );

////////
    stroke(sw,50);
    line(0,y,width,y);




}



  //  AUTO SAVER
  //if(frameCount%780==0){
  if(frameCount%1800==0){
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    minim = null;
    noLoop();
    exit();
  }

}

public void keyPressed()
{
  
  switch(key)
  {
    case 's':
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    break;
  }
  
  
  
}
  public void settings() {  size(1024, 1024, P2D);  smooth();  pixelDensity(displayDensity()); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Input" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
