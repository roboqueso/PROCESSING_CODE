/*
  FLOW lightboard behavior
  0-on
  1-off
  
  L to R
  R to L
  play with alternating on/off gaps
*/

import blinkstick.*;
BlinkStick device;
float x, y;
int fontSz = 42;
String sHr, sMin, sSec, hexV;
int thisLed = 0, iDelay = 2;


//  Change this to the number of LEDs connected
// NOTE: leds is used all over the place.  don't remove it
int leds = 64;


////////////////////////////////////////////////////////////////////////
void setup() 
{
  size(640,320);
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
void draw()
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

    //	Left to Right ->>
    if(thisLed<leds){
    	thisLed++;
    }else{
    	thisLed=0;
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
void LAMP_OFF(){

    if(device!=null){

      setColors(0);
      delay(10);

      device.turnOff();  
    }

}


void keyPressed(){

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