/**
 * Getting Started with Capture.
 * 
 * Reading and displaying an image from an attached Capture device. 
 
NOTE: if running on BLOOD-DRAGON or a machine with a controllable webcam,
REMEMBER TO TURN ON THE WEBCAM BEFORE RUNNING THIS SKETCH, DUH
 
 */
import java.util.*;
import processing.video.*;


//  NOTE: hard coding for only 2 cameras
Capture tmpCam;
String[] cameras;
ArrayList<Capture> cams = new ArrayList();



//  Text key to identify the camera you're looking for
//  NOTE: multiple webcams don't always render the same dimensions
//  Be sure to identify a size and fps that match across cameras
String CAM_NAME_KEY = "size=640x480,fps=30"; // "size=1280x720,fps=30";  //
//String CAM_NAME_KEY = "size=1920x1080,fps=30";

PFont f;
int txtH;
String text;

/**********************************************************************************************************/
void setup() {
  
  size(displayWidth, displayHeight, P3D);
  background(-1);
  pixelDensity(displayDensity());
  smooth(8);
  strokeWeight(1);

  //  full og list of cameras
  cameras = Capture.list();

  // DEBUG
println("OG Capture.list");
printArray(cameras);
println("looking for : " + CAM_NAME_KEY);

//  dedupe camera list
cameras = deDupeCamList( cameras, CAM_NAME_KEY );

println("UPDATED CAMERAS");
printArray(cameras);

  txtH = (int)( (height/cameras.length )-HALF_PI);

// debug
print("txtH : " + txtH);

  f = createFont("Arial", txtH);

  //  setup TEXT
  textFont(f);  
  textSize(txtH);
  textAlign(LEFT,TOP);

//  PRE-START CAMERAS?
    for (int c = 0; c < cameras.length; c++ )
    {
      // The camera can be initialized directly using an 
      // element from the array returned by list():
      Capture tt = new Capture(this, cameras[c]);
      tt.start();

      cams.add(tt);
    }

}


/**********************************************************************************************************/
void draw() {

  
 //  loop through ArrayList<Capture>
 for(Capture cc : cams ){

      //if (cc.available()) 
      //{
        cc.read();
  
        text = cc.toString();
 
        fill(random(160,255), random(160), random(160), 43);
        rect( frameCount-(txtH/2), frameCount*(height/cameras.length)-textAscent(), (textWidth(text)+(txtH*1.5)), txtH, -frameCount, txtH, txtH, -frameCount );

        fill(random(240,250));
        fittedText( text, f, frameCount%width, frameCount*(height/cameras.length) , width, txtH );

        fill(255);
        fittedText( text, f, frameCount%width, frameCount*(height/cameras.length) , width, txtH );

        image(cc, frameCount%width, frameCount*(height/cameras.length) , width, txtH );
  
        // check for hitting the side
        if( frameCount > width-(textWidth(text)+txtH) ){
println("EXIT");
          doExit();
        }

       //}
   }
}
 /* 
  
  
    //  loop through cameras
    for (int c = 0; c < cameras.length; c++ )
    {
      // The camera can be initialized directly using an 
      // element from the array returned by list():
      tmpCam = ((Capture)cameras[c]);

      if (tmpCam.available()) 
      {
        tmpCam.read();
  
        text = tmpCam.toString();
 
        fill(random(160,255), random(160), random(160), 43);
        rect( frameCount-(txtH/2), frameCount*(height/cameras.length)-textAscent(), (textWidth(text)+(txtH*1.5)), txtH, -frameCount, txtH, txtH, -frameCount );

        fill(random(240,250));
        fittedText( text, f, frameCount%width, frameCount*(height/cameras.length) , width, txtH );

        fill(255);
        fittedText( text, f, frameCount%width, frameCount*(height/cameras.length) , width, txtH );

        if (tmpImg != null) {
          image(tmpImg, frameCount%width, (c+1)*(height/cameras.length) , width, txtH );
        }
  
        // check for hitting the side
        if( frameCount > width-(textWidth(text)+txtH) ){
          doExit();
        }
        
      } else {
      
         println( tmpCam + " : " + tmpCam.available() );
      }

    }
*/


/***********************************************************************************************************/
void captureEvent(Capture c) {
  c.read();
}

/***********************************************************************************************************/
/**
  Captures.list String[] de-duper.
  @cams     = String[] of Capture.list()
  @keyName  = String label to search Capture.list() for.  Returns item(s) containing @keyName
*/
String[] deDupeCamList( String[] cams, String keyName ){
  //  DEDUPER
  ArrayList<String> result = new ArrayList();
  
  // Loop over argument list.
  for (String item : cams) 
  {
    //  RESTRICT CAMERA BY NAME HERE
    if( item.toString().contains( keyName ) ) 
    {
      // Keep track of the new strings
      if (!result.contains(item)) {
        result.add(item);
      }
    } 
  }
  
  
  // CLEANUP BE RE-ASSIGNMENT
  cams = null;
  cams = result.toArray( new String[0] );

  return cams;
}


/***********************************************************************************************************/
// from https://forum.processing.org/two/discussion/20238/scale-text-to-screen-width
//  Seems to work nice for WIDTH, but not so much height?
public void fittedText(String text, PFont font, float posX, float posY, float fitX, float fitY)
{
  textFont(font);
  textSize(min(font.getSize()*fitX/textWidth(text), fitY));
  text(text, posX, posY);
}


/***********************************************************************************************************/
/**
exit handler
**/
void doExit(){

    save(this+".png"); 
  
  //  cleanup camera(s)
    for(Capture cc : cams ){
     cc.stop();
     cc = null;
    }

    noLoop();
    super.exit();
}
