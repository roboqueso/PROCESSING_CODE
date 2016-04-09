HShape myShape;
HDrawablePool pool;

HColorField colorField;

void setup(){
	size(900,900);
	H.init(this).background(#ECECEC).autoClear(true);
	smooth();

	myShape = new HShape("shape.svg");
	// myShape.visibility(false);
	// H.add(myShape);

	colorField = new HColorField(width, height)
		.addPoint(100,100, #0000FF, 0.5)
		.addPoint(500,300, #FF0000, 0.5)
		.addPoint(100,500, #00FF00, 0.3)
		.fillOnly()
	;

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
						.visibility(false)
					;

					if ( myShape.contains( d.x(), d.y() ) ) {
						d.visibility(true);
					}

					colorField.applyColor(d);
				}
			}
		)
		.requestAll()
	;
}
 
void draw(){
	H.drawStage();
}








