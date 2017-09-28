

import ddf.minim.*;

Minim minim;
AudioInput in;
int y, x, z, cx, cy, bfSz, radSz, mod;
float x1, x2;

int cirX, cirY, cirSz = 11, cirAng;

/////////////////////////////////////////////////////////////////////////////
void setup()
{
  //fullScreen();
  size(1024, 1024);
  
  // Pulling the display's density dynamically
  pixelDensity(displayDensity());
  background(255);
  smooth();
  strokeCap(PROJECT);
  
  cx = int(width/2);
  cy = int(height/2);

  minim = new Minim(this);
  
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  bfSz = in.bufferSize();
}


/////////////////////////////////////////////////////////////////////////////
void draw()
{
//background(255);
  
   //<>//
  x = (frameCount%width);
  y = (frameCount%height);

  // the value returned by the level method is the RMS (root-mean-square) 
  // value of the current buffer of audio.
  // see: http://en.wikipedia.org/wiki/Root_mean_square
  //  EX: 0.022453465
  radSz = int(11 * (1 + in.left.level() + in.right.level()) );
  z = (frameCount%radSz);
/*
  stroke(random(75));
  strokeWeight(9);
  line(  x, (cy - (in.left.level()*height))%height,
        x, (cy + (in.right.level()*height))%height );
  
    

  stroke(random(255),random(155),random(55));
  strokeWeight(PI);
  line(  x, (cy - (in.left.level()*height))%height,
        x, (cy + (in.right.level()*height))%height );
*/

drawLissajous( x, y, ( radSz + in.left.level() + in.right.level()) );

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
      cirSz *= 1.5;
    }
    cirSz = cirSz%width;
     
    cirX    = int(cx - int( cos(radians(cirAng)) * (cirSz + (in.left.level()*cx) ) ) );
    cirY    = int(cy - int( sin(radians(cirAng)) * (cirSz + (in.right.level()*cy) ) ) );
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
  /*
  strokeWeight(.75+in.left.level()+in.right.level());
  noFill();  
  stroke(  x*(in.left.level()*height)%height,
           (in.right.level()*width)%width,
           radSz*PI,
           75);
           
  ellipse(cx, cy, 
            ( radSz + (in.left.level()*height))%height,
            ( radSz + (in.right.level()*width))%width );
*/
  //  AUTO SAVER
  //if(frameCount%1800==0){
//  5 minutes?
    if(frameCount%9000==0){
    save(pdeName() + getTimestamp() + ".png");
  }

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

//////////////////////////////////////////////////////
//  
void drawLissajous( float a, float b, float amp )
{
//  float amp = 33;
  float x, y;
  float sz = amp / PI;  //TWO_PI;
  
  for( float t = 0; t <= 360; t += .1)
  {
    x = a - amp * sin(a * t * PI/180);
    y = b - amp * sin(b * t * PI/180);

//    point(x,y);
    evenOddStroke(255);  //  #2012EF

    ellipse(x,y,sz,sz);
    
  }
}

//////////////////////////////////////////////////////
//  Pass in a color, and this will fill even frames with 255,
//  odd frames with clr
//  * INVERTED for evenOddFill() pleasure
void evenOddStroke( color clr ) {
  if( frameCount % 2 == 0 ) {
    stroke(clr);
  } else {
    stroke(0);
  } 
}

public String getTimestamp() {
  return ""+month()+"-"+day()+"-"+year()+"-"+hour()+"-"+minute()+"-"+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
public String pdeName() {
  return split( this.toString(), "[")[0];
}