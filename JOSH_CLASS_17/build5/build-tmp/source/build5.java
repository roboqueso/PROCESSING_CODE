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

public class build5 extends PApplet {

//	TALK DIRECTLY TO 



int stageW = 800;
int stageH = 800;
int  clrBG = 0xff242424;

String pathData = "../../../data/";

//  --  //

Arduino arduino;
int myPin = 2;

//  --  //

public void settings(){
  
  size(stageW, stageH);
  
}


public void setup()
{
  background(clrBG);
  
  arduino = new Arduino( this, Arduino.list()[1], 57600 );
  arduino.pinMode(myPin, Arduino.OUTPUT);

}


public void draw()
{
  
}


public void mousePressed()
{

	arduino.digitalWrite(myPin, Arduino.HIGH);
}

public void mouseReleased()
{

	arduino.digitalWrite(myPin, Arduino.LOW);
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build5" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
