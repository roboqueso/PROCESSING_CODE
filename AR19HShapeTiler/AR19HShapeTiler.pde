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

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import fixlib.*;

/* ------------------------------------------------------------------------- */
Fixlib fix = Fixlib.init(this);
HDrawablePool pool;
HShape hs;
HGridLayout hgl;

int gridX, gridY;
int colCt = 2;
int rowCt = colCt;  //  NOTE: remember to update this value
int colSpacing = 0;
int drawW, drawH; //  HDrawable Width / Height
int cX, cY;
int ct = 0;
int w = 81;    //51;
int inc;
// int[] cts = { 9, 10, 12, 20 };  // instead of sequential, only stick to approved incrementors
int[] cts = { 5, 6, 7, 9, 11, 13, 18, 20, 34, 30 };  // instead of sequential, only stick to approved incrementors
PShape tmp = new PShape();
int shapeX, shapeY;


//  TODO: is there a smarter way to "get relative" when saving PNGs from a running PApplet?
String OUT_TYPE = ".png";   // ".tif";
String PNG_OUT = "";
String msg = "ericfickes.com";

/* ------------------------------------------------------------------------- */

void  settings () {
    // size(612, 460, P3D);
    size(1836, 1380, P3D);
    smooth(8);
    pixelDensity(displayDensity());
    sketchSmooth();
}

/* ------------------------------------------------------------------------- */

void setup() {

  //  init VARIABLES
  drawW = (int)( (width-(colSpacing))/colCt)-colSpacing;
  drawH = (int)( (height-(colSpacing))/rowCt)-colSpacing;
  gridX = (int)( drawW/2-colSpacing);
  gridY = (int)( drawH/2-colSpacing);
  cX = (int) width/2;
  cY = (int) height/2;

  //  init HYPE
  H.init(this).use3D(true);

  hs = new HShape();
  hgl = new HGridLayout()
      .startLoc(gridX, gridY)
      .spacing( drawW+colSpacing, drawH+colSpacing )
      .cols(colCt);

    pool = new HDrawablePool(colCt*rowCt);
    pool.autoAddToStage()

    .add ( hs )

    .layout ( hgl )

    .onCreate (
    new HCallback() {
    public void run(Object obj) {
println( "idx : " + pool.currentIndex() );
      //  DO STUFF HERE
      HDrawable d = (HDrawable) obj;
      d
        .noFill()
        .strokeWeight(TWO_PI)
        .size( drawW, drawH )
        //.scale(.9)
        //.anchorAt(H.CENTER)
        ;
        
        
      if( pool.currentIndex() == 1 || pool.currentIndex() == 3 )
      {
        d.scale(-1,-1);
        d.rotateX(-180);
      }
        
    }
  }
  );
}





/* ------------------------------------------------------------------------- */
void draw() {

  noFill();
  strokeWeight(TWO_PI);
  // NOTE: deck w/h
  shapeX = mouseX%612;
  shapeY = mouseY%460;
  inc = cts[ct];


  tmp = shapeJuan( shapeX, shapeY, drawW, inc );
  hs.shape(tmp);

  pool.requestAll();
  H.drawStage();

  pool.drain();
  pool.add(hs);
  hgl.resetIndex();



      ////  stamp bottom right based on textSize
      fill(180);
      textSize(75);
      msg = "(" + shapeX +"-"+ shapeY +"-"+ w +"-"+ inc + ")";
      //  OG BOTTOM RIGHT STAMP
      //text(msg, width-(textWidth(msg)+textAscent())+24, height-textAscent()+24);
      //  NEW RIGHT VERTICAL STAMP
      textAlign(CENTER,BOTTOM);
      pushMatrix();
        translate(width-TWO_PI, cY);
        rotate(-HALF_PI);
        text(msg,0,0);
      popMatrix();



}





    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    void mouseClicked() {
        
        println( "(" + shapeX +"-"+ shapeY +"-"+ w +"-"+ inc + ")");
        
      ////  stamp bottom right based on textSize
      fill(0);
      textSize(75);
      msg = "(" + shapeX +"-"+ shapeY +"-"+ w +"-"+ inc + ")";
      //  OG BOTTOM RIGHT STAMP
      //text(msg, width-(textWidth(msg)+textAscent())+24, height-textAscent()+24);
      //  NEW RIGHT VERTICAL STAMP
      textAlign(CENTER,BOTTOM);
      pushMatrix();
        translate(width-TWO_PI, cY);
        rotate(-HALF_PI);
        text(msg,0,0);
      popMatrix();

        savePng();

        System.gc();
    }



    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @Override
    public void keyPressed(){

        switch(keyCode){

            case ESC:{
                doExit();
            }
            break;

            //  GET A NEW INCREMENTOR
            case 'i':
            case 'I':
            {
                ct = (ct+1)%cts.length;

            }

            case 's':
            case 'S':
            {
                savePng();
            }
            break;
        }

    }


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /**
     * exit function
     */
    private void doExit(){
        noLoop();
        System.gc();
        exit();
    }


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /**
     * SAVE PNG helper
     */
    void savePng(){
        save(  PNG_OUT + fix.pdeName() + shapeX +"-"+ shapeY +"-"+ w +"-"+ ct + OUT_TYPE);
    }


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /**
     * Helper function to clear stage
     */
    private void setupStage() {

        //  reset stage
        background(-1);

        strokeCap(ROUND);
        strokeJoin(ROUND);
        strokeWeight(TWO_PI);

        noFill();

    }





    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /**
     *  STILL NORMING
     * @param a X
     * @param b Y
     * @param amp "amplitude"
     * @param inc incrementor, "slicer of the max point count : typically 360/inc"
     * @return PShape
     */
    private PShape shapeJuan( float a, float b, float amp, int inc )
    {
        //  PROTOTYPING : trying to locate universal ideal INCrementor for lisajouss loop
        //  Ideal range is someplace between 1 and 36
        if( ( inc < 1 ) || ( inc > 36 ) ) {
            inc = 1;
        }

        PShape shp = createShape();
        shp.beginShape();

        float x, y;

        for ( int t = 0; t <= 90; t+=inc)  //  180 instead of 360?
        {
            //  NEW HOTNESS!
            // x = a - amp * cos((a * t * TWO_PI)/360);
            // y = b - amp * sin((b * t * TWO_PI)/360);
            // x = a - amp * cos((a * t * TWO_PI)/180);
            // y = b - amp * sin((b * t * TWO_PI)/180);
            x = amp * cos((a * t * TWO_PI)/180);
            y = amp * sin((b * t * TWO_PI)/180);

            //  Z mods INC
            // shp.vertex(x, y, t%inc);
            shp.vertex(x, y);
        }
        shp.endShape();

        return shp;
    }
