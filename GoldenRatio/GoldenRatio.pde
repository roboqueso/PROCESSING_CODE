float phi = (sqrt(5)+1)/2;
// https://github.com/ericfickes/FIXLIB 
import fixlib.*;
Fixlib fix = Fixlib.init(this);
String SAVE_NAME = "thisShouldBeDynamic";

/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(1760, 880, P3D); // FX2D can't load OBJs?
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
  background(-1);
 
  //  Generate filename containing sketch settings meta NOW
  SAVE_NAME = fix.pdeName() + "-"+ fix.getTimestamp();

  translate(height/phi,0);
  scale(height);
  noStroke();  
  //strokeWeight(HALF_PI);
  //stroke(255);
  smooth(8);

/*
  for (float i=0; i<10; i++) 
  {
    fill(i/10*255, i);
    rect(0,0,1,1);

    fill( i%255,255,0,i);  //150);
    arc(0,0,2,2,0,PI/2);
    
    scale(1/phi);
    rotate(PI/2);
    translate(1/phi,0);   
  } 
*/
}

void draw(){
  
  
 translate(width*0.5, height*0.5);

  float f = TWO_PI*(sqrt(5) + 1) * 0.5;  // golden ratio

  for (int r = 0; r < width; r++) {
    //stroke(f%255, r%255, f+r%255);
    
    // colors
    if(r%2==0)
     stroke(f*r%255, f%255, r%255); 
    else if(r%3==0)
     stroke(r%255, f*r%255, f%255); 
    else if(r%5==0)
     stroke(f%255, r%255, f*r%255); 
    else
     stroke( f*r%255,f*r%255, f*r%255);

    strokeWeight( 1+(r/TWO_PI) );
    point(cos(f*r)*r, sin(f*r)*r);
    
  } 

  doExit();
  
  
}


/**
  End of sketch closer
*/
void doExit()
{


  String msg = "ericfickes.com";
  //  stamp bottom right based on textSize
  fill(0);
  textSize(16);
  text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());

  //  SAVE W/META FOR RE-RUN HELP
  //  NAME-GROUP-lights_fillStyle_radius_preScale-TIMESTAMP
  save( SAVE_NAME +".png" );    //  USE .TIF IF COLOR  

  //  cleanup
  fix = null;




  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
