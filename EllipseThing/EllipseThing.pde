//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);



//  RECT GRID playing with rounded rectangle radiuss

public Boolean isFinal = true;
//public Branch br;
public int cols = 5, rows = 4;
public float xx = 0, yy = 0, rowHeight, colWidth, rectSz, tmp, strokeSz;

//////////////////////////////////////////////////////////////////////////
void setup(){
  size(1024,768);
  background(0);

  smooth();
  noFill();
  
  ellipseMode(CENTER);
  rectMode(CENTER);


  
  colWidth = 1024/cols;
  rowHeight = 768/rows;

  rectSz = (colWidth+rowHeight);
  strokeSz = int(rectSz/cols);
}


//////////////////////////////////////////////////////////////////////////
void draw(){

    strokeWeight(strokeSz);
    
    ellipse( xx, yy, rectSz, rectSz);    

    if( frameCount%2==0)
      stroke( random(rectSz+strokeSz) );
    else
      stroke(0);

    point( xx, yy );

    
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
