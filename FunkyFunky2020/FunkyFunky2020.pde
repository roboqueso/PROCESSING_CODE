import java.text.*;
import java.util.Date;



String VOICE = "Tom";  //  default
String MSG = "I did not find message.txt";  //  default

PShape logo;  // FYI : used as a global since it's E.PLURIBUS.UNUM
Boolean itsOn = true;  //  simple boolean toggler
int bg;

//
//
void setup() {
  size(666,530);
  background(255);
  
  logo = loadShape("CaB.svg");
  readMessage();
}


//
//
void draw() {
  //  dynamic with time
  bg = getEpochInt();
  
  
  if(itsOn)
    background( bg+frameCount );
  else
    background( bg*frameCount );

  translate(width/2, height/2);
  shape(logo, -(logo.width*.5), -(logo.height*.5) );
}


//
//  Get's EPOCH from current time then returns the last 6 digits for use as color code
int getEpochInt(){
  long epoch = System.currentTimeMillis()/1000;
  int epochInt = int( (""+epoch).substring(4, 10) );
  return epochInt;
}



//
//  Read voice.txt and message.txt into globals VOICE & MESSAGE
void readMessage(){
  
  //  GET VOICE AND MESSAGE
  try{
  String[] voice = loadStrings("voice.txt");
    VOICE = voice[0];
  } catch ( Exception exc ) {
    VOICE = "Zarvox";
  }

  try{
    String[] message = loadStrings("message.txt");
    MSG = message[0];
  } catch ( Exception e ) {
    println("ERROR" + e.getMessage() );
  }
}


//
//  Apply styling to shp
void styleShape( PShape shp )
{
  // TODO: Use MINIM & HYPE to visualize the SAY command
  //  * MINIM to draw sine wave
  //  * HYPE for pixel colorist ( fueled by audio, epoch color palette )
  if(itsOn)
    shp.disableStyle();
  else
    shp.enableStyle();
    
  itsOn = !itsOn;
}

//
//  Push mouse, say message in voice
void mousePressed() {
  
  readMessage();
  //  NOTE: passing the ONLY global PShape
  styleShape(logo);
  
  //println("SAY '" + MSG + "'");

  //  first version hard coded like OG compilers  
  String[] params = {"say", "-v", VOICE, MSG };
  exec(params);
}
