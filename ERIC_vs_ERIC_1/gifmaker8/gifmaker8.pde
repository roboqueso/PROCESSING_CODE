import gifAnimation.*;

boolean gif = true;  // flip this switch to record a gif

GifMaker gifExport;
float xx, sz, ct = 10, cX, cY;
PVector pt, pt2;

/*

Take the zigzag line logic and apply to a circle drawer
        x = startX - int( cos(radians(angle)) * w );
        y = startY - int( sin(radians(angle)) * w );

*/


void setup() 
{
  size(250,250);
  background(0);
  smooth();
  
  sz=16;
  noFill();
  cX = width/2;
  cY = height/2;
  
  if(gif){
    frameRate(12);
    gifExport = new GifMaker(this, sketchName()+".gif");
    gifExport.setRepeat(0);             // make it an "endless" animation
    //  SCRIVNER: multiples of 16 frames
    gifExport.setTransparent(0,0,0);    // black is transparent
  //  gifExport.setTransparent(255);    // white is transparent
  }

}



void draw() 
{
  // we need both, but only drawing pt2 currently
    pt = new PVector( xx, xx );
    pt2 = circleXY( cX, cY, (random(pt.y)-random(cY)), xx ); 
    
    strokeWeight(TWO_PI);
    stroke(frameCount%255);
    point( pt2.x, pt2.y);
    
    strokeWeight(HALF_PI);
    stroke(frameCount);
    line(cX, cY, pt2.x, pt2.y );

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
