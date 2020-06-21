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
String VIDEO_NAME = "DoubleHDoutrunToArvadaSkatepark.mp4";

float w, h;
int cX, cY;
PImage txtImg;  //  frame to use in setTexture(txtImg)
PImage bg;
PShape myBox, mySphere, myJous;
/* ------------------------------------------------------------------------- */
    
void  settings ()  {
    size(2704,1520, P3D); //  always use P3D!!!
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());

    // TODO - what is sketchSmooth();
    sketchSmooth();
}

/* ------------------------------------------------------------------------- */

void setup() {
  background(0xCCEF20);  // SAFETY FIRST
  //blendMode(EXCLUSION);
  imageMode(CORNERS);
  shapeMode(CORNERS);  // CORNER, CORNERS, CENTER
  rectMode(RADIUS); 
  
  strokeWeight(8);
  
  //  SAFETY FIRST!
  stroke(0xCCEF20);
  
  //  let us begin
  myMovie = new Movie(this, VIDEO_NAME);
  myMovie.loop(); 
  myMovie.volume(0);

  cX = (int) width/2;
  cY = (int) height/2;

  bg = get(0,0,width, height);

}


// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
  txtImg = m;
}


/* ------------------------------------------------------------------------- */
void draw() {

        camera();
        lights(); //    because P3D


  
      if(frameCount%2==0)
      {
        bg.filter(INVERT);
        line(0,random(height),width, random(height));
      } 
      else 
      {
        bg.filter(OPAQUE);
        line(random(width),0, random(width), height);
      }
      

    //  w = h * 1.8
    //  increment by 8 until > sz  h
    h = sz;
    w = h * 1.8;


      // TODO: NEIL BLENDER IT!!!
pushMatrix();
translate(0,0,0);
    tint(255, 11);
    txtImg.blend(bg, 0,0,width,height, 0, 0,width,height, REPLACE);
    scale(-1,-1);
    blend(bg, 0,0,width,height, 0, 0,width,height, REPLACE);
    
    tint(255, 11);
    image(txtImg, cX,cY,width,height);
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
        myJous = shapeJous( cX,cY, sz, STOP_SZ );
        myJous.setTexture(txtImg);
      endShape(CLOSE);
  
  
    //  BOX
    pushMatrix();
      translate(cX,cY, 0);
//tint(0xCCEF20,20);
      rotateY(sz);
      rotateZ(frameCount);
      shape(myBox);
      shape(mySphere);
      shape(myJous);
    popMatrix();
  
  
    if(sz>STOP_SZ)
    {
      //sz -= STOP_SZ;
      sz -= PI;
    }
    else
    {
      doExit();
    }
    

  
    //saveFrame( "frames/pshapes#######.tif");  //  USE .TIF IF COLOR or TO BE GLITCHED
    //  FFMPEG doesn't like these .tif????
    
    saveFrame( "frames/pshapes#######.png");  //  USE .PNG IF NEEDING SPACE
    //  GRAB A SCREENSHOT
    bg = get(0,0,width,height);
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
        if( ( inc < 1 ) || ( inc > 36 ) ) {
            inc = 1;
        }

        PShape shp = createShape();
        shp.beginShape(POLYGON);

        float x, y;

        for ( int t = 0; t <= 160  ; t+=inc)  //  160 is the NEW hotness -> slightly less points, no blank frames 9-36
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
