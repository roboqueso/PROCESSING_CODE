

import ddf.minim.*;

Minim minim;
AudioInput in;
int y, x, cx, cy, sw, bfSz, radSz;
float x1, x2;

void setup()
{
  //fullScreen(P2D);
  size(1024, 768, P2D);

  // Pulling the display's density dynamically
  pixelDensity(displayDensity());
  background(0);
  smooth();
  
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


//  debug
//print(" L: " + in.left.level() + " R: " +in.right.level() );
  
  // the value returned by the level method is the RMS (root-mean-square) 
  // value of the current buffer of audio.
  // see: http://en.wikipedia.org/wiki/Root_mean_square
  //  EX: 0.022453465
  radSz = int(11 * (1 + in.left.level() + in.right.level()) );
  
  //  LEVELS
  strokeWeight(PI + (1 + in.left.level() + in.right.level()) );
  stroke( x % 255, 175 + (1 + in.left.level() + in.right.level()) );
  point( x, cy/3 + (in.right.level()*cy) ); 
  point( x, cy/3 - (in.left.level()*cy) );
  
  
  strokeWeight(HALF_PI);
  stroke( random(255), 50);
  point( x, cy/3 + (in.right.level()*cy) ); 
  point( x, cy/3 - (in.left.level()*cy) );
 
  strokeWeight(1);
  stroke( random(255), 50);
  line( x, cy/3 + (in.right.level()*cy), 
       x, cy/3 - (in.left.level()*cy) );
  



  //  WAVEFORMS
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  // note that if the file is MONO, left.get() and right.get() will return the same value
  for(int i = 0; i < bfSz - 1; i++)
  {
    x1 = map( i, 0, bfSz, 0, width );
    x2 = map( i+1, 0, bfSz, 0, width );
  
    //  LOWER WAVEFORMS
    strokeWeight(PI + (1 + in.left.level() + in.right.level()) );
    stroke( i%255, x%255, y%255, 100);
    point( x1, cy - (in.left.get(i) * 42) - (in.left.level()*cy) ); 
    point( x2, cy + (in.right.get(i+1)* 42) + (in.right.level()*cy)  );
  
    strokeWeight(HALF_PI);
    stroke( random( frameCount%255 ), 200 );
    point( x1, cy - (in.left.get(i) * 42) - (in.left.level()*cy) ); 
    point( x2, cy + (in.right.get(i+1)* 42) + (in.right.level()*cy)  );

  }
  

  //  AUTO SAVER
  //if(frameCount%1800==0){
//  5 minutes?
    if(frameCount%9000==0){
    save( fix.pdeName() + fix.getTimestamp() + ".png");
  }

}

void keyPressed()
{
  
  switch(key)
  {
    case 's':
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    break;
  }
  
  
  
}

////////////////////////////////////////////////////////////////



public String getTimestamp() {
  return ""+month()+"-"+day()+"-"+year()+"-"+hour()+"-"+minute()+"-"+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?

  return split( this.toString(), "[")[0];
}