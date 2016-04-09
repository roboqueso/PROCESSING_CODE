import processing.video.*;

PShape s;
int numShapes;


// rogue
Capture cam;


void setup() {
	size( 1000, 900, P3D );
	background(#FF6600);
	smooth();

	s = loadShape("layout.svg");
	numShapes = s.getChildCount();

	cam = new Capture( this, Capture.list()[0] );
	cam.start();
}


void draw() {
	// background(#FF6600);
	
	for(int i = 1; i < numShapes; i++)
	{
		rect( random(i), random(i), i, i);

		buildVertex( s.getChild(i) );
	}

}



void buildVertex( PShape curShape )
{
	stroke(#0000FF);
	fill(#00FF00);


if( cam.available() ){
	cam.read();

}

	beginShape(TRIANGLES);

texture(cam);

		for( int i = 0; i < curShape.getVertexCount(); i++ ){

			PVector v = curShape.getVertex(i);

			vertex( v.x, v.y, v.z );

		}
		

	endShape();
}