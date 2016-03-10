import gifAnimation.*;

GifMaker gifExport;
float xx, sz, ct = 4;
boolean gif = true;
PVector pt;

void setup() 
{
  size(250,250);
  background(0);
  smooth();
  //  frameRate(12);
  frameRate(32);
  if(gif){
    gifExport = new GifMaker(this, "export.gif");
    gifExport.setRepeat(0);             // make it an "endless" animation
    //  SCRIVNER: multiples of 16 frames
    gifExport.setTransparent(0,0,0);    // black is transparent
  //  gifExport.setTransparent(255);    // white is transparent
  }
  strokeWeight(HALF_PI);
  sz=TWO_PI;
  noFill();
}



void draw() 
{
    pt = new PVector(random(xx),random(xx));
    stroke(random(155,255));
    //  vertical
    line( xx, 0, xx, pt.y );
    
    stroke(random(150));
    //  horizontal
    line( 0, xx, pt.x, xx );


    if( xx < width )
    {
      
      if(gif){
      gifExport.setDelay(1);
      gifExport.addFrame();
      }
      
      xx += sz;
    }
    else
    {
      if(ct<=0)
      {
        if(gif){
        gifExport.finish();  // write file
        }
      stop();
      }
      else{
        xx=random(-sz,sz);
        ct--;
      }
    }


}

