//  SEE:   https://ello.co/ericfickes/post/w-5jdxsotujdi7s7bo-zlw

import java.util.Date;

public boolean isFinal = false;
public float xx=0,yy=0, coldisplayWidth=0, rowdisplayHeight=0;
public int i = 0, gridSize = 10, cX, cY;
public int[] sz = { 3, 6, 9, 11, 13, 15, 24, 45, 69, 75, 99, 111 };


void settings(){
  size(displayWidth, displayHeight);
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}


////////////////////////////////////////////////////////////////////////
void setup() {
    frameRate(420);
    background(#DAD720);
    noFill();
    coldisplayWidth = displayWidth/gridSize;
    rowdisplayHeight = displayHeight/gridSize;
    
    filter(INVERT);
} 
/////////////////////////////////////////////////////////////////////////////////
void draw() {  // this is run repeatedly.  

filter(INVERT);

    stroke(random(255), 100);
    
    xySystem( xx, yy );

    
    strokeWeight(random(PI,gridSize));
    stroke(random(gridSize, 255)+noise(gridSize), gridSize, gridSize );
        
    point( xx, yy );
    point( yy-xx, yy );

    if( frameCount % gridSize == 0 )
    {

        ellipse(xx, yy, gridSize*PI, gridSize*PI );
        ellipse(yy, xx, gridSize*PI, gridSize*PI );

        stroke(random(gridSize,255), gridSize, gridSize+noise(gridSize), 100);
        bezier( xx, yy, xx+yy, random(gridSize)+xx, random(xx), random(yy), displayWidth/2-xx, displayHeight/2-yy );

        beginShape();
          vertex( xx, xx);
          vertex( displayWidth/2-xx, random(gridSize)-yy);
          vertex( random(xx)+noise(xx), random(yy)+noise(yy));
          vertex( yy, yy );
        endShape();
        
        curve( yy, yy, displayWidth/2, random(gridSize)+noise(gridSize), random(xx)+noise(xx), random(yy)+noise(yy), xx, xx );
        
        strokeWeight(1);
        stroke(random(255), 100);
        rect(xx, yy, gridSize*TWO_PI, gridSize*TWO_PI );
        rect(yy, xx, gridSize*TWO_PI, gridSize*TWO_PI );

        //  RESIZE GRID
        gridSize = sz[ (int)random(sz.length ) ];
        coldisplayWidth = displayWidth/gridSize;
        rowdisplayHeight = displayHeight/gridSize;
        
        stroke(random(gridSize),gridSize);
        lineGrid(gridSize);
    }
    
    
    if(frameCount>displayHeight){//+displayWeight){
        fill(#EF2020);
        textFont(createFont("Monospace", 11));
        text("nothing says ART like bezier", 11, displayHeight-11);
        
        //if(isFinal){
          save( pdeName() + getEpoch() + ".png");
        //}
        exit();
    }
}
/////////////////////////////////////////////////////////////////////////////////
void xySystem( float a, float b ){
    switch(int( random( 4 ) ) )
    {
        case 0:{
            if ( a < displayWidth ) {
                xx += coldisplayWidth;
            } else {
                xx = random(coldisplayWidth);
                yy += rowdisplayHeight;
            }
        } break;

        case 1:{
            if (b < displayHeight) {
                yy += rowdisplayHeight;
            } else {
                yy = random(displayHeight-rowdisplayHeight);
                xx += coldisplayWidth;
            }
        } break;
        
        case 2:{
                yy -= rowdisplayHeight;
                xx += coldisplayWidth;
        } break;
        
        case 3:{
                yy += rowdisplayHeight;
                xx -= coldisplayWidth;
        } break;

    }
}

/////////////////////////////////////////////////////////////////////////////////
void lineGrid( int gridSize ){
  
  strokeWeight(gridSize/100);
  for( int w = 0; w < displayWidth; w+= int(displayWidth/gridSize)){
    line( w, random(gridSize), w, displayHeight );
  }
  
}



///////////////////////////////////////////////////////////
//  get EPOCH timestamp
long getEpoch() {
  return new Date().getTime()/1000;
}

String getTimestamp() {
  return new Date().toString();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
String pdeName() {
  return split( this.toString(), "[")[0];
}
