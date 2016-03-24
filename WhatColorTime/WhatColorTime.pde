 /*
 * ProLEDFrame.
 *
 * Send LED frame for BlinkStick Pro.
 */
 
import blinkstick.*;
BlinkStick device;
float x, y;
int fontSz = 20;

////////////////////////////////////////////////////////////////////////
void setup() {
  size(640,480);

  textSize(fontSz);


  device = BlinkStick.findFirst();
  if(device!=null)
  {
    //You need to set the mode only once
    device.setMode(2);
  }
  else{

    println("NO BLINKSTICK");
    noLoop();

  }
}

////////////////////////////////////////////////////////////////////////
void draw()
{
  if (device != null)
  {

    
/*  
    //Change this to the number of LEDs connected
    int leds = 3;//8;
    
    byte[] data = new byte[leds * 3];

    for (int i = 0; i < data.length; i++)
    {
      data[i] = (byte)random(128);
    }

    //  sends to 1 of 3 channels
      device.setColors(0, data);  //  R
delay(333);
      device.setColors(1, data);  //  G
delay(333);
      device.setColors(2, data);  //  B
delay(333);
*/

    dotime();

  }
  
  

  if(frameCount>height+width){
    text("done",0,random(height));
    device.turnOff();
    noLoop();
  }
}


////////////////////////////////////////////////////////////////////////
void dotime()
{

  int hours = hour();
  int mins = minute();
  int secs = second();
  String sHr, sMin, sSec;

  sHr = (hours < 10) ? "0" + hours : str(hours);
  sMin = (mins < 10) ? "0" + mins : str(mins);
  sSec = (secs < 10) ? "0" + secs : str(secs);
  
  // String hexV = "#" + sHr + sMin + sSec;
  String hexV = sHr + sMin + sSec;


  background( unhex(hexV) );
  
  fill(255);
  text("#"+hexV, x, y );

  // TEST
  // device.setColor( int(hexV) );
  // device.setIndexedColor(0, 0, int(random(75)) );
  // device.setIndexedColor(0, 1, (int)random(128) );
  // device.setColor(unhex(hexV));
  
  device.setIndexedColor(0, 0, int(hexV) );
  delay(250);
  device.setIndexedColor(1, 0, int(hexV) );
  delay(250);
  device.setIndexedColor(2, 0, int(hexV) );
  delay(250);


  device.setIndexedColor(0, 0, 0 );
  delay(250);
  device.setIndexedColor(1, 0, 0 );
  delay(250);
  device.setIndexedColor(2, 0, 0 );
  delay(250);

  // manage x,y
  if( y < height ){
    y += fontSz;
  } else {
    y = 0;

    if(x<width)
      x = x += (hexV.length()*fontSz);
    else
      x = 0;
  }
}


////////////////////////////////////////////////////////////////////////
void keyPressed(){

  if( key == ESC )
  {
    text("done",0, random(height));
    device.turnOff();
    noLoop();
  }
}



