
import nervoussystem.obj.*;
//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);


  // see: https://processing.org/reference/PVector_fromAngle_.html
  
PShape s;
float x, y;
ArrayList<PVector> original;
int fc;
OBJExport obj;
int shpMaxAngle = 360;  //  360 makes a circle
int objMaxShapeCt = 44;  //  how many times to drop the shape into the OBJ

void settings()
{
  size(1024, 768, P3D );
  smooth(8);
  pixelDensity(displayDensity());

}

void setup() {
    x = width/2;
    y = height/2; 

    // The "original" locations of the vertices make up a circle
    original = new ArrayList<PVector>();

    //  MAKE THE VECTORS USING fromAngle
    for (float a = 1; a < shpMaxAngle; a++) { 
      PVector v = PVector.fromAngle(a);
      v.mult(200);
      original.add(v);
    }
    
    //  MAKE THE PSHAPE
    s = createShape();
    s.beginShape();
    s.noFill();
    s.stroke(0);
    // s.strokeWeight(2);
    for (PVector v : original) {
      s.vertex(v.x, v.y);
    }
    s.endShape(CLOSE);

  
    //  BEGIN THE OBJ PROCESS
    OBJExport obj = (OBJExport) createGraphics( width, height, "nervoussystem.obj.OBJExport", fix.pdeName()+fix.getTimestamp()+".obj");
    obj.beginDraw();

    //  BAKE THE OBJ -------------------------------

    for(int fc = 1; fc <= objMaxShapeCt; fc++){
      obj.translate(fc, y);
      

      obj.beginShape();

      for (PVector v : original) {
        obj.vertex(v.x, v.y, 1);
 
        obj.rotateX(fc *90 );
        obj.rotateY(fc *90 );

       obj.vertex(v.x, v.y, -1);
   }
  
    obj.endShape(CLOSE);

    }


    //  END BAKE THE OBJ -------------------------------

    obj.endDraw();
    obj.dispose();
    obj = null;

    //  TODO: how do you squeeze an image out of the NervousSystem.OBJ?
    //save(this+".png");

exit();
  
}
