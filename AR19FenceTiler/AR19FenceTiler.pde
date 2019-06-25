/*

MAKE FAT PIECE FOR FENCE WOOD

w:  20"
h:  5"

*/
//import processing.dxf.*;
import processing.pdf.*;
import fixlib.*;
Fixlib fix = Fixlib.init(this);
int bumpRight = 44;
boolean record;

    int cX, cY;
    int ct = 0, w = 81;    //51;
    int inc;
    // int[] cts = { 2, 4, 5, 8, 9, 10, 12, 15, 18 };  // AR19 yr9 incrementors
    int[] cts = { 3, 6, 9, 18 };  // AR19 yr9 incrementors
    int colCt = 10;
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
        size(1440, 360, P3D);  //  DXF or PDF
        smooth(8);
        pixelDensity(displayDensity());
        sketchSmooth();

    }


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    public  void  setup ()  {
        setupStage();

        //  setup variables
        cX = (width/2);
        cY = height/2;

        w = height-200; //(int)(cY/colCt)-81;
        ct = 0;
        inc = cts[ct];
    }


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @Override
    public  void  draw ()  {
     

    if (record) {
        // beginRaw(DXF, PNG_OUT + fix.pdeName() + shapeX +"-"+ shapeY +"-"+ w +"-"+ ct + ".DXF");
        beginRecord( PDF, PNG_OUT + fix.pdeName() + shapeX +"-"+ shapeY +"-"+ w +"-"+ inc + ".PDF");
    }
      
        background(#EFEFEF);
        noFill();
        //  NEW: incrementor MODs mouseX / mouseY so shape hunting isn't so eratic
        if(mouseX%cts[ct]==0){
            shapeX = mouseX%width;
        }
        if(mouseY%cts[ct]==0){
            shapeY = mouseY%width;
        }
        inc = cts[ct];

        stroke(0);
        strokeWeight(44);
        // drawRingShallow();
        //  FATTY
        tmp = curveJuan(shapeX, shapeY, w, inc); 
        for(int cc = 0; cc < colCt; cc++ ){
            shape(tmp, cc*w, cY);
        }

        stroke(255);
        strokeWeight(9);
        // drawRingDeep();
        //  thin
        cShp = curveJuan(shapeX, shapeY, w, inc);
        // shape(cShp, cX, cY);
        for(int cc = 0; cc < colCt; cc++ ){
            shape(cShp, cc*w, cY);
        }

if (record) {
    println("RECORDING");
    doStampAndSave();
}

System.gc();

    }


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    void drawRingDeep()
    {
        int oW = (int)(w*2);
        int iW = (int)(w*1.8);
    
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

        msg = "~FJD/AR19_" + shapeX +"."+ shapeY +"."+ w +"."+ inc;
        println( msg );

        //  end DXF
        // endRaw();


        //  end PDF
        endRecord();

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
        save(  PNG_OUT + fix.pdeName() + shapeX +"-"+ shapeY +"-"+ w +"-"+ inc + OUT_TYPE);
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



    // ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // /**
    //  *  STILL NORMING
    //  * @param a X
    //  * @param b Y
    //  * @param amp "amplitude"
    //  * @param inc incrementor, "slicer of the max point count : typically 360/inc"
    //  * @return PShape
    //  */
    // private PShape shapeJuan( float a, float b, float amp, int inc )
    // {
    //     //  PROTOTYPING : trying to locate universal ideal INCrementor for lisajouss loop
    //     //  Ideal range is someplace between 1 and 36
    //     if( ( inc < 1 ) || ( inc > 36 ) ) {
    //         inc = 1;
    //     }

    //     PShape shp = createShape();
    //     shp.beginShape();

    //     float x, y;

    //     for ( int t = 0; t <= 90; t+=inc)  //  180 instead of 360?
    //     {
    //         //  NEW HOTNESS!
    //         // x = a - amp * cos((a * t * TWO_PI)/360);
    //         // y = b - amp * sin((b * t * TWO_PI)/360);
    //         // x = a - amp * cos((a * t * TWO_PI)/180);
    //         // y = b - amp * sin((b * t * TWO_PI)/180);
    //         x = amp * cos((a * t * TWO_PI)/180);
    //         y = amp * sin((b * t * TWO_PI)/180);

    //         //  Z mods INC
    //         // shp.vertex(x, y, t%inc);
    //         shp.vertex(x, y);
    //     }
    //     shp.endShape();

    //     return shp;
    // }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /**
     *  STILL NORMING
     * @param a X
     * @param b Y
     * @param amp "amplitude"
     * @param inc incrementor, "slicer of the max point count : typically 360/inc"
     * @return PShape
     */
    private PShape curveJuan( float a, float b, float amp, int inc )
    {
        //  PROTOTYPING : trying to locate universal ideal INCrementor for lisajouss loop
        //  Ideal range is someplace between 1 and 36
        if( ( inc < 1 ) || ( inc > 36 ) ) {
            inc = 1;
        }

        PShape shp = createShape();
        shp.beginShape();

        float x, y;

        for ( int t = 0; t <= 180; t+=inc)  //  180 instead of 360?
        {
            //  NEW HOTNESS!
            // x = amp * cos((a * t * TWO_PI)/360);
            // y = amp * sin((b * t * TWO_PI)/360);
            // x = amp * cos((a * t * TWO_PI)/180);
            // y = amp * sin((b * t * TWO_PI)/180);
            x = amp * cos((a * t * TWO_PI)/180);
            y = amp * sin((b * t * TWO_PI)/180);

            //  Z mods INC
            // shp.vertex(x, y, t%inc);
            // shp.vertex(x, y);
            shp.curveVertex(x, y);
        }
        shp.endShape();

        return shp;
    }
