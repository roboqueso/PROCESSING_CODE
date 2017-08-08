//
//	Firmata & Serial :> talk directly to Arduino board instead of Serial event
import processing.serial.*;
import cc.arduino.*;

int stageW = 800;
int stageH = 800;
color  clrBG = #242424;

String pathData = "../../../data/";

//  --  //

Arduino arduino;
int myPin = 2;

//  --  //

void settings(){
  
  size(stageW, stageH);
  
}


void setup()
{
  background(clrBG);
  
  arduino = new Arduino( this, Arduino.list()[1], 57600 );
  arduino.pinMode(myPin, Arduino.OUTPUT);

}


void draw()
{
  
}


void mousePressed()
{

	arduino.digitalWrite(myPin, Arduino.HIGH);
}

void mouseReleased()
{

	arduino.digitalWrite(myPin, Arduino.LOW);
}
