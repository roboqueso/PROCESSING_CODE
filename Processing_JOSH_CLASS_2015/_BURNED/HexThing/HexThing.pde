//  RECT GRID playing with rounded rectangle radiuss
import processing.pdf.*;

//public Branch br;
public int cols = 8, rows = 6;
public float xx = 0, yy = 0, rowHeight, colWidth, rectSz, tmp, strokeSz;

//////////////////////////////////////////////////////////////////////////
void setup(){
  size( 2549, 1950);  //  8.5 x 6.5 AI dimensions
  // size(2560, 1920, P3D );
  frameRate(420);
  background(0);

  smooth();
  noFill();
  
  colWidth = width/cols;
  rowHeight = height/rows;

  rectSz = (colWidth+rowHeight);
  strokeSz = int(rectSz/cols);

  xx = 0;
  yy = 0;



}


//////////////////////////////////////////////////////////////////////////
void draw(){
    smooth();
    strokeWeight(strokeSz);

    
    stroke(frameCount%255);
    hexagon( xx, yy, rectSz);

    
    stroke(frameCount%2==0?0:255);
    star( 5, 
          xx, yy, 
          strokeSz,strokeSz, 
          frameCount%180,
          random(0.2, 0.9) * cos(PI / frameCount) );


    strokeCap(ROUND);
    stroke(random(255));
    point( xx, yy );

    strokeWeight(strokeSz/2);
    stroke(frameCount%2==0?255:0);
    point( xx, yy );

    
  //  move
  if( xx < width+colWidth ){
    xx += colWidth;
  } else {
    xx = 0;
    yy += rowHeight;    
  }
  
  if( xx >= width+colWidth && yy >= height+rowHeight ) {
    xx = 0;
    yy = 0;
  
    rectSz -= rows;
    strokeSz -= noise(frameCount);
    
    if(strokeSz<1){
      strokeSz=1;
    }
  }


  if( rectSz < 0 ) {

//  SAVE PDF
    beginRecord(PDF, fileStamp()+".pdf");
      image(get(),0,0);
    endRecord();

//  SAVE PNG
    save(fileStamp()+".png");

    noLoop();
  }
}



//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}


//////////////////////////////////////////////////////////////////////////
//  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
void hexagon( float startX, float startY, float shapeSize ) {

  strokeCap(PROJECT);
  strokeJoin(BEVEL);

  startX -= ( shapeSize/2 );
  startY -= ( shapeSize/2 );


  line( startX, startY+(shapeSize*.5), startX+(shapeSize*.25), startY );
  line( startX+(shapeSize*.25), startY, startX+(shapeSize*.75), startY );
  line( startX+(shapeSize*.75), startY, startX+(shapeSize), startY+(shapeSize*.5) );

  line( startX+(shapeSize), startY+(shapeSize*.5), startX+(shapeSize*.75), startY+shapeSize );
  line( startX+(shapeSize*.75), startY+shapeSize, startX+(shapeSize*.25), startY+shapeSize );
  line( startX+(shapeSize*.25), startY+shapeSize, startX, startY+(shapeSize*.5) );
}



void star(int n, float cx, float cy, float w, float h, float startAngle, float proportion)
{
  strokeCap(PROJECT);
  strokeJoin(MITER);

  if (n > 2)
  {
    float angle = TWO_PI/ (2 *n);  // twice as many sides
    float dw; // draw width
    float dh; // draw height

    w = w / 2.0;
    h = h / 2.0;

//fill( random(255), n*r*proportion );

    beginShape();
    for (int i = 0; i < 2 * n; i++)
    {
      dw = w;
      dh = h;
      if (i % 2 == 1) // for odd vertices, use short radius
      {
        dw = w * proportion;
        dh = h * proportion;
      }
      vertex(cx + dw * cos(startAngle + angle * i), 
      cy + dh * sin(startAngle + angle * i));
    }
    endShape(CLOSE);
  }
}

