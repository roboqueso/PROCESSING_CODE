// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

//  figure out the iPhone 4S desktop grid
public Boolean isFinal = true;
int rowCt = 9, colCt = 5, dWidth, dHeight;
float rowH, colW, startX = 0, startY = 0, xx = 0, yy = 0, shapeSz;
int clr = #228B22;

//  greens
color[] p3 = { #19EF75, #87A96B, #006400, #71BC78, #228B22, #49796B, #29AB87, #A9BA9D, #90EE90, #74C365, #ADDFAD, #317873, #98FB98, #01796F, #009E60, #008080, #00FF00, #008000, #00A550, #009F6B, #00A877, #4B5320, #006A4E, #66FF00, #1B4D3E, #1E4D2B, #00563F, #00703C, #50C878, #4D5D53, #00AB66, #ADFF2F, #3FFF00, #355E3B, #138808, #009768, #00A86B, #4CBB17, #004953, #18453B, #39FF14, #00853E, #006600, #00A693, #2E8B57, #014421 };

//  see: http://en.wikipedia.org/wiki/Shades_of_green
//  Asparagus - #87A96B 
//  Dark Green - #006400
//  Fern - #71BC78
//  Forest green - #228B22
//  Hooker's Green - #49796B
//  Jungle Green - #29AB87
//  Laurel Green - #A9BA9D
//  Light Green - #90EE90
//  Mantis - #74C365
//  Moss Green - #ADDFAD
//  Myrtle Green - #317873
//  Pale Green - #98FB98
//  Pine Green - #01796F
//  Shamrock Green - #009E60
//  Teal - #008080
//  Lime - #00FF00
//  Green - #008000
//  Green CMYK - #00A550
//  Green NCS - #009F6B
//  Green Munsell - #00A877
//  Army Green - #4B5320
//  Bottle Green - #006A4E
//  Bright Green - #66FF00
//  Brunswick Green - #1B4D3E
//  Cal Poly Pomona green - #1E4D2B
//  Castleton green - #00563F
//  Dartmouth green - #00703C
//  Emerald - #50C878
//  Feldgrau - #4D5D53
//  GO green - #00AB66
//  Yellow-green - #ADFF2F
//  Harlequin - #3FFF00
//  Hunter Green - #355E3B
//  India Green - #138808
//  Islamic Green - #009768
//  Jade - #00A86B
//  Kelly Green - #4CBB17
//  Midnight Green - #004953
//  MSU Green - #18453B
//  Neon Green - #39FF14
//  North Texas Green - #00853E
//  Pakistan green - #006600
//  Persian Green - #00A693
//  Sea Green - #2E8B57
//  UP Forest Green - #014421
//  




//////////////////////////////////////////////////////////////////////////////////////////////////////////
public void setup() {

  dWidth = 1024;
  dHeight = 768;
  
  size( 1024, 768 );
//  PImage imgBg = loadImage("iphone4s.PNG");
//  background(imgBg);
  background(0);
  frameRate(666);
  
  noFill();
  ellipseMode(CENTER);
  rectMode(CENTER);
  
  smooth();
  rowH = 175;
  colW = 153;
  
  startX = -62;
  startY = 124;
  
  stroke(#EF1975);
  strokeWeight(11);
  shapeSz = (rowH+colW);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
void draw() {

  //  color
//  if( frameCount%3==0)
//     stroke(clr);
//    stroke( p3[ int(random( p3.length-1 )) ] );
//stroke(random(yy,255),xx, xx,100);
//    stroke(#EF2012);
//  else if( frameCount%4==0)
//    stroke(#EFEF37);
//  else if( frameCount%5==0)
//    stroke(#006A4E);
//  else
//    stroke(0);

  if(frameCount%2==0)
    stroke(#123456);
  else
    stroke(#212121);

    
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


    strokeWeight(6);
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
        save( fix.pdeName() + fix.getTimestamp() + ".png" );
      }
      noLoop();
      exit();
  }
}