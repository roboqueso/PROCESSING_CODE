/**
 * FindAll. 
 * 
 * Sample code demonstrating how to iterate through all BlinkSticks 
 * connected to the computer and print their serial numbers.
 */
 
import blinkstick.*;

void setup() {
  println("Listing all BlinkSticks:");
  
  for (BlinkStick device: BlinkStick.findAll()) {
    println("  Found BlinkStick: " + device.getSerial());
  }

  noLoop();
}
