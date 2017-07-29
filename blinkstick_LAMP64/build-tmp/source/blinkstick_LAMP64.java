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

public class blinkstick_LAMP64 extends PApplet {

//  TODO: MAKE LAMP



//  Inspired by http://whatcolourisit.scn9a.org/
//  Coded by Eric Fickes - http://ericfickes.com


BlinkStick device;
float x, y;
int fontSz = 42;
String sHr, sMin, sSec, hexV;

//Change this to the number of LEDs connected
int leds = 64;


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
    delay(100);

    println("Manufacturer: " + device.getManufacturer());
    println("Product:      " + device.getProduct());
    println("Serial:       " + device.getSerial());
    println("Color:        " + device.getColorString());
    println("InfoBlock1:   " + device.getInfoBlock1());
    println("InfoBlock2:   " + device.getInfoBlock2());
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
  //  send colors to BlinkStick
  if(device!=null)
  {


    for(int i = 0; i < leds; i++)
    {
      device.setIndexedColor(i, (int)random(255));
    }


      delay(30);

  }


  //  auto stopper
  if(frameCount>3600)
  {
    LAMP_OFF();
    text("done",0,random(height));
    noLoop();
  }
}



////////////////////////////////////////////////////////////////////////
public void LAMP_OFF(){

    if(device!=null){

      for(int i = 0; i < leds; i++)
      {
        device.setIndexedColor(i, 0);
      }
      
      device.turnOff();  
    }

}


public void keyPressed(){

  if( key == ESC )
  {
    LAMP_OFF();

    text("done",0, random(height));

    noLoop();
  }
}
  public void settings() {  size(640,320); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "blinkstick_LAMP64" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
