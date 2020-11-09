//  SEE:   https://ello.co/ericfickes/post/ux6bt6ul1blrtxszgs6skw
//  GOTO:  https://github.com/ericfickes/FIXLIB   
import fixlib.*;

Fixlib fix = Fixlib.init(this);

public float x=0,y=0, colwidth=0, rowheight=0, rX, rY;
public int i = 0, gridSize = 13, cX, cY;
public Boolean isFinal = true;

void settings() {
  size(displayWidth, displayHeight, P3D);
  smooth(8);
  pixelDensity(displayDensity());
}

////////////////////////////////////////////////////
//
void setup() {
  frameRate(420);
  background(#0420EF);  //  orange : #EF4520
    noFill();
    
    cX = int(width/2);
    cY = int(height/2);
    colwidth = width/gridSize;
    rowheight = height/rowheight;
    
    ellipseMode(CENTER);
    rectMode(CENTER);
} 
/////////////////////////////////////////////////////////////////////////////////
void draw() {

    stroke(random(255));

    strokeWeight(PI);

    xySystem( x, y );
    point(x,y);

    xySystem( y, x );
    point(y,x);
 
    if( frameCount % 22 == 0 )
    {
    stroke(#123456, 100);
    rect( rX+gridSize, cY+y, rY, cX-x , random(gridSize) );

      strokeWeight(random(gridSize));
        
        rX = random(width-x);
        rY = random(height-y);
 
        stroke(random(255),gridSize,gridSize, random(222) );
        bezier( rX, rY, cX+random(x), cY+random(y), gridSize+x, gridSize+y, y, x );
        beginShape();
             vertex( rX, rY);
             vertex( cX+random(x), cY+random(y) );
             vertex( gridSize+rX, gridSize+rY);
             vertex( y, x );
        endShape();
        ellipse( x, rY, gridSize, gridSize );
        rect( y+gridSize, rX, gridSize, gridSize );
        ellipse( y+gridSize, x, gridSize, gridSize );
 
        stroke(random(255) );
        ellipse(x, rY, gridSize*TWO_PI, gridSize*TWO_PI );
        rect(y, x, gridSize*TWO_PI, gridSize*TWO_PI );
 
        gridSize = int(random(PI,42));
        colwidth = width/gridSize;
        rowheight = height/rowheight;
    }
    if(frameCount>height+width){
        fill(#000075);
        textFont(createFont("Monospace", 11));
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
    switch( int( random( 3 ) ) ){
        case 0:{
            if (a < width) {
                x += colwidth;
            } else {
                x = colwidth;
                y += rowheight;
            }
        } break;
        
        case 1:
        {
            if (b < height) {
                x += colwidth*2;
                y += rowheight;
            } else {
                y = rowheight;
                x = colwidth;
            }
        } break;
        
        case 2:
        {
            if (b < height) {
                y += rowheight;
                x += colwidth;
            } else {
                y = rowheight;
                x += colwidth;
            }
        } break;
    }
}
