import nervoussystem.obj.*;
// https://github.com/ericfickes/FIXLIB	
import fixlib.*;
OBJExport obj;
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

void setup() {
	size(900,900);
	// background( loadImage("photo.jpg") );
	background(21);
	strokeWeight(HALF_PI);
	smooth();
	noFill();

	// create start and end points
	pStart = new PVector( 0, random(pStep));
	pEnd = new PVector( width, random(height));
	//	get path between points
	fullPath = fix.GeneratePath( pStart, pEnd, pStep);
}

///////////////////////////////////////////////////////
void draw() {
  OBJExport obj = (OBJExport) createGraphics( width, height, "nervoussystem.obj.OBJExport", fix.pdeName()+".obj");
  obj.beginDraw();
	
	// CURVE VERTEX
	// curveTightness(frameCount);

	// obj.stroke(random(100));
	// obj.strokeWeight(9);

	obj.ellipse(pStart.x, pStart.y, pStep, pStep);
	obj.ellipse(pEnd.x, pEnd.y, pStep, pStep);

	obj.beginShape();
		obj.vertex( pStart.x, pStart.y  );
		for (int i = 0; i<fullPath.size(); i++)
		{
			pt = (PVector)fullPath.get(i);
			obj.curveVertex(pt.x, pt.y, pt.z);
	 	}
	obj.vertex( pEnd.x, pEnd.y);
	obj.endShape();



	obj.beginShape();
		obj.vertex( pStart.x, pStart.y  );
		for (int i = 0; i<fullPath.size(); i++)
		{
			pt = (PVector)fullPath.get(i);
			obj.curveVertex(pt.y, pt.x, pt.z);
		}
		obj.vertex( pEnd.x, pEnd.y);
	obj.endShape();
    obj.endDraw();
    obj.dispose();

obj = null;

/*
	pStep = int(pStep+TWO_PI);
	// create start and end points
	pStart = new PVector( random(width), pStart.y+pStep );
	pEnd = new PVector( random(width), random(height));
	//	get path between points
	fullPath = fix.GeneratePath( pStart, pEnd, pStep );
*/

	//	STOPPER
	// if( pStart.y > height)
	// {
		// fill(#EFEFEF);
		// text("ericfickes.com", width-100, height-11);
		save( fix.pdeName() + fix.getTimestamp() + ".png");
		noLoop();
		exit();
	// }

}
