/*

DA MEETING CRASHER


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

//import fixlib.*;
import processing.video.*;
Movie myMovie;

/* ------------------------------------------------------------------------- */
//Fixlib fix = Fixlib.init(this);
float sz = 2704;  //3840;  //  THIS SKETCH GOES FROM BIG TO SMALL, keep this width of sketch
int STOP_SZ = 8;
String VIDEO_NAME = "BikeRide720_preWarp_audio.mp4";
float w, h;
int cX, cY;
PImage txtImg;  //  frame to use in setTexture(txtImg)
PImage bg;
PShape myBox, mySphere;
/* ------------------------------------------------------------------------- */
    //size(3840,2160, P3D); //  always use P3D!!!
    
void  settings ()  {
    size(2704,1520, P3D); //  always use P3D!!!
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */

void setup() {
  background(0xCCEF20);
  myMovie = new Movie(this, VIDEO_NAME);
  myMovie.loop(); 
  myMovie.volume(0);

  cX = (int) width/2;
  cY = (int) height/2;
  rectMode(CENTER);      //  NOTE: bike3 experimentation
  shapeMode(CENTER);    //  NOTE: bike3 experimentation
  imageMode(CENTER);    //  NOTE: bike3 experimentation
  
  textureMode(IMAGE);    //  NORMAL was bike2, what does IMAGE look like?
  textureWrap(REPEAT);   //  CLAMP ( default ) or REPEAT --> was bike2  
  noStroke();
  
  bg = get(0,0,width, height);
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
        //bg.filter(BLUR);
      } 
      else 
      {
        bg.filter(POSTERIZE,255);
      }
      
    // TODO: cool?
// bike2
    blend(bg, 0,0,width,height, cX, cY,width,height, DIFFERENCE);
    tint(255, 69);
    image(bg, 0,0,width,height);
    noTint();
    
lights();
ambientLight( 0xCCEF20, cX, cY);
directionalLight( random(cX%255), random(cY%255), random(cY%255), cX, cY, STOP_SZ);
pointLight( random(cX%255), random(cY%255), random(cY%255), cX, cY, STOP_SZ);
    //  TODO: figure out a good algo for https://processing.org/reference/spotLight_.html
  //clear();
  noStroke();


    //  w = h * 1.8
    //  increment by 8 until > sz  h
    h = sz;
    w = h * 1.8;

    //  ELLIPSE, RECT, ARC, TRIANGLE, SPHERE, BOX, QUAD



      //  BOX
      beginShape();
        myBox = createShape( BOX, sz, sz, sz );
        myBox.disableStyle();
        myBox.setTexture(txtImg);
      endShape(CLOSE);
    
      //  SPHERE
      beginShape();
        sphereDetail(6);
        mySphere = createShape( SPHERE, sz );
        mySphere.disableStyle();
        mySphere.setTexture(txtImg);
      endShape(CLOSE);
    
  
      //  pull colors from texture
      //stroke(bg.get(bg.width/2, bg.height/2));
      tint(bg.get(bg.width/2, bg.height/2) );//, 240 );

    //  BOX
    pushMatrix();
      translate((cX-(sz*.5))%width, cY, 0);
      rotate(frameCount);
      shape(myBox);
    popMatrix();
  
  
    //  SPHERE
    pushMatrix();
      translate( (cX+(sz*.5))%width, cY, 0);
      rotate(frameCount);
      shape(mySphere);
    popMatrix();
 noTint();
  
    if(sz>STOP_SZ)
    {
      //sz -= STOP_SZ;
      sz -= PI;
    }
    else
    {
      doExit();
    }
    
      //  TODO: blending is causing lame gray
  strokeWeight(.45);
  stroke(0xCCEF20);
  line(0,random(height),width, random(height));
  noStroke();
  
    //saveFrame( "frames/pshapes#######.tif");  //  USE .TIF IF COLOR or TO BE GLITCHED
    //  FFMPEG doesn't like these .tif????
    
    saveFrame( "frames/pshapes#######.png");  //  USE .PNG IF NEEDING SPACE
    //  GRAB A SCREENSHOT
    //bg = get(0,0,2704,1520);
    bg = get(0,0,width,height);
}







/* ------------------------------------------------------------------------- */
/*  NON - P5 BELOW  */
/* ------------------------------------------------------------------------- */

/**
  End of sketch closer
*/
void doExit(){
  //String msg = "ericfickes.com";
  ////  stamp bottom right based on textSize
  //fill(0);
  //textSize(16);
  //text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());

  //save( fix.pdeName() + "-" + fix.getTimestamp()+"_FINAL.png" );    //  USE .TIF IF COLOR  
  
  ////  cleanup
  //fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
