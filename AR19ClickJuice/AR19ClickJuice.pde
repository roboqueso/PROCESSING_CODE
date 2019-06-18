import nervoussystem.obj.*;
import fixlib.*;
Fixlib fix = Fixlib.init(this);
/*
AR2019 seed incubator sketch

seed: NEW shapeJuan shape generator for stamp shapes

* amp : ideal sizes TBD
* inc :  only work with 9, 10, 12 and 20 as the lisaJous incrementor value

*/

    int cX, cY;
    int ct = 0, w = 81;    //51;
    // int[] cts = { 9, 10, 12, 20 };  // instead of sequential, only stick to approved incrementors
    int[] cts = { 5, 6, 7, 9, 11, 13, 18, 20, 34, 30 };  // instead of sequential, only stick to approved incrementors
    int colCt = 4;
    PShape tmp = new PShape();

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

        w = (int)(height/colCt);

        ct = cts[0];
    }


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @Override
    public  void  draw ()  {
        background(255);
        stroke(0);
        noFill();

        shapeX = mouseX;
        shapeY = mouseY;

        tmp = shapeJuan(shapeX, shapeY, w, ct); 

// translate(w, w, w);

        //  SHAPE1
        for(int rr = 0; rr < colCt; rr++ ){
            for(int cc = 0; cc < colCt; cc++ ){
                shape(tmp, w*cc, w*rr);
                //shape(tmp, (width/cc)*cc, (height/rr)*cc, w, w);

            }
        }

        //  OR
        /*
            translate(width/rr, height/cc, frameCount);
            beginShape();

                // FILL YOURSELF
                texture( get(shapeX, shapeY , w, w+rr+cc) );

                for(int vv = 0; vv < tmp.getVertexCount(); vv++ )
                {
                    PVector vect = tmp.getVertex(vv);

                    vertex( vect.x, vect.y, vect.z, vect.y, vect.x );
                }
            endShape(CLOSE);

        */
            

    /*
            //  SHAPE2  - G
            beginShape();

                stroke(frameCount%240);

                // FILL YOURSELF
                texture( get(xx,yy,width, w+ct) );

                for(int vv = 0; vv < tmp.getVertexCount(); vv++ )
                {
                    PVector vect = tmp.getVertex(vv);

                    vertex( vect.x, vect.y, vect.z, vect.y, vect.x );
                }
            endShape(CLOSE);


            //  SHAPE3
            //  do the FredV
            pushMatrix();

                // stroke(frameCount%240);

                translate(xx, yy, w);
                scale(random(.6f,4.2f));
                rotate(tmp.getVertexCount());

                shape(tmp);
            popMatrix();
    */


         
      ////  stamp bottom right based on textSize
      fill(#EFEFEF);
      textSize(75);
      msg = "(" + shapeX +"-"+ shapeY +"-"+ w +"-"+ ct + ")";
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
        
        println( "(" + shapeX +"-"+ shapeY +"-"+ w +"-"+ ct + ")");
        
      ////  stamp bottom right based on textSize
      fill(0);
      textSize(75);
      msg = "(" + shapeX +"-"+ shapeY +"-"+ w +"-"+ ct + ")";
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
                ct = cts[(int)random(cts.length)];

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
            x = a - amp * cos((a * t * TWO_PI)/180);
            y = b - amp * sin((b * t * TWO_PI)/180);

            //  TODO: test all logics below and remove what's not usable


//            double dt = Math.PI / 180;
//            int w = getWidth() / 2;
//            int h = getHeight() / 2;
//            path.reset();
//            path.moveTo(w, h);
//            for (double t = 0; t < 2 * Math.PI; t += dt) {
//                double x = w * Math.sin(5 * t) + w;
//                double y = h * Math.sin(4 * t) + h;
//                path.lineTo(x, y);
//            }

//function f(t) =
//[   cos(nx t + px) ,
//    cos(ny t + py),
//    cos(nz t + pz) vz
//];
//
//            where
//                    nx=3;
//                    ny=2;
//                    nz=7;
//
//            px=10; // by experiment
//            py=35;
//            pz=0;
//
//            vz=0.25; // vary to change height


//            a parametrized Lissajous curve defines as
//            y=sin(mt),
//            x=cos(nt)


//            cos(nt+τk)=cos(t)
//            cos(mt+τk)=cos(t)


//            A Lissajous curve with frequencies p,qp,q and phase cc is given by the parametrization
//            x(t)=cos(p t + c )
//            y(t)=cos(q t ).


//            X=r cos u cos2t−sin2 t cos t(1+rsinu);
//            Y=r cos u sin2t+cos2 t cos t(1+rsinu);
//            Z=s int(1+r sin u )Z=sin⁡t(1+rsin⁡u),



            //  MATT BERNHARDT
            //  https://www.openprocessing.org/sketch/57613#


            //  Z mods INC
            shp.vertex(x, y, t%inc);
        }
        shp.endShape();

        return shp;
    }


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
        shp.beginShape();

        float x, y;

        for ( int t = 0; t <= 360; t+=inc)
        {
            x = a - amp * sin((a * t * PI)/180);
            y = b - amp * sin((b * t * PI)/180);

            //  Z mods INC
            shp.vertex(x, y, t%inc);
        }
        shp.endShape();

        return shp;
    }
