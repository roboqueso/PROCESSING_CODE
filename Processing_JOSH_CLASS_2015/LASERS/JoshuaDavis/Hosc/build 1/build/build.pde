HOscillator osc1, osc2;

void setup(){
	size(900,900);
	H.init(this).background(#111111).autoClear(true);
	smooth();

	osc1 = new HOscillator().range(0,100).speed(1).freq(2);
	osc2 = new HOscillator().range(0,100).speed(0.1).freq(10);

}
 
void draw(){
	osc1.nextRaw();
	osc2.nextRaw();

	// H.drawStage();

	int yPos = (int)map(osc1.curr(),0,100, 100,800 );
	int rot  = (int)map(osc1.curr(),0,100, -360,360 );

	int yPos2 = (int)map(osc2.curr(),0,100, 100,800 );

	stroke(#FF3300); fill(#333333); rectMode(CENTER);

	pushMatrix();
		translate(150, yPos);
		rotate( radians(rot) );
		rect(0, 0, 100, 100);
	popMatrix();

	pushMatrix();
		translate(350, yPos2);
		rotate( radians(rot) );
		rect(0, 0, 100, 100);
	popMatrix();
}






