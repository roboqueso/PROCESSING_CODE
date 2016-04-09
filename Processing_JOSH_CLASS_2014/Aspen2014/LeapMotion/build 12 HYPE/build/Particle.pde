class Particle{
	int finger_which;
	color clr;
	PVector pt;

	int lifespan;

	PVector location;
	PVector velocity;
	PVector acceleration;

	HOscillator oScale;

	Particle(int _finger_which, PVector _pt, color _clr ) {

		lifespan = (int)random(111);

		finger_which = _finger_which;
		clr = _clr;
		pt = _pt;

		location = pt.get();
		velocity = new PVector( random(-1,1), random(-2,0) );
		acceleration = new PVector(0, 0.1);

		oScale = new HOscillator()
		.range(0,lifespan)
		.speed(1)
		.freq(finger_which)
		;
	}

	void run() {
		velocity.add(acceleration);
		location.add(velocity);

		oScale.nextRaw();

		// noStroke(); 
		fill(clr);

		pushMatrix();
			translate(location.x, location.y, map(pt.z,0,100,900,-900) );
			
			strokeWeight( oScale.curr() * noise(location.x) / 10 );

			ellipse(0,0, oScale.curr(), oScale.curr() );
		popMatrix();

		if (lifespan>0) lifespan--;
	}

	boolean isDead() {
		return (lifespan==0);
	}
}