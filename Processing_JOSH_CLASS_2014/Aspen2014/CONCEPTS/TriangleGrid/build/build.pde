import processing.pdf.*;


/*
Adjust triangle grid to be used as layout.
- record to PDF
- import to AI
- trace magic
- output layout.svg
- suck into P5


*/
public Boolean isFinal = false;
//public Branch br;
public int dWidth = 1024, dHeight = 768;
public float cols = 5, rows = 5, xx = 0, yy = 0, rowHeight, colWidth, shapeSz, tmp, strokeSz;
boolean record = false;
//  iPhone  : cols = 4.01, rows = 11
//  desktop : cols = 10, rows = 6
//////////////////////////////////////////////////////////////////////////
void setup(){
//  desktop override
//  dWidth = 1024;
//  dHeight = 768; 
  
  size( 1000, 900 );
  background(255);
  smooth();
  noFill();
  
  // ellipseMode(CENTER);
  // rectMode(CENTER);


  
  colWidth = dWidth/cols;
  rowHeight = dHeight/rows;

  shapeSz = (colWidth+rowHeight);
  strokeSz = TWO_PI;
  

  if (record) {
    beginRecord(PDF, "MyRender-####.pdf");
  }

}

/*
Hunter Green - #355E3B

Lawn Green - #7CFC00
*/
//////////////////////////////////////////////////////////////////////////
void draw(){





  stroke(0); noFill();
  
  // for (Join j : joins) {   
  //   line (j.n1.x, j.n1.y, j.n2.x, j.n2.y);
  // }
    
  // for (Node n : nodes) {
  //   n.move();
  // }



  //  move
  if( xx < dWidth+colWidth ){
    xx += colWidth;
  } else {
    xx = 0;
    yy += rowHeight*2;
  }
  
  if( xx >= dWidth+colWidth && yy >= dHeight+rowHeight ) {
    xx = 0;
    yy = 0;
  
    shapeSz /= 2.5;
  }

// line(xx+(shapeSz/2), yy-shapeSz, xx+shapeSz, yy);

    strokeWeight(strokeSz);
    triangle( xx, yy, xx+(shapeSz/2), yy-shapeSz, xx+shapeSz, yy);

  if( shapeSz < 0 ) {
  
      // fill(255);
      // textFont(createFont("Silom",23));
      
      //    TOP RIGHT CORNER-ISH ( between the time and the battery )
      // text("ERICFICKES.COM", (dWidth/2)*1.2, 28 );

//      Bottom left corner
//      text("ERICFICKES.COM", -2, height-2 );

      if(isFinal){
        save( pdeName() + getTimestamp() + ".png" );
      } 

    if (record) {
      endRecord();
      record = false;
    }

      noLoop();
  }

}










String getTimestamp() {
  return ""+month()+day()+year()+hour()+second()+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
String pdeName() {
  return split( this.toString(), "[")[0];
}

