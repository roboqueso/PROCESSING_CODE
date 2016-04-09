PShape s;
int numShapes;

PVector tp1, tp2, tp3;
PImage t;

int[] texScale = { 100, 150, 200 };
int[] pickedTextScale;

///////////////////////////////////////////////////////////////////////////////
void setup() {
	size( 1000, 900, P3D );
	background(255);
	smooth();

	s = loadShape("layout.svg");
	numShapes = s.getChildCount();
	pickedTextScale = new int[numShapes];

	// texture image
	t = loadImage("jeremy.png");

	for( int i = 0; i < numShapes; i++ ){
		pickedTextScale[i] = texScale[ (int) random(texScale.length) ];
	}

}


///////////////////////////////////////////////////////////////////////////////
void draw() 
{
	
	for(int i = 0; i < numShapes; i++)
	{
		buildVertex( s.getChild(i), i );
	}

}


///////////////////////////////////////////////////////////////////////////////
void buildVertex( PShape curShape, int triNum )
{
	noStroke();
	noFill();

	beginShape(TRIANGLES);

		texture(t);

		int tScale = pickedTextScale[ triNum ];

		for( int i = 0; i < curShape.getVertexCount(); i++ )
		{

			PVector v = curShape.getVertex(i);
			PVector textPos = new PVector();

			// set texture point based on which vertex we're hitting
			switch(i)
			{
				case 0:
				textPos = new PVector(0,0);
				break;

				case 1:
				textPos = new PVector( tScale ,0);
				break;

				case 2:
				textPos = new PVector( 0, tScale );
				break;
			}

			vertex( v.x, v.y, v.z, textPos.x, textPos.y );


		}
	endShape();
}