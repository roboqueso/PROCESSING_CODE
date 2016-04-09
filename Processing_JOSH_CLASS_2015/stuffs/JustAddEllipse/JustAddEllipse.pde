import processing.pdf.*;

int i = 0, cX, cY;
////////////////////////////////////////////////////////
void setup() {  // this is run once.   
    
// NOTE: once finalized, rerun sketch and AI centric dimension
size(1280, 960);    
frameRate(420);


    background(0);
    smooth();
    noFill();
    cX = width/2;
    cY = height/2;
} 
////////////////////////////////////////////////////////
void draw() {
// strokeWeight(1);
// stroke(11);
// bezier( 
//         width-i*cos(frameCount), height-i*sin(frameCount),
//         0, 0, 
//         width, height,
//         i*cos(frameCount), i*sin(frameCount)
//         );
strokeWeight(PI);
stroke( i*sin(frameCount),i*sin(frameCount)%255, i*cos(frameCount));
bezier( 
        i*cos(frameCount), i*sin(frameCount),
        width, height,
        0, 0, 
        width-i*cos(frameCount), height-i*sin(frameCount)
        );

strokeWeight(1);
stroke( random(255) );
bezier( 
        i*cos(frameCount), i*sin(frameCount),
        width, height,
        0, 0, 
        width-i*cos(frameCount), height-i*sin(frameCount)
        );


stroke(random(255));
strokeWeight(random(11));
point ( width-i*cos(frameCount), height-i*sin(frameCount) );
point ( i*cos(frameCount), i*sin(frameCount) );
ellipse( width-i*cos(frameCount), height-i*sin(frameCount), i, i );
ellipse( i*cos(frameCount), i*sin(frameCount), i, i );
    // move it move it
    if (i < width ) {
        i+=TWO_PI;
    } else {
        i = 0; 
    }
    if( frameCount > width )
    {
        // fill(#EFEFEF);
        // textFont( createFont("SYSTEM", 35, true) );
        // text("just add ellipse", 4, 30 );
        // fill(#EF2012);
        // text("just add ellipse", 5, 31 );

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
