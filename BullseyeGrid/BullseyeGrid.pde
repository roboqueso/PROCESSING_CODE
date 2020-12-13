//  SEE:   https://ello.co/ericfickes/post/ylwzq7sepm_c_ftrc30yoq
//  GOTO:  https://github.com/ericfickes/FIXLIB

import fixlib.*;
Fixlib fix = Fixlib.init(this);

// make the vert system shakier
public float xx=0, yy=0;

public boolean isFinal = true, flip = false, wobble = true;

public int gridSize=5, shapeSize = 75;
public float colWidth, rowHeight;
public int tmp;


void settings(){
  size(displayWidth, displayHeight );
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}



//////////////////////////////////////////////////////////////////////
void setup() {
    background(#720420);

    ellipseMode(CENTER);
    rectMode(CENTER);

    noFill();
    colWidth = int(width/gridSize);
    rowHeight = int(height/gridSize);
} 
//////////////////////////////////////////////////////////////////////
void draw() {

  
    if(frameCount%2==0)
    fix.bullsEye( xx, yy, shapeSize );  
  else
    fix.rectEye( xx, yy, shapeSize );
    
//  XY SYSTEM
    
    if( xx < width ) {
      
      xx += shapeSize;

      if(wobble) {
        yy -= noise(yy)+random(-PI,PI);
      }
      
    } else {
      
      xx = 0;
      yy += shapeSize;//2;
      
    if(wobble) {
      if(flip)
        xx = random(-shapeSize/2,shapeSize/2);
      else
        xx = -shapeSize;///2;

      flip = !flip;
    }
    

    }
    
   
  
  
   if(xx > width && yy > height){
        fill(255);
        text("ERICFICKES.COM", 11, height-11);
        if(isFinal){
          save( fix.pdeName() + fix.getTimestamp() + ".tif");
          save( fix.pdeName() + fix.getTimestamp() + ".png");
        }
        noLoop();
        exit();
    }

}
//////////////////////////////////////////////////////////////////////
void vertSys( float a, float b ){
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
