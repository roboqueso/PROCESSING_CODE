 /*
 * ProLEDFrame.
 *
 * Send LED frame for BlinkStick Pro.
 */
 
import blinkstick.*;

void setup() {
  BlinkStick device = BlinkStick.findFirst();
  
  if (device == null)
  {
    println("Not found...");  
  } 
  else
  {
  	//You need to set the mode only once
    device.setMode(2);
    delay(100);
  
    //Change this to the number of LEDs connected
    int leds = 8;
    
    byte[] data = new byte[leds * 3];
    for (int i = 0; i < data.length; i++)
    {
      data[i] = (byte)random(128);
    }
    
    //Sends to R channel
    device.setColors(0, data);
  }

  noLoop();
}