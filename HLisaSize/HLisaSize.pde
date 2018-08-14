/*
HLisaSize  : square one starting point P5/HYPE template sketch
*
Make a 4 x 4 gridlayout showing the differences in shape rendering vs lisa() code rendering

------------------------------------------------------
HRect      | P5 rect()     | HPath.lisa() | P5 lisa()
------------------------------------------------------
HEllipse    | P5 ellipse() | HPath.lisa() | P5 lisa()
------------------------------------------------------
HBox?      | P5 box()     | HPath.lisa() | P5 lisa()
------------------------------------------------------
HSphere? | P5 sphere() | HPath.lisa() | P5 lisa()
------------------------------------------------------


Get LISA() size code dialed in to match HYPE sizing

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
int colCt = 4;
int rowCt = colCt;
int colSpacing = 24;
int drawW, drawH; //  HDrawable Width / Height

/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(1280, 720, P3D); //"processing.opengl.PGraphics3D");
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
  H.init(this).background(-1);  //.use3D(true);

  pool = new HDrawablePool(colCt*rowCt);
  pool.autoAddToStage()
//TODO: figure out how to convert PShape to HShape before bringing HPath back into the mix
    //.add ( new HPath() )    
    //.add ( new HRect() )
    .add ( new HShape("scribble.svg") )


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

          //  OBJ TYPE CHECK
          //TODO: is there a smarter way to detect which child we're on?
          if(obj instanceof HRect) {
            println(obj + " == HRect");  
            HRect r = (HRect)obj;
            r
              .size( drawW, drawH )
              .noFill()
              .stroke( (int) r.x()%255, (int) r.y()%255, (int) r.z()%255 )
              .anchorAt(H.CENTER)
            ;

          }

          //  HShape
          else if(obj instanceof HShape)  {
            println(obj + " == HShape");
            
            //  get incoming HShape
            //HShape sh = (HShape) obj;
/*
// debug
println("sh.x(), sh.y(), drawH = " + sh.x() + " ," +  sh.y() + ", " + drawH );

            //  get PShape from FIXLIB
            PShape p = fix.shapeJous( sh.x(), sh.y(), drawH, 8 );

            //  reuse 
            sh = new HShape("scribble.svg");

            sh
              .scale(.5)
              .strokeWeight(2)
              .noFill()
              .stroke( (int)random(255) )
              .anchorAt(H.CENTER);

            obj = sh;

// DEBUG
//println("p vt ct : " + p.getVertexCount() );
//println("sh vt ct : " + sh.shape().getVertexCount() ); 
//println("obj vt ct : " +((HShape)obj).shape().getVertexCount() ); 
            
            //  cleanup
            sh = null;
            //p = null;
 */          
          }
          //  HPath
          else if(obj instanceof HPath)  {
            
            println(obj + " == HPath");  
            HPath p = (HPath)obj;
            p
              .lisa( p.x(), p.y(), drawH, (int)random(3,35) )
              .strokeWeight(2)
              .noFill()
              .stroke( (int)random(255) )
              .anchorAt(H.CENTER)
            ;
          }
          else{
            println("UNKNOWN type: " + obj);
          }


          

        


        }
      }
    )

    .requestAll()
  ;

  H.drawStage();
}





/* ------------------------------------------------------------------------- */
void draw() {

  /*
  // 3D code
  hint(DISABLE_DEPTH_TEST);
  camera();
  lights(); //    because P3D

  ambientLight(ct,ct,ct);
  emissive(ct,ct,ct);
  specular(ct,ct,ct);
  */

  if(frameCount>43)doExit();

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