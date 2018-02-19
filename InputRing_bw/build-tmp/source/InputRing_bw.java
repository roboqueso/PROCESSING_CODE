import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import fixlib.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class InputRing_bw extends PApplet {


// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);


Minim minim;
AudioInput in;
int y, x, z, cx, cy, bfSz, radSz, mod;
float x1, x2;

int cirX, cirY, cirSz = 11, cirAng;

/////////////////////////////////////////////////////////////////////////////
public void setup()
{
  //fullScreen();
  
  
  // Pulling the display's density dynamically
  
  background(255);
  
  strokeCap(PROJECT);
  
  cx = PApplet.parseInt(width/2);
  cy = PApplet.parseInt(height/2);

  minim = new Minim(this);
  
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  bfSz = in.bufferSize();
}


/////////////////////////////////////////////////////////////////////////////
public void draw()
{
 //<>//
  x = (frameCount%width);
  y = (frameCount%height);

  // the value returned by the level method is the RMS (root-mean-square) 
  // value of the current buffer of audio.
  // see: http://en.wikipedia.org/wiki/Root_mean_square
  //  EX: 0.022453465
  radSz = PApplet.parseInt(11 * (1 + in.left.level() + in.right.level()) );
  z = (frameCount%radSz);

  stroke(random(75));
  strokeWeight(9);
  line(  x, (cy - (in.left.level()*height))%height,
        x, (cy + (in.right.level()*height))%height );
  
    

  stroke(random(255),random(155),random(55));
  strokeWeight(PI);
  line(  x, (cy - (in.left.level()*height))%height,
        x, (cy + (in.right.level()*height))%height );


  //  WAVEFORMS
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  // note that if the file is MONO, left.get() and right.get() will return the same value
  

  for(int i = 0; i < bfSz - 1; i++)
  {

    //  CIRCLE CIRCLE DOT DOT
    cirAng = (i % 359);
      
    // hack circle increaser
    if(cirAng % 360 == 0)
    {
      cirSz *= 1.5f;
    }
    cirSz = cirSz%width;
     
    cirX    = PApplet.parseInt(cx - PApplet.parseInt( cos(radians(cirAng)) * (cirSz + (in.left.level()*cx) ) ) );
    cirY    = PApplet.parseInt(cy - PApplet.parseInt( sin(radians(cirAng)) * (cirSz + (in.right.level()*cy) ) ) );
    //  hack safety
    cirX = cirX%width;
    cirY = cirY%height;

    strokeWeight(2+(in.left.level()+in.right.level()));
    stroke(frameCount%255, 10*(in.left.level()+in.right.level()));
    point(cirX, cirY);

if(radSz >= 16 && i % 4 == 0 ) {

//  WAVEFORM    
    x1 = map( i, 0, bfSz, 0, width );
    x2 = map( i+1, 0, bfSz, 0, width );
  
  // hack
  //radSz = 50;
  
    //  LOWER WAVEFORMS
    strokeWeight(3);
    stroke( radSz, 100 );
    point( x1, cy - (in.left.get(i) * 50) - (in.left.level()*cy) ); 
    point( x2, cy + (in.right.get(i+1)* 50) + (in.right.level()*cy) );

    strokeWeight(2);
    stroke( random(200,255) );
    point( x1, cy - (in.left.get(i) * 50) - (in.left.level()*cy) ); 
    point( x2, cy + (in.right.get(i+1)* 50) + (in.right.level()*cy) );

}
  }
  
  strokeWeight(.75f+in.left.level()+in.right.level());
  noFill();  
  stroke(  x*(in.left.level()*height)%height,
           (in.right.level()*width)%width,
           radSz*PI,
           75);
           
  ellipse(cx, cy, 
            ( radSz + (in.left.level()*height))%height,
            ( radSz + (in.right.level()*width))%width );

  //  AUTO SAVER
  //if(frameCount%1800==0){
//  5 minutes?
    if(frameCount%9000==0){
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    minim = null;
    noLoop();
    exit();
  }

}



/////////////////////////////////////////////////////////////////////////////
public void keyPressed()
{
  
  switch(key)
  {
    case 's':
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    break;
  }
  
  
}
  public void settings() {  size(1024, 1024);  smooth();  pixelDensity(displayDensity()); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "InputRing_bw" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
