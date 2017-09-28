import apsync.*;
import processing.serial.*; //import the serial library a dependency of APsync

AnalogMeter speedOMeter;
AnalogMeter revMeter;

AP_Sync streamer;

public int analogValue;

void setup(){
  size(730,430);
  speedOMeter = new AnalogMeter(width/2,height/2,240,"gauge.png");
  speedOMeter.setMaxReading(600);
  //revMeter = new AnalogMeter(190,230,210,"revmeter.png");
  //revMeter.setStartPoint(3.1);
  //revMeter.setEndPoint(6.25);
  //revMeter.setMaxReading(2600);
  streamer = new AP_Sync(this,"COM14", 9600);
}

void draw(){
  ellipse(20,20,50,50);
  //revMeter.setValue(analogValue);
  speedOMeter.setValue(analogValue);
}