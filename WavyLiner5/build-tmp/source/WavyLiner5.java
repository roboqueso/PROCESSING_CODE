import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import fixlib.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class WavyLiner5 extends PApplet {

// https://github.com/ericfickes/FIXLIB	


Fixlib fix = Fixlib.init(this);

/*
liner

1. define start and stop points

2. calculate left to right coordinates between start and stop

3. return PVector[] fullPath[]

4. Draw path 

* increment starting Y to avoid overlaps

- ellipse

- vertex : http://processing.org/reference/vertex_.html

- bezierVertex : http://processing.org/reference/bezierVertex_.html

- curveVertex : http://processing.org/reference/curveVertex_.html

- quadraticVertex : http://processing.org/reference/quadraticVertex_.html

*/
///////////////////////////////////////////////////////
PVector pStart, pEnd, pt;
Integer pStep = 22;
ArrayList<PVector> fullPath;

public void setup() {
	
	// background( loadImage("photo.jpg") );
	background(21);
	strokeWeight(HALF_PI);
	
	noFill();

	// create start and end points
	pStart = new PVector( 0, random(pStep));
	pEnd = new PVector( width, random(height));
	//	get path between points
	fullPath = fix.GeneratePath( pStart, pEnd, pStep);

}

///////////////////////////////////////////////////////
public void draw() {
	
	// CURVE VERTEX
	curveTightness(frameCount);

	stroke(random(100));
	strokeWeight(9);

	ellipse(pStart.x, pStart.y, pStep, pStep);
	ellipse(pEnd.x, pEnd.y, pStep, pStep);

	beginShape();
		vertex( pStart.x, pStart.y  );
		for (int i = 0; i<fullPath.size(); i++)
		{
			pt = (PVector)fullPath.get(i);
			curveVertex(pt.x, pt.y);
		}
		vertex( pEnd.x, pEnd.y);
	endShape();



	stroke(random(255),random(155),random(55));
	strokeWeight(PI);

	ellipse(pStart.x, pStart.y, pStep, pStep);
	ellipse(pEnd.x, pEnd.y, pStep, pStep);

	beginShape();
		vertex( pStart.x, pStart.y  );
		for (int i = 0; i<fullPath.size(); i++)
		{
			pt = (PVector)fullPath.get(i);
			curveVertex(pt.x, pt.y);
		}
		vertex( pEnd.x, pEnd.y);
	endShape();


	pStep = PApplet.parseInt(pStep+TWO_PI);
	// create start and end points
	pStart = new PVector( random(width), pStart.y+pStep );
	pEnd = new PVector( random(width), random(height));
	//	get path between points
	fullPath = fix.GeneratePath( pStart, pEnd, pStep );


	//	STOPPER
	if( pStart.y > height)
	{
		fill(0xffEFEFEF);
		text("ericfickes.com", width-100, height-11);
		save( fix.pdeName() + fix.getTimestamp() + ".png");
		noLoop();
		exit();
	}

}
  public void settings() { 	size(displayWidth, displayHeight); 	smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "WavyLiner5" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
