import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import blinkstick.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class blinkstick_LAMP extends PApplet {

//  TODO: MAKE LAMP



//  Inspired by http://whatcolourisit.scn9a.org/
//  Coded by Eric Fickes - http://ericfickes.com


BlinkStick device;
float x, y;
int fontSz = 42;
String sHr, sMin, sSec, hexV;

////////////////////////////////////////////////////////////////////////
public void setup() 
{
  
  textAlign(CENTER,CENTER);
  fill(255);
  device = BlinkStick.findFirst();
  if(device!=null)
  {
    //You need to set the mode only once
    
    device.setMode(2);
  }
  else
  {
    println("NO BLINKSTICK");
    noLoop();
  }
}

////////////////////////////////////////////////////////////////////////
public void draw()
{
    //  get time in string format
  sHr = ( hour() < 10) ? "0" + hour() : str(hour());
  sMin = (minute() < 10) ? "0" + minute() : str(minute());
  sSec = (second() < 10) ? "0" + second() : str(second());
 
    //  make hexidecimal
  hexV = sHr + sMin + sSec;
  
  //  change background color
  background( unhex(hexV) );

  
  //  time
  textSize(fontSz*PI);
  // text( sHr + ":" + sMin + ":" + sSec, (width/PI)-(textAscent()+textDescent()), (height/2) );
  text( sHr + ":" + sMin + ":" + sSec, width/2, (height/4) );


  //  hexidecimal
  textSize(fontSz);
  text("#"+hexV, (width/2), (height/2)+(textAscent()+textDescent()) );



  //  send colors to BlinkStick
  if(device!=null)
  {
    //  "blink" color
    device.setIndexedColor(0, 0, color(255, 0, 0));//unhex(hexV) );
    delay(160);
    device.setIndexedColor(1, 0, color(0, 255, 0));//unhex(hexV) );
    delay(160);
    device.setIndexedColor(2, 0, color(0, 0, 255));//unhex(hexV) );
    delay(160);


    //  "turn off LEDs"
    device.setIndexedColor(0, 0, 0 );
    delay(160);
    device.setIndexedColor(1, 0, 0 );
    delay(160);
    device.setIndexedColor(2, 0, 0 );
    delay(160);
  }



  //  auto stopper
  if(frameCount>3600)
  {
    if(device!=null)
    {
      device.turnOff();
    }
    text("done",0,random(height));
    noLoop();
  }
}



////////////////////////////////////////////////////////////////////////
public void keyPressed(){

  if( key == ESC )
  {
    if(device!=null){
      device.turnOff();  
    }

    text("done",0, random(height));

    noLoop();
  }
}
  public void settings() {  size(640,320); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "blinkstick_LAMP" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
