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
  // The file "bot.obj" must be in the data folder
  // of the current sketch to load successfully
  // s = loadShape("export.obj");

  // childCt = s.getChildCount();

  strokeWeight(PI);
}


void draw() {

	smooth();
	lights();

	if( frameCount == 1 ){
	  beginRaw( DXF, fix.pdeName() +".dxf" );
	}


	pushMatrix();
		translate(width/2, height/2, frameCount);

		rotateX(frameCount);
		rotateY(frameCount);
		rotateZ(frameCount);
		
		beginShape(POLYGON);
			// shape(s, 0, 0);

			// box(200);
			sphereDetail(frameCount*3,frameCount*3);
			sphere(frameCount*24);
/*
// loop through kids
for( int cc = 0; cc < childCt; cc++){

  stroke(random(255));

  for (int i = 0; i < s.getChild(cc).getVertexCount(); i++) {
      PVector v = s.getChild(cc).getVertex(i);
      // v.x += random(-1, 1);
      // v.y += random(-1, 1);
      // s.setVertex(i, v);
      vertex( v.x, v.y, v.z );
  
    }
}
*/
		endShape(CLOSE);

	popMatrix();

	if(frameCount==numFrames){
	    endRaw();

	    save( fix.pdeName()+".png");

	    noLoop();
	    exit();
	}
}