//  Inspired by http://whatcolourisit.scn9a.org/
//  Coded by Eric Fickes - http://ericfickes.com

import blinkstick.*;
BlinkStick device;
float x, y;
int fontSz = 42;
String sHr, sMin, sSec, hexV;

int leds = 8;
int delay_rate = 100;

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
  textSize(fontSz*HALF_PI);
  text("#"+hexV, (width/2), (height/2)+(textAscent()+textDescent()) );


  //  send colors to BlinkStick
  if(device!=null)
  {

    //  FORWARD
    for( int ll = 0; ll < leds-1; ll++)
    {
      //  "blink" color
      device.setIndexedColor(0, ll, unhex(hexV) );
      delay( delay_rate );

      //  "turn off LEDs"
      device.setIndexedColor(0, ll, 0 );
      delay(delay_rate);
    }
    

    //  BACKWARDS
    //  NOTE: don't do a full loop to avoid blinking
    for( int ll = leds-1; ll > 0; ll--)
    {
      //  "blink" color
      device.setIndexedColor(0, ll,unhex(hexV) );
      delay(delay_rate);

      //  "turn off LEDs"
      device.setIndexedColor(0, ll, 0 );
      delay(delay_rate);
    }

  }



  //  auto stopper
  if(frameCount>3600)
  {
    stopit();
  }
}


////////////////////////////////////////////////////////////////////////
void stopit(){

    if(device!=null){
      device.setColor(0);
      for( int ll = 0; ll < leds; ll++)
      {
        //  "blink" color
        device.setIndexedColor(0, ll, 0 );
        delay(1);
      }
      device.turnOff();  
    }

    text("OVER", 0, random(height));

    noLoop();

}

////////////////////////////////////////////////////////////////////////
void keyPressed(){

  if( key == 'e' )
  {
    stopit();
  }
}



