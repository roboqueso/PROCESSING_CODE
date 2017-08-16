/**
 * HelloWorld. 
 * 
 * Sample code demonstrating how to find a first BlinkStick connected to the computer 
 * and change colors.
 *
 * The following functions are available to set the color:
 *
 * setColor(name)
 *     Sets the named color, for example "red", "green", "blue" and etc.
 *
 *     Example: 
 *         device.setColor("pink"); 
 * 
 * setColor(r, g, b)
 *     Sets the color by r, g and b value. The values define the intensity of each
 *     RGB color element in the range from 0 to 255.
 *
 *     Example: 
 *         device.setColor(255, 0, 0) sets red
 *
 * setColor(color)
 *     Sets the color based on the Processing color functions
 *
 *     Example:
 *         color c = color(0, 255, 0);
 *         device.setColor(c); 
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
    device.setColor("red");
    delay(1000);
    device.setColor("green");
    delay(1000);
    device.setColor("blue");
    delay(1000);
    device.turnOff();
  }

  noLoop();
}
