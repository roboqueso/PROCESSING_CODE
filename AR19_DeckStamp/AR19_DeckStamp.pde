// import nervoussystem.obj.*;
import processing.dxf.*;
import fixlib.*;
Fixlib fix = Fixlib.init(this);

boolean record;
/*

a. FIGURE OUT export to DXF
* DXF NOT WORKING

b. merge back to AR19_DeckStamp


*/

    int cX, cY;
    int ct = 0, w = 81;    //51;
    int inc;
    int[] cts = { 4, 6, 9, 11, 13, 18, 20, 24, 35 };  // instead of sequential, only stick to approved incrementors
    int colCt = 1;
    PShape tmp = new PShape();
    PShape cShp = new PShape();
    PShape smallShp = new PShape();
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

        w = (int)(cY/colCt)-81;
        ct = 0;
    }


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @Override
    public  void  draw ()  {

      if (record) {
        beginRaw(DXF, PNG_OUT + fix.pdeName() + shapeX +"-"+ shapeY +"-"+ w +"-"+ ct + ".DXF");
      }
      
      
        background(#EFEFEF);
        noFill();

        // NOTE: deck w/h
        shapeX = mouseX%612;
        shapeY = mouseY%460;
        inc = cts[ct];

        stroke(0);
        strokeWeight(81);
        drawRingShallow();
        //  FATTY
        tmp = shapeJuan(shapeX, shapeY, w, ct); 
        shape(tmp, cX, cY);

        stroke(255);
        strokeWeight(9);
        drawRingDeep();
        //  thin
        cShp = shapeJuan(shapeX, shapeY, w, ct);
        shape(cShp, cX, cY);

if (record) {
    println("RECORDING");
    doStampAndSave();
}

    }


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    void drawRingDeep()
    {
        int oW = (int)(w*2.);
        int iW = (int)(w*1.75);
    
    beginShape();
        for( int aa = 0; aa < 361; aa+=2)
        {
            PVector pvI = fix.circleXY( cX, cY, iW, aa );
            PVector pvO = fix.circleXY( cX, cY, oW, aa );
            // point(pvO.x, pvO.y);
            vertex(pvI.x, pvI.y);
            vertex(pvO.x, pvO.y);
        }
    endShape(CLOSE);

    }



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    void drawRingShallow(){
        int oW = (int)(w*1.6);

    beginShape();
        
        for( int aa = 0; aa < 361; aa++)
        {
            PVector pvO = fix.circleXY( cX, cY, oW, aa);
            vertex(pvO.x, pvO.y);
        }

    endShape(CLOSE);
    }



    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    void doStampAndSave(){

        msg = "~FJD/AR19_" + shapeX +"."+ shapeY +"."+ w +"."+ ct;
        println( msg );

      pushMatrix();
        ////  stamp bottom right based on textSize
        fill(0);
        textSize(44);

        //  OG BOTTOM RIGHT STAMP
        textAlign(CENTER,BOTTOM);

        translate(width-24, cY);
        rotate(-HALF_PI);
        text(msg,0,0);
      popMatrix();

        //  end dxf
        endRaw();
        record = false;

        savePng();
        System.gc();
  }



    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    void mouseClicked() {

        // doStampAndSave();
        record = !record;
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

            case 'r':
            case 'R':
            {
                // record = !record;
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
