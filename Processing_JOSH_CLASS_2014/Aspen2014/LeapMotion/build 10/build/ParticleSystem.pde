import java.util.Iterator;


class ParticleSystem
{
	int finger_which;
	color clr;
	PVector pt;

	ArrayList<Particle> particles = new ArrayList<Particle>();
	int numParticles = 5;


	ParticleSystem( int _finger_which, PVector _pt, color _clr)
	{
		finger_which = _finger_which;
		clr = _clr;
		pt = _pt; 

		for(int i = 0; i < numParticles; i++){
			particles.add( new Particle( finger_which, pt, clr ) );
		}
	}



	void run()
	{

		Iterator<Particle> it = particles.iterator();

		while( it.hasNext())
		{
			Particle p = it.next();
			p.run();

			if( p.isDead() ) it.remove();
		}

	}

}