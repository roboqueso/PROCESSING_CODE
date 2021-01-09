//  SEE:   https://ello.co/ericfickes/post/0uf5njq3mklyjwmoc2lifq
//  GOTO:  https://github.com/ericfickes/FIXLIB
//  HypeObj.pde : Export HYPE sketches as OBJ
import nervoussystem.obj.*;

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
int colCt = 10;
int rowCt = colCt;  //  NOTE: remember to update this value
int colSpacing = 20;  
int drawW, drawH; //  HDrawable Width / Height
String saveName;

PShape box, square, sphere;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    size( 720, 720, P3D); //"processing.opengl.PGraphics3D");
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */

void setup() {
  sphereDetail(3);
  rectMode(CENTER);
  ellipseMode(CENTER);

  //  init VARIABLES
  drawW = (int)( (width-(colSpacing))/colCt)-colSpacing;
  drawH = (int)( (height-(colSpacing))/rowCt)-colSpacing;
  gridX = (drawW/2)+colSpacing;
  gridY = (drawH/2)+colSpacing;
  saveName = fix.pdeName() + "-" + fix.getTimestamp();
this.beginRecord("nervoussystem.obj.OBJExport", saveName+".obj");

  //  init HYPE
  H.init(this).background(H.CLEAR).use3D(true).autoClear(false);
  

  pool = new HDrawablePool(colCt*rowCt);
  pool.autoAddToStage()
    
    .add (

      // swap this out with something else
      new HBox()
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
          HBox d = (HBox) obj;
          d
            .size( drawW, drawH )
            .z(drawW+ (pool.currentIndex()+PI))
            .noFill()
            .anchorAt(H.CENTER)
          ;
        

        //  NATIVE P5?
        //  createShape() https://processing.org/reference/createShape_.html

// kind  int: either POINT, LINE, TRIANGLE, QUAD, RECT, ELLIPSE, ARC, BOX, SPHERE
// p float[]: parameters that match the kind of shape
        // translate( d.x(), d.y(), 0 );
        


      square = createShape(QUAD,  d.x(), d.y(), 
                                  d.x()+drawW, d.y()+drawW , 
                                  d.y(), d.x(), 
                                  d.y()-drawW, d.x()-drawW ); 

      box = createShape(BOX, d.x(), d.y(), drawW+d.z()+pool.currentIndex() );
      sphere = createShape(SPHERE, 2*(1+pool.currentIndex()) );
  

        pushMatrix();
          translate( d.y(), d.z(), d.x() );

           shape(box, width/2, height/2);
           shape(square, width/2, height/2);

          //sphereDetail( (int)random(3,90) );
          sphereDetail(pool.currentIndex()%15);
          sphere(drawW);

          //sphereDetail( pool.currentIndex(), (int)(pool.currentIndex()+PI) );
          //shape(sphere, width/2, height/2);

          //sphereDetail( (int)random(3,colCt), colCt );
          sphere(drawW+colCt);


        popMatrix();

        }
      }
    );

}





/* ------------------------------------------------------------------------- */
void draw() {

pool.requestAll();
H.drawStage();

  /*
  //  save frame
  if(save_frame){
    saveFrame( fix.pdeName() + "-" + fix.getTimestamp() + "_##.png");  //  USE .TIF IF COLOR
  }
  */

  doExit();

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

  save( saveName+"_FINAL.png" );    //  USE .TIF IF COLOR  
  
  //  cleanup
  fix = null;
  
  noLoop();

  //  END OBJ
  this.endRecord();

  exit();
  System.gc();
  System.exit(1);
}
