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
// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);


PVector pStart, pEnd, pt;
Integer pStep = 22;
ArrayList<PVector> fullPath;

void setup() {
	size(displayWidth, displayHeight);
	// background( loadImage("photo.jpg") );
	background(255, 0);
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
	
	// CURVE VERTEX

curveTightness(frameCount);

	stroke(random(42));
	strokeWeight(11);

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


	pStep = int(pStep+TWO_PI);
	// create start and end points
	pStart = new PVector( random(width), pStart.y+pStep );
	pEnd = new PVector( random(width), random(height));
	//	get path between points
	fullPath = fix.GeneratePath( pStart, pEnd, pStep);


	//	STOPPER
	if( pStart.y > height)
	{
		save( fix.pdeName() + fix.getTimestamp() + ".png");
		noLoop();
		exit();
	}

}
