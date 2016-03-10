import gifAnimation.*;

GifMaker gifExport;
float xx, sz;

/* Vertical bars drawing left to right across the stage */

void setup() 
{
  size(250,250);
  background(255);
  smooth();
  //  frameRate(12);
  frameRate(32);

  gifExport = new GifMaker(this, "export.gif");
  gifExport.setRepeat(0);             // make it an "endless" animation
  //  SCRIVNER: multiples of 16 frames
//  gifExport.setTransparent(0,0,0);    // black is transparent
  gifExport.setTransparent(255);    // white is transparent

  strokeWeight(PI);
  sz=PI+2;
  noFill();

}



void draw() 
{
//    stroke(frameCount);
    stroke(random(255));
    line( xx, 0, xx, height );

//    stroke(random(255));
    line( 0, xx, width, xx );


    if( xx < width )
    {
      gifExport.setDelay(1);
      gifExport.addFrame();
      
      xx += sz;
    }
    else
    {
      gifExport.finish();  // write file
      stop();
    }


}

