class Particle{
	int finger_which;
	color clr;
	PVector pt;

	int lifespan;

	PVector location;
	PVector velocity;
	PVector acceleration;

	HOscillator oSize, oRotX, oRotY, oRotZ;


	Particle(int i, int _finger_which, PVector _pt, color _clr ) 
	{

		lifespan = (int)random(100);

		finger_which = _finger_which;
		clr = _clr;
		pt = _pt;

		location = pt.get();
		velocity = new PVector( random(-1,1), random(-2,0) );
		acceleration = new PVector(0, 0.1);

		oSize = new HOscillator().range(0,lifespan).speed(1).freq(finger_which).currentStep(i*3);
		
		oRotX = new HOscillator().range(-360, 360).speed(0.5).freq(finger_which).currentStep(i);
		oRotY = new HOscillator().range(-360, 360).speed(0.7).freq(finger_which).currentStep(i);
		oRotZ = new HOscillator().range(-360, 360).speed(0.3).freq(finger_which).currentStep(i);

	}

	void run() {
		velocity.add(acceleration);
		location.add(velocity);

		oSize.nextRaw();
		oRotX.nextRaw();
		oRotY.nextRaw();
		oRotZ.nextRaw();

		noStroke(); 
		fill(clr);

		pushMatrix();
			translate(location.x, location.y, map(pt.z,0,100,900,-900) );
			
			// strokeWeight( oSize.curr() * noise(location.x) / 10 );
			rotateX( radians( oRotX.curr() ));
			rotateY( radians( oRotY.curr() ));
			rotateZ( radians( oRotZ.curr() ));

			ellipse(0,0, oSize.curr(), oSize.curr() );

		popMatrix();

		if (lifespan>0) lifespan--;
	}

	boolean isDead() {
		return (lifespan==0);
	}
}