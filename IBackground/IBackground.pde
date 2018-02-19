//  figure out the iPhone 4S desktop grid
  int rowCt = 10, colCt = 4, dWidth = 1024, dHeight = 768;
float rowH, colW, startX = 0, startY = 0, xx = 0, yy = 0;


//////////////////////////////////////////////////////////////////////////////////////////////////////////
public void setup() {

//  dWidth = 640;
//  dHeight = 960;
  
  size( 1024, 768 );
//  PImage imgBg = loadImage("iphone4s.PNG");
//  background(imgBg);
background(#99C0DE);
  
  noFill();
  ellipseMode(CENTER);
  rectMode(CENTER);
  smooth();  
  rowH = 175;  //dHeight / rowCt;
  colW = 153; //dWidth / colCt;
  
  startX = 90-colW;
  startY = 124-rowH;

  stroke(0);
  
  
  // scan lines
//  for( int vv = 0; vv < dHeight; vv+=PI){
//    line( 0, vv, dHeight, vv );
//  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
void draw() {


  strokeWeight(xx/42);
  stroke(random(42),random(42),random(42,255));
  rect( startX+xx, startY+yy, colW, rowH, -frameCount+frameCount );

  stroke(random(255));
  rect( startX+xx, startY+yy, colW, rowH, frameCount+frameCount );  

  
  strokeWeight(yy/7);  
  stroke(random(255));
  point( startX+xx, startY+yy );

    //  move
    if( xx < dWidth )
      xx += colW;
    else {
      xx = 0;
      yy += rowH;
    }

      
    if( yy > dHeight+rowH )
    {
      fill(0);
      text("ericfickes.com", 0, height-3);
save( fix.pdeName() + fix.getTimestamp()+".png" );

      noLoop();
    }

}

