//  TODO: MAKE LAMP



//  Inspired by http://whatcolourisit.scn9a.org/
//  Coded by Eric Fickes - http://ericfickes.com

import blinkstick.*;
BlinkStick device;
float x, y;
int fontSz = 42;
String sHr, sMin, sSec, hexV;

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



  //  send colors to BlinkStick
  if(device!=null)
  {
    //  "blink" color
    device.setIndexedColor(0, 0, color(255, 0, 0));//unhex(hexV) );
    delay(160);
    device.setIndexedColor(1, 0, color(0, 255, 0));//unhex(hexV) );
    delay(160);
    device.setIndexedColor(2, 0, color(0, 0, 255));//unhex(hexV) );
    delay(160);


    //  "turn off LEDs"
    device.setIndexedColor(0, 0, 0 );
    delay(160);
    device.setIndexedColor(1, 0, 0 );
    delay(160);
    device.setIndexedColor(2, 0, 0 );
    delay(160);
  }



  //  auto stopper
  if(frameCount>3600)
  {
    if(device!=null)
    {
      device.turnOff();
    }
    text("done",0,random(height));
    noLoop();
  }
}



////////////////////////////////////////////////////////////////////////
void keyPressed(){

  if( key == ESC )
  {
    if(device!=null){
      device.turnOff();  
    }

    text("done",0, random(height));

    noLoop();
  }
}