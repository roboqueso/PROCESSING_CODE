import nervoussystem.obj.*;
import fixlib.*;
Fixlib fix = Fixlib.init(this);
// import processing.dxf.*;

/*
AR2019 seed incubator sketch

seed: NEW shapeJuan shape generator for stamp shapes

* amp : ideal sizes TBD
* inc :  only work with 9, 10, 12 and 20 as the lisaJous incrementor value

*/

    int cX, cY;
    int ct = 0, w = 81;    //51;
    int inc;
    int[] cts = { 4, 6, 9, 11, 13, 18, 20, 24, 35 };  // instead of sequential, only stick to approved incrementors
    int colCt = 1;
    PShape tmp = new PShape();
    PShape cShp = new PShape();
    int shapeX, shapeY;


    //  TODO: is there a smarter way to "get relative" when saving PNGs from a running PApplet?
    String OUT_TYPE = ".png";   // ".tif";
    String PNG_OUT = "";
    String msg = "ericfickes.com";


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @Override
    public  void  settings ()  {
        // size(612, 460, P3D);
        size(1836, 1380, P3D);
        smooth(8);
        pixelDensity(displayDensity());
        sketchSmooth();
    }


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    public  void  setup ()  {

        setupStage();

        //  setup variables
        cX = width/2;
        cY = height/2;

        w = (int)(cY/colCt);

        

    }


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @Override
    public  void  draw ()  {
        background(-1);
        noFill();

        // NOTE: deck w/h
        shapeX = mouseX%612;
        shapeY = mouseY%460;
        inc = cts[ct];

        //  NOTE: keep the thin one HERE
        //  thin
        cShp = shapeJuan(shapeX, shapeY, w, ct); 
        pushMatrix();
            translate(cX, cY);//, 42);
            noFill();
            stroke(random(254,256), 9, 18);
            strokeWeight(9);
            shape(cShp);
        popMatrix();

        //  FATTY
        tmp = shapeJuan(shapeX, shapeY, w, ct); 
        pushMatrix();
            translate(cX, cY);//, -TWO_PI);
            noFill();
            stroke(0);
            strokeWeight(100);
            shape(tmp);
        popMatrix();



        ////  stamp bottom right based on textSize
        //  NEW RIGHT VERTICAL STAMP
        pushMatrix();
            textAlign(CENTER,BOTTOM);
            fill(180);
            textSize(75);
            msg = "(" + shapeX +"-"+ shapeY +"-"+ w +"-"+ inc + ")";

            translate(width-TWO_PI, cY);
            rotate(-HALF_PI);
            text(msg,0,0);
        popMatrix();
    }


    ////////////////////////////////////////////////////////////////////////////////////////
    void doCircle( PShape cs ){

println("hi: "+cs);

        for(int aa = 1; aa < 361; aa++){
            PVector pt = fix.circleXY( cX, cY, 44, aa );
            
            pushMatrix();
            translate(pt.x, pt.y, pt.z);
                // rotateX(aa);
                
stroke(random(255));
                // cs.scale(.1);

                shape(cs);

            popMatrix();
        }
        // endRaw();
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    void mouseClicked() {
        // beginRaw(DXF, "output.dxf");
        println( "(" + shapeX +"-"+ shapeY +"-"+ w +"-"+ ct + ")");

      pushMatrix();
          ////  stamp bottom right based on textSize
          fill(0);
          textSize(75);
          msg = "(" + shapeX +"-"+ shapeY +"-"+ w +"-"+ ct + ")";
          //  OG BOTTOM RIGHT STAMP
          //text(msg, width-(textWidth(msg)+textAscent())+24, height-textAscent()+24);
          //  NEW RIGHT VERTICAL STAMP
          textAlign(CENTER,BOTTOM);

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
            break;

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