class Particle{
	int finger_which;
	color clr;
	PVector pt;
	PImage img;

	int lifespan = (int)random(PI,42);

	PVector location;
	PVector velocity;
	PVector acceleration;

	Particle(int i, int _finger_which, PVector _pt, color _clr ) {
		finger_which = _finger_which;
		clr = _clr;
		pt = _pt;

		location = pt.get();
		velocity = new PVector( random(-2,2), random(-2,2) );
		acceleration = new PVector(0, 0.1);

		// ellipseMode(CENTER);
		rectMode(CENTER);
		// imageMode(CENTER);
	}

	void run() {
		velocity.add(acceleration);
		location.add(velocity);

		img = imgs[ finger_which-1];

		pushMatrix();
			translate(location.x, location.y );
		
		if(location.x%2==0)
		{
			img.filter(INVERT);
		}

			image( img, 0, 0 );

		popMatrix();

		if (lifespan>0) lifespan--;
	}

	boolean isDead() {
		return (lifespan==0);
	}
}