/*
HUNT FOR HOT OBJS

TriangleStrip16S
OG: http://fix400.tumblr.com/post/74207786552/trianglestrip

*/
import fixlib.*;
import nervoussystem.obj.*;


Fixlib fix = Fixlib.init(this);
String SAVE_NAME = "thisShouldBeDynamic";
float cX, cY;


/* ------------------------------------------------------------------------- */
//  major settings
float outerRad = 18;  //24;//min(width, height) * 0.4;
float innerRad = 9;  //11;//outerRad * 0.6;
float getRadder = 180; // increase radii by this much each pass
float pts = 180; //72; //8;
float rot = 360.0/pts;

//  internals
float angle = 0;
PVector pVec,pVec2,pVec3;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(1920, 1080);
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
  background(#EFEFEF);


  cX = width/2;
  cY = height/2;

  //  NEW TRICK - save sketch settings into output file name for revisiting
  //  with popular settings.
  //  Generate filename containing sketch settings meta NOW
  SAVE_NAME = fix.pdeName() + fix.getTimestamp();

}



/*****************************************************************************/
void draw() {

//  SKETCH HERE

  OBJExport obj = (OBJExport) createGraphics( width, height, "nervoussystem.obj.OBJExport", fix.pdeName()+".obj");
  obj.beginDraw();





while( outerRad < height ) {
 
  obj.beginShape(TRIANGLE_STRIP); 
    for (int i = 0; i < pts; i++) 
    {
      //  NEW TRICK
      pVec = fix.circleXY( cX, cY, outerRad, angle );
      obj.vertex( pVec.x, pVec.y, angle*noise(i+pts) );
      angle += rot;


      // NEW TRICK - reuse for innerRad
      pVec2 = fix.circleXY( pVec.x, pVec.y, innerRad*noise(i+pts), angle*noise(i+pts) );
      // obj.rotate(angle);
      obj.vertex( pVec2.x, pVec2.y, -pVec2.z );


      pVec3 = PVector.lerp(pVec, pVec2, i);
      // obj.rotate(angle);
      obj.vertex( pVec3.x, pVec3.y, -pVec3.z );

      angle += rot;
    }
  obj.endShape();
 
  //  make bigger
  innerRad += getRadder;
  outerRad += getRadder;
}

    obj.endDraw();
    obj.dispose();


    noLoop();
    doExit();
  
}



/* ------------------------------------------------------------------------- */
/*  NON - P5 BELOW  */
/* ------------------------------------------------------------------------- */

/**
  End of sketch closer
*/
void doExit(){
  /*
  String msg = "ERICFICKES.com ";
  //  stamp bottom right based on textSize
  fill(#EF1975);
  textSize(13);
  text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());
  
  save(SAVE_NAME+".png"); //  USE .TIF IF COLOR  
  */
  //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
