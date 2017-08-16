/**
 * FindBySerialNumber. 
 * 
 * Sample code demonstrating how to find BlinkStick by serial number. 
 */
 
import blinkstick.*;

void setup() {
  BlinkStick device = BlinkStick.findBySerial("BS000001-1.0");
  
  if (device == null)
  {
    println("Not found...");  
  } 
  else
  {
    println("BlinkStick found. Current color: " + device.getColorString());
  }

  noLoop();
}
