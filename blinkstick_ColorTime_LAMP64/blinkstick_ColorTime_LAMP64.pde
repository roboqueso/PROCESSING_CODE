//  TODO: MAKE LAMP



//  Inspired by http://whatcolourisit.scn9a.org/
//  Coded by Eric Fickes - http://ericfickes.com

import blinkstick.*;
BlinkStick device;
float x, y;
int fontSz = 42;
String sHr, sMin, sSec, hexV;

//Change this to the number of LEDs connected
int leds = 64;


////////////////////////////////////////////////////////////////////////
void setup() 
{
  size(640,320);
  textAlign(CENTER,CENTER);
  fill(255);
  device = BlinkStick.findFirst();
  if(device!=null)
  {
    //You need to set the mode only once
    device.setMode(2);
    delay(100);

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

   //  get time in string format
  sHr = ( hour() < 10) ? "0" + hour() : str(hour());
  sMin = (minute() < 10) ? "0" + minute() : str(minute());
  sSec = (second() < 10) ? "0" + second() : str(second());
 
    //  make hexidecimal
  hexV = sHr + sMin + sSec;
  
  //  change background color
  background( unhex(hexV) );

  
  //  time
  textSize(fontSz*PI);
  // text( sHr + ":" + sMin + ":" + sSec, (width/PI)-(textAscent()+textDescent()), (height/2) );
  text( sHr + ":" + sMin + ":" + sSec, width/2, (height/4) );


  //  hexidecimal
  textSize(fontSz);
  text("#"+hexV, (width/2), (height/2)+(textAscent()+textDescent()) );




    for(int i = 0; i < leds; i++)
    {
      device.setIndexedColor(i, (int)unhex(hexV) );
      delay(1);
    }


  }


  //  auto stopper
  if(frameCount>3600)
  {
    LAMP_OFF();
    text("done",0,random(height));
    noLoop();
  }
}



////////////////////////////////////////////////////////////////////////
//  FICKES 
void LAMP_OFF(){

    if(device!=null){

      for(int i = 0; i < leds; i++)
      {
        device.setIndexedColor(i, 0);
        delay(11);
      }
      
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