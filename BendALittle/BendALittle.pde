public float x=0,y=0, col1024=0, row768=0, rX, rY;
public int i = 0, gridSize = 11, cX, cY;
public Boolean isFinal = true;

/////////////////////////////////////////////////////////////////////////////////
void setup() {
    background(#012345);
    size(1024,768);
//size(display1024, display768);
    smooth();
    noFill();
    
    cX = int(1024/2);
    cY = int(768/2);
    col1024 = 1024/gridSize;
    row768 = 768/row768;
    
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
        
        rX = random(1024-x);
        rY = random(768-y);
 
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
        col1024 = 1024/gridSize;
        row768 = 768/row768;
    }
    if(frameCount>768+1024){
        fill(#000075);
        textFont(createFont("Monospace", 11));
        text("ERICFICKES.COM", 11, 768-11);
        
        if(isFinal){
          save( pdeName() + getTimestamp() + ".png");
        }

        noLoop();
    }
}
/////////////////////////////////////////////////////////////////////////////////
void xySystem( float a, float b ){
    switch( int( random( 3 ) ) ){
        case 0:{
            if (a < 1024) {
                x += col1024;
            } else {
                x = col1024;
                y += row768;
            }
        } break;
        
        case 1:
        {
            if (b < 768) {
                x += col1024*2;
                y += row768;
            } else {
                y = row768;
                x = col1024;
            }
        } break;
        
        case 2:
        {
            if (b < 768) {
                y += row768;
                x += col1024;
            } else {
                y = row768;
                x += col1024;
            }
        } break;
    }
}


String getTimestamp() {
  return ""+month()+day()+year()+hour()+minute()+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
String pdeName() {
  return split( this.toString(), "[")[0];
}
