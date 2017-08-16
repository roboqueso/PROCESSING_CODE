import apsync.*;
import processing.serial.*;

PFont f;
AP_Sync streamer;

public String randomPet;

public int randomRed;
public int randomGreen;
public int randomBlue;

void setup(){
  size(500,300);
  
  streamer = new AP_Sync(this,"COM14", 9600);
  
  background(0);
  f = createFont("Arial",36,true);
  textFont(f,36);
  fill(255);
}

void draw() {
  background(0);
  textAlign(CENTER);
  if(randomRed != -1 &&  randomGreen != -1 && randomBlue != -1){
    background(randomRed,randomGreen,randomBlue);
  }
  if(randomPet != null){
    text(randomPet,width/2,height/2);
  }
}