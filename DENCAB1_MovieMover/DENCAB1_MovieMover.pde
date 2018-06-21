import processing.video.*;
import fixlib.*;


Fixlib fix = Fixlib.init(this);
Movie myMovie;

String PDE;  //  1280, 720
int MODE = 0;  // doesn't matter as long as all frames have the same MODE
String MOV_FILE = "bulldog.mp4";  //  1280, 720


void setup() {
size(1080, 1920, P3D);

  background(-1);
  smooth(8);
  //frameRate(420);
  strokeWeight(2);
  pixelDensity(displayDensity());
  
  PDE = fix.pdeName();
  myMovie = new Movie(this, MOV_FILE );
  // Prints the duration of the movie
  println(myMovie.duration());
  myMovie.loop();
}

void draw() {
  if (myMovie.available()) {
    myMovie.read();
  }

  tint(random(255),random(255),random(255), 75);
  image(myMovie, (frameCount%width), (frameCount%height), 43, 75);


   myMovie.filter(INVERT);
   tint(255,random(80,240));
   image(myMovie, frameCount%width, random(height), random(myMovie.width), random(myMovie.height));


	scale(-1, 1); // this will flip everything! (read: also the coordinates)
  image(myMovie, width*.43, frameCount, random(myMovie.width), random(myMovie.height));


//  SAVE FRAMES FOR GIFing
saveFrame("frames/DENCAB1_"+PDE+"-"+MOV_FILE+"-"+MODE+"-frame#####.png");

if(frameCount>=height){
  save(fix.pdeName()+fix.getTimestamp()+".png");
  myMovie.stop();
  stop();
  exit();
}  

}

void movieEvent(Movie myMovie) {
  myMovie.read();
}

void mousePressed() {
  myMovie.jump(random(myMovie.duration()));
}
