import gifAnimation.*;
int MODE = 2;	// 2
/*
1 = vertical
2 = horizontal
*/
boolean bz_REVERSE = true;	// output gif has it's frames inverted
GifMaker gifExport;
int ct, frmCt;
PImage frmImg, maskImg;
PImage[] allFrames;

// String SRC_GIF = "6.gif";	//	386, 383
// String SRC_GIF = "5.gif";	//	1245, 960
// String SRC_GIF = "4.gif";	//	500, 339
// String SRC_GIF = "3.gif";	//	500, 500
// String SRC_GIF = "2.gif";	//	500, 500
// String SRC_GIF = "1.gif";	//	500, 500
// String SRC_GIF = "0.gif";	//	500, 500

// String SRC_GIF = "codame_postVoodoo52370568-MOTION.gif"; // 972 × 730
// String SRC_GIF = "codame_postVoodoo56658668-MOTION.gif"; // 760 × 570
// String SRC_GIF = "codame_postVoodoo57964139-MOTION.gif"; // 972 × 730
String SRC_GIF = "May-July2013_75-MOTION.gif"; // 618 × 410

void setup() 
{
	size(618,410);
	//	1. Load existing GIF into frames
	allFrames = Gif.getPImages(this, SRC_GIF);
	//	get frame count
	frmCt = allFrames.length;
	ct = 1; // KEEP THIS IN SYNC WITH frmCt LOOP BELOW
}

void draw() {

// alpha((int)random(255));
frmImg = allFrames[frameCount%frmCt];

frmImg.filter(DILATE);
frmImg.filter(POSTERIZE,11);
// tint(255,100);

	switch(MODE)
	{
		case 1:	//"vert":
			image(frmImg, 0, frameCount);

			if(frameCount>=height){
				bail();
			}
		break;

		case 2:	//"horizontal":
			image(frmImg, frameCount,0);

			if(frameCount>=width){
				bail();
			}
		break;
	}




}

// Called every time a new frame is available to read
// void movieEvent(Movie m) {
//   m.read();
// }


void bail(){
	save(SRC_GIF+"_"+timeStamp()+".png");
	// myMovie.stop();
	stop();
	exit();
}


/////////////////////////////////////////////////////////////////////////////
// PVector circleXY( float centerX, float centerY, float radius, float angle )
// {
//   return new PVector(
//                 centerX - int( cos(radians(angle)) * radius ),
//                 centerY - int( sin(radians(angle)) * radius )
//                 );
// }

//  return unique filename_timestamp string
public String sketchName(){
  return split( this.toString(), "[")[0];
}
//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}
//  return unique filename_timestamp string
public String timeStamp(){
  return " "+month()+day()+year()+hour()+minute()+second();
}
