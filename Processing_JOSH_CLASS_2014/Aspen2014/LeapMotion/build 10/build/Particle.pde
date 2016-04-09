class Particle
{
	int finger_which;
	color clr;
	PVector pt;

	int lifespan = 150;

	PVector location, velocity, acceleration;

	Particle( int _finger_which, PVector _pt, color _clr)
	{
		finger_which = _finger_which;
		clr = _clr;
		pt = _pt; 

		location = pt.get();
		velocity = new PVector( random(-finger_which+finger_which,finger_which*2), random(-finger_which, finger_which) );
		acceleration = new PVector(0, 0.05);
	}



	void run()
	{
		strokeWeight(finger_which+noise(frameCount));
		fill(clr);

		velocity.add(acceleration);
		location.add(velocity);


		pushMatrix();
			
			translate( location.x, location.y, map(pt.z, 0, 100, 900, -900) );

			// switch(finger_which){
			// 	case 1:
			// 		rect(0,0,20,20);
			// 	break;

			// 	default :
					ellipse(0,0,20,20);
			// 	break;	
			// }
			

		popMatrix();


		if(lifespan > 0 ){
			lifespan--;
		}
	}

	boolean isDead()
	{
		return ( lifespan <= 0 );
	}
}