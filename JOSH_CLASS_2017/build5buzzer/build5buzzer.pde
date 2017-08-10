//
//	Firmata & Serial :> talk directly to Arduino board instead of Serial event
//	BUZZ on press
//	Passive Buzzer Module
//  S ------------------------------------- D11
//  - ------------------------------------ GND
//  + -------------------------------------- 5V
import processing.serial.*;
import cc.arduino.*;

int stageW = 800;
int stageH = 800;
color  clrBG = #242424;

String pathData = "../../../data/";

//  --  //

Arduino arduino;
int myPin = 2;


/****** BUZZER *************************************/
int buzzerPin = 11;//the buzzer pin attach to
int fre;//set the variable to store the frequence value
/*******************************************/

//  --  //

void settings(){
  
  size(stageW, stageH);
  
}


void setup()
{
  background(clrBG);
  
  arduino = new Arduino( this, Arduino.list()[1], 57600 );
  arduino.pinMode(myPin, Arduino.OUTPUT);

  //	BUZZER
  arduino.pinMode(buzzerPin, Arduino.OUTPUT);


}


void draw()
{
  
}


void mousePressed()
{

	arduino.digitalWrite(myPin, Arduino.HIGH);

	for(int i = 800;i >= 200;i--)//frequence loop from 800 downto 200
	{
		// Arduino.tone(3,i);
		// byte commandes[]=msg.getMessage(); 



		delay(10);
	}
}

void mouseReleased()
{

	arduino.digitalWrite(myPin, Arduino.LOW);
}
