//  Inspired by http://whatcolourisit.scn9a.org/
//  Coded by Eric Fickes - http://ericfickes.com

import blinkstick.*;
BlinkStick device;
float x, y;
int fontSz = 42;
String sHr, sMin, sSec, hexV;

int leds = 64;
int delay_rate = 125;
byte[] data;
int kSz = 5, kStart = 0, kEnd = 0;

////////////////////////////////////////////////////////////////////////
void setup() 
{
  size(640,320);
  textAlign(CENTER,CENTER);
  fill(255);

kEnd = kStart+kSz;

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

    data = new byte[leds * 3];

    for (int i = 0; i < data.length; i++)
    {
    	// WE ONLY CARE ABOUT RED
    	// if(i < (kStart+kSz) && ( i%1 == 0) )
    	// {
    	// 	// ON
    	// 	data[i] = (byte)255;
    	// }
    	// else
    	// {
    	// 	//	OFF
    	// 	data[i] = 0;
    	// }


		if( i < ((kStart+kSz)*3) )
		{
// DEBUG
println( i + " < " + ((kStart+kSz)*3) );

		    	if ( i%2==0){
		    		data[i] = (byte)128;
		    	}
		    	else{
		    		data[i] = (byte)0;
		    	}
		}
		else 
		{
			data[i] = (byte)0;
		}
    }
    
    //Sends to R channel
    device.setColors(0, data);
    delay(100);

    if( kStart < ((leds*3)-kSz))
		kStart++; 
	else
		kStart=0;

    //  BACKWARDS
    //  NOTE: don't do a full loop to avoid blinking
    // for( int ll = leds-1; ll > 0; ll--)
    // {
    // }

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
        delay(11);
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



