//  SEE:   https://ello.co/ericfickes/post/c8rn_cofu_mmffj8nf1haa
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);


public Boolean isFinal = true;
public float xx=0,yy=0, colWidth=0, rowHeight=0;
public int i = 0, gridSize = 222, cX, cY;
public int[] sz = { 3, 6, 9, 11, 15, 23, 38, 61, 99, 111 };
/////////////////////////////////////////////////////////////////////////////////
void setup() {
  size(displayWidth, displayHeight);
  pixelDensity(displayDensity());
  smooth(8);
  frameRate(666);
  background(-1);
  noFill();
  
  colWidth = width/gridSize;
  rowHeight = height/gridSize;
} 
/////////////////////////////////////////////////////////////////////////////////
void draw() {  // this is run repeatedly.  
    
    stroke(random(255), 100);

    xySystem( xx, yy );

    
    strokeWeight(random(PI,gridSize));
    stroke(random(gridSize, 255), gridSize, gridSize );
        
    point( xx, yy );
    point( yy-xx, yy );

    if( frameCount % gridSize == 0 )
    {

        ellipse(xx, yy, gridSize*PI, gridSize*PI );
        ellipse(yy, xx, gridSize*PI, gridSize*PI );

        stroke(random(gridSize,255), gridSize, gridSize, 100);
        bezier( xx, yy, xx+yy, random(gridSize)+xx, random(xx), random(yy), width/2-xx, height/2-yy );

        beginShape();
          vertex( xx, xx);
          vertex( width/2-xx, random(gridSize)-yy);
          vertex( random(xx), random(yy));
          vertex( yy, yy );
        endShape();
        
        curve( yy, yy, width/2, random(gridSize), random(xx), random(yy), xx, xx );
        
        strokeWeight(1);
        stroke(random(255), 100);
        rect(xx, yy, gridSize*TWO_PI, gridSize*TWO_PI );
        rect(yy, xx, gridSize*TWO_PI, gridSize*TWO_PI );

        //  RESIZE GRID
        gridSize = sz[ (int)random(sz.length ) ];
        colWidth = width/gridSize;
        rowHeight = height/gridSize;
        
        stroke(random(gridSize),gridSize);
        lineGrid(gridSize);
    }
    
    
    if(frameCount>width+height){
        fill(#EF2012);
        textFont(createFont("Silom", 18));
        text("ERICFICKES.COM", 11, height-11);
        
        if(isFinal){
          save( fix.pdeName() + fix.getTimestamp() + ".png");
        }
        noLoop();
        exit();
    }
}
/////////////////////////////////////////////////////////////////////////////////
void xySystem( float a, float b ){
    switch(int( random( 4 ) ) )
    {
        case 0:{
            if ( a < 1024 ) {
                xx += colWidth;
            } else {
                xx = random(colWidth);
                yy += rowHeight;
            }
        } break;

        case 1:{
            if (b < height) {
                yy += rowHeight;
            } else {
                yy = random(height-rowHeight);
                xx += colWidth;
            }
        } break;
        
        case 2:{
                yy -= rowHeight;
                xx += colWidth;
        } break;
        
        case 3:{
                yy += rowHeight;
                xx -= colWidth;
        } break;

    }
}

/////////////////////////////////////////////////////////////////////////////////
void lineGrid( int gridSize ){
  
  strokeWeight(gridSize/100);
  for( int w = 0; w < width; w+= int(width/gridSize)){
    line( w, random(gridSize), w, height );
  }
  
}
