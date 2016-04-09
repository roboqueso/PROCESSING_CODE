class Particle{
	int finger_which;
	color clr;
	PVector pt;

	int lifespan = 150;

	PVector location;
	PVector velocity;
	PVector acceleration;

	Particle(int _finger_which, PVector _pt, color _clr ) {
		finger_which = _finger_which;
		clr = _clr;
		pt = _pt;

		location = pt.get();
		velocity = new PVector( random(-1,1), random(-2,0) );
		acceleration = new PVector(0, 0.1);
	}

	void run() {
		velocity.add(acceleration);
		location.add(velocity);

		noStroke(); fill(clr);

		pushMatrix();
			translate(location.x, location.y, map(pt.z,0,100,900,-900) );
			ellipse(0,0,20,20);
		popMatrix();

		if (lifespan>0) lifespan--;
	}

	boolean isDead() {
		return (lifespan==0);
	}
}
