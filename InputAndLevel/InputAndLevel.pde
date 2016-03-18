

import ddf.minim.*;

Minim minim;
AudioInput in;
int y, x, cx, cy, sw, bfSz, radSz;
float x1, x2;

void setup()
{
  //fullScreen(P3D);
  size(1024, 768);//, P2D);
//  NOTE: 
//  default engine renders higher quality, but SUPER SLOW
//  P3D renders fast but crunchy


  // Pulling the display's density dynamically
  pixelDensity(displayDensity());
  background(0);
  smooth();
  
  
 

  
  rectMode(CENTER);

  cx = int(height/2);
  cy = int(width/2);

  minim = new Minim(this);
  
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  bfSz = in.bufferSize();
  
//  debug
//print("bufferSize() " + bfSz );
}



void draw()
{
 //<>//
  x = (frameCount%width);
  y = (frameCount%height);


  //  WAVEFORMS
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  // note that if the file is MONO, left.get() and right.get() will return the same value
  for(int i = 0; i < bfSz - 1; i++)
  {
    x1 = map( i, 0, bfSz, 0, width );
    x2 = map( i+1, 0, bfSz, 0, width );
  
    strokeWeight(PI);
    stroke( (in.left.level()*width)%255, (in.right.level()*height)%255, random(11,111), 100 );
    line( x1, 75 + in.left.get(i)*50, x2, 75 + in.left.get(i+1)*50 );
    line( x1, 225 + in.right.get(i)*50, x2, 225 + in.right.get(i+1)*50 );
  

    strokeWeight(HALF_PI);
    stroke( frameCount%255, 150);
    line( x1, 75 + in.left.get(i)*50, x2, 75 + in.left.get(i+1)*50 );
    line( x1, 225 + in.right.get(i)*50, x2, 225 + in.right.get(i+1)*50 );
  
    
    //  CENTER
    strokeWeight(.5);
    stroke( frameCount%255 );
    line( x1, cy + in.right.get(i)*100, 
          x2, cy + in.right.get(i+1)*100 );
    
    
  }
  

//  debug
//print(" L: " + in.left.level() + " R: " +in.right.level() );
  
  // the value returned by the level method is the RMS (root-mean-square) 
  // value of the current buffer of audio.
  // see: http://en.wikipedia.org/wiki/Root_mean_square
  //  EX: 0.022453465
  radSz = int(11* (1 + in.left.level() + in.right.level()) );
  
  //  LEVELS
  noFill();
  strokeWeight(.5);
  stroke( random(255) );
  
  rect( x, cy-50, TWO_PI, in.left.level()*height, radSz);
  rect( x, cy+50, TWO_PI, in.right.level()*height, radSz);



  //  AUTO SAVER
  if(frameCount%1800==0){
    save(pdeName() + getTimestamp() + ".png");
  }

}

void keyPressed()
{
  
  switch(key)
  {
    case 's':
    save(pdeName() + getTimestamp() + ".png");
    break;
  }
  
  
  
}

////////////////////////////////////////////////////////////////



public String getTimestamp() {
  return ""+month()+"-"+day()+"-"+year()+"-"+hour()+"-"+minute()+"-"+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
public String pdeName() {
  return split( this.toString(), "[")[0];
}