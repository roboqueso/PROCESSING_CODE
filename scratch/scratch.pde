

import ddf.minim.*;

Minim minim;
AudioInput in;
int y, x, z, cx, cy, bfSz, radSz, mod;
float x1, x2;

int cirX, cirY, cirSz = 15, cirAng;

/////////////////////////////////////////////////////////////////////////////
void setup()
{
  //fullScreen(P3D);
  size(1024, 768, P3D);
/*
  // Pulling the display's density dynamically
  pixelDensity(displayDensity());
  background(0);
  smooth();
  
  minim = new Minim(this);
  
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  */
  
  bfSz = 1028;
  cx = int(width/2);
  cy = int(height/2);
}


/////////////////////////////////////////////////////////////////////////////
void draw()
{

  x = (frameCount%width);
  y = (frameCount%height);

  // the value returned by the level method is the RMS (root-mean-square) 
  // value of the current buffer of audio.
  // see: http://en.wikipedia.org/wiki/Root_mean_square
  //  EX: 0.022453465
  radSz = int(11 * noise(frameCount) );
  z = (frameCount%(radSz+1));
 

  //  WAVEFORMS
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  // note that if the file is MONO, left.get() and right.get() will return the same value


  for(int i = 0; i < bfSz - 1; i++)
  {

    //  CIRCLE CIRCLE DOT DOT
    cirAng = (i % 359);
      
    // hack circle increaser
    if(cirAng % 359 == 0)
    {
      cirSz *= 1.25;
//  DEBUG
println(i + " : cirAng = " + cirAng + " cirSz = " + cirSz );    
    }
    
    cirSz = cirSz%width;
    

stroke(random(255));

    cirX    = (cx - (in.left.get(i) * 50) - (in.left.level()*cx)) - int( cos(radians(cirAng)) * cirSz );
    cirY    = (cy - (in.left.get(i) * 50) - (in.left.level()*cy)) - int( sin(radians(cirAng)) * cirSz );
    
    strokeWeight(PI);
    point(cirX, cirY);

    //////////////
/*
    x1 = map( i, 0, bfSz, 0, width );
    x2 = map( i+1, 0, bfSz, 0, width );
  
    //  LOWER WAVEFORMS
    strokeWeight(PI);
    stroke( ((bfSz/x1+1)%255),  ((bfSz/x1+1)%200),  ((bfSz/x1+1)%100), 50);
    point( x1, cy - (in.left.get(i) * 50) - (in.left.level()*cy) , z-11); 
    point( x2, cy + (in.right.get(i+1)* 50) + (in.right.level()*cy) , z-11);




    strokeWeight(HALF_PI);
    stroke( x%255,  x%200,  x%155, 150);
    point( x1, cy - (in.left.get(i) * 50) - (in.left.level()*cy) , z-11); 
    point( x2, cy + (in.right.get(i+1)* 50) + (in.right.level()*cy) , z-11);
*/
  }



/*
  //  LEVELS REFERENCE
  point( x, cy/3 + (in.right.level()*cy) ); 
  point( x, cy/3 - (in.left.level()*cy) );
*/



}



/////////////////////////////////////////////////////////////////////////////
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