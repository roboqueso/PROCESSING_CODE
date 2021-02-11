//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);


//  ISpirals - figure out the iPhone desktop app layout dimensions for sweet background patterns
//iPhone5
//- 1136-by-640-pixel resolution at 326 ppi
//
//iPhone4S
//- 960-by-640-pixel resolution at 326 ppi

public Boolean isFinal = true;
//public Branch br;
public int dWidth = 1024, dHeight = 768;
public float cols = 10, rows = 6, xx = 0, yy = 0, rowHeight, colWidth, shapeSz, tmp, strokeSz;
//  iPhone  : cols = 4.01, rows = 11
//  desktop : cols = 10, rows = 6
//////////////////////////////////////////////////////////////////////////
void setup(){
//  desktop override
//  dWidth = 1024;
//  dHeight = 768; 
  
  size( 1024, 768 );

//  PImage img;
//  img = loadImage("iphone_desktop.png");
//  background(img);
background(0);

  smooth();
  noFill();
  
  ellipseMode(CENTER);
  rectMode(CENTER);


  
  colWidth = dWidth/cols;
  rowHeight = dHeight/rows;

  shapeSz = (colWidth+rowHeight);
  strokeSz = TWO_PI;
  
}

/*
Hunter Green - #355E3B

Lawn Green - #7CFC00
*/
//////////////////////////////////////////////////////////////////////////
void draw(){
  //  color
  if( frameCount%2==0)
  //  lawn green
//  stroke(#7CFC00);
  
  // hunter green
 stroke(#355E3B);

  else
    stroke(0);
    
  //  move
  if( xx < dWidth+colWidth ){
    xx += colWidth;
  } else {
    xx = 0;
    yy += rowHeight;    
  }
  
  if( xx >= dWidth+colWidth && yy >= dHeight+rowHeight ) {
    xx = 0;
    yy = 0;
  
    shapeSz -= rows;//+strokeSz;
  }


    strokeWeight(strokeSz);
//    ellipse( xx, yy, shapeSz, shapeSz);
    triangle( xx, yy, xx+(shapeSz/2), yy-shapeSz, xx+shapeSz, yy);

  if( shapeSz < 0 ) {
  
      fill(255);
      textFont(createFont("Silom",23));
      
      //    TOP RIGHT CORNER-ISH ( between the time and the battery )
      text("ERICFICKES.COM", (dWidth/2)*1.2, 28 );

//      Bottom left corner
//      text("ERICFICKES.COM", -2, height-2 );

      if(isFinal){
        save( fix.pdeName() + fix.getTimestamp() + ".png" );
      }
      noLoop();
  }
}