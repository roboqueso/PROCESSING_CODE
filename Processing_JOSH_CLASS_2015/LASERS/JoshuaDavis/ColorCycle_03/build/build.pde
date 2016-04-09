HPixelColorist hpc;
HImage         colorPNG;
color[]        colors;
int  []        colorsNums;
int            colorsMin = 0;
int            colorsMax = 50;

int            poolCols  = 13;
int            poolRows  = 7;
int            poolMin   = 0;
int            poolMax   = poolRows * poolCols;
HDrawablePool  pool;

void setup(){
	size(1000,600);
	H.init(this).background(#111111).autoClear(true);
	smooth();

	hpc = new HPixelColorist("color2.png");

	pool = new HDrawablePool(poolMax);
	pool.autoAddToStage()
		.add (new HRect(100).rounding(5))

		.layout (
			new HGridLayout()
			.startX(50)
			.startY(75)
			.spacing(75,75)
			.cols(poolCols)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.noStroke()
						.fill(#ECECEC)
						.anchorAt(H.CENTER)
						.rotation( 45 )
					;
				}
			}
		)

		.requestAll()
	;

	H.add( colorPNG = new HImage("color2.png") ).loc(-20000, 500);

	colors     = new color[ colorsMax ];
	for (int i = 0; i < colorsMax; i++) {
		float tempPos = (colorPNG.width() / colorsMax) * i;
		colors[i] = hpc.getColor(tempPos,0);
	}

	colorsNums = new color[ poolMax ];
	for (int i = 0; i < poolMax; i++) {
		colorsNums[i] = poolMin;
		poolMin++;
		if (poolMin==colorsMax) poolMin = 0;
	}
}
 
void draw(){
	int index = 0;
	for(HDrawable d : pool) {
		color c = colors[ colorsNums[index] ];
		d.fill(c);
		index++;
	}
	H.drawStage();

	for (int i = 0; i < poolMax; ++i) {
		int tempNum = colorsNums[i];
		tempNum++;
		if(tempNum == colorsMax) tempNum = 0;
		colorsNums[i] = tempNum;
	}
}








