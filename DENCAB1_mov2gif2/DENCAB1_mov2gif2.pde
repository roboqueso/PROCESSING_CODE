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
 */
import processing.video.*;
import ddf.minim.*;
import fixlib.*;

Minim minim;
AudioInput in;
Movie myMovie;
Fixlib fix = Fixlib.init(this);

float cX, cY;
/*
1 = vertical
2 = horizontal
*/
int MODE = 1;
String PDE;  //  1280, 720
String MOV_FILE = "bad_kevin.mp4";  //  1280, 720

color mc;


/*********************************************************************************************/
void setup() 
{

  size(2000, 1000, P3D);  //  2x1 so f360 honors as .hdr

  background(-1);
  smooth(8);
  pixelDensity(displayDensity());

  rectMode(CENTER);


  minim = new Minim(this);
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();

  myMovie = new Movie(this, MOV_FILE );
  myMovie.loop();
  cX = width/2;
  cY = height/2;
}

/*********************************************************************************************/
void draw() {
  if ( myMovie != null && myMovie.width > 0 && myMovie.height > 0 ) { 

    myMovie.filter(DILATE);
    myMovie.filter(POSTERIZE, 43);

    if (frameCount%2==0) {
      myMovie.filter(INVERT);
    } else if (frameCount%3==0) {
      myMovie.filter(ERODE);
      myMovie.filter(THRESHOLD);
    } else {
      myMovie.filter(GRAY);
    }


    // grab a color from the movie
    mc = myMovie.get( (frameCount % myMovie.width), (frameCount % myMovie.height) );


    // does this make any difference?
    // 3D code
    hint(DISABLE_DEPTH_TEST);
    camera();
    lights(); //    because P3D

    ambientLight(  frameCount+random(random(in.bufferSize() - 1))%255, 
      (frameCount+ in.left.get((int)random(in.bufferSize() - 1))*420)%255, 
      (frameCount+ in.right.get((int)random(in.bufferSize() - 1))*420)%255
      );
    emissive(mc);
    specular(mc);





    //  draw the soundwave
    // TODO: fix the end of sketch bug causing the full screen lines to cover all the art
    beginShape(POINTS);  //  POINTS - doesn't show issue but lines are meh
    //  LINES - shows issue, but it's not too bad
    texture(myMovie);

    // draw the waveforms so we can see what we are monitoring
    for (int i = 0; i < in.bufferSize() - 1; i++)
    {
      //  volume influences strokeWeight
      int sw =(int) (11 * (in.left.get(i) + in.right.get(i)*420));
      if (sw<1) { 
        sw = -sw;
      }
      
      
      // debug
      println("sw : " + sw );

      strokeWeight( (1+sw)%43 );

      //strokeWeight( (PI+sw) );
      //  color 1
      stroke(mc);

      vertex( i%width, (frameCount+ in.left.get(i)*420)%height, frameCount%height, random(myMovie.width), random(myMovie.height));
      vertex( i+1%width, (frameCount+ in.left.get(i+1)*420)%height, frameCount%height, random(myMovie.width), random(myMovie.height));

      //  color 2
      //strokeWeight(1);
      stroke(  frameCount+random(random(in.bufferSize() - 1))%255, 
        (frameCount+ in.left.get((int)random(in.bufferSize() - 1))*420)%255, 
        (frameCount+ in.right.get((int)random(in.bufferSize() - 1))*420)%255
        );


      vertex( i%width, (frameCount-  in.right.get(i)*420)%height, frameCount%height, random(i), random(i));
      vertex( i+1%width, (frameCount- in.right.get(i+1)*420)%height, frameCount%height, random(i), random(i));
    }
    endShape();  //  TODO: I think CLOSE contributes to the end of sketch coverup






    strokeWeight(.8);
    stroke( mc, 100);
    noFill();
    tint(  mc, random(80, 240));

    //  lay down the movie frame
    //  NOTE : image() is perpendicular to the soundwave mode
    //  EX: VERT mode the image goes height 100% whereas the sound wave goes 100% width
    switch(MODE)
    {
    case 1:  //"vert":
      image(myMovie, 0, frameCount%height, random(width), random(height) );
      line( 0, frameCount%height, random(width), random(height) );
      rect( 0, frameCount%height, random(width), random(height) );

      if (frameCount>=height) {
        bail();
      }
      break;

    case 2:  //"horizontal":
      image(myMovie, frameCount%width, 0, random(width), random(height) );
      line(  frameCount%width, 0, random(width), random(height) );
      rect(  frameCount%width, 0, random(width), random(height) );

      if (frameCount>=width) {
        bail();
      }
      break;
    }
    

//  SAVE FRAMES FOR GIFing
//saveFrame("frames/DENCAB1_"+PDE+"-"+MOV_FILE+"-"+MODE+"-frame#####.png");

 
    
  }  //  end myMovie checker
}







/*********************************************************************************************/
// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

/*********************************************************************************************/
void bail() {

  // stop the movie
  myMovie.stop();
  //  stop the sketch
  noLoop();
  // cleanup
  in.close();
  minim.stop();
  in = null;
  minim = null;

  //  save png
  save( fix.pdeName()+fix.getTimestamp()+".png");

  exit();
  super.stop();
}
