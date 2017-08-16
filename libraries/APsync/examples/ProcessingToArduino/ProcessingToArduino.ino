import apsync.*;
import processing.serial.*;

PFont f;

AP_Sync streamer;
StringBuilder toArduino = new StringBuilder();

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
  text(toArduino.toString(),width/2,height/2);
}

void keyPressed(){
  
  if (keyCode == ENTER){
      println(toArduino + " sent");
      streamer.send(toArduino.toString());
      toArduino.setLength(0);
  }
  if (keyCode == DELETE || keyCode == BACKSPACE){
      if(toArduino.length() > 0){
         toArduino.deleteCharAt(toArduino.length() - 1); 
      }
  }
  
  if(keyCode != ENTER &&
      keyCode != DELETE && 
      keyCode != ESC && 
      keyCode != UP && 
      keyCode != DOWN && 
      keyCode != BACKSPACE && 
      keyCode != TAB && 
      keyCode != ALT && 
      keyCode != CONTROL && 
      keyCode != RETURN ){
      
      toArduino.append(key);  
  }
}