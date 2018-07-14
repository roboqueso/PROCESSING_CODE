/*
HSphereDetails : lay down a 3x3 grid of spheres and increment sphereDetail each items
* BLOOD-DRAGON : 1920 x 1071
* size(displayWidth, displayHeight, P3D)
* HDR w, h is 2x1 EX: 2048, 1024
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

int gridX,gridY;
int colCt = 3;
int rowCt = colCt;  //  NOTE: remember to update this value
int colSpacing = 0;
int drawW, drawH; //  HDrawable Width / Height

/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(displayWidth, displayHeight, P3D); //"processing.opengl.PGraphics3D");
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */

void setup() {

  //  init VARIABLES
  drawW = (int)( (width-(colSpacing))/colCt)-colSpacing;
  drawH = (int)( (height-(colSpacing))/rowCt)-colSpacing;
  gridX = (drawW/2)+colSpacing;
  gridY = (drawH/2)+colSpacing;

  //  init HYPE
  H.init(this).background(-1).use3D(true);

  pool = new HDrawablePool(colCt*rowCt);
  pool.autoAddToStage()
    
    .add (

      // swap this out with something else
      new HSphere()
    )

    .layout (
      new HGridLayout()
      .startLoc(gridX, gridY)
      .spacing( drawW+colSpacing, drawH+colSpacing, colSpacing )
      .cols(colCt)
      .rows(rowCt)
    )

    .onCreate (
       new HCallback() {
        public void run(Object obj) {

          //  DO STUFF HERE

//	TODO: lay down an HSPHERE? changing sphereDetail( pool.currentIndex*3 )
/*
          HDrawable d = (HDrawable) obj;
          d
            .size( drawW, drawH)
            .noFill()
            .stroke( (int) d.x()%255, (int) d.y()%255, (int) d.z()%255 )
            .anchorAt(H.CENTER)
          ;
*/  
	

sphereDetail(3*pool.currentIndex());

// println("typeof: "+typeof);
HSphere hs = (HSphere)obj;
hs
.size( drawW, drawH, 0)
            .noFill()
            .stroke( (int) hs.x()%255, (int) hs.y()%255, (int) hs.z()%255 )
            .anchorAt(H.CENTER);

println("obj: "+obj);
//	debug
println("sphereDetails: "+ (3*pool.currentIndex()) );
 

        }
      }
    )

    .requestAll()
  ;

H.drawStage();

doExit();
  
}





/* ------------------------------------------------------------------------- */
void draw() {

	
  
  // 3D code
  // hint(DISABLE_DEPTH_TEST);
  // camera();
  // lights(); //    because P3D

  // ambientLight(ct,ct,ct);
  // emissive(ct,ct,ct);
  // specular(ct,ct,ct);
  

  // if(frameCount>43)doExit();

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

  save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  
  //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}