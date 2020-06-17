/*
setTexture( videoFrame )
http://brendandawes.com/blog/ffmpeg-images-to-video
TextureVidPShape

if(color)
  GO TIFF
  TIFF = Tagged Image File Format. This is one of the most complex image formats, and it can hold more kinds and depth of information than almost any other format. The standard is owned and maintained by Adobe.
else
  PNG

//  ffmpeg -r 60 -f image2 -pattern_type glob -i "*?png" -vcodec libx264 -crf 20 -pix_fmt yuv420p output60.mp4
*/

import fixlib.*;
import processing.video.*;
Movie myMovie;

/* ------------------------------------------------------------------------- */
Fixlib fix = Fixlib.init(this);
float sz = 3840;  //  THIS SKETCH GOES FROM BIG TO SMALL, keep this width of sketch
int STOP_SZ = 16;
String VIDEO_NAME = "ellipseses.mp4";
float w, h;
int cX, cY;
PImage txtImg;  //  frame to use in setTexture(txtImg)
PImage bg;
PShape myBox, mySphere;
/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(3840,2160, P3D); //  always use P3D!!!
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */

void setup() {
  background(255);
  myMovie = new Movie(this, VIDEO_NAME);
  myMovie.loop();
  myMovie.volume(0);
  
  bg = createImage(3840,2160,RGB);
  
  cX = (int) width/2;
  cY = (int) height/2;
  //strokeWeight(STOP_SZ);
  noStroke();
  textureMode(NORMAL);
  textureWrap(REPEAT);
  
  //  TODO: 
  //  1. Is blendMode working?
  //  2. which mode kicks out the best shit?
//BLEND - linear interpolation of colors: C = A*factor + B. This is the default.

//ADD - additive blending with white clip: C = min(A*factor + B, 255)

//SUBTRACT - subtractive blending with black clip: C = max(B - A*factor, 0)

//DARKEST - only the darkest color succeeds: C = min(A*factor, B)

//LIGHTEST - only the lightest color succeeds: C = max(A*factor, B)

//DIFFERENCE - subtract colors from underlying image.

//EXCLUSION - similar to DIFFERENCE, but less extreme.

//MULTIPLY - multiply the colors, result will always be darker.

//SCREEN - opposite multiply, uses inverse values of the colors.

//REPLACE - the pixels entirely replace the others and don't utilize alpha (transparency) values

blendMode(REPLACE);
}


// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
  txtImg = m; 
}


/* ------------------------------------------------------------------------- */
void draw() {
      if(frameCount%2==0)
      {
        bg.filter(INVERT);
      } 
      else 
      {
        bg.filter(ERODE);
      }

//  TODO: trying to apply a thin mask of the previous frame to BLEND with the new frame
//  IS TINT even helping???
tint(255,50);
image(bg,0,0);
noTint();
  
    lights();
    ambientLight( random(cX%255), random(cY%255), STOP_SZ, cX, cY, STOP_SZ);
    directionalLight( random(cX%255), random(cY%255), STOP_SZ, cX, cY, STOP_SZ);
    pointLight( random(cX%255), random(cY%255), STOP_SZ, cX, cY, STOP_SZ);
    //  TODO: figure out a good algo for https://processing.org/reference/spotLight_.html

    //  w = h * 1.8
    //  increment by 8 until > sz  h
    h = sz;
    w = h * 1.8;

    //  ELLIPSE, RECT, ARC, TRIANGLE, SPHERE, BOX, QUAD
  
      //  BOX
      beginShape();
        myBox = createShape( BOX, sz, sz, frameCount%STOP_SZ );
        myBox.setTexture(txtImg);
      endShape(CLOSE);
    
      //  SPHERE
      beginShape();
        sphereDetail( (int)(frameCount+sz)%8 );
        mySphere = createShape( SPHERE, sz );
        mySphere.setTexture(txtImg);
      endShape(CLOSE);
    
  
  //  pull colors from texture
  //stroke(txtImg.get(txtImg.width/2, txtImg.height/2));
  
    //  SET THE STAGE
    rotateX(frameCount);
    rotateY(frameCount);
    rotateZ(-frameCount);
    
    //  BOX
    pushMatrix();
      translate(cX-(sz*.5), cY, 0);
      shape(myBox);
    popMatrix();
  
  
    //  SPHERE
    pushMatrix();
      translate(cX+(sz*.5), cY, 0);
      shape(mySphere);
    popMatrix();
  
  
    if(sz>STOP_SZ)
    {
      sz -= STOP_SZ;
    }
    else
    {
      exit();
    }
    
    
    //saveFrame( "frames/pshapes#######.tif");  //  USE .TIF IF COLOR or TO BE GLITCHED
    //  FFMPEG doesn't like these .tif????
    
    saveFrame( "frames/pshapes#######.png");  //  USE .PNG IF NEEDING SPACE
    //  GRAB A SCREENSHOT
    bg = get();
}







/* ------------------------------------------------------------------------- */
/*  NON - P5 BELOW  */
/* ------------------------------------------------------------------------- */

/**
  End of sketch closer
*/
//void doExit(){
//  String msg = "ericfickes.com";
//  //  stamp bottom right based on textSize
//  fill(0);
//  textSize(16);
//  text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());

//  save( fix.pdeName() + "-" + fix.getTimestamp()+"_FINAL.png" );    //  USE .TIF IF COLOR  
  
//  //  cleanup
//  fix = null;
  
//  noLoop();
//  exit();
//  System.gc();
//  System.exit(1);
//}
