/**
 * InfoBlocks.
 *
 * Infoblocks are basic data that can be stored on the device. Each infoblock consists of 32 bytes.
 * 
 * InfoBlock1 - used to store the name of the BlinkStick.
 * infoBlock2 - can contain any 32 bytes of data.
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
    device.setInfoBlock1("Kitchen BlinkStick");
    println(device.getInfoBlock1());

    device.setInfoBlock2("info-block-2data");
    println(device.getInfoBlock2());
  }

  noLoop();
}
