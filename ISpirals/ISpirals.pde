//  SEE:   https://ello.co/ericfickes/post/1kihhqa8fvotxwa1ar0u2q
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);


public Boolean isFinal = true;
//public Branch br;
public int dWidth, dHeight;
public float cols = 6, rows = 6, xx = 0, yy = 0, rowHeight, colWidth, shapeSz, tmp, strokeSz;
/* ------------------------------------------------------------------------- */
void  settings ()  {
    size(displayWidth, displayHeight, FX2D); //"processing.opengl.PGraphics3D");
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}
//////////////////////////////////////////////////////////////////////////
void setup(){
	frameRate(420);
	dWidth = displayWidth;
	dHeight = displayHeight;
	background(0);

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
    stroke(random(255));
    
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



    strokeWeight(strokeSz*noise(strokeSz));
//    ellipse( xx, yy, shapeSz, shapeSz);
    triangle( xx, yy+shapeSz, xx-(shapeSz*2), yy-shapeSz, xx+shapeSz, yy);

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