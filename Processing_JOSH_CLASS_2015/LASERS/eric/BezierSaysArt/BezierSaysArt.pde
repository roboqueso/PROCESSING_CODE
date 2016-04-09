import processing.pdf.*;

public Boolean isFinal = true;
public float xx=0,yy=0, colWidth=0, rowHeight=0;
public int i = 0, gridSize = 42, cX, cY;
public int[] sz = { 4, 8, 9, 11, 15, 24, 40, 69, 99, 111 };
/////////////////////////////////////////////////////////////////////////////////
void setup() {
  size( 2549, 1950);  //  8.5 x 6.5 AI dimensions

  background(255);
  frameRate(420);

    smooth();
    noFill();
    colWidth = width/gridSize;
    rowHeight = height/gridSize;
} 
/////////////////////////////////////////////////////////////////////////////////
void draw() {  // this is run repeatedly.  
        
    
    strokeWeight(PI);
    stroke(random(255));

    xySystem( xx, yy );
    
    strokeWeight(random(gridSize));
    stroke(random(gridSize, 255));//, gridSize, gridSize );
    point( xx, yy );
    point( yy-xx, yy );

    if( frameCount % gridSize == 0 )
    {
// artDaily(yy,xx);


        stroke(random(255));
        fill(random(255),frameCount%255);

        ellipse(xx, yy, gridSize*PI, gridSize*PI );
        ellipse(yy, xx, gridSize*PI, gridSize*PI );

        stroke(random(gridSize,255));//, gridSize, gridSize);
        bezier( xx, yy, xx+yy, random(gridSize)+xx, random(xx), random(yy), width/2-xx, height/2-yy );

        fill(frameCount%2==0?0:255,frameCount%100);
        stroke(frameCount%2==0?255:0);

        beginShape();
            vertex( xx, xx);
            bezierVertex(xx, yy, width/2-xx, random(gridSize)-yy, random(xx), random(yy));
        endShape();
        
        noFill();
        curve( yy, yy, width/2, random(gridSize), random(xx), random(yy), xx, xx );
        
        strokeWeight(HALF_PI+noise(frameCount)+noise(gridSize));
        stroke(random(255));
        rect(xx, yy, gridSize*TWO_PI, gridSize*TWO_PI, random(PI));
        rect(yy, xx, gridSize*TWO_PI, gridSize*TWO_PI, random(-TWO_PI, TWO_PI));

        //  RESIZE GRID
        gridSize = sz[ (int)random(sz.length ) ];
        colWidth = width/gridSize;
        rowHeight = height/gridSize;
        
        stroke(random(gridSize));
        lineGrid((int)random(2,gridSize));
    }
    
    
    if(frameCount>(width*1.5) )
    {

  
artDaily(width/2, height/2);
////

//  SAVE PDF
    beginRecord(PDF, fileStamp()+".pdf");
      image(get(),0,0);
    endRecord();

//  SAVE PNG
    save(fileStamp()+".png");

    noLoop();
    }
}

/////////////////////////////////////////////////////////////////////////////////
void artDaily(float startX, float startY)
{

    textAlign(CENTER,CENTER);
    textFont( createFont("LosAlamosProFatMan", 242 ));

    fill(0);
    text("art ", startX, startY );
    text("daily", startX+205, startY );

    textSize(235);
    fill(255);
    text("art ", startX, startY );
    text("daily", startX+205, startY );
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
  
  strokeWeight(.42);//gridSize/100);
  for( int w = 0; w < width; w+= int(width/gridSize)){
    stroke(random(255));
    line( w, random(gridSize), w, random(height) );
  }
  
}


//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}
