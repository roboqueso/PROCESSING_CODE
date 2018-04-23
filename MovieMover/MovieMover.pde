import processing.video.*;
Movie myMovie;

void setup() {
  size(1024, 768);
  frameRate(69);
  // myMovie = new Movie(this, "tex2.mov");
  myMovie = new Movie(this, "ShapePrimitivesDXF_2018-Feb-26_04-21-31AM-000_CustomizedView50218821407.mp4");
  // Prints the duration of the movie
  println(myMovie.duration());
  myMovie.loop();
}

void draw() {
  if (myMovie.available()) {
    myMovie.read();
  }

// tint(random(255),random(255),random(255), 75);
//   image(myMovie, ((frameCount*200)%width), (frameCount%height));

// myMovie.filter(INVERT);
// image(myMovie, 0,0);

	scale(-1, 1); // this will flip everything! (read: also the coordinates)
  image(myMovie, width,0);

}

void movieEvent(Movie myMovie) {
  myMovie.read();
}

void mousePressed() {
  myMovie.jump(random(myMovie.duration()));
}