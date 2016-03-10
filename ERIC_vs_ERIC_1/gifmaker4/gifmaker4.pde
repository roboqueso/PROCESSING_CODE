import gifAnimation.*;

GifMaker gifExport;
float xx, sz, ct = 4;

/* Vertical bars drawing left to right across the stage */

void setup() 
{
  size(250,250);
  background(0);
  smooth();
  //  frameRate(12);
  frameRate(32);

  gifExport = new GifMaker(this, sketchName()+".gif");
  gifExport.setRepeat(0);             // make it an "endless" animation
  //  SCRIVNER: multiples of 16 frames
  gifExport.setTransparent(0);    // black is transparent
  // strokeWeight(HALF_PI);
  sz=PI+2;
  noFill();

}



void draw() 
{
    stroke(frameCount%255,50);
    line( xx, 0, xx, frameCount );
    
//    stroke(random(255),100);
    line( 0, xx, frameCount, xx );


    if( xx < width )
    {
      gifExport.setDelay(1);
      gifExport.addFrame();
      
      xx += sz;
    }
    else
    {
      if(ct<=0)
      {
      gifExport.finish();  // write file
      stop();
      }
      else{
//        background(255);
//fill(255,50);
//noStroke(); 
//rect(0,0,width,height); // DOES THE "OVERLAY" TRICK INCREASE OR DESCREATE FILESIZE?
//        gifExport.setTransparent(100);
        xx=0;
        ct--;
      }
    }


}

////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////
PVector circleXY( float centerX, float centerY, float radius, float angle )
{
  return new PVector(
                centerX - int( cos(radians(angle)) * radius ),
                centerY - int( sin(radians(angle)) * radius )
                );
}

//  return unique filename_timestamp string
public String sketchName(){
  return split( this.toString(), "[")[0];
}
//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}
