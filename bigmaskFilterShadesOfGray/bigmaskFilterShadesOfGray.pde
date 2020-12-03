//  SEE:   https://ello.co/ericfickes/post/iqmrsubdy0mlmo3ifcmliq
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;
Fixlib fix = Fixlib.init(this);


void settings(){
  // NOTE: match to mask size
  size(displayWidth, displayHeight);
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}



PImage deskTop;
PImage[] masks;  // array of PImage masks
int xx = 0, yy = 0, sz = 45;

void setup() {

  background(-1);
  
  masks = new PImage[6];

  //// keep track of the masks
  masks[0] = loadImage("bm1.png");
  masks[1] = loadImage("bm2.png");
  masks[2] = loadImage("bm3.png");
  masks[3] = loadImage("bm4.png");
  masks[4] = loadImage("bm5.png");
  masks[5] = loadImage("bm6.png");
  

}

void draw() {
  
filter(INVERT);

  // fill(sz+noise(frameCount, yy, xx),xx,yy, 100);
  // stroke(xx, yy, sz+noise(frameCount, xx, yy));
  fill(random(7,245), 100);
  stroke(frameCount%245);
  
  strokeWeight(1+noise(frameCount, xx, yy)+(int)random(masks.length));
  line( 0, xx, width, xx);
  rect( xx, yy, sz, sz, sz*-noise(xx));


  // fill(xx,yy,sz+noise(frameCount, yy, xx), 100);
  // stroke(xx, frameCount%255, yy);
	fill(random(7,245),100);
  stroke(frameCount%245);
  strokeWeight(random(7));  
  ellipse(yy,xx, sz, sz);
  

  //  xx, yy stuff
  xx += sz+noise(yy, frameCount, xx );



  if(frameCount%45==0){

    line(xx, 0, xx, height);

    deskTop = get();
    //  random mask
    //println("45 : "+ masks[(int)random(masks.length)] );
    deskTop.mask(masks[(int)random(masks.length)]);

    //  https://processing.org/reference/filter_.html
    filter(THRESHOLD);
//    filter(GRAY);
    filter(INVERT);
    filter(OPAQUE);
    filter(POSTERIZE, (int)random(2,255) );
    //filter(BLUR, (int)random(7));
    filter(ERODE);
    filter(DILATE);
    
    image(deskTop,0,0);
  }


  if ( xx >= width ) {
    yy += sz+noise(frameCount, xx, yy);
    xx = (int)random(sz);
  }

  //  stopper
  if(yy>=height){

    save(fix.pdeName()+fix.getTimestamp()+".png");

    exit();
  }
}
