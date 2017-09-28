/**
 * Information.
 *
 * Prints all available information about BlinkStick like manufacturer, product name, serial number,
 * current color, and info blocks.
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
    println("Manufacturer: " + device.getManufacturer());
    println("Product:      " + device.getProduct());
    println("Serial:       " + device.getSerial());
    println("Color:        " + device.getColorString());
    println("InfoBlock1:   " + device.getInfoBlock1());
    println("InfoBlock2:   " + device.getInfoBlock2());
  }

  noLoop();
}
