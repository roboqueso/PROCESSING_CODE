class Particle{
	int finger_which;
	color clr;
	PVector pt;
	PImage img;

	int lifespan = 20; //(int)random(150);

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
		// rectMode(CENTER);
		// imageMode(CORNERS);
	}

	void run() {
		velocity.add(acceleration);
		location.add(velocity);

		img = imgs[ finger_which-1];

		container.beginDraw();
			container.pushMatrix();
				container.translate(location.x, location.y );
				container.rotate( radians( map( location.z, 0, 100, -360, 360) - lifespan ) );


			if( location.y >= container.height/2)
			{
				container.tint( (int) color(clr) );
				img.filter(GRAY);
			} 
			else 
			{
				container.noTint();
			}

			container.image( img, 0, 0 );

			container.popMatrix();
		container.endDraw();

		if (lifespan>0) lifespan--;
	}

	boolean isDead() {
		return (lifespan==0);
	}
}