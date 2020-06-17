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
float sz = 1920;  //3840;  //  THIS SKETCH GOES FROM BIG TO SMALL, keep this width of sketch
int STOP_SZ = 8;
String VIDEO_NAME = "BikeRide720_preWarp.mp4";
float w, h;
int cX, cY;
PImage txtImg;  //  frame to use in setTexture(txtImg)
PImage bg;
PShape myBox, mySphere;
/* ------------------------------------------------------------------------- */

void  settings ()  {
    //size(3840,2160, P3D); //  always use P3D!!!
    size(1920,1080, P3D); //  always use P3D!!!
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */

void setup() {
  background(255);
  myMovie = new Movie(this, VIDEO_NAME);
  myMovie.loop();
  myMovie.volume(0);
  
  bg = createImage(1920,1080,RGB);
  
  cX = (int) width/2;
  cY = (int) height/2;
  //strokeWeight(STOP_SZ);
  noStroke();
  textureMode(NORMAL);
  textureWrap(REPEAT);
  blendMode(LIGHTEST);

}


// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
  txtImg = m; 
}


/* ------------------------------------------------------------------------- */
void draw() {
  
    lights();
    ambientLight( random(cX%255), random(cY%255), random(cY%255), cX, cY, STOP_SZ);
    directionalLight( random(cX%255), random(cY%255), random(cY%255), cX, cY, STOP_SZ);
    pointLight( random(cX%255), random(cY%255), random(cY%255), cX, cY, STOP_SZ);
    //  TODO: figure out a good algo for https://processing.org/reference/spotLight_.html
  
  
  
      if(frameCount%2==0)
      {
        bg.filter(INVERT);
        bg.filter(BLUR);
      } 
      else 
      {
        bg.filter(POSTERIZE,255);
      }

// TODO: cool?
//blendMode(LIGHTEST);
blend(bg, 0,0,1920,1080,0,0,1920,1080, DARKEST);

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
        sphereDetail((int)random(PI,45));
        mySphere = createShape( SPHERE, sz );
        mySphere.setTexture(txtImg);
      endShape(CLOSE);
    
  
  //  pull colors from texture
  strokeWeight(random(.09, HALF_PI));
  stroke(bg.get(bg.width/2, bg.height/2));
  
  
    //  SET THE STAGE
    //rotateX(frameCount);
    //rotateY(frameCount);
    //rotateZ(-frameCount);
// TODO: how do we BLEND the previous frames on the last?
    //  BOX
    pushMatrix();
      translate(cX-(sz*.5), cY, 0);
      rotateX(frameCount%75);
      rotateY(45);
      rotateZ(-frameCount);
      shape(myBox);
    popMatrix();
  
  
    //  SPHERE
    pushMatrix();
      translate(cX+(sz*.5), cY, 0);
      shape(mySphere);
    popMatrix();
  
  
    if(sz>STOP_SZ)
    {
      //sz -= STOP_SZ;
      sz -= HALF_PI;
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
