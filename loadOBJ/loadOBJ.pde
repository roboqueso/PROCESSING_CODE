import processing.opengl.*;
import processing.dxf.*;
// https://github.com/ericfickes/FIXLIB  
import fixlib.*;

PShape s;
int numFrames = 4;
int childCt;

Fixlib fix = Fixlib.init(this);

void setup() {
  background(-1);
  size(640, 480, P3D);
  smooth();

  // The file "bot.obj" must be in the data folder
  // of the current sketch to load successfully
  s = loadShape("export.obj");

  childCt = s.getChildCount();


}


void draw() {


  pushMatrix();
  translate(width/2, height/2, frameCount);


  beginShape(POLYGON);

    // loop through kids
    for( int cc = 0; cc < childCt; cc++){
        
      for (int i = 0; i < s.getChild(cc).getVertexCount(); i++) {
                
          PVector v = s.getChild(cc).getVertex(i);
          // v.x += random(-1, 1);
          // v.y += random(-1, 1);
          // s.setVertex(i, v);

            vertex( v.x, v.y, v.z );
        }
    }
  endShape();

  popMatrix();

  println("DONE");
  noLoop();
}