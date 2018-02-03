/******************************************

KineticOpenCam
	* rewrite of KINETIC FIRE to use
		1. standard web cam
		2. OpenCV

inspired by updating :  KINETIC FIRE

  WARNING: ACTIVE HOT MESS!! 
******************************************/

//Capture video;
OpenCV opencv;
Kinect kinect;

import org.openkinect.freenect.*;
import org.openkinect.processing.*;


import gab.opencv.*;
//import processing.video.*;
import java.awt.*;

PVector      tmp = new PVector();                                   

ArrayList<Contour> contours = new ArrayList();
int contCt = 0;

Rectangle rect, nextRect;
Rectangle[] faces;
int     steps   = 2;  // to speed up the drawing, draw every third point
int     index;
PVector rwp;



PImage imgDepth = new PImage();	//	depth
//PImage imgIr = new PImage();	//	ir
PImage imgRgb = new PImage();	//	rgb
PImage imgTexture = new PImage();


ArrayList<PVector> joints = new ArrayList<PVector>();
String stamp = "[opencv]+[camera]";

///////////////////////////////////////////////////////////////////////////////
void setup()
{
//  size(1200, 900,P3D);  // strange, get drawing error in the cameraFrustum if i use P3D, in opengl there is no problem
  size( displayWidth, displayHeight, P3D );
  background(-1);
  frameRate(60);
  
	//textureMode(NORMAL);
	//textureWrap(REPEAT);


  smooth();  

  imgTexture = loadImage("fire1.png");


	//	INIT CAMERA
	//video = new Capture(this, displayWidth, displayHeight);
  kinect = new Kinect(this);
  kinect.initDepth();

	opencv = new OpenCV(this, displayWidth, displayHeight);
	opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

 }


///////////////////////////////////////////////////////////////////////////////
void draw()
{
//  60 fps, run draw every half second
//if(frameCount%15==0) {
  
  //if (video.available()) 
  //{
    //video.read(); // Read a new video frame
    //video.loadPixels(); // Make the pixels of video available
    
    // update the cam
    opencv.loadImage(kinect.getDepthImage());
    
    //opencv.useColor(HSB);
    //opencv.setGray(opencv.getH().clone());
    //opencv.inRange(20, 40);
    
    //     Passing 'true' sorts them by descending area.
    contours = opencv.findContours(true, true);
    // only draw the top SQUARE ROOT contours
    contCt = (int)Math.round( Math.sqrt(contours.size()) );
    
    //  detect face
    //video.read();
    opencv.loadImage(kinect.getVideoImage());
    faces = opencv.detect();
    
    // DEBUG
    text( "contours: " + contours.size() + " | " + contCt, random(width), frameCount%height );
    text( "faces: " + faces.length, frameCount%width, random(height) );

  //opencv.findScharrEdges(OpenCV.VERTICAL);
  //imgDepth = opencv.getSnapshot();
  
  opencv.findCannyEdges(20,80);
  imgDepth = opencv.getSnapshot();

  //opencv.gray();
  //opencv.threshold(80);
  //imgDepth = opencv.getOutput();
  
  //imgDepth.filter(INVERT);
  //imgDepth.mask(get());
  
  //video.read();
	imgRgb 		= kinect.getDepthImage();
  //imgRgb.mask(imgDepth);
  
  //tint(255, 80);
  image(imgRgb, frameCount%width, 0, kinect.width, kinect.height );


  //tint(255, 80 );
  //image(imgDepth, 0,0);


  for(int i=0;i<faces.length;i++)
  {
    rect = faces[i];

    // SHOW FACE(S)
    tint(255);
    //if(rect.x%2==0){
    //  kinect.filter(INVERT);
    //}
    image( kinect.getVideoImage().get(rect.x, rect.y, rect.width, rect.height), rect.x-16, rect.y-16 );

    fill( rect.x %255, rect.y %255, rect.height %255);
    text("FACE"+i, rect.x, rect.y);
    noFill();
    
    stroke( rect.x %255, rect.y %255, rect.width %255);
    strokeWeight(8);
    rect( rect.x-16, rect.y-16, rect.width, rect.height);
    
    
    
    
    strokeWeight(1+i);
    sphereDetail( rect.x%21, rect.y%21 );

    pushMatrix();
      translate(rect.x, rect.y, frameCount);
      sphere(random(40,88));
    popMatrix();


  //scale(-1,-1);
  //tint( rect.x %255, rect.y %255, rect.height %255, 80);//;
  //tint(255,80);
  //image(opencv.getSnapshot(), frameCount%width, 0, contCt*8, height );

  }    // END for each user
  
  
  //  CONNECT THE FACES
  for(int i=0;i<faces.length;i++)
  {
    rect = faces[i];
    if(i<(faces.length-1) ){
      nextRect = faces[i+1];
    }else{
      nextRect = faces[0];
    }
  
    stroke(rect.x);// rect.x %255, rect.y %255, nextRect.x %255 );
    strokeWeight(4);
    line( rect.x, rect.y, nextRect.x, nextRect.y );

    stroke( rect.y %255, rect.x %255, nextRect.y %255 );
    strokeWeight(2);
    line( rect.x, rect.y, nextRect.x, nextRect.y );

  
  }
  
  
    
  // <9> Check to make sure we've found any contours
  if (contours.size() > 1) 
  {


    for(int cc = 0; cc < contCt; cc++)
    {
      Contour contour = contours.get(cc);

      //stroke(random(255));
      //strokeWeight(2);
      //contour.draw();

strokeWeight(2);

      beginShape(POLYGON);
        noFill();
        //texture(imgTexture);
  
        for (PVector point : contour.getPolygonApproximation().getPoints()) 
        {
          stroke(point.x, point.y, point.z);
          
          vertex( point.x %width, 
                  point.y %height, 
                  point.z+cc, point.x %width, point.y %height );
        }
      endShape();

    }

  }  // end contours



  //}  // end videoAvailable



//}	// end frameCount checker

  //  AUTO SAVER
  if(frameCount%780==0){
    save(pdeName() + getTimestamp() + ".png");
  }


}






////// S SAVE HANDLER /////////

void keyPressed(){
  switch(key){
  
    case 's':
      save(pdeName() + getTimestamp() + ".png");
    break;
  
    case ESC:
  
     opencv.close(1);
     kinect.stopDepth();
     kinect.stopVideo();
     
      save(pdeName() + getTimestamp() + ".png");
  
      exit();
    break;
  
  
  /*
      case LEFT:
        rotY += 0.1f;
  
        break;
      case RIGHT:
        // zoom out
        rotY -= 0.1f;
  
        break;
      case UP:
        if(keyEvent.isShiftDown())
          zoomF += 0.01f;
        else
          rotX += 0.1f;
        break;
      case DOWN:
        if(keyEvent.isShiftDown())
        {
          zoomF -= 0.01f;
          if(zoomF < 0.01)
            zoomF = 0.01;
        }
        else
          rotX -= 0.1f;
        break;
  */
  }

}  

//void captureEvent(Capture c) {
//  c.read();
//}

public String getTimestamp() {
  return ""+month()+"-"+day()+"-"+year()+"-"+hour()+"-"+minute()+"-"+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
public String pdeName() {
  return split( this.toString(), "[")[0];
}