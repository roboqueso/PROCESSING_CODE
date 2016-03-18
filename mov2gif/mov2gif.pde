//	MOV to GIFFER
//	1. locate movie on vimeo
//  2. go to http://www.convertfiles.com/
//	3. conver to MOV
//	4. update size() to match MOV dimensions
//	5. run through this pde
//	6. let's party
/*
- https://vimeo.com/23097220
https://www.youtube.com/watch?v=oyi_q7hIOmw
https://vimeo.com/75799644
https://vimeo.com/72088585
https://vimeo.com/127970339
https://vimeo.com/127877243
https://vimeo.com/127869970
https://vimeo.com/127315710
https://vimeo.com/127315709
https://vimeo.com/127306632
https://vimeo.com/126424925
https://vimeo.com/126321193
 */
import processing.video.*;
Movie myMovie;
int MODE = 2;	// 2
/*
1 = vertical
2 = horizontal
*/

String MOV_FILE = "23097220.mov";	//	1280, 720

void setup() 
{
size(1280, 720);
// size(960, 720);
// size(640, 360);
// size(320,240);

  myMovie = new Movie(this, MOV_FILE );
  myMovie.loop();
}

void draw() {

// alpha((int)random(255));

myMovie.filter(DILATE);
myMovie.filter(POSTERIZE,11);
// tint(255,100);

	switch(MODE)
	{
		case 1:	//"vert":
			image(myMovie, 0, frameCount);

			if(frameCount>=height){
				bail();
			}
		break;

		case 2:	//"horizontal":
			image(myMovie, frameCount,0);

			if(frameCount>=width){
				bail();
			}
		break;
	}




}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}


void bail(){
	save(MOV_FILE+"_"+timeStamp()+".png");
	myMovie.stop();
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
