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

public class BendALittle extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

public float x=0,y=0, col1024=0, row768=0, rX, rY;
public int i = 0, gridSize = 11, cX, cY;
public Boolean isFinal = true;

/////////////////////////////////////////////////////////////////////////////////
public void setup() {
    background(0xff012345);
    
//size(display1024, display768);
    
    noFill();
    
    cX = PApplet.parseInt(1024/2);
    cY = PApplet.parseInt(768/2);
    col1024 = 1024/gridSize;
    row768 = 768/row768;
    
    ellipseMode(CENTER);
    rectMode(CENTER);
} 
/////////////////////////////////////////////////////////////////////////////////
public void draw() {

    stroke(random(255));

    strokeWeight(PI);

    xySystem( x, y );
    point(x,y);

    xySystem( y, x );
    point(y,x);
 
    if( frameCount % 22 == 0 )
    {
    stroke(0xff123456, 100);
    rect( rX+gridSize, cY+y, rY, cX-x , random(gridSize) );

      strokeWeight(random(gridSize));
        
        rX = random(1024-x);
        rY = random(768-y);
 
        stroke(random(255),gridSize,gridSize, random(222) );
        bezier( rX, rY, cX+random(x), cY+random(y), gridSize+x, gridSize+y, y, x );
        beginShape();
             vertex( rX, rY);
             vertex( cX+random(x), cY+random(y) );
             vertex( gridSize+rX, gridSize+rY);
             vertex( y, x );
        endShape();
        ellipse( x, rY, gridSize, gridSize );
        rect( y+gridSize, rX, gridSize, gridSize );
        ellipse( y+gridSize, x, gridSize, gridSize );
 
        stroke(random(255) );
        ellipse(x, rY, gridSize*TWO_PI, gridSize*TWO_PI );
        rect(y, x, gridSize*TWO_PI, gridSize*TWO_PI );
 
        gridSize = PApplet.parseInt(random(PI,42));
        col1024 = 1024/gridSize;
        row768 = 768/row768;
    }
    if(frameCount>768+1024){
        fill(0xff000075);
        textFont(createFont("Monospace", 11));
        text("ERICFICKES.COM", 11, 768-11);
        
        if(isFinal){
          save( fix.pdeName() + fix.getTimestamp() + ".png");
        }

        noLoop();
        exit();
    }
}
/////////////////////////////////////////////////////////////////////////////////
public void xySystem( float a, float b ){
    switch( PApplet.parseInt( random( 3 ) ) ){
        case 0:{
            if (a < 1024) {
                x += col1024;
            } else {
                x = col1024;
                y += row768;
            }
        } break;
        
        case 1:
        {
            if (b < 768) {
                x += col1024*2;
                y += row768;
            } else {
                y = row768;
                x = col1024;
            }
        } break;
        
        case 2:
        {
            if (b < 768) {
                y += row768;
                x += col1024;
            } else {
                y = row768;
                x += col1024;
            }
        } break;
    }
}
  public void settings() {  size(1024,768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "BendALittle" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
