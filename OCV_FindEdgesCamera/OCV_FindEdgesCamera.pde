import gab.opencv.*;
import processing.video.*;

OpenCV opencv;
PImage canny, scharr, sobel, tmpVid;

Capture video;


void setup() {
  //video = loadImage("test.jpg");
  //size(1080, 720, P3D);
  size( displayWidth, displayHeight, P3D );
  background(255);
  //frameRate(60);
  
  //  INIT CAMERA
  video = new Capture(this, width, height);
  opencv = new OpenCV(this, video);
  video.start();
}


void draw() {
    
//  60 fps, run draw every half second
//if(frameCount%15==0) {
  
  if(video.available())
  {
    video.read(); // Read a new video frame
    opencv.findCannyEdges(40,80);//20,75);
    canny = opencv.getSnapshot();
    
    opencv.loadImage(video);
    opencv.findScharrEdges(OpenCV.HORIZONTAL);
    scharr = opencv.getSnapshot();
    
    opencv.loadImage(video);
    opencv.findSobelEdges(1,0);
    sobel = opencv.getSnapshot();


    tint(255,0,0);//, 100);
    canny.mask(video);
    image(canny, 0, 0, (width/3), canny.height);
    text("Canny", 0, 40 );
    
    tint(0,255,0);
    scharr.mask(video);
    image(scharr, (width/3), 0, (width/3), canny.height);
    text("Scharr", (width/3), 40 );
    
    tint(0,0,255);
    sobel.mask(video);
    image(sobel, (width/3)*2, 0, (width/3), canny.height);
    text("Sobel", (width/3)*2, 40 );
  
  
} else {

    textSize(88);
    text("waiting for video",0, height-100 );
}

//}
}