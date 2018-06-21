import fixlib.*;

//	DENCAB1 - version of og sketch mov2gif

//  LEGACY NOTES
//	1. locate movie on vimeo
//  2. go to http://www.convertfiles.com/
//	3. conver to MOV
//	4. update size() to match MOV dimensions
//	5. run through this pde
//	6. let's party
/*
- https://vimeo.com/23097220
https://www.youtube.com/watch?v=oyi_q7hIOmw
 */
import processing.video.*;

Fixlib fix = Fixlib.init(this);
Movie myMovie;

/*
1 = vertical
2 = horizontal
*/
int MODE = 1;
String PDE;  //  1280, 720
String MOV_FILE = "bulldog.mp4";  //  1280, 720


void setup() 
{
  size(1080, 1920, P3D);

  background(-1);
  smooth(8);
  pixelDensity(displayDensity());

  rectMode(CENTER);

  PDE = fix.pdeName();
  myMovie = new Movie(this, MOV_FILE );
  myMovie.loop();
}

void draw() {

  if(frameCount%2==0){
println("GREY - filter");
    myMovie.filter(DILATE);
    myMovie.filter(ERODE);
     myMovie.filter(GRAY);

  }else{
    
println("INVERT - filter");
    myMovie.filter(INVERT);
    myMovie.filter(POSTERIZE,88);
    myMovie.filter(THRESHOLD);
    
  }


tint(random(88,240), random(100,200));


	switch(MODE)
	{
		case 1:	//"vert":

			image(myMovie, 0, frameCount+random(11), width, random(myMovie.height));

			if(frameCount>=height){
				bail();
			}
		break;

		case 2:	//"horizontal":

			image(myMovie, frameCount+random(11),0, random(myMovie.width), height);
			if(frameCount>=width){
				bail();
			}
		break;
	}

//  SAVE FRAMES FOR GIFing
saveFrame("frames/DENCAB1_"+PDE+"-"+MOV_FILE+"-"+MODE+"-frame#####.png");



}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}


void bail(){

  //  drop a frame onto desktop
  //float cX = width/2;
  //float cY = height/2;
  //tint(255,100);  
  ////  move is the same size as this sketch, so /movie = /width
  //image( myMovie,cX-cX, cY-cY, cX, cY );
  
  
	save(fix.pdeName()+fix.getTimestamp()+".png");
	myMovie.stop();
	stop();
	exit();
}
