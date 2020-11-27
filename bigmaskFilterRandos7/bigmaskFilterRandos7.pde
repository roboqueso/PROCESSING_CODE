//  SEE:   https://ello.co/ericfickes/post/ea1nocrbbpdonof1i4xnew
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;
Fixlib fix = Fixlib.init(this);


PImage deskTop;
PImage[] masks;  // array of PImage masks
int xx = 0, yy = 0, sz = 45;



void settings(){
  // NOTE: match to mask size
  size(3360, 2100);
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}


////////////////////////////////////////////////////////////////////////
void setup() {

  background(-1);
  frameRate(420);
  noFill();
  ellipseMode(CENTER);
  rectMode(CENTER); 
  strokeCap(ROUND); 
  strokeJoin(ROUND);
  masks = new PImage[3];

  // keep track of the masks
  masks[0] = loadImage("1.png");
  masks[1] = loadImage("2.png");
  masks[2] = loadImage("3.png");


  imageMode(CORNER);

}

/////////////////////////////////////////////////////////////////////
void draw() {
  
  //fill(getSeven(xx,245), sz, getSeven(7,245), getSeven(sz,245));
    fill(sz, getSeven(xx,245), getSeven(7,245), getSeven(sz,245));

  stroke(getSeven(7,245));
  strokeWeight(random(.7,2.8));

  line( 0, xx, yy, xx);
  ellipse(yy,xx, sz, sz);
  
  noFill();
strokeWeight(getSeven(7,sz));  
  rect( xx, yy, sz, sz);
  
  strokeWeight(getSeven(1,sz));
  point( getSeven(sz,xx), getSeven(sz,yy) );
 point( yy,yy);
  point( yy, xx);



  if(frameCount%sz==0){


    line(xx, 0, xx, height);

    deskTop = get(0,0,3360, 2100);

    deskTop.mask(masks[(int)random(masks.length)]);

    //  https://processing.org/reference/filter_.html
    filter(POSTERIZE, (int)getSeven(7,245) );
    filter(DILATE);

 tint(getSeven(7,245), getSeven(7,245), getSeven(7,245), getSeven(70,140) );
    stroke(getSeven(7,yy), getSeven(sz ,xx), getSeven(7,245), 245);
    strokeWeight(sz);

    rect(xx,yy,getSeven(sz,xx), getSeven(sz,yy), -getSeven( (int)random(sz), sz) );

    //	slap it down
    image(deskTop, 0,0, random(width), random(height));

    //	one w/flavor
filter(INVERT);
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
  if(frameCount>height ){

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
