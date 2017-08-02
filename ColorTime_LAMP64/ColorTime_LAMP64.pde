//  TODO: MAKE LAMP



//  Inspired by http://whatcolourisit.scn9a.org/
//  Coded by Eric Fickes - http://ericfickes.com

import blinkstick.*;
BlinkStick device;
float x, y;
int fontSz = 42;
String sHr, sMin, sSec, hexV;
int iHr, iMin, iSec;


//  Change this to the number of LEDs connected
// NOTE: leds is used all over the place.  don't remove it
int leds = 64;


////////////////////////////////////////////////////////////////////////
void setup() 
{
  size(640,320);
  background(0);
  
  fill(255);
  textAlign(CENTER,CENTER);
  
  device = BlinkStick.findFirst();


  //  NOTE: don't mess with frameRate for the time being
  //  delay(leds) seems to be helping throughout this sketch

  if(device!=null)
  {
    //You need to set the mode only once
    device.setMode(2);
    delay(leds);

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

  //  TODO : does this "smooth" things out
  //  FOR THIS SKETCH WHICH IS A CLOCK
  //  REFRESH EVERY SECOND
//  if(frameCount %60==0){

   //  get time in string format
  sHr = ( hour() < 10) ? "0" + hour() : str(hour());
  sMin = (minute() < 10) ? "0" + minute() : str(minute());
  sSec = (second() < 10) ? "0" + second() : str(second());
 
  //  GET CRAZY WITH COLORS BUT STILL DISPLAY sTIME
  iHr = (hour()*21)%255;
  iMin = (minute()*60)%255;
  iSec = (second()*60)%255;
 
    //  make hexidecimal
  hexV = sHr + "" + sMin + "" + sSec;
  
  //  change background color
  // background( unhex(hexV) );
  background( color(iHr, iMin, iSec ) );

  
  //  time
  textSize(fontSz*PI);
  // text( sHr + ":" + sMin + ":" + sSec, (width/PI)-(textAscent()+textDescent()), (height/2) );
  text( sHr + ":" + sMin + ":" + sSec, width/2, (height/4) );


  //  hexidecimal
  textSize(fontSz);
  // text("#"+hexV, (width/2), (height/2)+(textAscent()+textDescent()) );
  text( color(iHr, iMin, iSec ) , (width/2), (height/2)+(textAscent()+textDescent()) );
  
  //  send colors to BlinkStick
  if(device!=null)
  {


      // setColors( (int)unhex(hexV) );
      setColors(  color(iHr, iMin, iSec )  );
      // delay(leds);

  }

  //  auto stopper
  if(frameCount>3600)
  {
    LAMP_OFF();
    text("done",0,random(height));
    noLoop();
  }


//} // frameCount % leds



}


////////////////////////////////////////////////////////////////////////
//  FICKES 
void LAMP_OFF(){

    if(device!=null){

      setColors(0);
      delay(10);

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

public void setColors(int c){

  for(int i = 0; i < leds; i++)
  {
    try{
      device.setIndexedColor(i, c);
      delay((int)sqrt(leds));
  } catch( Exception e )
  {
    println("Exception: "+ e);
  }
  }

}