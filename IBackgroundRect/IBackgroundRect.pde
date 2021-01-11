//  SEE:   https://ello.co/ericfickes/post/nim8ky4rq8q_u6ilszaydq
//  GOTO:  https://github.com/ericfickes/FIXLIB

import fixlib.*;
Fixlib fix = Fixlib.init(this);




//  figure out the iPhone 4S desktop grid
public Boolean isFinal = true;
int rowCt = 6, colCt = 9, dWidth, dHeight;
float rowH, colW, startX = 0, startY = 0, xx = 0, yy = 0, shapeSz;
int clr = #228B22;

//  greens
//color[] p3 = { #19EF75, #87A96B, #006400, #71BC78, #228B22, #49796B, #29AB87, #A9BA9D, #90EE90, #74C365, #ADDFAD, #317873, #98FB98, #01796F, #009E60, #008080, #00FF00, #008000, #00A550, #009F6B, #00A877, #4B5320, #006A4E, #66FF00, #1B4D3E, #1E4D2B, #00563F, #00703C, #50C878, #4D5D53, #00AB66, #ADFF2F, #3FFF00, #355E3B, #138808, #009768, #00A86B, #4CBB17, #004953, #18453B, #39FF14, #00853E, #006600, #00A693, #2E8B57, #014421 };
color[] p3 = { #87A96B, #006400 , #71BC78 , #228B22 , #49796B , #29AB87 , #A9BA9D , #90EE90 , #74C365 , #ADDFAD , #317873 , #98FB98 , #01796F , #009E60 , #008080 , #00FF00 , #008000 , #00A550 , #009F6B , #00A877 , #4B5320 , #006A4E , #66FF00 , #1B4D3E , #1E4D2B , #00563F , #00703C , #50C878 , #4D5D53 , #00AB66 , #ADFF2F , #3FFF00 , #355E3B , #138808 , #009768 , #00A86B , #4CBB17 , #004953, #18453B, #39FF14, #00853E, #006600, #00A693, #2E8B57, #014421 };

//  see: http://en.wikipedia.org/wiki/Shades_of_green



void settings(){
  size(displayWidth, displayHeight);
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
public void setup() {

  dWidth = displayWidth;
  dHeight = displayHeight;
  
  background( p3[ int(random( p3.length-1 )) ] );
  frameRate(666);
  
  noFill();
  ellipseMode(CENTER);
  rectMode(CENTER);

  rowH = dWidth/colCt;
  colW = dHeight/rowCt;
  
  startX = startY = 0;
  
  strokeWeight(PI);
  shapeSz = (rowH+colW);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
void draw() {

  stroke( p3[ int(random( p3.length-1 )) ] );
    
  //  move
  if( xx < dWidth+colW ){
    xx += colW;
  } else {
    xx = 0;
    yy += rowH;    
  }
  
  if( xx >= dWidth+colW && yy >= dHeight+rowH ) {
    xx = 0;
    yy = 0;
  
    shapeSz -= 21;//+strokeSz;
  }



//    ellipse( startX+xx, startY+yy, shapeSz, shapeSz);
    rect( startX+xx, startY+yy, shapeSz, shapeSz, frameCount);


      
  if( shapeSz < 0 ) {
  
      fill(255);
      textFont(createFont("Silom",23));
      
      //    TOP RIGHT CORNER-ISH ( between the time and the battery )
      text("ERICFICKES.COM", (dWidth/2)*1.2, 28 );

//      Bottom left corner
//      text("ERICFICKES.COM", -2, height-2 );

      if(isFinal){
    String saveName = fix.pdeName() + "-" + fix.getTimestamp();
    save( saveName +".tif" );
    save( saveName +".png" );
      }
      noLoop();
      exit();
  }
}
