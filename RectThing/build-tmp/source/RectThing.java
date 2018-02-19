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

public class RectThing extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);

//  RECT GRID playing with rounded rectangle radiuss

public Boolean isFinal = true;
//public Branch br;
public int cols = 5, rows = 4;
public float xx = 0, yy = 0, rowHeight, colWidth, rectSz, tmp, strokeSz;

//////////////////////////////////////////////////////////////////////////
public void setup(){
  
  background(0);

  
  noFill();
  
  ellipseMode(CENTER);
  rectMode(CENTER);


  
  colWidth = 1024/cols;
  rowHeight = 768/rows;

  rectSz = (colWidth+rowHeight);
  strokeSz = PApplet.parseInt(rectSz/cols);
}


//////////////////////////////////////////////////////////////////////////
public void draw(){

    strokeWeight(strokeSz);
    

    rect( xx, yy, rectSz, rectSz, rectSz/xx-yy);
    
    if( frameCount%2==0)
      stroke( random(42,255) );
    else
      stroke(0);
      
//    rect( xx, yy, int(rectSz/rows), int(rectSz/rows), -rectSz);
//    rect( xx, yy, int(rectSz/rows), int(rectSz/rows), -yy);
//    rect( xx, yy, int(rectSz/rows), int(rectSz/rows), -xx);
rect( xx, yy, PApplet.parseInt(rectSz/rows), PApplet.parseInt(rectSz/rows), -strokeSz);

  //  move
  if( xx < 1024+colWidth ){
    xx += colWidth;
  } else {
    xx = 0;
    yy += rowHeight;    
  }
  
  if( xx >= 1024+colWidth && yy >= 768+rowHeight ) {
    xx = 0;
    yy = 0;
  
    rectSz -= cols;
    strokeSz -= noise(frameCount);
    
    if(strokeSz<1){
      strokeSz=1.5f;
    }
  }


  if( rectSz < 0 ) {
  
      fill(0xffEF2012);
      textFont(createFont("Silom",42));
      text("ERICFICKES.COM", 0, height-2 );
      if(isFinal){
        save( fix.pdeName() + fix.getTimestamp() + ".png" );
      }
      noLoop();
      exit();
  }
}




//////////////////////////////////////////////////////////////////////////
//  update the X and Y of supplied PVector
public void moveSys( PVector pv ) {
 
//   if( br.SplitBy % 3 == 0 ){
   
     // horizontal
      if( pv.x < width ) {
          pv.x += 51;
      } else {
        
        if( pv.y < height )
          pv.y += 51;
        else
          pv.y = 0;
        
        
        pv.x = 0;
      }

  if( pv.x >= width && pv.y >= height ){
    pv.x = 0;
    pv.y = 0;
    

    rectSz += 6;
    
  }

  
}

//////////////////////////////////////////////////////////////////////////
//  draw stuff using supplied PVector
public void drawSys( PVector pv ) {
  
  noFill();
  strokeWeight(2);
  stroke(random(255) );

  ellipse( pv.x, pv.y, rectSz, rectSz );
  rect( pv.x, pv.y, 50, 50, rectSz );

  
}
  public void settings() {  size(1024,768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "RectThing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
