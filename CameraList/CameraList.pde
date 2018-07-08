/**
 * Getting Started with Capture.
 * 
 * Reading and displaying an image from an attached Capture device. 
 
NOTE: if running on BLOOD-DRAGON or a machine with a controllable webcam,
REMEMBER TO TURN ON THE WEBCAM BEFORE RUNNING THIS SKETCH, DUH
 
 */
import java.util.*;
import processing.video.*;


Capture cam;
String[] cameras;

//  Text key to identify the camera you're looking for
String CAM_NAME_KEY = "size=1920x1080,fps=30";

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

  if (cameras == null) {
    println("FAIL");
    // cam = new Capture(this, 640, 480);
  } 
  if (cameras.length == 0) {
    println("86 ON CAMERAS");
    exit();
  } else {
    println("Available cameras:");
    printArray(cameras);

  }
  
  textFont(f);  
  textSize(txtH);
  textAlign(LEFT,TOP);

}


/**********************************************************************************************************/
void draw() {

    //  loop through cameras
    for (int c = 0; c < cameras.length; c++ )
    {
      text = cameras[c];

      fill(random(160,255), random(160), random(160), 43);
      rect( frameCount-(txtH/2), c*(height/cameras.length)-textAscent(), (textWidth(text)+(txtH*1.5)), txtH, -frameCount, txtH, txtH, -frameCount );
      
      fill(random(240,250));
      fittedText( text, f, frameCount%width, c*(height/cameras.length) , width, txtH );
      
      fill(255);
      fittedText( text, f, frameCount%width, c*(height/cameras.length) , width, txtH );

      // check for hitting the side
      if( frameCount > width-(textWidth(text)+txtH) ){

        save(this+".png");
        exit();
      }
    }
}


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



// from https://forum.processing.org/two/discussion/20238/scale-text-to-screen-width
//  Seems to work nice for WIDTH, but not so much height?
public void fittedText(String text, PFont font, float posX, float posY, float fitX, float fitY)
{
  textFont(font);
  textSize(min(font.getSize()*fitX/textWidth(text), fitY));
  text(text, posX, posY);
}
