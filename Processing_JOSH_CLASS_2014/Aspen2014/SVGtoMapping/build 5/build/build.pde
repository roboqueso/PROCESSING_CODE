PShape s;
int numShapes;

PVector tp1, tp2, tp3;
PImage t;

int[] texScale = { 50, 100, 200 };
int pickedTextScale = texScale[0];

///////////////////////////////////////////////////////////////////////////////
void setup() {
	size( 1000, 900, P3D );
	background(255);
	smooth();

	s = loadShape("layout.svg");
	numShapes = s.getChildCount();

	// texture image
	t = loadImage("jeremy.png");
}


///////////////////////////////////////////////////////////////////////////////
void draw() 
{
	background(pickedTextScale,pickedTextScale,pickedTextScale);
	
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
				textPos = new PVector( pickedTextScale ,0);
				break;

				case 2:
				textPos = new PVector( 0, pickedTextScale );
				break;
			}

			vertex( v.x, v.y, v.z, textPos.x, textPos.y );


		}
	endShape();
}

///////////////////////////////////////////////////////////////////////////////
void keyPressed()
{
	switch(key)
	{
		case '1':
		pickedTextScale = texScale[0];
		break;
		
		case '2':
		pickedTextScale = texScale[1];
		break;

		case '3':
		pickedTextScale = texScale[2];
		break;
	}
}

