/*
Base with color ( x,y powered RGB )
 
 SEVEN items from Eve
 
 1. Rainbows
 2. hearts
 3. diamonds
 4. crystals
 5. stars
 6. peace signs
 7. moon

filters ( no gray )

stroke shades of gray

 */



PImage deskTop;
PImage[] masks;  // array of PImage masks
int xx = 0, yy = 0, sz = 42;

void setup() {
  size(1260, 840);
  masks = new PImage[6];

  // keep track of the masks
  masks[0] = loadImage("bigmask.png");
  masks[1] = loadImage("bigmask_black.png");
  masks[2] = loadImage("diamonds_black_wbg.png");
  masks[3] = loadImage("diamonds_black.png");
  masks[4] = loadImage("diamonds_bw.png");
  masks[5] = loadImage("diamonds_white.png");
}

void draw() {
  

  // fill(sz+noise(frameCount, yy, xx),xx,yy, 200);
  // stroke(xx, yy, sz+noise(frameCount, xx, yy));
  fill(random(7,245), 200);
  stroke(frameCount%245);
  
  strokeWeight(1+noise(frameCount, xx, yy)+(int)random(masks.length));
  line( 0, xx, width, xx);
  rect( xx, yy, sz, sz, sz*-noise(xx));


  // fill(xx,yy,sz+noise(frameCount, yy, xx), 200);
  // stroke(xx, frameCount%255, yy);
	fill(random(7,245),200);
  stroke(frameCount%245);
  strokeWeight(random(7));  
  ellipse(yy,xx, sz, sz);
  

  //  xx, yy stuff
  xx += sz+noise(yy, frameCount, xx );



  if(frameCount%42==0){

    line(xx, 0, xx, height);

    deskTop = get();
    //  random mask
    //println("42 : "+ masks[(int)random(masks.length)] );
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