//  SEE:   https://ello.co/ericfickes/post/iyxa4ljs9qwcpthjsko7za
//  GOTO:  https://github.com/ericfickes/FIXLIB

import fixlib.*;
Fixlib fix = Fixlib.init(this);

void settings(){
  size(displayWidth, displayHeight, P3D);
  smooth(8);
  pixelDensity(displayDensity());
}

public float xx=0,yy=0, colWidth=0, rowHeight=0;
public int i = 0, gridSize = 4;
public int[] gSizes = { 2, 3, 4, 8, 9, 11, 13, 21, 34, 55, 89  };
public boolean isFinal = true;

/////////////////////////////////////////////////////////////////////////////////
void setup() {
    background(#EF4521);
    frameRate(303);
    smooth();
    noFill();
    rectMode(CENTER);
    colWidth = width/gridSize;
    rowHeight = height/gridSize;
} 

/////////////////////////////////////////////////////////////////////////////////
void draw() {  // this is run repeatedlyy.  
    

    xySystem( xx, yy );
    strokeWeight(TWO_PI);
    stroke(random(200,255));
    point(xx,yy);
    
    stroke(random(100,155));
    point(yy,xx);
    point(yy,xx-yy);

    
    stroke(random(255), gridSize);
    strokeWeight(1);
    rect( xx, yy, gridSize,gridSize, noise(frameCount) );
    
    
    if(frameCount>=(width+height)*PI ){
        fill(#1975EF);
        textFont(createFont("Monospace", 11));
        text("ERICFICKES.COM", 111, height-11);
        if(isFinal){
          save(fix.pdeName()+fix.getTimestamp()+".png");
        }
        exit();
    }
}
/////////////////////////////////////////////////////////////////////////////////
void xySystem( float a, float b ){
    switch( int( random( 11 ) ) ){
        case 0:{
            if (a > 0) {
                xx -= colWidth;
            } else {
                xx = width;
                yy -= rowHeight;
            }
        } break;
        
        case 1:{
          xx++;
        } break;

        case 2:{
          xx+=2;
        } break;

        case 3:{
          xx+=3;
        } break;

        case 4: {          
            if (a < width) {
                xx += colWidth;
            } else {
                xx = 0;
                yy += rowHeight;
            }
        } break;


        case 5:{
          xx+=5;
        } break;

        case 6:{
          yy-=rowHeight;
        }break;
        case 7:{
          if (b < height) {
            yy += rowHeight;
          } else {
            yy = 0;
            xx += colWidth;
          }
        }
        break;
        
        case 8:{
          xx+=8;
        } break;
        
        case 9:{
            if (b < height) {
                yy += rowHeight;
            } else {
                yy = 0;
                xx += colWidth;
            }
        } break;
    }
    
    
    //  CHECK FOR END OF GRID
    //if( a >= width && b >= height ){
    if( frameCount % int(width/2) == 0){
    
      gridSize = gSizes[int(random(gSizes.length))];

      fill(#1975EF);
      text( gridSize + " : " + colWidth + "xx" + rowHeight, yy, xx );
      noFill();

      colWidth = width/gridSize;
      rowHeight = height/gridSize;
      
      xx = yy = 0;
    
    }
    
    
}
