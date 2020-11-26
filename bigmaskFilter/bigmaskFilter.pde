//  SEE:   https://ello.co/ericfickes/post/oj_e0deasgrluljttb2trq
//  GOTO:  https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);


PImage deskTop;  
PImage[] masks;  // array of PImage masks
int xx = 0, yy = 0, sz = 69;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(2760, 3672);
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
  background(-1);
  frameRate(666);
  masks = new PImage[8];  // NOTE : keep PImage size in sync with how many images you are loading below

  // keep track of the masks
  masks[0] = loadImage("lasers1.png");
  masks[1] = loadImage("lasers2.png");
  masks[2] = loadImage("lasers3.png");
  masks[3] = loadImage("lasers4.png");
  masks[4] = loadImage("lasers5.png");
  masks[5] = loadImage("lasers6.png");
  masks[6] = loadImage("lasers7.png");
  masks[7] = loadImage("lasers8.png");
}



void draw() {
  
  filter(INVERT);
  
  
  fill(xx,yy,sz+noise(frameCount, yy, xx), 180);
  //stroke( sz+noise(frameCount, xx, yy), xx, yy);
  stroke( yy, sz+noise(frameCount, xx, yy), xx );
  
  strokeWeight(1+noise(frameCount, xx, yy)+(int)random(masks.length));
  line( 0, xx, 2760, xx);
  rect( xx, yy, sz, sz, -sz*noise(xx));


  fill(xx,sz+noise(frameCount, yy, xx),yy, 180);
  //stroke(xx, frameCount%255,  yy);
  stroke(frameCount%255, xx, yy);

  strokeWeight(random(7));
  ellipse( yy,xx, sz, sz);
 
  //  xx, yy stuff
  xx += sz+noise(yy, frameCount, xx );



  if(frameCount%45==0){

    line(xx, 0, xx, 3672);

    deskTop = get(0,0,2760, 3672);
    //  random mask
    //println("42 : "+ masks[(int)random(masks.length)] );
    deskTop.mask(masks[(int)random(masks.length)]);

    //  https://processing.org/reference/filter_.html
    filter(THRESHOLD);
//    
    if(xx%4==0){
      filter(INVERT);
    } else {
      filter(GRAY);
    }

    filter(OPAQUE);
    filter(POSTERIZE, (int)random(2,255) );
    //filter(BLUR, (int)random(7));
    filter(ERODE);
    filter(DILATE);
    
    image(deskTop,0,0,2760, 3672);
  }


  if ( xx >= width ) {
    yy += sz+noise(frameCount);//, xx, yy);
    xx = (int)random(sz);
  }

  //  stopper
  if(yy>=(width/2)){

     save(fix.pdeName()+fix.getTimestamp()+".png");

    exit();
  }
}
