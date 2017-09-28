 /*
 * ProIndexedColors.
 *
 * Send indexed colors to BlinkStick Pro.
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

    device.setIndexedColor(0, 0, color(255, 0, 0));
    device.setIndexedColor(0, 1, color(0, 255, 0));
    device.setIndexedColor(0, 2, color(0, 0, 255));
  }

  noLoop();
}