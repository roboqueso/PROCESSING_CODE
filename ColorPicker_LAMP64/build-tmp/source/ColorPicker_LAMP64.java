import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import blinkstick.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ColorPicker_LAMP64 extends PApplet {

//  TODO: port to 64 LED strip

/**
 * ColorPicker. 
 * 
 * A basic color picker UI to change the color of BlinkStick.
 *
 * Color picker code from http://www.julapy.com/processing/ColorPicker.pde 
 */



GuiColorPicker cp;
BlinkStick device;


//Change this to the number of LEDs connected
int leds = 64;


public void setup() 
{
  
  // frameRate( 100 );
  
  cp = new GuiColorPicker( 10, 10, 400, 400, 255 );
  
  device = BlinkStick.findFirst();
}

public void draw ()
{
  background( 80 );
  cp.render();
}

public class GuiColorPicker 
{
  int x, y, w, h, c;

  PImage cpImage;
  
  public GuiColorPicker ( int x, int y, int w, int h, int c )
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    
    cpImage = new PImage( w, h );
    
    init();
  }
  
  private void init ()
  {
    // draw color.
    int cw = w - 60;

    for( int i=0; i<cw; i++ ) 
    {
      float nColorPercent = i / (float)cw;
      float rad = (-360 * nColorPercent) * (PI / 180);
      int nR = (int)(cos(rad) * 127 + 128) << 16;
      int nG = (int)(cos(rad + 2 * PI / 3) * 127 + 128) << 8;
      int nB = (int)(Math.cos(rad + 4 * PI / 3) * 127 + 128);
      int nColor = nR | nG | nB;

      setGradient( i, 0, 1, h/2, 0xFFFFFF, nColor );
      setGradient( i, (h/2), 1, h/2, nColor, 0x000000 );
    }
    
    // draw black/white.
    drawRect( cw, 0,   30, h/2, 0xFFFFFF );
    drawRect( cw, h/2, 30, h/2, 0 );
    
    // draw grey scale.
    for( int j=0; j<h; j++ )
    {
      int g = 255 - (int)(j/(float)(h-1) * 255 );
      drawRect( w-30, j, 30, 1, color( g, g, g ) );
    }
  }

  private void setGradient(int x, int y, float w, float h, int c1, int c2 )
  {
    float deltaR = red(c2) - red(c1);
    float deltaG = green(c2) - green(c1);
    float deltaB = blue(c2) - blue(c1);

    for (int j = y; j<(y+h); j++)
    {
      int c = color( red(c1)+(j-y)*(deltaR/h), green(c1)+(j-y)*(deltaG/h), blue(c1)+(j-y)*(deltaB/h) );
      cpImage.set( x, j, c );
    }
  }
  
  private void drawRect( int rx, int ry, int rw, int rh, int rc )
  {
    for(int i=rx; i<rx+rw; i++) 
    {
      for(int j=ry; j<ry+rh; j++) 
      {
        cpImage.set( i, j, rc );
      }
    }
  }
  
  public void render ()
  {

    image( cpImage, x, y );
    
    if( mousePressed &&
        mouseX >= x && 
        mouseX < x + w &&
        mouseY >= y &&
        mouseY < y + h )
    {
      c = get( mouseX, mouseY );
      
      if (device != null)
      {
        setColors(c);
      }
    }
    fill( c );
    rect( x, y+h+10, 20, 20 );


  }
}

//	FICKES


////////////////////////////////////////////////////////////////////////
//  FICKES 
public void LAMP_OFF(){

    if(device!=null){

      for(int i = 0; i < leds; i++)
      {
        device.setIndexedColor(i, 0);
        delay(11);
      }

      device.turnOff();  
    }

}


public void keyPressed(){

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
    device.setIndexedColor(i, c);
    delay(1);
  }

}
  public void settings() {  size( 500, 500 ); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ColorPicker_LAMP64" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
