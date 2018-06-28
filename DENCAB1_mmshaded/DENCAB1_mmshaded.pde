import processing.video.*;
import fixlib.*;


Fixlib fix = Fixlib.init(this);
Movie myMovie;

String PDE;  //  1280, 720
int MODE = 0;  // doesn't matter as long as all frames have the same MODE

String MOV_FILE = "Big_an_sad_news.mp4";
// String MOV_FILE = "Dog.mp4";
// String MOV_FILE = "Hello_blog.mp4";
// String MOV_FILE = "I_finally_fand_him.mp4";
// String MOV_FILE = "Just_a_warning.mp4";
// String MOV_FILE = "March_20_2018.mp4";
// String MOV_FILE = "My_shadow_puppet_play.mp4";
// String MOV_FILE = "The_meaning_of_life.mp4";
// String MOV_FILE = "the_wise_owl.mp4";

PImage iSlice;
//  SHADER BIZNESS
PShader shade;

// bands.glsl
// bilateral_filter.glsl
// bits.glsl
// blobby.glsl
// blur.glsl
// brcosa.glsl
// channels.glsl
// deform.glsl
// drip.glsl
// edges.glsl
// electro.glsl
// eye.glsl
// halftone.glsl
// halftone_cmyk.glsl
// hue.glsl
// invert.glsl
// landscape.glsl
// modcolor.glsl
// monjori.glsl
// nebula.glsl
// neon.glsl
// noisy.glsl
// patches.glsl
// pixelate.glsl
// pixelrolls.glsl
// rain.glsl
// ripple.glsl
// shady.glsl
// sinewave.glsl
// threshold.glsl
// waterNoise.glsl
// wrap.glsl

void setup() {
size(2000, 1000, P3D);  //  2x1 so f360 honors as .hdr

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

  //  SHADER BIZNESS
  shade = loadShader("brcosa.glsl");
}

void draw() {
  if (myMovie.available()) {
    // myMovie.read();


//  SHADER BIZNESS
    shade.set("brightness", 1.0);
    shade.set("contrast", map(mouseX, 0, width, -5, 5));
    shade.set("saturation", map(mouseY, 0, height, -5, 5));

  // turn on shader and display source
  shader(shade);


  // iSlice = myMovie.get(0, 0, (int)random(frameCount), (int)(sqrt(frameCount)*noise(frameCount)) );

  // tint(255,43);
  // image(iSlice, 8, (frameCount%height));



// HORIZONTAL
  iSlice = myMovie.get( (int)random(myMovie.width),  (int)random(myMovie.height),  (int)random(43),  height);
  tint(255, 50);
  image(iSlice, frameCount%width, random(iSlice.height) );

//  VERTICAL
  iSlice = myMovie.get( 0,0, width-iSlice.width,  (int)random(TWO_PI) );
  tint(255, 50);
  image(iSlice, 0, frameCount%height );

  // turn off shader before displaying filename
  // resetShader();

//  SAVE FRAMES FOR GIFing
// saveFrame("frames/DENCAB1_"+PDE+"-"+MOV_FILE+"-"+MODE+"-frame#####.png");

if(frameCount>=width){
  // stop the movie
  myMovie.stop();
  // cleanup
  
  // include source MOV_FILE & MODE
  save(fix.pdeName()+"-"+MOV_FILE+"-"+MODE+"-"+fix.getTimestamp()+".png");

  //  stop the sketch
  noLoop();
  exit();
  super.stop();
}  

  }

}

void movieEvent(Movie myMovie) {
  myMovie.read();
}

void mousePressed() {
  myMovie.jump(random(myMovie.duration()));
}
