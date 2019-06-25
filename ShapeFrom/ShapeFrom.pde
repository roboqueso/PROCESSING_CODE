import nervoussystem.obj.*;
import fixlib.*;
Fixlib fix = Fixlib.init(this);

  
  
  PShape s;
  // Its location
  float x, y;
  
  // For 2D Perlin noise
  float yoff = 0;
  
  // We are using an ArrayList to keep a duplicate copy
  // of vertices original locations.
  ArrayList<PVector> original;
int fc;
  OBJExport obj;

void settings()
{
  size(1024, 768, P3D );
  smooth(8);
  pixelDensity(displayDensity());

}

void setup() {
  frameRate(9);
    x = width/2;
    y = height/2; 

    // The "original" locations of the vertices make up a circle
    original = new ArrayList<PVector>();
    //for (float a = 1; a < 360; a++) {
    for (float a = 1; a < 9; a++) { 
      PVector v = PVector.fromAngle(a);
      v.mult(100);
      original.add(v);
    }
    
    // Now make the PShape with those vertices
    s = createShape();
    s.beginShape();
    s.noFill();
    //s.stroke(0);
    s.strokeWeight(2);
    for (PVector v : original) {
      s.vertex(v.x, v.y);
    }
    s.endShape(CLOSE);

  
    OBJExport obj = (OBJExport) createGraphics( width, height, "nervoussystem.obj.OBJExport", fix.pdeName()+fix.getTimestamp()+".obj");
    obj.beginDraw();

    for(int fc = 1; fc < 45; fc++){
      //obj.translate(fc*HALF_PI, y);
      obj.rotate(fc);
      obj.noFill();
    obj.beginShape();
    obj.noFill();
    //obj.stroke(0);
    obj.strokeWeight(2);
    
    for (PVector v : original) {
      obj.curveVertex(v.x, v.y);
  }
  
  //obj.rotateX(fc);
  //obj.rotateY(fc);
  
  //    for (PVector v : original) {
  //      //obj.translate(fc, y);
  //      obj.vertex(v.x, v.y);
  //  }
  
    obj.endShape(CLOSE);
      //obj.shape(s);
    }
    obj.endDraw();
    obj.dispose();
    obj = null;

    //  TODO: how do you squeeze an image out of the NervousSystem.OBJ?
    //save(this+".png");

exit();
  
}
