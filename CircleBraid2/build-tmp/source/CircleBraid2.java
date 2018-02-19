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

public class CircleBraid2 extends PApplet {

//  IMPORTS  ////////////////////////////////////////////////////


// https://github.com/ericfickes/FIXLIB	


Fixlib fix = Fixlib.init(this);
Boolean isFinal = true, fwd = true;
int alf = 37, sz = 30;
float angle = -90, radius = 66, x, y, x2, y2, cX, cY, strokeSz = 2;


////////////////////////////////////////////////////
//
public void setup() {


  // setup core sketch settings items
  
  background(0xffEFEFEF);
  strokeWeight(strokeSz);
  frameRate(303);

  //  setup variables
  cX = width/2;
  cY = 0;

}


////////////////////////////////////////////////////
//
public void draw()
{
    x = cX - PApplet.parseInt( cos(radians(angle)) * radius );
    y = cY - PApplet.parseInt( sin(radians(angle)) * radius );
    
    x2 = cX - PApplet.parseInt( sin(radians(-angle)) * radius );
    y2 = cY - PApplet.parseInt( cos(radians(-angle)) * radius );


    stroke(random(155,255), sz, sz);
    ellipse( x, angle, sz, sz);

    stroke(random(100));
    ellipse( x2, angle, sz, sz);




    // stroke(sz,random(155,255), sz);
    // ellipse( angle, y, sz, sz);

    // stroke(random(100), sz, sz);
    // ellipse( angle, y2, sz, sz);


    if( angle % 270 == 0 )
    {
      cY += sz;
    }


    if(fwd)
      angle ++;
    else
      angle--;


    if ( angle >= height+sz ){
      cX = random(width-sz);
      cY = 0;
      angle = -90;
    }

    // STOPPER
    if( frameCount > (width+height)*radius ){
    	doExit();
    }
}



	
///////////////////////////////////////////////////////////
//  End handler, saves png
public void doExit() 
{



  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }


  noLoop();
  exit();
}



////// S SAVE HANDLER /////////

public void keyPressed(){
switch(key){
	case 's':
		save( fix.pdeName() + fix.getTimestamp() + ".png");
	break;

	case ESC:
		save( fix.pdeName() + fix.getTimestamp() + ".png");
		stop();
	break;
}

}
  public void settings() {  size(1024, 768); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CircleBraid2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
