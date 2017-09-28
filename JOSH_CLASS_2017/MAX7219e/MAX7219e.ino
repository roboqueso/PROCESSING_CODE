//  LESSON 15 LED MAX + JOYSTICK
//  2 modes : regular dot & CLICK for inverted cross hair & intensity set control
//We always have to include the library
#include "LedControl.h"

/*
 Now we need a LedControl to work with.
 ***** These pin numbers will probably not work with your hardware *****
 pin 12 is connected to the DataIn 
 pin 11 is connected to LOAD(CS)
 pin 10 is connected to the CLK 
 We have only a single MAX72XX.
 */
LedControl lc=LedControl(12,10,11,1);

/* we always wait a bit between updates of the display */
unsigned long delaytime=50;



//  JOYSTICK
int xPin = A1;
int yPin = A0;
int buttonPin = 2;

int xPosition = 0;
int yPosition = 0;
int buttonState = 0;


int gX, gY; // gridX gridY
boolean invertMode = false;

void setup() {
  /*
   The MAX72XX is in power-saving mode on startup,
   we have to do a wakeup call
   */
  lc.shutdown(0,false);
  /* Set the brightness to a medium values */
//  lc.setIntensity(0,8);
  /* and clear the display */
  lc.clearDisplay(0);


  // initialize serial communications at 115200 bps:
  Serial.begin(115200); 
  
  pinMode(xPin, INPUT);
  pinMode(yPin, INPUT);

  //activate pull-up resistor on the push-button pin
  pinMode(buttonPin, INPUT_PULLUP); 

}


void loop() { 

//  writeArduinoOnMatrix();
//  rows();
//  columns();
//  single();

  //  READ JOYSTICK
  xPosition = analogRead(xPin);
  yPosition = analogRead(yPin);
  buttonState = digitalRead(buttonPin);

  //  TRANSLATE TO GRID
  gX = map(xPosition, 0, 1023, 0, 7);
  gY = map(yPosition, 0, 1023, 0, 7);


  //  TODO: use buttonState to toggle NEGATIVE / POSITIVE
  //  NOTE: Button 1 = UP, "off"
  invertMode = ( buttonState == 0 ) ? true : false;


  //  how to draw
  if(invertMode)
  {
    //  TURN ON ALL GRID
    /*
    lc.setIntensity(0, 15 );
    delay(10);

    for( int i = 0; i<8; i++){
      lc.setRow(0,i, 255 );
    }
    delay(100);
*/
    /* and clear the display */
    lc.clearDisplay(0);

    //  cross-hairs
    lc.setIntensity(0, (gY*2) );
    lc.setRow(0,gY, 255);
    lc.setColumn(0,gX, 255 );
    
    //  joystick turns OFF led  
    lc.setLed(0,gY,gX, (byte) 0 );
    
    delay(10);

  }
  else
  {
    //  joystick turns ON led  

    /* and clear the display */
    lc.clearDisplay(0);

    //  SET led
    lc.setLed(0,gY,gX,true);
      delay(10);

  }


  Serial.print("Joystick: " + String(xPosition) + "," + String(yPosition) + '\n');
  Serial.print("Grid: " + String(gX) + "," + String(gY) + '\n');
  Serial.print("Button: " + String(buttonState) + '\n');
  Serial.print("invertMode: " + String(invertMode) + '\n');

  delay(delaytime);

}





