

import ddf.minim.*;

Minim minim;
AudioInput in;
int y, x, z, cx, cy, bfSz, radSz, mod;
float x1, x2;

void setup()
{
  //fullScreen(P2D);
  size(1024, 768, P3D);

  // Pulling the display's density dynamically
  pixelDensity(displayDensity());
  background(0);
  smooth();
  
  cx = int(width/2);
  cy = int(height/2);

  minim = new Minim(this);
  
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  bfSz = in.bufferSize();
}


void draw()
{
 //<>//
  x = (frameCount%width);
  y = (frameCount%height);

  // the value returned by the level method is the RMS (root-mean-square) 
  // value of the current buffer of audio.
  // see: http://en.wikipedia.org/wiki/Root_mean_square
  //  EX: 0.022453465
  radSz = int(11 * (1 + in.left.level() + in.right.level()) );
  z = (frameCount%radSz);

// debug
println("radSz = "+radSz);

  //  LEVELS
  fill(radSz, 50);
  strokeWeight(1);
  stroke( y%200, x%150,z%100);

  //  TOP
  pushMatrix();
    sphereDetail( (int)random(2,sqrt(radSz)) );  //random(2,5) );
    translate(x, cy - (in.left.level()*height), z);
    rotate(frameCount);
    sphere(radSz*.5);
  popMatrix();
  
  //  BOTTOM
  pushMatrix();
    //boxDetail( (int)random(2,5) );  
    translate(x, cy + (in.right.level()*height), z);
    rotate(frameCount);
    box(radSz*.5);
  popMatrix();
 

  //  WAVEFORMS
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  // note that if the file is MONO, left.get() and right.get() will return the same value
  
beginShape();
  
  //  determine mod size based on radSz
  if(radSz>=15) 
    mod = 4;
  else 
    mod = 2;
  
  for(int i = 0; i < bfSz - 1; i++)
  {

    if(i%mod==0){
    
    
    x1 = map( i, 0, bfSz, 0, width );
    x2 = map( i+1, 0, bfSz, 0, width );
  
    //  LOWER WAVEFORMS
    strokeWeight(1);
    stroke( x%255,  x%200,  x%155, 50);
    vertex( x1, cy - (in.left.get(i) * 50) - (in.left.level()*cy) , z-11); 
    vertex( x2, cy + (in.right.get(i+1)* 50) + (in.right.level()*cy) , z-11);

    }
  }
endShape();


/*
  //  LEVELS REFERENCE
  point( x, cy/3 + (in.right.level()*cy) ); 
  point( x, cy/3 - (in.left.level()*cy) );
*/


  //  AUTO SAVER
  //if(frameCount%1800==0){
//  5 minutes?
    if(frameCount%9000==0){
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