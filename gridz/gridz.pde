/*
Grids : 55, 89, 144

*/
float cX, cY, xx, yy;
int sz;

ArrayList<PVector> p1 = new ArrayList<PVector>();
ArrayList<PVector> p2 = new ArrayList<PVector>();
ArrayList<PVector> p3 = new ArrayList<PVector>();


void setup()
{
  size(displayWidth, displayHeight);
  smooth();
  noFill();
  frameRate(1446);
  sz = 144;
  xx = yy = -sz;
  strokeWeight(2);
}

/*
Grids : 55, 89, 144
*/

void draw()
{

	switch(sz)
	{
		case 144:
		{	
			stroke(255);
			strokeWeight(TWO_PI);
		}
		break;

		case 89:
		{
			stroke(#EF2015);
			strokeWeight(4);
		}
		break;

		case 55:
		{
			stroke(#2015EF);
			strokeWeight(PI);
		}
		break;
	}


	point( xx, yy );

	if(xx<width)
	{
		xx += sz;
	}
	else
	{
		xx = -sz;
		yy += sz;

		// check for reset
		if( yy >= height )
		{
			yy = -sz;

			if(sz==144)
				sz = 89;
			else if ( sz == 89)
				sz = 55;
			else if ( sz == 55)
				sz = -1;
		}
	}


	// }




  //	Grids : 55, 89, 144
  if( sz == -1 )
  {
    
    save(fix.pdeName()+fix.getTimestamp()+".png");

    noLoop();
  }




}
