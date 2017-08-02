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

public class Flow_LAMP64 extends PApplet {

/*
  FLOW lightboard behavior
  0-on
  1-off
  
  L to R
  R to L
  play with alternating on/off gaps
*/


BlinkStick device;
float x, y;
int fontSz = 42;
String sHr, sMin, sSec, hexV;
int thisLed = 0, iDelay = 2;


//  Change this to the number of LEDs connected
// NOTE: leds is used all over the place.  don't remove it
int leds = 64;


////////////////////////////////////////////////////////////////////////
public void setup() 
{
  
  background(0);
  
  fill(255);
  textAlign(CENTER,CENTER);
  
  //iDelay = (int)sqrt(leds);

  device = BlinkStick.findFirst();


  //  NOTE: don't mess with frameRate for the time being
  //  delay(leds) seems to be helping throughout this sketch

  if(device!=null)
  {
    //You need to set the mode only once
    device.setMode(2);
    delay(iDelay);

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
      try
      {
	      	if(i==thisLed)
	      	{
	          device.setIndexedColor(i, color(255,0,0) );
	      	}
	      	else
	      	{
	          device.setIndexedColor(i, color(frameCount%255) );
	      	}

	        delay(iDelay);
	         
	    } 
	    catch( Exception e )
	    {
	      println("Exception: "+ e);
	    }
    }


    if(thisLed<leds){
    	thisLed++;
    }else{
    	// thisLed=0;
    	thisLed = (int)random(leds);
    }

  }

  //  auto stopper
  if(frameCount>3600)
  {
    LAMP_OFF();
    text("done",0,random(height));
    noLoop();
  }


//} // frameCount % leds



}


////////////////////////////////////////////////////////////////////////
//  FICKES 
public void LAMP_OFF(){

    if(device!=null){

      setColors(0);
      delay(10);

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

public void setColors(int c){

  for(int i = 0; i < leds; i++)
  {
    try{
      device.setIndexedColor(i, c);
      delay((int)sqrt(leds));
  } catch( Exception e )
  {
    println("Exception: "+ e);
  }
  }

}
  public void settings() {  size(640,320); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Flow_LAMP64" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
