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

public class CircleyThing_blue extends PApplet {



//  https://github.com/ericfickes/FIXLIB
Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;


int alf = 75;
float tX, tY, szW, szH, cX, cY, inc, m; 
float r,g,b;
int tmr_Interval = 10;  // seconds

float x, y, angle, sz;
float x2, y2, angle2, sz2; 
float x3, y3, angle3, sz3; 
float x4, y4, angle4, sz4; 

//////////////////////////////////////////////
public void setup() { 
  background(0xff000011);
  

  fix.alpha(alf);

  frameRate(303);  
  noFill();

  cX = width/2;
  cY = height/2;
  sz = 11;
  sz2 = 37;
  sz3 = 75;
  sz4 = 185;
} 


//////////////////////////////////////////////
public void draw() {
  smooth();

  x = cX - PApplet.parseInt( cos(radians(angle)) * sz );  // * noise(frameCount);
  y = cY - PApplet.parseInt( sin(radians(angle)) * sz );  // * noise(frameCount);
  x2 = cX - PApplet.parseInt( cos(radians(angle2)) * sz2 );  // * noise(frameCount);
  y2 = cY - PApplet.parseInt( sin(radians(angle2)) * sz2 );  // * noise(frameCount);
  x3 = cX - PApplet.parseInt( cos(radians(angle3)) * sz3 );  // * noise(frameCount);
  y3 = cY - PApplet.parseInt( sin(radians(angle3)) * sz3 );  // * noise(frameCount);
  x4 = cX - PApplet.parseInt( cos(radians(angle4)) * sz4 );  // * noise(frameCount);
  y4 = cY - PApplet.parseInt( sin(radians(angle4)) * sz4 );  // * noise(frameCount);

//BLINKY TO INDICATE ACTION
m = random(height);
strokeWeight(.37f);
stroke(millis()%0xff000075);
ellipse( cX, cY, m, m );


  strokeWeight(random(TWO_PI));
  stroke(0);
//  stroke(random(255), random(alf),random(alf),alf);
  point( x, y );
  point( x2, y2 );
  point( x3, y3 );
  point( x4, y4 );



  strokeWeight(.75f);
  stroke(random(37), random(37),random(255),alf);
  bezier(x, y, x2, y2, x3, y3, x4, y4 );
  bezier(x2, y2, x3, y3, x4, y4, x, y );
  stroke(random(75),random(75),random(255),alf);
  bezier(x3, y3, x4, y4, x, y, x2, y2 );
  bezier(x4, y4, x, y, x2, y2, x3, y3 );

    strokeWeight(TWO_PI*noise(y));
    stroke(millis()%0xff000075);
    point(x,y);
    stroke(random(75),random(75), random(255) );
    point(x2, y2);
    point(x3, y3);
    point(x4, y4);


// HACK: save on checking every single frame
if( frameCount % tmr_Interval == 0 ) {
//  LOFI timer.
    if( millis()/1000 % tmr_Interval == 0 ) {
      strokeWeight(noise(frameCount));
      r = random(255);
      g = random(255);
      b = random(11);
      stroke(r,g,b);
//      m = random(angle2,angle3);
      fix.drawLissajous( r,g,b );
} 
}
//println( millis() + " : " + millis()/1000 + " : " + tmr_Interval);



  angle += 10;
  angle2 += 15;
  angle3 += 20;
  angle4 -= 5;

  if ( angle2 % 360 == 0 ) {
    inc += TWO_PI;//cos(frameCount)*cos(frameCount)+PI;
    sz += inc;
    sz2 += inc;
    sz3 += inc;
    sz4 += inc;
      
    //  safe it
    if( sz > height || sz4 > height ) {
      sz = alf;
      sz2 = sz+5; 
      sz3 = sz+10;
      sz4 = sz+15;
    }
    

  }

  if ( frameCount > (width*PI) ) {
    doExit();
  }
}





///////////////////////////////////////////////////////////
//  End handler, saves png
public void doExit() 
{

  artDaily( "ERICFICKES.COM" );

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

  textFont( createFont( "AppleGaramond", 37 ) );  //  "TrajanPro-Bold"
  smooth();

  fill(0xff2012EF);
  text( " "+dailyMsg, -1, height-2);

  fill(0xff1975ef);
  text( " "+dailyMsg, 0, height-3);
}

  public void settings() {  size(1024, 768); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CircleyThing_blue" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
