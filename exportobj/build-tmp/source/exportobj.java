import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.opengl.*; 
import processing.dxf.*; 
import fixlib.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class exportobj extends PApplet {



// https://github.com/ericfickes/FIXLIB  


PShape s;
int numFrames = 4;
int childCt;

Fixlib fix = Fixlib.init(this);

public void setup() {
  background(-1);
  
  // The file "bot.obj" must be in the data folder
  // of the current sketch to load successfully
  s = loadShape("export.obj");

  childCt = s.getChildCount();

  strokeWeight(PI);
}


public void draw() {

	smooth();
	noFill();

	if( frameCount == 1 ){
	  beginRaw( DXF, fix.pdeName() +".dxf" );
	}


	pushMatrix();
		translate(width/2, height/2);

		rotateX(frameCount);
		rotateY(frameCount);
		rotateZ(frameCount);
		
		beginShape(POLYGON);
			// shape(s, 0, 0);

			// box(200);
			sphereDetail(frameCount*2);
			sphere(frameCount*24);

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

		endShape(CLOSE);

	popMatrix();

	if(frameCount==numFrames){
	    endRaw();

	    save( fix.pdeName()+".png");

	    noLoop();
	    exit();
	}
}
  public void settings() {  size(640, 480, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "exportobj" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
