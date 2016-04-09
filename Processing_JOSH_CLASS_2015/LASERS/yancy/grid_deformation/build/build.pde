HDrawablePool pool;
HColorPool colors;

float xnoise, ynoise, xstart;
int hexSize = 3;

void drawPoint(HDrawable d, float x, float y, float noiseFactor){
	float size = 3 * noiseFactor;
	// d.width(size*noiseFactor*1);
	// d.height(size*noiseFactor*6);
	d.rotation(size*noiseFactor);
	d.size(size);
	// println(noiseFactor);
	noiseFactor = map(noiseFactor,0,1,-1,1);

	d.x( d.x() + x * noiseFactor * size);
	d.y( d.y() + y * noiseFactor * size);

	if ( dist(d.x(), d.y(), width/2, height/2) > 500){					
		d.size(0);
	}
	// d.fill( colors.getColor( (int)(10 * noiseFactor) ));
	// d.width(size).height(size);
	// d.anchor(-size*2,-size*2);
}

void setup() {
	size(1900,1200);
	H.init(this).background(#FFFFFF);
	smooth();

	// colors = new HColorPool(#8F00FF, #4B0082, #0000FF, #00FF00, #FFFF00, #FF7F00, #FF0000);
	colors = new HColorPool(#000000 );
	// colors = new HColorPool(#00FF00);

	pool = new HDrawablePool(75200);
	pool.autoAddToStage()
		// .layout(new HGridLayout().startX(-10).startY(-10).spacing(4,4).cols(574))
		.layout(new HHexLayout().spacing((hexSize)).offsetX(0).offsetY(0))
		// .add ( new HSphere(), 25 )
		.add (
			new HEllipse()
			// new HRect()
		)
		.colorist(colors)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					HDrawable d = (HDrawable) obj;
					d
						// .fill(#999999)
						// .strokeWeight(1)
						.width(2)
						.height(6)
						.noStroke()
						// .stroke(#202020)
						.anchorAt(H.CENTER)
						// .anchor(0,150)
						// .loc( (int)random(width), (int)random(height) )
						// .anchor( new PVector(25,25) )
						// .rotation( (int)random(360) )
						// .size( 25 + ( (int)random(3)*25 ) )
					;
					// float x = dist( d.x(), height/2, width/2, height/2 )  / 200.0;
					// float y = dist( width/2 , d.y(), width/2, height/2 )  / 200.0;
					float x = d.x() / 200;
					float y = d.y() / 200;

					drawPoint( d, x, y, noise( x, y ) );
					// drawPoint( d, x, y, noise( x, y ) );

					if ( dist(d.x(), d.y(), width/2, height/2) > 500){
						d.size(0);
					}

					// new HOscillator()
					// 	.target(d)
					// 	.property(H.DX)
					// 	.range(1, -1)
					// 	.waveform(H.SINE)
					// 	.speed(4)
					// 	.freq(1)
					// 	.currentStep(  noise(x-50, y+50) * 60)
					// ;

					// new HOscillator()
					// 	.target(d)
					// 	.property(H.DY)
					// 	.range(1, -1)
					// 	.waveform(H.SINE)
					// 	.speed(1)
					// 	.freq(4)
					// 	.currentStep(  noise(x+50, y-50) * 60)
					// ;

					// new HOscillator()
					// 	.target(d)
					// 	.property(H.ROTATION)
					// 	.range(0, 360)
					// 	.waveform(H.SINE)
					// 	.speed(0.125)
					// 	.freq(32)
					// 	.currentStep(  noise(x,y) * 60 )
					// ;
					// HRotate r = new HRotate();
					// r.target(d).speed( random(-4,4) );
				}
			}
		)

		.requestAll()
	;


}

void draw() {
	H.drawStage();
	for (HDrawable d : pool){					
					// float x = (d.x()/2 - dist( d.x(), height/2, width/2, height/2 ))  / 200.0;
					// float y = (d.y()/2 - dist( width/2 , d.y(), width/2, height/2 ))  / 200.0;
					float x = d.x() / 200;
					float y = d.y() / 200;

					drawPoint( d, x, y, noise( x, y ) );
	}

	if(frameCount % 1 == 0 && frameCount < 91){
	 	saveFrame("a-90/image-#####.png");
	}
}

