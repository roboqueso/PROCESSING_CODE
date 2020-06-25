/*

 DA MEETING CRASHER
 
 
 1 - if your MP4 doesn't exist, this sketch will start then disappear, remember to keep VIDEO_NAME correct.
 
 2 - Processing's Video library just won't read all movies. If your movie exists but P5 can't read it, you'll get a special screen

 3 - saveFrame using PNG to save on file size while making this better.  The .tif files are all 100MB each and ffmpeg doesn't seem to like them ( circle back to that observation )
   
  > setTexture( videoFrame )
  
  > Bren freaking rules >>  http://brendandawes.com/blog/ffmpeg-images-to-video
  
   TextureVidPShape
   
   if(color)
   GO TIFF
   TIFF = Tagged Image File Format. This is one of the most complex image formats, and it can hold more kinds and depth of information than almost any other format. The standard is owned and maintained by Adobe.
   else
   PNG
 
 //  ffmpeg -r 60 -f image2 -pattern_type glob -i "*?png" -vcodec libx264 -crf 20 -pix_fmt yuv420p output60.mp4
 */

import processing.video.*;
Movie myMovie;

/* ------------------------------------------------------------------------- */
float sz = 3840;  //3840;  //  THIS SKETCH GOES FROM BIG TO SMALL, keep this width of sketch
float w,h;
int STOP_SZ = 8;
int cX, cY;
String VIDEO_NAME = "G5622T_RUN.mp4";  //  Texture image source

PImage txtImg;  //  frame to use in setTexture(txtImg)
PImage bg;

PShape myBox, mySphere, myJous;
color txClr;

/* ------------------------------------------------------------------------- */

void  settings () {
  size(3840, 2160, P3D); //  always use P3D!!!
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());

  // TODO - what is sketchSmooth();
  sketchSmooth();
}


/* ------------------------------------------------------------------------- */

void setup() {
  background(0xCCEF20);  // SAFETY FIRS
  strokeWeight(8);
  //  SAFETY FIRST!
  stroke(0xCCEF20);

  //  let us begin
  myMovie = new Movie(this, VIDEO_NAME);
  myMovie.loop(); 
  myMovie.volume(0);

  cX = (int) width/2;
  cY = (int) height/2;

  bg = get(0, 0, width, height);

}


// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
  txtImg = m;
}


/* ------------------------------------------------------------------------- */
void draw() {

  //camera();
  lights(); //    because P3D

  //  SAFETY FIRST - don't assume the movie is readable
  //  NOTE: using myMovie.available() causes Java heap space crash.
  //  Just confirm txtImg isn't null since this gets set from Movie reads
  if ( txtImg  != null ) {

    if (frameCount%2==0)
    {
      bg.filter(INVERT);
      line(0, random(height), width, random(height));
    } else 
    {
      bg.filter(POSTERIZE,45 );
      line(random(width), 0, random(width), height);
    }

    tint(255,11);
    pushMatrix();
      translate(cX,cY,0);
      image(myMovie, 0,0);
    popMatrix();

    h = sz;
    w = h * 1.8;


    // TODO: NEIL BLENDER IT!!!
    pushMatrix();
    translate(cX,cY,0);
    tint(255, 11);
    //  NOTE: if Movie can't be read, thee PImages will be null
    if (null!=bg && txtImg!=null) { 
      txtImg.blend(bg, 0, 0, width, height, 0, 0, width, height, REPLACE);
    }
    //scale(-1, -1);
    blend(bg, 0, 0, width, height, 0, 0, width, height, REPLACE);

    tint(255, 11);
    //  NOTE: if Movie can't be read, thee PImages will be null
    if (null!=bg && txtImg!=null)image(txtImg, 0, 0);
    noTint();
    popMatrix();
    //

    // TODO: come back and make all of these
    //  ELLIPSE, RECT, ARC, TRIANGLE, SPHERE, BOX, QUAD



    //  BOX
    beginShape();
    myBox = createShape( BOX, sz, sz, sz );
    myBox.setTexture(txtImg);
    endShape(CLOSE);

    //  SPHERE
    beginShape();
    sphereDetail(9);
    mySphere = createShape( SPHERE, sz );
    mySphere.setTexture(txtImg);
    endShape(CLOSE);

    //  JOUS
    beginShape();
    myJous = shapeJous( cX, cY, sz, STOP_SZ );
    myJous.setTexture(txtImg);
    endShape(CLOSE);



    //  BOX
    pushMatrix();

      directionalLight(102, 102, 102, 0, 0, -1);
      lightSpecular(204, 204, 204);
      directionalLight(102, 102, 102, 0, 1, -1);
      lightSpecular(102, 102, 102);

      tint(255,11);  
  
      translate(cX, cY, 0);
  
      //ambient(0xCCEF20);
      //emissive(0xCCEF20);
      //specular(0xCCEF20);
//  BETA : NEW LIGHTING FROM TEXTURE
      //  pull tint from texture
      txClr = txtImg.get( cX, cY ); 
      ambient(txClr);
      emissive(txClr);
      specular(txClr);
        
      shininess(5.0);

      shape(myBox);
      shape(mySphere);
      shape(myJous);
    popMatrix();

    //  GRAB A SCREENSHOT
    bg = get(0, 0, width, height);

  } else {
    fill(frameCount%255, (int)random(width)%255,  (int)random(height)%255);
    textFont( createFont( PFont.list()[ frameCount%PFont.list().length ], sz ) );
    text( "MOVIE:ERROR:" + frameCount, random(width), random(height) );
  }

  //  FRAME SAVER
  saveFrame( "frames/pshapes#######.png");  //  USE .PNG IF NEEDING SPACE
  
  // HOT OR NOT?
System.gc();
  
  //  SKETCH STOPPER
  //  KEEP THIS HERE OR
  //  JAVA WILL RUN OUT OF HEAP SPACE
    if (sz>STOP_SZ)
    {
      sz -= STOP_SZ;
// debug
if(frameCount%100==0)  println( frameCount + " : " + sz + " > " + STOP_SZ );
    } else
    {
      try{
        //  TESTING
        launch("/usr/bin/say All done chief");
      } catch (Exception e ){
        println("END EXC :: " + e.getMessage() );
      }
      doExit();
    }
    
}







/* ------------------------------------------------------------------------- */
/*  NON - P5 BELOW  */
/* ------------------------------------------------------------------------- */

//  TODO FUNCTIONS ---------------------------------------

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Lissajous PShape maker
 * @param a     X coordinate
 * @param b     Y coordinate
 * @param amp   Amplitude or size
 * @param inc   Loop magic incrementer [ 1 - 36 supported ]. (360 / inc) = number of points in returned PShape
 * @return  PShape containing vertices in the shape of a lissajous pattern
 */
private PShape shapeJous( float a, float b, float amp, int inc )
{
  //  PROTOTYPING : trying to locate universal ideal INCrementor for lisajouss loop
  //  Ideal range is someplace between 1 and 36
  if ( ( inc < 1 ) || ( inc > 36 ) ) {
    inc = 1;
  }

  PShape shp = createShape();
  shp.beginShape(POLYGON);

  float x, y;

  for ( int t = 0; t <= 160; t+=inc)  //  160 is the NEW hotness -> slightly less points, no blank frames 9-36
  {
    //  NEW HOTNESS!
    x = a - amp * cos((a * t * TWO_PI)/360);
    y = b - amp * sin((b * t * TWO_PI)/360);

    //  Z mods INC
    shp.vertex(x, y, t%inc);
  }

  shp.endShape(CLOSE);

  return shp;
}

/**
 End of sketch closer
 */
void doExit() {
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
