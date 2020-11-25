//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);


PImage deskTop;
PImage[] masks;  // array of PImage masks
int xx = 0, yy = 0, sz = 45;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    //size(displayWidth, displayHeight, P3D);//, P3D, P2D, FX2D  NOTE: P2D throwing tesselation errors
    size(2760, 3672, P3D);// P3D or P2D??? // FX2D can't handle this sketch
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
  
  fill(sz+noise(frameCount, yy, xx),xx,yy, 180);
  stroke(xx, yy, sz+noise(frameCount, xx, yy));
  
  strokeWeight(1+noise(frameCount, xx, yy)+(int)random(masks.length));
  line( 0, xx, 2760, xx);
  rect( xx, yy, sz, sz, sz*-noise(xx));


  fill(xx,yy,sz+noise(frameCount, yy, xx), 180);
  stroke(xx, frameCount%255, yy);
  strokeWeight(random(7));  
  ellipse(yy,xx, sz, sz);
  

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


  if ( xx >= 2760 ) {
    yy += sz+noise(frameCount, xx, yy);
    xx = (int)random(sz);
  }

  //  stopper
  //if(yy>=height){
    if(xx>width){

    save(fix.pdeName()+fix.getTimestamp()+".png");

    exit();
  }
}



//////////////////////////////////////////////////////////////////
//void saveMask()
//{
//  PImage mask1, mask2, mask3, mask4, mask5, mask6, mask7;
//  PImage deskTop = get();
  
//  mask1 = loadImage("1_rainbow.png");
//  mask2 = loadImage("2_hearts.png");
//  mask3 = loadImage("3_diamonds.png");
//  mask4 = loadImage("4_crystals.png");
//  mask5 = loadImage("5_stars.png");
//  mask6 = loadImage("6_peace_signs.png");
//  mask7 = loadImage("7_moon.png");
  
//  deskTop.mask(mask1);
//  image(deskTop,0,0);
//  deskTop.mask(mask2);
//  image(deskTop,0,0);
//  deskTop.mask(mask3);
//  image(deskTop,0,0);
//  deskTop.mask(mask4);
//  image(deskTop,0,0);
//  deskTop.mask(mask5);
//  image(deskTop,0,0);
//  deskTop.mask(mask6);
//  image(deskTop,0,0);
//  deskTop.mask(mask7);
  
//  //background(255);
//  image(deskTop,0,0);
//  save(fix.pdeName()+fix.getTimestamp()+".png");
//  //saveFrame(this+".tiff");
//}





/*
PImage img, mask1, mask2, mask3, mask4, mask5, mask6, mask7, mask8;

int xx = 0, yy = 0, sz = 14;


///////////////////////////////////////////////////////////////////////////
void setup() {
  size(420, 420);
  background(255);

  mask1 = loadImage("1_rainbow.jpg");
  mask2 = loadImage("2_hearts.jpg");
  mask3 = loadImage("3_diamonds.jpg");
  mask4 = loadImage("4_crystals.jpg");
  mask5 = loadImage("5_stars.jpg");
  mask6 = loadImage("6_peace_signs.jpg");
  mask7 = loadImage("7_moon.jpg");
  // test jpg
  mask8 = loadImage("trek.jpg");
}


///////////////////////////////////////////////////////////////////////////
void draw() {

  stroke(xx, yy, sz+noise(frameCount, xx, yy));
  strokeWeight(1+noise(frameCount, xx, yy));

  rect( xx, yy, sz, sz, sz*noise(xx));

  //  xx, yy stuff
  xx += sz+noise(frameCount, xx, yy);


  if ( frameCount % 42 == 0 ) {
    img = get(0,0,width,height);
    //  mask it down
    img.mask(mask1);
background(random(255));
    img.mask(mask2);
background(random(255));
    img.mask(mask3);
background(random(255));
    img.mask(mask4);
background(random(255));
    img.mask(mask5);
background(random(255));
    img.mask(mask6);
background(random(255));
    img.mask(mask7);
background(random(255));
    img.mask(mask8);
background(random(255));
    image(img, 0, 0);
    println("just happeneD");
  }



  if ( xx >= width ) {
    yy += sz+noise(frameCount, xx, yy);
    xx = (int)random(sz);
  }

  //  stopper
  if ( yy > height )
  {
    // do it
    img = get(0,0,width,height);
    //  mask it down
    img.mask(mask1);
    img = get(0,0,width,height);
    img.mask(mask2);
    img = get(0,0,width,height);
    img.mask(mask3);
    img = get(0,0,width,height);
    img.mask(mask4);
    img = get(0,0,width,height);
    img.mask(mask5);
    img = get(0,0,width,height);
    img.mask(mask6);
    img = get(0,0,width,height);
    img.mask(mask7);
    img = get(0,0,width,height);
    img.mask(mask8);
    image(img, 0, 0);
    
    save(img+".jpg");

    image(img, 0, 0);
    save(this+".jpg");
    exit();
  }
}


void keyPressed() {
  if (key == 'm') 
  {
    println("Sup M?");
    img = get(0,0,width,height);
    
    img.mask(mask1);
    
    image(img,0,0);
  } else if ( key == 'd')
  {
    image(mask1,0,0);
  }

}
*/
