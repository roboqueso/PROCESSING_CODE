import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import fixlib.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class CircDeRedLay extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);


/////////////////////////////////////

Boolean isFinal = true;
int alf = 11;
float cX, cY, eX, eY, i;

public void setup() {
    background(0xff000011);
    
  frameRate(303); 
  fix.alpha(alf);
    
    noFill();
    ellipseMode(CENTER);
    rectMode(CENTER);
    
    cX = width/2;
    cY = height/2;
} 

public void draw() {  // this is run repeatedly.  


    eX = cX *cos(frameCount)*radians(cX); 
    eY = cY *sin(frameCount)*radians(cY);


    stroke(random(255), alf);
    fix.systems(eX, eY);
    stroke(random(11,42), alf);
    fix.systems(eY, eX);
    
    stroke(0,0,random(alf),alf);
    fix.systems(cX+i, cY+i);
    
    stroke(random(alf),0,0,alf);
    fix.systems(cX-i, cY-i);

    // move over a pixel
    if (i < width/2) {
        i+=1;
    } else {
        i = 0; 
    }
    

  if( frameCount > height+width )
    {
        doExit();
    }
}


///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
public void doExit() 
{

  //  artDaily("The difference between who you are and who you want to be is WHAT YOU DO");
  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
public void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 42 ) );
  smooth();
  
  fill(0xff20EF75);
  text( " "+dailyMsg, width-420, this.height-10);
  
  fill(0);
  text( " "+dailyMsg, width-421, this.height-9);
  
  fill(0xffEFEFEF);
  text( " "+dailyMsg, width-422, this.height-8);
}

  public void settings() {  size(1024, 768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CircDeRedLay" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
