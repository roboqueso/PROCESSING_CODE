// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

//  make rounded rect that match the app group
//  http://en.wikipedia.org/wiki/Silver_(color)

public Boolean isFinal = true;
int rowCt = 10, colCt = 5, dWidth, dHeight;
float rowH, colW, startX = 0, startY = 0, xx = 0, yy = 0, shapeSz, strokeSz;
int clr = #228B22;

//  silvers - http://en.wikipedia.org/wiki/Silver_(color)
//color[] p3 = { #C0C0C0, #C9C0BB, #C4AEAD, #BFC1C2, #ACACAC, #838996, #848482, #757575 };

color[] p3 = { #65000B, #B22222, #A52A2A, #E25822, #800000, #8B0000, #7C0A02 };  


//  Vermilion
//http://en.wikipedia.org/wiki/Vermilion#Orange-red
//color[] p3 = { #EF2012, #E34234, #FF5349, #FF3F00, #D9603B, #AA381E, #C0C0C0, #C9C0BB, #C4AEAD, #BFC1C2, #ACACAC, #838996, #848482, #757575, #19EF75, #87A96B, #006400, #71BC78, #228B22, #49796B, #29AB87, #A9BA9D, #90EE90, #74C365, #ADDFAD, #317873, #98FB98, #01796F, #009E60, #008080, #00FF00, #008000, #00A550, #009F6B, #00A877, #4B5320, #006A4E, #66FF00, #1B4D3E, #1E4D2B, #00563F, #00703C, #50C878, #4D5D53, #00AB66, #ADFF2F, #3FFF00, #355E3B, #138808, #009768, #00A86B, #4CBB17, #004953, #18453B, #39FF14, #00853E, #006600, #00A693, #2E8B57, #014421 };

//////////////////////////////////////////////////////////////////////////////////////////////////////////
public void setup() {

  dWidth = 1024;  //640;  //  
  dHeight = 768;  //960; //    
  
  size( 1024, 768 );
  background(#210000);
  frameRate(666);
  
  noFill();
  ellipseMode(CENTER);
  rectMode(CENTER);
  
  smooth();
  rowH = 175;
  colW = 153;
  
  startX = -62;
  startY = 126-rowH;

  strokeSz = PI;
  shapeSz = (rowH+colW);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
void draw() {

  if(frameCount%2==0)
    stroke(0);
  else
    //  random palette
    stroke( p3[ int(random( p3.length )) ] );

  strokeWeight(strokeSz);
    
    
  //  move
  if( xx < dWidth+colW ){
    xx += (colW*1.23);
  } else {
    xx = 0;
    yy += (rowH*1.23);    
  }
  
  if( xx >= dWidth+colW && yy >= dHeight+rowH ) {
    xx = 0;
    yy = 0;
  
    shapeSz  -= 9;
  }

  ellipse( startX+xx, startY+yy, shapeSz, shapeSz);

      
  if( shapeSz <= 9 ) {
  
      fill(255);
      textFont(createFont("Silom",23));
      
      //    TOP RIGHT CORNER-ISH ( between the time and the battery )
      text("ERICFICKES.COM", (dWidth/2)*1.2, 25 );  // 28

//      Bottom left corner
//      text("ERICFICKES.COM", -2, height-2 );

      if(isFinal){
        save( fix.pdeName() + fix.getTimestamp() + ".png" );
      }
      noLoop();
      exit();
  }
}