/*
SEVEN UNTIL AUGUST AND CURRATE FOR ART CLASS
* just keep arting

STEREOGRAM : make magic  eye

EVE- the inspiration
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
int randX, randY, randZ;

/////////////////////////////////////////////////////////////////////
void setup() {
  size(1260, 840, P3D); // TODO : stick with P3D or P2D?
  masks = new PImage[7];

  // keep track of the masks
  masks[0] = loadImage("seven.png");
  masks[1] = loadImage("six.png");
  masks[2] = loadImage("five.png");
  masks[3] = loadImage("four.png");
  masks[4] = loadImage("three.png");
  masks[5] = loadImage("two.png");
  masks[6] = loadImage("one.png");

	smooth(sz);
	textSize(sz);
}

/////////////////////////////////////////////////////////////////////
void draw() {
  
  fill(getSeven(xx,245), sz, getSeven(7,245), getSeven(sz,245));
  stroke(getSeven(7,245));
  
  strokeWeight(random(.7,2.8));
  line( 0, xx, frameCount,  random(yy) , xx,frameCount);
  
  noFill();

	randY = (int)random(yy);
  	shp = shape7(xx, randY, int(sz*noise(frameCount) ));

  	shape(shp, randY , xx, sz, sz);

	strokeWeight(random(sz));
	shape(shp, (randY*sz)%width , xx, sz, sz);

	randX = getSeven(sz,xx);
	randY = getSeven(sz,yy);
	randZ = getSeven(sz,frameCount);
	
	point( randX, randY, randZ );
	point( (randX*sz)%width, randY, randZ );




  if(frameCount%sz==0){


    //  GET SHAPE
    randZ = (int)sqrt(1+noise(frameCount, xx, yy)+(int)getSeven(masks.length, sz));
    shp = shape7(yy, xx, randZ);  

    // stroke(242);
    stroke(getSeven(7,245));
    
    strokeWeight(randZ);
    shape(shp, xx, yy, sz, sz);

    strokeWeight(randZ/PI);
	shape(shp, (xx*sz)%width, yy, sz, sz);

    // vertical
    line(xx, 0, xx, height);

      //  GET SHAPE
    shp = shape7(yy,xx,getSeven(sz,xx)*7 );

    shape(shp, yy,xx, sz, sz);
    shape(shp, (yy*sz)%width,xx, sz, sz);
    

    deskTop = get();
    deskTop.mask(masks[(int)random(masks.length)]);

    //  https://processing.org/reference/filter_.html
    filter(POSTERIZE, (int)getSeven(7,245) );
    filter(DILATE);

    tint(getSeven(7,245), getSeven(7,245), getSeven(7,245), getSeven(70,140) );
    //
    stroke(getSeven(7,245));
    //strokeWeight(sz);

    rect(xx,yy,getSeven(sz,xx), getSeven(sz,yy), -getSeven( (int)random(sz), sz) );
    shp = shape7(xx,yy,getSeven(sz,xx)+getSeven(sz,yy));  


    randX = getSeven(sz,xx);
    randY = getSeven(sz,yy);
    shape(shp, randX,  randY, xx,yy);
    shape(shp, (xx*sz)%width,yy, randX, randY );

    //	slap it down
    image(deskTop, 0,0, frameCount%width, frameCount%height);

    randZ = (int)TWO_PI;
    strokeWeight(randZ);

    randX = getSeven(sz,xx);
    randY = getSeven(sz,yy);

    shape(shp, xx,yy, randX, randY);

    strokeWeight(HALF_PI);
	shape(shp, (xx*sz)%width,yy,randX, randY);


	strokeWeight(sz*noise(frameCount));
	noFill();

    rotate(PI/sz, 1, 1, 0);
    filter(INVERT);
    tint(randX,randY, getSeven(xx, width));
	image(deskTop, getSeven(sz,randX),getSeven(sz,randY), getSeven(xx, width), getSeven(yy, height) );

	stroke(frameCount%255);
	rect(0, 0, width, height);
	
	scale(-1, 1, 0);
	image(deskTop, 0, 0);//, width/2, height);


	rotate(TWO_PI/sz, 1, 1, 0);
	image(deskTop, 0, 0, width, height);



	scale(1, -1, -1);
	image(deskTop, width/2, 0);//, width/2, height);

stroke(frameCount%255);
rect(width/2, 0, deskTop.width, deskTop.height);
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

    save(this+".png");

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


