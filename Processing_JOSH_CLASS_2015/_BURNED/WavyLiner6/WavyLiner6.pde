import processing.pdf.*;

///////////////////////////////////////////////////////
PVector pStart, pEnd, pt;
Integer pStep = 125;
ArrayList<PVector> fullPath;

PGraphics pGraph;

void setup() {
	size(2560, 1920, P3D );
	// size(1280, 960, P3D );
	// pGraph = createGraphics(width,height, P3D);

	// create start and end points
	pStart = new PVector( 0, random(pStep) );
	pEnd = new PVector( width, random(height));
	//	get path between points
	fullPath = GeneratePath( pStart, pEnd, pStep);
	
	beginRecord(PDF, fileStamp()+".pdf");
}

///////////////////////////////////////////////////////
void draw() {
	
	// beginDraw();
	smooth();
	noFill();

	// CURVE VERTEX
	curveTightness(frameCount);

	// stroke(random(100));
	stroke(0);
	strokeWeight(random(9,13));

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



	// stroke(random(255),random(155),random(55));
	stroke(random(255));
	strokeWeight(random(PI,9));

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


	pStep+=TWO_PI;
	// create start and end points
	pStart = new PVector( random(width), pStart.y+pStep );
	pEnd = new PVector( random(width), random(height));
	//	get path between points
	fullPath = GeneratePath( pStart, pEnd, pStep );


	//	STOPPER
	if( pStart.y >= height)
	{
		// fill(#EFEFEF);
		// text("ericfickes.com", width-100, height-11);
		
// CLOSE PDF
		endRecord();


		// save( pdeName() + getTimestamp() + ".png");
		noLoop();
	}

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
				lerp(lastPt.x, lastPt.x+step, random(.1,.9) ),
				random(step,height-step) );

		path.add(thisPt);

		lastPt = thisPt;
	}

	return path;
}


public String getTimestamp() {
  return ""+month()+day()+year()+hour()+minute()+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
public String pdeName() {
  return split( this.toString(), "[")[0];
}

//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}
