import processing.dxf.*;
import gab.opencv.*;
import processing.video.*;
import java.awt.*;
// https://github.com/ericfickes/FIXLIB  
import fixlib.*;

Fixlib fix = Fixlib.init(this);

Capture video;
OpenCV opencv;
Rectangle[] faces;
PImage imgFace;
//ArrayList<Contour> contours;
ArrayList<Line> lines;
PVector maxPt;
// single face support
int i = 0;
Boolean recording = true;



void setup() {
  size(1280, 1060, P3D);
  video = new Capture(this, 640/2, 480/2);
  video.start();
  delay(666);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  delay(666);
  println("end setup()");
}



void draw() {
  

	scale(2);
	opencv.loadImage(video);

	  maxPt = opencv.max();

	  // opencv.dilate();
	  faces = opencv.detect();

tint(255,80);
image(video, 0, 0 );
noTint();

// NOTE: single face detection currently

if( faces.length > i ){
  if( !recording ){
    beginRaw(DXF, fix.pdeName()+".dxf"); // Start recording to the file
    recording=true;
  }
  
  // lights();

  //for (int i = 0; i < faces.length; i++) {
    //println(faces[i].x + "," + faces[i].y);
    
    imgFace = video.get( faces[i].x, faces[i].y, faces[i].width, faces[i].height);
        
    //  get FACE contours
    // opencv.loadImage(imgFace);
    // opencv.gray();    
    // //  try getting better face via adaptiveThreshold
    // opencv.threshold(75);
    opencv.findCannyEdges( imgFace.width, imgFace.height);

	// Find lines with Hough line detection
	// Arguments are: threshold, minLengthLength, maxLineGap
	lines = opencv.findLines(75, 32, 16);
    
    //imgFace.filter(INVERT);
    //image( imgFace, faces[i].x, faces[i].y );          

    //rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
      
    
    for (Line line : lines) {
      //stroke(0, 255, 0);
      //contour.draw();
      
      stroke(255, 0, 0);
      
      pushMatrix();
      translate( faces[i].x, faces[i].y, frameCount );
      
      beginShape(TRIANGLE);
        
        texture(imgFace);
        
        rotate(frameCount*45);  //*10
        
        vertex( maxPt.x, maxPt.y, maxPt.z, faces[i].x, faces[i].y );
        
        //bezierVertex(maxPt.x, maxPt.y, maxPt.z, faces[i].x, faces[i].y, faces[i].width-faces[i].height);
        
        // bezierVertex( line.start.x, line.start.y, frameCount, line.end.x, line.end.y, frameCount );


      endShape(CLOSE);
      
      popMatrix();
    }
  
}else{

	stroke(random(255));
	point(frameCount%width, height/2+noise(frameCount));

}


  if(frameCount > 420 )
  {
  	video.stop();
  	video = null;


    if(recording){
     endRaw();
    }
     save(fix.pdeName()+fix.getTimestamp()+".png");
     noLoop();
     exit();
}
    }

void captureEvent(Capture c) {
  c.read();
}
