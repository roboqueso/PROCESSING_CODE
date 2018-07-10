/**
 * Camera Previews
 
 P5
* Captures.list

Loop through each
    * Start
    * read
    * set()
    * stop()  
*/

// TODO: Why does BisonCam light up, but not actually work?

import processing.video.*;


Capture cam;
String[] cameras;
int cc = 0;  //  currect camera index
int MODE = 2;	//1;	//	2
//	1 : horizontal
//	2 : vertical
int colW, rowH;

//PImage img;
//  TODO: Would spitting Camera preview to PGraphic instead of mainstage make this faster?


//	TODO: de-dupe cameras into list of matching fps=30

/******************************************************************************/
void setup() {
  
  size(displayWidth, displayHeight, P3D );  //  P2D, P3D
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
  
  cameras = Capture.list();

  if (cameras == null) {
    println("FAIL");
    noLoop();
    exit();
  }
  
//  DEBUG
println("Available cameras:");
printArray(cameras);

	switch(MODE){
		//	HORIZONTAL
		case 1:{
			colW = width / cameras.length;
			rowH = height;
		}
		break;

		//	VERTICAL
		case 2:{
			colW = width;
			rowH = height / cameras.length;
		}
		break;
	}


  textSize(height/cameras.length);
  strokeWeight(HALF_PI);
    
  //  startup the first camera!
  cam = new Capture(this, cameras[cc]);
  cam.start();
  
  
  delay(1000);
  cam.read();  
}

/******************************************************************************/
void draw() {
	stroke(frameCount%255);
	point(cameras.length, frameCount%height);

  if (cam.available() == true) {
    cam.read();
    delay(1000);
  } else {
  
      //  waiting
      point( (frameCount*(cc+1)%width), cameras.length );
      
  }

	switch(MODE){
		//	HORIZONTAL
		case 1:{
			colW = width / cameras.length;
			rowH = height;
			image(cam, (cc+1)*colW, 0, colW, rowH );
		}
		break;

		//	VERTICAL
		case 2:{
			colW = width;
			rowH = height / cameras.length;
			image(cam, 0, (cc+1)*rowH, colW, rowH );
		}
		break;
	}

  delay(1000);

  //  DEBUG
  println("DESTROY CAM " + cc );
  cam.stop();
  cam = null;

  delay(1000);
    

  if( cc < (cameras.length-1) ){
    cc++;

  } else  {
    doExit();
  }


  if(cam==null){

	// debug
	println("MAKE NEXT CAMERA: " + cc + " : " + cameras[cc].toString() );

    //  startup the first camera!
    cam = new Capture(this, cameras[cc]);
    cam.start();

    fill(random(255));
    text( cameras[cc].toString(), width/2, (frameCount*((cc+1)*cameras.length))%height );

    delay(1000);
  }

}



/***********************************************************************************************************/
void captureEvent(Capture c) {
  c.read();
}

/***********************************************************************************************************/
/**
exit handler
**/
void doExit(){

    save(this+ "_"+MODE+".png"); 
  
    noLoop();
    super.exit();
}
