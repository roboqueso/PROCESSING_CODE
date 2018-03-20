// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

int alf = 13;
PImage img;
color[] p1;
float ct, maxCt, xx;
Boolean isFinal = true;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void setup() {
  size( 1024, 768 );
  background(255);
  noFill();
  
  img = loadImage("wrestlefaces.jpg");
  p1 = getImgColors( img );
  fix.alpha(alf);
  image(img,0,0 );
  filter(GRAY);  //  THRESHOLD, GRAY, INVERT, POSTERIZE, BLUR, OPAQUE, ERODE, or DILATE

  
  img.filter(INVERT);  // 
  image(img,width/2,0 );
  
  maxCt = width+height;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void draw() {

// draw pattern over image

  if( ct < maxCt ) {
    stroke(  p1[  int( random( 0, p1.length-1 ) )  ] ,alf );
    strokeWeight( random(.5, PI ) );
    ellipse( 0, xx, xx, xx );

    stroke(  p1[  int( random( 0, p1.length-1 ) )  ] ,alf );
    ellipse( xx, 0, xx, height ); 
    
    stroke(  p1[  int( random( 0, p1.length-1 ) )  ] ,alf );
    strokeWeight( random(.25, PI ) );
    rect( 0, xx, width, xx );
    
    stroke(  p1[  int( random( 0, p1.length-1 ) )  ] ,alf );
    rect( xx, 0, xx, height ); 
    
    stroke(  random(p1[  int( random( 0, p1.length-1 ) )  ]+alf) ,alf );
    strokeWeight( p1.length );
    point( random(xx), random(xx) );

  } else {
    doExit();  
  }
  

  
  if( xx > width ) {
    xx = random( PI );
  } else {
    xx += PI;
  }  
  
  ct++;
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  pull colors out of image and return color[]
color[] getImgColors( PImage img ) {
  ArrayList alColors = new ArrayList();
  color[] colors = {#000000};
  int loc;

  //  get the colors
  img.loadPixels();

  for (int x = 0; x < img.width; x++) {
  for (int y = 0; y < img.height; y++ ) {
    // Calculate the 1D pixel location
    loc = x + y*img.width;
    // Get the pixel value
//    img.pixels[loc]
    
    //  if we don't already have it, save it
    if( ! alColors.contains( img.pixels[loc] ) ) {
      alColors.add( img.pixels[loc] ); 
      colors[ colors.length-1 ] = img.pixels[loc];
    }

  }
}

  /*
for (int x = 0; x < img.width; x++) {
  for (int y = 0; y < img.height; y++ ) {
    // Calculate the 1D pixel location
    int loc = x + y*img.width;
    // Get the R,G,B values from image
    float r = red   (img.pixels[loc]);
    float g = green (img.pixels[loc]);
    float b = blue  (img.pixels[loc]);
    // Change brightness according to the mouse here
    float adjustBrightness = ((float) mouseX / width) * 8.0;
    r *= adjustBrightness;
    g *= adjustBrightness;
    b *= adjustBrightness;
    // Constrain RGB to between 0-255
    r = constrain(r,0,255);
    g = constrain(g,0,255);
    b = constrain(b,0,255);
    // Make a new color and set pixel in the window
    color c = color(r,g,b);
    pixels[loc] = c;
  }
}
*/
  
  return colors;
}


void doExit() {
  fill(#EFEFEF);
  text("ERICFICKES.COM", 0, height-11 );
  
  
  if ( isFinal )
  {
    save( fix.pdeName()+fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
}
