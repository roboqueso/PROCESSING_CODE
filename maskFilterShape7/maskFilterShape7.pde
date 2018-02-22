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

PShape shp;

PImage deskTop;
PImage[] masks;  // array of PImage masks
int xx = 0, yy = 0, sz = 42;

/////////////////////////////////////////////////////////////////////
void setup() {
  size(1260, 840, P2D); // TODO : stick with P3D or P2D?
  masks = new PImage[7];

  // keep track of the masks
  masks[0] = loadImage("one.png");
  masks[1] = loadImage("two.png");
  masks[2] = loadImage("three.png");
  masks[3] = loadImage("four.png");
  masks[4] = loadImage("five.png");
  masks[5] = loadImage("six.png");
  masks[6] = loadImage("seven.png");

  smooth(sz);
  // imageMode(CORNER);

}

/////////////////////////////////////////////////////////////////////
void draw() {
  
  fill(getSeven(xx,245), sz, getSeven(7,245), getSeven(sz,245));
  stroke(getSeven(7,245));
  
  strokeWeight(random(.7,2.8));
  line( 0, xx, random(yy) , xx);
  noFill();
  shp = shape7(xx, yy, int(sz*noise(frameCount) ));  
  shape(shp,  random(yy) , xx, sz, sz);

  point( getSeven(sz,xx), getSeven(sz,yy) );
  // point( yy, xx);



  if(frameCount%sz==0){


    //  GET SHAPE
    shp = shape7(yy, xx, sz*7);  

    stroke(242);
    strokeWeight(sqrt(1+noise(frameCount, xx, yy)+(int)getSeven(masks.length, sz)));
    shape(shp, xx, yy, sz, sz);

    // vertical
    line(xx, 0, xx, height);

      //  GET SHAPE
    shp = shape7(xx,yy,getSeven(sz,xx)*7 );  
    shape(shp, yy,xx, sz, sz);
    

    deskTop = get();
    deskTop.mask(masks[(int)random(masks.length)]);

    //  https://processing.org/reference/filter_.html
    filter(POSTERIZE, (int)getSeven(7,245) );
    //filter(BLUR, (int)getSeven(0,7));
    filter(DILATE);

    //tint(getSeven(7,245), getSeven(7,245), getSeven(7,245), getSeven(70,140) );
    stroke(getSeven(7,xx), getSeven(sz ,245), getSeven(7,yy), 245);
    strokeWeight(sz);

    // rect(xx,yy,getSeven(sz,xx), getSeven(sz,yy), -getSeven( (int)random(sz), sz) );
    shp = shape7(xx,yy,getSeven(sz,xx)+getSeven(sz,yy));  
    shape(shp, xx,yy,getSeven(sz,xx), getSeven(sz,yy));

    //	slap it down
    image(deskTop, 0,0 );

    strokeWeight(PI);
    shape(shp, xx,yy,getSeven(sz,xx), getSeven(sz,yy));


    //	one w/flavor
    // filter(INVERT);
    tint(getSeven(7,245), getSeven(7,245), getSeven(7,245), getSeven(70,203) );
    image(deskTop, getSeven(sz,xx),getSeven(sz,yy), getSeven(xx, width), getSeven(yy, height) );
    
  }



  //  xx, yy stuff
  xx += sz+noise(yy, frameCount, xx );

  if ( xx >= width ) {
    yy += sz+noise(frameCount, xx, yy);
    xx = (int)getSeven(1,sz);
  }

  if( yy >= height ){
    yy = (int)getSeven(1,sz); 
  }


  //  stopper
  if(frameCount>width ){

    save(fix.pdeName()+fix.getTimestamp()+".png");

    exit();
  }
}


// 
// Pick a random multiple of 7 between a min and max num
// 
int getSeven(int min, int max)
{
  int safecatch = 1, val=1;

	//	be safe
	if((min<max) && max>0)
	{
	  while( ((val%7)!=0 ) && safecatch<7)
	  {
	    val = (int)random(min,max);
	    // don't loop more than 7 times
	    safecatch++;
	  }
	}
  return val;
}



//  
//  Create a PShape of 7 points, centered at specified cx, cy
PShape shape7(int cx, int cy, int sz)
{  
  //  createShape(kind, params)
  //  @kind   int: either POINT, LINE, TRIANGLE, QUAD, RECT, ELLIPSE, ARC, BOX, SPHERE
  //  @p      float[]: parameters that match the kind of shape
  PShape shape7;
  
  shape7 = createShape();
  shape7.beginShape();

  //  LET'S BE POSITIVE
  cx = ( cx < 0 ) ? -cx : cx;
  cy = ( cy < 0 ) ? -cy : cy;


  for (int i = 0; i < 6; i = i+1) 
  {
    //  pick seven points using circle logic
    shape7.vertex(   cx - int( cos(radians(random(360))) * sz ),
                      cy - int( sin(radians(random(360))) * sz ) );
  }
  
  shape7.endShape(CLOSE);

  return shape7;
}


