import processing.pdf.*;

/*
PROPS:
 * A complete tutorial can be found over at:
 * http://sighack.com/post/exporting-high-resolution-images-in-processing


UNDER LUCKY STARS specs

 The design has to work for all three of the following print sizes, either by cropping or otherwise adjusting it:
                        = 300 dpi pixels

◆ 18x24 inches          = 5400, 7200
◆ 24x36 inches          = 7200, 10800
◆ A1 (23.4 x 33.1 in)   = 7020, 9930

 */





int seed;
int CONFIG_SCALE_FACTOR = 10;
float hue;

void setup() {
  size(540, 720);  //  + CONFIG_SCALE_FACTOR = 10 for rendering
  //size( 1080, 1440 );
  // Pulling the display's density dynamically
  pixelDensity(displayDensity());
 
  textMode(CENTER);
  textAlign(CENTER);
  textSize(42);
	// create Font makes .vlw loadFont is for VLW
	textFont(loadFont("BebasNeueBold-42.vlw"), 42);
	//textFont(createFont("Bebas Neue Bold", 42));

  fill(0);
  
  
  seed = millis();
  seededRender();
}

void draw() {
  //  do drawing in render()
}

void seededRender() {
  randomSeed(seed);
  noiseSeed(seed);
  render();
}

void render() {
  /* Write your drawing code here */
  smooth();
  noStroke();
  colorMode(HSB, 360, 100, 100);
  background(255, 0, 100);
  hue = random(360);
  
  

  
  
  //  PROJECTION
  //  placeholders are 4662 × 4662
  for (int i = 0; i < 10000; i++) {
    float r = random(10, 50);
    fill(hue, 50 + random(-50, 50), 50 + random(-50, 50), 50);
    ellipse(random(-width/2, width * 5/4), random(-height/2, height * 5/4), r, r);
  }
  
  //  TITLE
  fill(0);
  text("TITLE", width/2, height*.1);
  
  stroke(#ef2018);
  line(width/2, 0,
        width/2, height);
  
  //  FOOTNOTE
  fill(0);
  text("FOOTNOTE", width/2, height*.95 );
  
  
}

/*
 * The keyPressed handler handles the following
 * -- If the key 's' (lower case) is pressed, then
 *    it will save a low-resolution version of the
 *    image into a file 'lowres-<seed>.png'.
 *
 * -- If the key 'h' (lower case) is pressed, then
 *    it will save a high-resolution version into
 *    the file 'highres-<seed>.png', scaled by an
 *    amount set in the SCALE_FACTOR variable.
 *    So if your screen width is 500 pixels, a
 *    scale factor of 10 will generate a
 *    high-resolution version that is 5000x5000px.
 *
 * -- If the key 'p' (lower case) is pressed, then
 *    it will save a vector version as PDF into the
 *    file 'vector-<seed>.pdf', which is inherently
 *    scalable to any resolution.
 *
 * -- If any other key is pressed, a new random
 *    seed is generated and the render function
 *    called again to generate a new artwork.
 */
void keyPressed() {
  if (key == 's') {
    saveLowRes();
  } else if (key == 'h') {
    saveHighRes(CONFIG_SCALE_FACTOR);
  } else if (key == 'p') {
    savePDF();
  } else {
    seed = millis();
    seededRender();
  }
}

void saveLowRes() {
  println("Saving low-resolution image...");
  save(seed + "-lowres.png");
  println("Finished");
}

void saveHighRes(int scaleFactor) {
  PGraphics hires = createGraphics(
                        width * scaleFactor,
                        height * scaleFactor,
                        JAVA2D);
  println("Saving high-resolution image...");
  beginRecord(hires);
  hires.scale(scaleFactor);
  seededRender();
  endRecord();
  hires.save(seed + "-highres.png");
  println("Finished");
}

void savePDF() {
  println("Saving PDF image...");
  beginRecord(PDF, seed + "-vector.pdf"); 
  seededRender();
  endRecord();
  println("Finished");
}
