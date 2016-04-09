HGroup myAssets1;
HRect  r1, r2;

void setup(){
	size(900,900);
	H.init(this).background(#111111).autoClear(true);
	smooth();

	H.add( myAssets1 = new HGroup()).loc(width/2, height/2);
	new HRotate(myAssets1, 1);

	myAssets1.add(r1 = new HRect()).rounding(5).fill(#FF3300).anchorAt(H.CENTER).loc(0,-100).rotation(45);
	myAssets1.add(r2 = new HRect()).rounding(5).fill(#FF6600).anchorAt(H.CENTER).loc(0, 100).rotation(45);
}
 
void draw(){
	H.drawStage();
}









