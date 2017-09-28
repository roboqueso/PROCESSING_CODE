/**
 * Pulse.
 *
 * Basic example showing how to pulse red color.
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
    for (int i = 0; i < 255; i++) {
      device.setColor(i, 0, 0);
      delay(7);
    } 	

    for (int i = 255; i >= 0; i--) {
      device.setColor(i, 0, 0);
      delay(7);
    }   
  }

  noLoop();
}