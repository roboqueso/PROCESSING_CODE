import processing.video.*;

/*

NOTE: PROCESSING3

THIS CODE DOES NOT WORK IF LAPPY IS CLOSED AND PLUGGED INTO CINEMA DISPLAY

THIS CODE **DOES** WORK IF THE LAPTOP LID IS OPEN

*/


Capture cam;

void setup() {
  size(640, 480);

  String[] cameras = Capture.list();
  int camIdx = 0;
    for (int i = 0; i < cameras.length; i++) {
      println(i + " " + cameras[i]);

      //  pick first DISPLAY if in list
      if(cameras[i].toString().contains("Display") )
      {
        camIdx = i;
        // hack EXIT
        i = cameras.length;
      }
      
    }

println("PICK CAPTURE : " + camIdx + " --> " + cameras[camIdx] );

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[camIdx]);
    cam.start();     
  }      

}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
}