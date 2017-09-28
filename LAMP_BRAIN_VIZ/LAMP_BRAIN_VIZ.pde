/*

  LAMP brain & visualization
  
  TODO: 
    - Write LAMP behavior for every letter in alphabet
    - Write LAMP behavior for each #

    - Fill RECTs in sketch to mirror LEDs on strip

*/


import blinkstick.*;
BlinkStick device;


//Change this to the number of LEDs connected
int leds = 64;
int[] colors;
int thisLed = 0;
int led_w, led_h;

String LAMP_MODE = "";  //  K - kitt, D - "default", 
Boolean toggle = false;  // generic toggle switch

/////////////////////////////////////////////////////////
void setup(){

  size( 1420, 420 );
  frameRate(8);

  device = BlinkStick.findFirst();
  // delay(leds);

  led_w = (int)(width/leds);  // pad
  led_h = height/2;

}
/////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////
void draw(){

  println(LAMP_MODE);
  

  switch(LAMP_MODE)
  {
    case "kitt":
    {
      behave_kittMode(thisLed);
      
      //  FWD / REW logic
      if(thisLed == 0 )
        toggle = false; // forwards
      else if(thisLed == leds )
        toggle = true;  //  backwards

      thisLed = ( toggle ) ? thisLed-1 : thisLed+1;
    }
    break;
    
    default:
    {
      fill( random(255) );
      text(frameCount, frameCount%width, frameCount%height);

      for( int i = 0; i < leds; i++){
      
        fill( random(255) );
        rect( (i*led_w), leds, led_w, led_h);
        
        fill(0);
        text( i, (i*led_w)+(led_w/PI), leds );

		// setColors( thisColor );
		device.setIndexedColor(i, color( random(255) ) );
		// delay(leds);
    
      } 
    } 
    break;
    
  }
  

}
/////////////////////////////////////////////////////////




/*
	TODO: 
	- Write LAMP behavior for every letter in alphabet
	- Write LAMP behavior for each #
*/
void keyPressed(){

  switch(key)
  {
    case ESC:
    {
      LAMP_OFF();
  
      text("done",0, random(height));
  
      noLoop();
    }
    break;
    
    case 'd':
    case 'D':
    {
      //  reset mode to 'default'
      LAMP_MODE = "";
    } 
    break;

    case 'k':
    case 'K':
    {
      LAMP_MODE = "kitt";
    } 
    break;
    
  }
  
}

//  BEHAVIORS  ////////////////////////////////////////////////////////////
  // see: https://www.youtube.com/watch?v=wAoKzfbGnCc
void behave_kittMode(int activeLed){
//  TODO: figure out tail logic

    for( int i = 0; i < leds; i++){


      if(i==activeLed){
        fill(color(250,0,0));
        stroke(#EF2017);
        rect( (i*led_w), leds, led_w, led_h);
        
        fill(0xEF2017);
        text( i, (i*led_w)+(led_w/PI), leds );

		// setColors( thisColor );
		device.setIndexedColor(i, color(250,0,0) );
		// delay(i);	//leds);
        
      } else {
        
        fill(0);
        stroke(111);
        rect( (i*led_w), leds, led_w, led_h);
        
		device.setIndexedColor(i, 0 );
		// delay(i);	//leds);
      }
      
      
    } 

  
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