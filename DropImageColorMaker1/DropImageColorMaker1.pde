// https://github.com/ericfickes/FIXLIB	
import fixlib.*;

Fixlib fix = Fixlib.init(this);

//	JAVA
import java.util.*;

//	TODO: figure out how to tap into native drag n drop
//
// import drop.*;


//  image action
PImage img;
int randColor;
int imgPixCt;

// see: http://docs.oracle.com/javase/1.4.2/docs/api/java/util/ArrayList.html


// SDrop drop;

void setup() {
  size(displayWidth,displayHeight);
  background(-1);
  // drop = new SDrop(this);
  fix.alpha(100);
  img = loadImage("black_blue_pink.png");
}

void draw() {

  if(img!=null)
  {

//  NOTE: this needs to be smartened up


    image(img,10,10);

    suck(img);
    

    noLoop();

  } else {

      fill(0);
      textSize(66);
      textAlign(CENTER);
      text("DON'T HAVE COW", (width/2), (height/2) );
    }
}




void suck(PImage img){

	//	get unique colors from image
	ArrayList<Integer> result = fix.getImgColors(img);

//  SPIT OUT ARRAY
	// for (String ii : _colors) {
	for (Integer ii : result) {
		println( "#" + hex(ii, 6) + ", " );
	}

fix.paletteGrid(result);

// println("suck " + img + "\n color ct: " + result.size() );

//	Replace ALL image pixesl with de-duped set?
// img.pixels = convertIntegers( result );
// img.updatePixels();

// delay(1000);


	
}

public static int[] convertIntegers(ArrayList<Integer> ints)
{
    int[] ret = new int[ints.size()];

	// for (Integer ii : ints) {
	for ( int c = 0; c < ints.size(); c++ )
	{
		// ret[ii] = ints.get(ii);
		ret[c] = ints.get(c);
    }
    return ret;
}



/**

Drop library doesn't loadImage like standard loadImage does
find replacement

	NOTE: dropEvent doesn't seem to load image correctly

void dropEvent(DropEvent theDropEvent) 
{
  
  // if the dropped object is an image, then 
  // load the image into our PImage.
  if(theDropEvent.isImage()) {
    println("### loading image ...");
    img = theDropEvent.loadImage();
    img.loadPixels();
    img.resize(width/2,height/2);
    loop();
  }
}

*/