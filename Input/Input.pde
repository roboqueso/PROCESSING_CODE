

import ddf.minim.*;

Minim minim;
AudioInput in;
int y, x, cx, cy;
float l1,r1, sw;

void setup()
{
  //fullScreen(P3D);
  size(1024, 1024, P2D);
//  NOTE: 
//  default engine renders higher quality, but SUPER SLOW
//  P3D renders fast but crunchy


  // Pulling the display's density dynamically
  pixelDensity(displayDensity());
  background(255);
  smooth();
  
  
 

  
  rectMode(CENTER);

  cx = int(height/2);
  cy = int(width/2);

  minim = new Minim(this);
  
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
}



void draw()
{
 //<>//
  x = (frameCount%width);
  y = (frameCount%height);
  

  // draw the waveforms so we can see what we are monitoring
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    l1 = in.left.get(i);
    r1 = in.right.get(i);

    sw = (11*l1*r1); 
    if( sw < 0 ) sw = 11;
    
////////
    stroke(  (x*l1*r1),
             (i*l1*r1),
             (y*l1*r1) );
    strokeWeight( sw );
    point( i, l1*100 - y );
    point( i, r1*100 + y );


////////    
    stroke(i, x%255,y%200);
    strokeWeight(in.left.level()*11);
    point( i, l1*100 - y );
    
    strokeWeight(in.right.level()*11);
    point( i, r1*100 + y );

////////
    stroke(sw,50);
    line(0,y,width,y);




}



  //  AUTO SAVER
  //if(frameCount%780==0){
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