class Particle
{
	int finger_which;
	color clr;
	PVector pt;


	Particle( int _finger_which, PVector _pt, color _clr)
	{
		finger_which = _finger_which;
		clr = _clr;
		pt = _pt; 
	}


	void run()
	{
		noStroke();
		fill(clr);

		pushMatrix();
			
			translate( pt.x, pt.y, map(pt.z, 0, 100, 900, -900) );

			if(finger_which%2==0)
				ellipse(0,0,20,20);
			else
				rect(0,0,20,20);

		popMatrix();	
	}
}