import processing.dxf.*;
import gab.opencv.*;
import processing.video.*;
import java.awt.*;
// https://github.com/ericfickes/FIXLIB  
import fixlib.*;

Fixlib fix = Fixlib.init(this);
Capture video;
OpenCV opencv;
ArrayList<Line> lines;
PVector maxPt;
Boolean recording = false;
Rectangle[] faces;
PImage imgFace;
int i = 0;


void setup() {
  //PImage src = loadImage("film_scan.jpg");
  //src.resize(0, 800);
  size(1024, 800, P3D);
  background(-1);
  

  strokeCap(ROUND);
  strokeJoin(ROUND);
  //strokeWeight(TWO_PI);
  
  video = new Capture(this, width/2, height/2);
  opencv = new OpenCV(this, width/2, height/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 
  video.start();

}

void draw() {
  
  if(video.available() )
  {
    scale(2);
    opencv.loadImage(video);
    faces = opencv.detect();
    
    if( faces.length > i ){
  
    // Find lines with Hough line detection
    // Arguments are: threshold, minLengthLength, maxLineGap
    imgFace = video.get( faces[i].x, faces[i].y, faces[i].width, faces[i].height);
        
    //  get FACE contours
    opencv.loadImage(imgFace);
    maxPt = opencv.max();
    opencv.findCannyEdges(20, 75);
    
    lines = opencv.findLines(100, 30, 20);
    
    //image(opencv.getOutput(), 0, 0);
        
    if( !recording ){
      beginRaw(DXF, fix.pdeName()+".dxf"); // Start recording to the file
      recording=true;
    }
    lights();
    
    
    pushMatrix();
      translate( faces[i].x, faces[i].y, frameCount );
      rotateX(frameCount);
      rotateY(frameCount);
      rotateZ(frameCount);
      
      
      
      beginShape(POLYGON);
  
        fill(random(255));
        texture(imgFace);
  
        //vertex(maxPt.x, maxPt.y, frameCount);
  
      for (Line line : lines) {
  
        // lines include angle in radians, measured in double precision
        // so we can select out vertical and horizontal lines
        // They also include "start" and "end" PVectors with the position
        if (line.angle >= radians(0) && line.angle < radians(1)) {
          stroke(0, 255, 0);
          vertex(line.start.x, line.start.y, line.start.z, line.start.x, line.start.y);
          vertex(line.end.y, line.end.x, line.end.z, line.end.x, line.end.y);
          //line(line.start.x, line.start.y, line.start.z, line.end.x, line.end.y, line.end.z );
        }
    
        if (line.angle > radians(89) && line.angle < radians(91)) {
          stroke(255, 0, 0);
          //line(line.start.x, line.start.y, line.start.z, line.end.x, line.end.y, line.end.z );
          vertex(line.start.x, line.start.y, line.start.z, line.start.x, line.start.y);
          vertex(line.end.y, line.end.x, line.end.z, line.end.x, line.end.y); 
        }
        
      }
      endShape(CLOSE);
    popMatrix();
    
    }
    
  if(frameCount > 32 )
  {
    if(recording){
     endRaw();
    }
     save(fix.pdeName()+fix.getTimestamp()+".png");
     noLoop();
     exit();
  }

    
  }
}

void captureEvent(Capture c) {
  c.read();
}