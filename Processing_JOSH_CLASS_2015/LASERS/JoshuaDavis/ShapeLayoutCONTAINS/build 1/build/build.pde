HImage myShape;

HDrawablePool pool;

void setup(){
	size(900,900);
	H.init(this).background(#ECECEC).autoClear(true);
	smooth();

	myShape = new HImage("shape.png");
	H.add(myShape);


	pool = new HDrawablePool(576);
	pool.autoAddToStage()
		.add (new HRect().rounding(4))
		.layout (new HGridLayout().startX(21).startY(21).spacing(26,26).cols(24))
		.onCreate (
			 new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.noStroke()
						.fill( #666666 )
						.anchorAt(H.CENTER)
						.size( 25 )
					;

					if ( myShape.contains( d.x(), d.y() ) ) {
						d.fill(#00FF00);
					}
				}
			}
		)
		.requestAll()
	;
}
 
void draw(){
	H.drawStage();
}








