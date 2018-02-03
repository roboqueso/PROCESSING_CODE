import gab.opencv.*;
import java.awt.*;

import org.openkinect.freenect.*;
import org.openkinect.processing.*;


OpenCV opencv;
Kinect kinect;


PVector loc;
PImage img;


PImage src, dst;
ArrayList<Contour> contours;
ArrayList<Contour> polygons;

// We'll use a lookup table so that we don't have to repeat the math over and over
float[] depthLookUp = new float[2048];



void setup() {
  size(800, 600, P3D);
  kinect = new Kinect(this);
  
  kinect.initDepth();
  kinect.initVideo();
  //kinect.enableIR(ir);
  //kinect.enableColorDepth(colorDepth);
  
  opencv = new OpenCV(this, kinect.width, kinect.height );


}


void draw() {
if(frameCount%15==0) {
  
  //image(kinect.getVideoImage(), 0, 0);
  //image(kinect.getDepthImage(), 640, 0);
  //img = kinect.getVideoImage();
  img = kinect.getDepthImage();
  opencv.loadImage(img);
  
  //  MASK MAGIC?
  img.mask(kinect.getVideoImage());
  tint(255,frameCount%64);
  image(img, 0, 0, width, height );



  //  CONTOURS
    contours = opencv.findContours();
  noFill();
  strokeWeight(1);

  for (Contour contour : contours) {

    

      stroke(random(255));
 
  
//  brightest point
loc = opencv.max();

    beginShape(POLYGON);
    texture(kinect.getVideoImage());
    tint(255, 64);
    for (PVector point : contour.getPolygonApproximation().getPoints()) {
      
     // if(point.x%8==0){
      
      stroke(loc.x%255, loc.y%255, frameCount%160);
      
      
      vertex(point.x, point.y, random(8), point.x, point.y);
      //vertex(loc.x, loc.y, frameCount);
      //, loc.x, point.x, point.y);
      //point(point.x, point.y);
      //}  
  }
    endShape();


// draw
     noFill();
      contour.draw();

  }

//  brightest point
loc = opencv.max();

  stroke( loc.x, loc.y, frameCount%255 );
  fill(loc.y%255, loc.x%255, random(loc.x)); 
  strokeWeight(4);
  noFill();
  ellipse(loc.x, loc.y, 10, 10);


strokeWeight(random(8));
  stroke( loc.x, loc.y, frameCount%255, 64);
line(width/2,height/2, loc.y, loc.x );

}
 
  
  if(frameCount%240==0)save(this+".png");
  
  
}



// These functions come from: http://graphics.stanford.edu/~mdfisher/Kinect.html
float rawDepthToMeters(int depthValue) {
  if (depthValue < 2047) {
    return (float)(1.0 / ((double)(depthValue) * -0.0030711016 + 3.3309495161));
  }
  return 0.0f;
}

PVector depthToWorld(int x, int y, int depthValue) {

  final double fx_d = 1.0 / 5.9421434211923247e+02;
  final double fy_d = 1.0 / 5.9104053696870778e+02;
  final double cx_d = 3.3930780975300314e+02;
  final double cy_d = 2.4273913761751615e+02;

  PVector result = new PVector();
  double depth =  depthLookUp[depthValue];//rawDepthToMeters(depthValue);
  result.x = (float)((x - cx_d) * depth * fx_d);
  result.y = (float)((y - cy_d) * depth * fy_d);
  result.z = (float)(depth);
  return result;
}

/*

// Daniel Shiffman
// Depth thresholding example

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

// Original example by Elie Zananiri
// http://www.silentlycrashing.net
import org.openkinect.freenect.*;
import org.openkinect.processing.*;

//  openCV Brightest Point
import gab.opencv.*;

OpenCV opencv;
PVector loc;


Kinect kinect;

// Depth image
PImage depthImg;

// Which pixels do we care about?
int minDepth =  60;
int maxDepth = 860;

// What is the kinect's angle
float angle;

void setup() {
  size(1280, 480);

  kinect = new Kinect(this);
  kinect.initDepth();
  angle = kinect.getTilt();

  // Blank image
  depthImg = new PImage(kinect.width, kinect.height);
  
  //  openCV to Kinect image
  opencv = new OpenCV(this, depthImg);
}

void draw() {

  // Draw the raw image
  image(kinect.getDepthImage(), 0, 0);

  // Threshold the depth image
  int[] rawDepth = kinect.getRawDepth();
  for (int i=0; i < rawDepth.length; i++) {
    if (rawDepth[i] >= minDepth && rawDepth[i] <= maxDepth) {
      depthImg.pixels[i] = color(255);
    } else {
      depthImg.pixels[i] = color(0);
    }
  }

  // Draw the thresholded image
  depthImg.updatePixels();
  image(depthImg, kinect.width, 0);
  
  
  //  get brightest point
  loc = opencv.max();
  stroke(255, 0, 0);
  strokeWeight(4);
  noFill();
  ellipse(loc.x, loc.y, 10, 10);

  fill(0);
  text("TILT: " + angle, 10, 20);
  text("THRESHOLD: [" + minDepth + ", " + maxDepth + "]", 10, 36);
}

// Adjust the angle and the depth threshold min and max
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      angle++;
    } else if (keyCode == DOWN) {
      angle--;
    }
    angle = constrain(angle, 0, 30);
    kinect.setTilt(angle);
  } else if (key == 'a') {
    minDepth = constrain(minDepth+10, 0, maxDepth);
  } else if (key == 's') {
    minDepth = constrain(minDepth-10, 0, maxDepth);
  } else if (key == 'z') {
    maxDepth = constrain(maxDepth+10, minDepth, 2047);
  } else if (key =='x') {
    maxDepth = constrain(maxDepth-10, minDepth, 2047);
  }
}


*/