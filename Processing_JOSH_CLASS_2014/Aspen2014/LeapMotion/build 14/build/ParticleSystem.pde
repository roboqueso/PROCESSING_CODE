import java.util.Iterator;

class ParticleSystem {
	int finger_which, ct;
	color clr;
	PVector pt;

	ArrayList<Particle> particles;
	int numParticles = 5;

	ParticleSystem(int _ct, int _finger_which, PVector _pt, color _clr) {
		finger_which = _finger_which;
		clr = _clr;
		pt = _pt;
		ct = _ct;

		particles = new ArrayList<Particle>();

		for (int i = 0; i < numParticles; ++i) {
			Particle p = new Particle(i*ct,finger_which, pt, clr);
			particles.add(p);
		}
	}

	void run() {
		Iterator<Particle> it = particles.iterator();

		while( it.hasNext() ) {
			Particle p = it.next();
			p.run();

			if( p.isDead() ) it.remove();
		}
	}

	boolean systemDead() {
		return ( particles.isEmpty() );
	}
}
