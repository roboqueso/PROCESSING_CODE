/*
setTexture( videoFrame )
http://brendandawes.com/blog/ffmpeg-images-to-video
TextureVidPShape

if(color)
  GO TIFF
  TIFF = Tagged Image File Format. This is one of the most complex image formats, and it can hold more kinds and depth of information than almost any other format. The standard is owned and maintained by Adobe.
else
  PNG


*/

import fixlib.*;
import processing.video.*;
Movie myMovie;

/* ------------------------------------------------------------------------- */
Fixlib fix = Fixlib.init(this);
float sz = 3840;  //  THIS SKETCH GOES FROM BIG TO SMALL, keep this width of sketch
int STOP_SZ = 8;
String VIDEO_NAME = "fishtank8.mp4";
float w, h;
int cX, cY;
PImage txtImg;  //  frame to use in setTexture(txtImg)

PShape myBox, mySphere;
/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(3840,2160, P3D); //  always use P3D!!!
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */

void setup() {
  //frameRate(888);  //  this doesn't seem to matter when saving frames
  background(255);
  myMovie = new Movie(this, VIDEO_NAME);
  myMovie.loop();
  myMovie.volume(0);
  
  cX = (int) width/2;
  cY = (int) height/2;
  strokeWeight(STOP_SZ);
  textureMode(NORMAL);
  textureWrap(REPEAT);
}


// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
  txtImg = m; 
}


/* ------------------------------------------------------------------------- */
void draw() {
  
  
  //if (myMovie.available()) {
  //  myMovie.read();
    
//    //  LOAD TEXTURE IMAGE
//    try{
//      //  TODO : loadMovie(), onMovieEvent() txtImg = movie.read();
//      txtImg = myMovie;  //loadImage("testframe.png");  // realtime load to simulate loading from movie
////image(txtImg, 0,0);
//    }
//    catch(Exception exc){
//      println("TEXTURE IMAGE EXC:  \n"+ exc.getMessage() );
//      txtImg = get();
//    }
    
    //  TESTING
    //image(txtImg,0,0);
    
    
    //  w = h * 1.8
    //  increment by 8 until > sz  h
    h = sz;
    w = h * 1.8;
    //stroke( (frameCount % 2 == 0 ? 0 : color(255,0,0) )); 
  
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
    
    //  IT'S ON
    lights();
  
  //  pull colors from texture
  stroke(txtImg.get(txtImg.width/2, txtImg.height/2));
  
    //  SET THE STAGE
    rotate(frameCount);
    
    //  BOX
    pushMatrix();
      translate(cX-(sz*.5), cY, STOP_SZ);
      shape(myBox);
    popMatrix();
  
  
    //  SPHERE
    pushMatrix();
      translate(cX+(sz*.5), cY, STOP_SZ);
      shape(mySphere);
    popMatrix();
  
  
    if(sz>STOP_SZ)
    {
      sz -= 64;
    }
    else
    {
      exit();
    }
    
    
    //saveFrame( "frames/pshapes#######.tif");  //  USE .TIF IF COLOR or TO BE GLITCHED
    saveFrame( "frames/pshapes#######.png");  //  USE .PNG IF NEEDING SPACE

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
