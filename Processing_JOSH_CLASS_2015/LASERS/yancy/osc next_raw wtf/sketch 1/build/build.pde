/*

HOscillator.nextRaw() looks like it's intended to return the next raw value
between the min/max range.  Instead it returns the normalized value 
somewhere between -1 & 1.

Rect 1 is the usual oscillator behavior added to an HDrawable
Rect 2 is the oscillator nextRaw value mapped to a rect
Rect 3 is the adjusted nextRaw value as a workaround


*/


HOscillator osc1, osc2;
HDrawable d, d2;

void setup() {
	size(500, 500, P2D);

	H.init(this).background(#ff6600);
	smooth();


	HDrawable d = new HRect().size(50).loc(width/4,height/2);
	H.add(d);

	//we should move between 100 & 400
	osc1 = new HOscillator().range(100,400).speed(0.25).freq(5);
	osc2 = new HOscillator().range(100,400).speed(0.25).freq(5);
	osc1.target(d);
	
}

void draw() {
	H.drawStage();

	// nextRaw should return in the specified range
	// instead returns in the range of -1,1
	osc2.nextRaw();
	
	pushMatrix();
	  translate(width/2, osc2.curr() );
	  rectMode(CENTER);
	  rect(0,0,50,50);
	popMatrix();

	pushMatrix();
	  translate(width/2+width/4, map(osc2.curr(), 100, 400, 100, 400));
	  rectMode(CENTER);
	  rect(0,0,50,50);
	popMatrix();
}
