//  HDoubleJousDXF
//  - HYPE
//  - double JOUS comparison
//  - SAVE to DXF
//  "gitirdun" mode

/*
HLisaSize  : square one starting point P5/HYPE template sketch
*
Make a 4 x 4 gridlayout showing the differences in shape rendering vs drawLissajous()) code rendering

------------------------------------------------------
HRect      | P5 rect()     | HPath.drawLissajous()) | P5 drawLissajous())
------------------------------------------------------
HEllipse    | P5 ellipse() | HPath.drawLissajous()) | P5 drawLissajous())
------------------------------------------------------
HBox       | P5 box()     | HPath.drawLissajous()) | P5 drawLissajous())
------------------------------------------------------
HSphere? | P5 sphere() | HPath.drawLissajous()) | P5 drawLissajous())
------------------------------------------------------


Get drawLissajous()) size code dialed in to match HYPE sizing

*/

// NOTE: this sketch updated from machine running legacy HYPE.HPath.drawLissajous()
//  NOT HYPE.HPath.lisa()
//  quick n dirty - gitirdun .dxf
//  shapeJous() vs drawLissajous()


import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

import processing.opengl.*;
import processing.dxf.*;
import fixlib.*;

/* ------------------------------------------------------------------------- */
Fixlib fix = Fixlib.init(this);
HDrawablePool pool;

PShape pp;
HShape sh;

int gridX,gridY;
int colCt = 4;
int rowCt = colCt;
int colSpacing = 10;
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
  // TODO: grid layout start will fluctuate?
  gridX = drawW/2+colSpacing;  //drawW/2-colSpacing;
  gridY = drawH/2+colSpacing;

  //  init HYPE
  H.init(this).background(-1).use3D(true);

  pool = new HDrawablePool(colCt*rowCt);
  pool.autoAddToStage()

    //.add ( new HBox() )    
    .add ( new HPath() )    
    //.add ( new HRect() )
    
    //  TODO: why is this the only way that HSHape( PShape ) works???
    //.add ( new HShape( fix.shapeJous( drawW, drawH, 43, 8 )  ) )

    .layout (
      new HGridLayout()
      .startLoc(gridX, gridY)
      .spacing( drawW+colSpacing, drawH+colSpacing, colSpacing )
      .cols(colCt)
      .rows(rowCt)
    )

//.spacing( drawW+colSpacing, drawH+colSpacing, colSpacing )

    .onCreate (
       new HCallback() {
        public void run(Object obj) {

          //  DO STUFF HERE
          //  OBJ TYPE CHECK
          //TODO: is there a smarter way to detect which child we're on?
          
          //  HBox
          if(obj instanceof HBox) 
          {
            println(obj + " == HBox");  
            HBox d = (HBox) obj;
              d
              .depth(random(drawH))
              .width(drawW)
              .height(drawH)
              .stroke( (int) d.x()%255, (int) d.y()%255, (int) d.z()%255 )
              .fill((int)random(255),43)
              .strokeWeight(2)
              .anchorAt(H.CENTER);

          }

          //  HPath
          else if(obj instanceof HPath)  {
            
            println(obj + " == HPath");  
            HPath p = (HPath)obj;
// TODO: figure out modulo to use HPath.drawLissajous()) or HPath + vertices from PShape
if( p.x() % 2 == 0 ) {

 // debug
 println("FIX.SHAPEJOUS");
  
          //  Generate PShape then convert to HPath
          pp = fix.shapeJous( p.x(), p.y(), drawH, (int)random(8,16) );
            
          PVector vv;  // used in loop and style
          for (int i = 0; i < pp.getVertexCount(); i++) {
            vv = pp.getVertex(i);
            p.vertex( vv.x, vv.y );
          }

          // style it differently
          vv = pp.getVertex( (int)(pp.getVertexCount()/2) );
          p
            .strokeWeight(2)
            .fill((int)random(255),43)
            .stroke( (int)vv.x%255, (int) vv.y%255, (int) vv.z%255 )
            .anchorAt(H.CENTER)
            ;
}
else
{
  // debug
 println("HPath.drawLissajous"); 
  
  
            p.drawLissajous( p.x(), p.y(), drawH )//, (int)random(8,16) )
              .strokeWeight(2)
              .noFill()
              .stroke( (int)random(11,69) )
              .anchorAt(H.CENTER)
            ;
}              


          }
          
          //  HRect
           else if(obj instanceof HRect) {
            println(obj + " == HRect");  
            HRect r = (HRect)obj;
            r
              .size( drawW, drawH )
              .fill((int)random(255),43)
              .strokeWeight(2)
              .stroke( (int) r.x()%255, (int) r.y()%255, (int) r.z()%255 )
              .anchorAt(H.CENTER)
            ;

          }



          //  HShape
          else if(obj instanceof HShape)  {
            println(obj + " == HShape");
            
            //  get incoming HShape
            sh = (HShape) obj;


// debug
println("sh.x(), sh.y(), drawH = " + sh.x() + " ," +  sh.y() + ", " + drawH );

            //  get PShape from FIXLIB
            //pp = fix.shapeJous( sh.x(), sh.y(), drawH, 8 );
            
// debug
println( "vt ct : " + sh.shape().getVertexCount() );
            
            sh.shape( fix.shapeJous( sh.x(), sh.y(), drawH, 8 ) );

// debug
println( "vt ct2 : " + sh.shape().getVertexCount() );

            sh
              .strokeWeight(2)
              .fill((int)random(255),43)
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

          }
          else{
            println("UNKNOWN type: " + obj);
          }


          

        


        }
      }
    );

   // .requestAll()
  //;

  //H.drawStage();

}





/* ------------------------------------------------------------------------- */
void draw() {

if( frameCount <= 1 ){
  beginRaw( DXF, fix.pdeName() + "-" + fix.getTimestamp()+".dxf" );
}

  // 3D code
  hint(DISABLE_DEPTH_TEST);
  camera();
  lights(); //    because P3D
  /*
  ambientLight(ct,ct,ct);
  emissive(ct,ct,ct);
  specular(ct,ct,ct);
  */

  scale(.43);
  pool.request();
  H.drawStage();

    //  chill
  delay(pool.count());

  //  bounce
  if(frameCount> pool.count() )doExit();

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

  endRaw();

  save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  
  //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
