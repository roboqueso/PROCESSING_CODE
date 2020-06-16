/*
ALPHA  : square one starting point P5/HYPE template sketch
* BLOOD-DRAGON : 1920 x 1071
* size(displayWidth, displayHeight, P3D)
* HDR w, h is 2x1 EX: 2048, 1024

if(color)
  GO TIFF
  TIFF = Tagged Image File Format. This is one of the most complex image formats, and it can hold more kinds and depth of information than almost any other format. The standard is owned and maintained by Adobe.
else
  PNG


*/

/* ------------------------------------------------------------------------- */
Fixlib fix = Fixlib.init(this);
float sz = 8;
float w, h;
float cX, cY;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(3840,2160, P3D); //  always use P3D!!!
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */

void setup() {
  frameRate(60);
  background(255);
  noFill();
  strokeWeight(4);
  cX = width/2;
  cY = height/2;
}





/* ------------------------------------------------------------------------- */
void draw() {

  //  w = h * 1.8
  //  increment by 8 until > sz  h
  h = sz;
  w = h * 1.8;
  stroke( (frameCount % 2 == 0 ? 0 : color(255,0,0) )); 
  
  //  RUN versions with all the primitives
  ellipse( cX, cY, w, h );
  //  save frame  
  saveFrame( "ellipse_######.tif");  //  USE .TIF IF COLOR  
  
  //rect( cX, cY, w, h, sz);
  //saveFrame( "rect_######.tif");  //  USE .TIF IF COLOR



  if(sz<width)
  {
    sz +=8;
  }
  else
  {
    exit();
  }
}







/* ------------------------------------------------------------------------- */
/*  NON - P5 BELOW  */
/* ------------------------------------------------------------------------- */

/**
  End of sketch closer
*/
void doExit(){
  String msg = "ericfickes.com";
  //  stamp bottom right based on textSize
  fill(0);
  textSize(16);
  text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());

  save( fix.pdeName() + "-" + fix.getTimestamp()+"_FINAL.png" );    //  USE .TIF IF COLOR  
  
  //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
