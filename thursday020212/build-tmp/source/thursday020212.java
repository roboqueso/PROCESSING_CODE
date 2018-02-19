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

public class thursday020212 extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;

float r = 12; 
float theta = .12f;

int cX = 0;
int cY = 0;

int alf = 100;

///////////////////////////////////////////////////////////
//  
public void setup() {
  
  background(r);
  
  
  rectMode(CENTER);
  stroke( r, r, r );
  strokeWeight(1);
  fix.alpha(alf);
  
  cX = width/2;
  cY = height/2;
}

///////////////////////////////////////////////////////////
//  
public void draw() {
  
  // Polar to Cartesian conversion
  float x = r * cos(theta);
  float y = r * sin(theta);
  
  
  //  color adjuster
  // if( r <= 300 )
  if(frameCount%3==0)
  {
    stroke( r*noise(frameCount), random(r*noise(frameCount)), random(r*noise(frameCount)), alf );
  }
  // else if( r <= 600 )
  else if(frameCount%4==0)
  {
    stroke( random(r*noise(frameCount)), r*noise(frameCount), random(r*noise(frameCount)), alf );
  }
  else if(frameCount%5==0)
  {
    stroke( random(r*noise(frameCount)), random(r*noise(frameCount)), r*noise(frameCount), alf );
  }
  else
  {
    stroke( random(r), random(r),  random(r), alf );
  }
    
  noFill();
  
  
  rect( x + cX, y + cY, r, r );


  theta += 1;
  r += 1;

  if( r % 6 == 0 )
  {
    alf -= 0.5f;
  }

  //
  if( r >= 1000 )
  {
    doExit();
  }
  
}



///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
public void doExit() 
{
  stroke(255, 255, 255);
  text( "ERICFICKES.COM", 0, height-11);

  //  if final, save output to png
  if( isFinal )
  {
  save( fix.pdeName() + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
}
  public void settings() {  size( 1024, 768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "thursday020212" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
