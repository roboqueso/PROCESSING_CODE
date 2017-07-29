//  TODO: port to 64 LED strip

/**
 * ColorPicker. 
 * 
 * A basic color picker UI to change the color of BlinkStick.
 *
 * Color picker code from http://www.julapy.com/processing/ColorPicker.pde 
 */

import blinkstick.*;

BlinkStick device;


//Change this to the number of LEDs connected
int leds = 64;
int[] colors;
int thisColor;

void setup() 
{
  size( 500, 500 );

frameRate(69);

  colors =  getColors( 10, 10, 400, 400, 255 );
  
  device = BlinkStick.findFirst();
  delay(11);

}

void draw ()
{
	thisColor = colors[ (frameCount%colors.length) ];
	background( thisColor );

  if (device != null)
  {
    setColors( thisColor );
    delay(30);
  }




}

int[] getColors ( int x, int y, int w, int h, int c )
{
// draw color.
int cw = w - 60;
int[] colors = new int[cw];
for( int i=0; i<cw; i++ ) 
{
  float nColorPercent = i / (float)cw;
  float rad = (-360 * nColorPercent) * (PI / 180);
  int nR = (int)(cos(rad) * 127 + 128) << 16;
  int nG = (int)(cos(rad + 2 * PI / 3) * 127 + 128) << 8;
  int nB = (int)(Math.cos(rad + 4 * PI / 3) * 127 + 128);
  int nColor = nR | nG | nB;
colors[i] = nColor;
}

return colors;
}

//  FICKES


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
	    delay(1);
	} catch( Exception e )
	{
		println("Exception: "+ e);
	}
  }

}