import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 
import cc.arduino.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build5buzzer extends PApplet {

//
//	Firmata & Serial :> talk directly to Arduino board instead of Serial event
//	BUZZ on press
//	Passive Buzzer Module
//  S ------------------------------------- D11
//  - ------------------------------------ GND
//  + -------------------------------------- 5V



int stageW = 800;
int stageH = 800;
int  clrBG = 0xff242424;

String pathData = "../../../data/";

//  --  //

Arduino arduino;
int myPin = 2;


/****** BUZZER *************************************/
int buzzerPin = 11;//the buzzer pin attach to
int fre;//set the variable to store the frequence value
/*******************************************/

//  --  //

public void settings(){
  
  size(stageW, stageH);
  
}


public void setup()
{
  background(clrBG);
  
  arduino = new Arduino( this, Arduino.list()[1], 57600 );
  arduino.pinMode(myPin, Arduino.OUTPUT);

  //	BUZZER
  arduino.pinMode(buzzerPin, Arduino.OUTPUT);


}


public void draw()
{
  
}
String aa = "tone";
byte[] cmd = new byte(aa);

public void mousePressed()
{

	arduino.digitalWrite(myPin, Arduino.HIGH);

	for(int i = 800;i >= 200;i--)//frequence loop from 800 downto 200
	{
		// Arduino.tone(3,i);
		// byte commandes[]=msg.getMessage(); 



		delay(10);
	}
}

public void mouseReleased()
{

	arduino.digitalWrite(myPin, Arduino.LOW);
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build5buzzer" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
