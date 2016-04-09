import processing.video.*;

PShape s;
int numShapes;

PVector tp1, tp2, tp3;
PImage t;

///////////////////////////////////////////////////////////////////////////////
void setup() {
	size( 1000, 900, P3D );
	background(#EF7800);
	smooth();

	s = loadShape("layout.svg");
	numShapes = s.getChildCount();

	// texture image
	t = loadImage("jeremy.png");
	// points of triangle
	tp1 = new PVector(0,0);
	tp2 = new PVector(200, 0);
	tp3 = new PVector(0, 200);
}


///////////////////////////////////////////////////////////////////////////////
void draw() 
{
	
	for(int i = 0; i < numShapes; i++)
	{
		buildVertex( s.getChild(i) );
	}

}


///////////////////////////////////////////////////////////////////////////////
void buildVertex( PShape curShape )
{
	noStroke();
	noFill();

	beginShape(TRIANGLE_FAN);
	

		texture(t);

		for( int i = 0; i < curShape.getVertexCount(); i++ )
		{

			PVector v = curShape.getVertex(i);
			PVector textPos = new PVector();

			// set texture point based on which vertex we're hitting
			switch(i)
			{
				case 0:
				textPos = tp1;
				break;

				case 1:
				textPos = tp2;
				break;

				case 2:
				textPos = tp3;
				break;
			}

			vertex( v.x, v.y, v.z, textPos.x, textPos.y );

		}
	endShape();
}