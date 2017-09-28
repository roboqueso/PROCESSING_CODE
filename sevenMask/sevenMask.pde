/*
Base with color ( x,y powered RGB )
 
 SEVEN
 
 1. Rainbows
 2. hearts
 3. diamonds
 4. crystals
 5. stars
 6. peace signs
 7. moon
 
 
 photo = loadImage("test.jpg");
 maskImage = loadImage("mask.jpg");
 photo.mask(maskImage);
 */


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