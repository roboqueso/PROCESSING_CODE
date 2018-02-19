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

public class redsquared2 extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

float cX, cY;
float x, y;
float a,b;
float amp = 13;
Boolean isFinal = true;

//////////////////////////////////////////////////////////////////////////////
public void setup() {  // this is run once.   
    
    background(0xffEFEFEF);
     
 
    
    noFill();
 
    cX = width/2;
    cY = height/2;
 
    smooth();
    strokeWeight(2);
    
    
} 
 
 
//////////////////////////////////////////////////////////////////////////////
public void draw() {
 
 
 
    a = cX + random(amp) * (180/PI);
    b = cY + random(amp) * (180/PI);
 
    for( float t = 0; t <= 360; t ++ ) {

        x = cX - amp * sin(a * t * TWO_PI/180);
        y = cY - amp * sin(b * t * TWO_PI/180);

        stroke( random(255), 11, 11, amp/2 );
       
        point( x, y - 180 );
        point( x+360, y - 180 );
        point( x-360, y - 180 );
       
        stroke( 11,11,random(255), amp/2 );

        point( x, y + 180 );
        point( x+360, y + 180 );
        point( x-360, y + 180 );

    }
 
    if( frameCount % 30 == 0 )
    {
        amp *= 1.3f;
    }
 
    if( frameCount > height/2.5f ) {
        textFont(createFont("Helvetica",11));
        fill(0xff676800);
        text("ERICFICKES.COM", 3, height-5);
 
       if(isFinal){
       
        save( fix.pdeName() + fix.getTimestamp() +".png" );
       
       }
 
        noLoop();
        exit();
    }
 
}
  public void settings() {  size( 1024, 768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "redsquared2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
