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

public class scratch extends PApplet {

/*
inspiration from http://paulbourke.net/geometry/supershape/
*/

PShape can;
float angle;
PShader colorShader;

public void setup() {
  
  
  rectMode(CENTER);
  
  strokeWeight(PI);
}

int numPts = 40;
int x, y;
float m, n1, n2, n3, phi;

PVector tmp;



public void draw() {    
  
  beginShape();
    
    for (int i=0; i <= numPts; i++) {
        phi = i * TWO_PI / numPts;
        
        tmp = Eval( numPts, 2, 1.7f, 1.7f, phi );
        
        vertex( tmp.x, tmp.y, tmp.z );
        
println( tmp );
     }

  endShape();
  
  noLoop();
  
  /*
  pushMatrix();
    
    translate((width/2), (height/2), frameCount );
    rotate(frameCount);
    //fill(frameCount%255, 50);
    noFill();
    stroke(frameCount%255, 100);
    rect( 0,0, (frameCount%(width/2)) , (frameCount % ( height/2) ), -frameCount%-8 );
    
  popMatrix();
  */
}


public PVector Eval(float m, float n1, float n2, float n3, float phi )
{
   float r;
   float t1,t2;
   float a=1,b=1;
   float x=0, y=0;

   t1 = cos(m * phi / 4) / a;
   t1 = abs(t1);
   t1 = pow(t1,n2);

   t2 = sin(m * phi / 4) / b;
   t2 = abs(t2);
   t2 = pow(t2,n3);

   r = pow(t1+t2,1/n1);
   
   if (abs(r) == 0) {
      x = 0;
      y = 0;
   } else {
      r = (1 / r) * 10;
      x = r * cos(phi) * 10;
      y = r * sin(phi) * 10;
   }

   // make positive
   if(x<0) x = -x;
   if(y<0) y = -y;
   //if(r<0) r = -r;

  return new PVector( round(x), round(y), round(r) );
}
  public void settings() {  size(1024, 768, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "scratch" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
