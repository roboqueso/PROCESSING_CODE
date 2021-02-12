//  SEE:   https://ello.co/ericfickes/post/_-n699dmrbsxmnstmlnqya
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);



//  RECT GRID playing with rounded rectangle radiuss

public Boolean isFinal = true;
//public Branch br;
public int cols = 5, rows = 4;
public float xx = 0, yy = 0, rowHeight, colWidth, rectSz, tmp, strokeSz;


void settings(){
  size(displayWidth, displayHeight, FX2D);// FX2D, P3D
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}



//////////////////////////////////////////////////////////////////////////
void setup(){
  background(0);
  frameRate(303);

  smooth();
  noFill();
  
  ellipseMode(CENTER);
  rectMode(CENTER);


  
  colWidth = displayWidth/cols;
  rowHeight = displayHeight/rows;

  rectSz = (colWidth+rowHeight);
  strokeSz = int(rectSz/cols);
}


//////////////////////////////////////////////////////////////////////////
void draw(){

    strokeWeight(strokeSz);
    
    ellipse( xx, yy, rectSz, rectSz);    

    if( frameCount%2==0)
      stroke( random(255) );
    else
      stroke( random(-255), 150 );

    point( xx, yy );

    
  //  move
  if( xx < displayWidth+colWidth ){
    xx += colWidth;
  } else {
    xx = 0;
    yy += rowHeight;    
  }
  
  if( xx >= displayWidth+colWidth && yy >= displayHeight+rowHeight ) {
    xx = 0;
    yy = 0;
  
    rectSz -= rows;
    strokeSz -= 1+noise(frameCount);
    
    if(strokeSz<1){
      strokeSz=1;
    }
  }


  if( rectSz < 0 ) {
  
      fill(#EF2012);
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
void moveSys( PVector pv ) {
 
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
void drawSys( PVector pv ) {
  
  noFill();
  strokeWeight(2);
  stroke(random(255) );

  ellipse( pv.x, pv.y, rectSz, rectSz );
  rect( pv.x, pv.y, 50, 50, rectSz );
}
