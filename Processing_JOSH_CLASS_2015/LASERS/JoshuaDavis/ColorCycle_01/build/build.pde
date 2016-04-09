HPixelColorist hpc;
HImage         colorPNG;
color[]        colors;
int  []        colorsNums;
int            colorsMin = 0;
int            colorsMax = 200;

String         joinedColors, joinedColorsNums;

void setup(){
	size(1000,600);
	H.init(this).background(#111111).autoClear(true);
	smooth();

	hpc = new HPixelColorist("color1.png");

	H.add( colorPNG = new HImage("color1.png") ).loc(0, 500);

	colors     = new color[ colorsMax ];
	colorsNums = new color[ colorsMax ];

	for (int i = 0; i < colorsMax; i++) {
		float tempPos = (colorPNG.width() / colorsMax) * i;
		colors[i] = hpc.getColor(tempPos,0);
		colorsNums[i] = i;
	}

	joinedColors = join(nf(colors,0), ", ");
}
 
void draw(){
	H.drawStage();
	noStroke(); fill(#ECECEC); textSize(11); text("200", 10, 495);

	for (int i = 0; i < colorsMax; ++i) {
		int tempNum = colorsNums[i];
		tempNum++;
		if(tempNum == colorsMax) tempNum = 0;
		colorsNums[i] = tempNum;
	}

	joinedColorsNums = join(nf(colorsNums,0), ", ");
	text(joinedColorsNums, 10, 10,  990, 600);
	text(joinedColors,     10, 125, 990, 600);

}








