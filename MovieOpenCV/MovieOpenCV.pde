import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;

//  TODO: get working on MP4 + OpenCV
//  NEXT: get HYPEd
 
OpenCV opencv;
Movie myMovie;
Rectangle[] faces;
 
void setup() {
  size(608, 1080);  //, P3D);
 
  myMovie = new Movie(this, "justawarning.mp4");
  opencv = new OpenCV(this, 608, 1080);
 
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  //myMovie.loop();
  myMovie.play();
}
 
void draw() {
   //Movie needs time to load into canvas, so we wait until we get a height
   //while (myMovie.height == 0 )  delay(10); 
   if(myMovie != null && myMovie.height > 0)
   {
     
    tint(255, (int)random(80));
   image(myMovie, (int)random(width), 0, (int)random(24), height );
   opencv.loadImage(myMovie);
   faces = opencv.detect();
 
 
  if (faces != null) {
    for (int i = 0; i < faces.length; i++) {
      strokeWeight(2);
      stroke(255, 0, 0);
      noFill();
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height, frameCount);
    }
  }
  


if( myMovie.time() > myMovie.duration() ){
//TODO: how to detect end of movie, this detection doesn't work?!?!?!?
println("STOP THE MOVIE : " + myMovie.time() );
}


 //  RANDO STOPPER
  if(frameCount > width )
  {
   

  
  myMovie.stop();
  myMovie.dispose();
  
  myMovie = null;
  opencv = null;
  
  save(this+".png"); 
  
  noLoop();
  exit();
   }

  
}  // end null movie
}
 
 
void movieEvent(Movie myMovie) {
  myMovie.read();
}
