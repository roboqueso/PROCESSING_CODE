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
Integer pStep = 21;
ArrayList<PVector> fullPath;

void setup() {
	size(1024, 768);
	// background( loadImage("photo.jpg") );
	background(255);
	strokeWeight(HALF_PI);
	smooth();

	// create start and end points
	pStart = new PVector( 0, random(height));
	pEnd = new PVector( width, random(height));
	//	get path between points
	fullPath = GeneratePath( pStart, pEnd, pStep);


}

///////////////////////////////////////////////////////
void draw() {
	
/*
	strokeWeight(42);
	stroke(#1975EF);
	line(pStart.x, pStart.y, pEnd.x, pEnd.y);	

	// for( PVector pt : fullPath )
	for (int i = 0; i<fullPath.size(); i++)
	{
		pt = (PVector)fullPath.get(i);
		point(pt.x,pt.y);
	}

	
	strokeWeight(23);
	stroke(#EFEFEF);
	line(pStart.x, pStart.y, pEnd.x, pEnd.y);
	
	// for( PVector pt : fullPath )
	for (int i = 0; i<fullPath.size(); i++)
	{
		pt = (PVector)fullPath.get(i);
		point(pt.x,pt.y);
	}
*/

	//	VERTEX
	// beginShape();
	// 	vertex( pStart.x, pStart.y);
	// 	for (int i = 0; i<fullPath.size(); i++)
	// 	{
	// 		pt = (PVector)fullPath.get(i);
	// 		vertex(pt.x, pt.y);
	// 	}
	// 	vertex( pEnd.x, pEnd.y);
	// endShape();

	// CURVE VERTEX
	noFill();
	stroke(#EF2014);

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


save(this+".png");
	noLoop();

}

///////////////////////////////////////////////////////
// Generate a path between supplied points
ArrayList<PVector> GeneratePath( PVector startPt, PVector endPt, Integer step )
{
	ArrayList<PVector>	path = new ArrayList<PVector>();

	PVector thisPt;
	PVector lastPt = new PVector(startPt.x, startPt.y);

	while( lastPt.x < endPt.x )
	{
// TODO: need better path generation logic
		thisPt = new PVector(
				lerp( lastPt.x, lastPt.x + step, random(1) ),
				random(height-step) );

		path.add(thisPt);

		lastPt = thisPt;
	}

	return path;
}






