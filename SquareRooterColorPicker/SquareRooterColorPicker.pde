//	JAVA
import java.util.*;
//	//
import drop.*;


//  image action
PImage img;
int randColor;
int imgPixCt;
int ct = 0;
// see: http://docs.oracle.com/javase/1.4.2/docs/api/java/util/ArrayList.html
int dropCt = 0;

ArrayList<Integer> colors;

SDrop drop;

void setup() {
  size(666,666);
  background(255);
  drop = new SDrop(this);
}


int boxW, boxH;

void draw() {
  background(frameCount%255);
  if(img !=null) 
  {
    loop();

    //  NOTE: if images get too big this doesn't work
    if(dropCt == 11) 
    {
      colors = suck(img);

      image(img,10,10, width-10, height-10 );

      boxW = int( (width/colors.size())-TWO_PI );
      boxH = int( (height/colors.size())-TWO_PI );

      for (Integer item : colors) {
        // println("item: "+ hex(item,6));
        println( "#" + hex(item, 6) + ", " );

noFill();
        stroke( item );
        strokeWeight(-boxW);

        rect( random(width), 
              random(height), boxW, boxH );

        line(frameCount%width, 0, frameCount%width, height);
      }

      // NOTE: colors don't fully load until a handful of cycles through draw() 
      // println("[draw]  img.pixels.length: "+img.pixels.length);

      noLoop();

    }
    else
    {
      dropCt++;
    }
  }
}


///////////////////////////////////////////////////////////////
//  Color suck function based on double root magic
ArrayList<Integer> suck(PImage img)
{
/////////
int root1, root2;
int sum1 = 0;
int sum2 = 0;

ArrayList<Integer> colors1 = new ArrayList<Integer>();
ArrayList<Integer> colors2 = new ArrayList<Integer>();

/////////
  loadPixels();

  println("img.pixels.length: "+img.pixels.length);
/*
root1 = int(sqrt(img.pixels.length));
root2 = int(sqrt(root1));

  println("root1 : "+root1 );
  println("root2 : "+root2 );

  //  root1
  for (int ii = 0; ii < img.pixels.length-1; ++ii) 
  {  
    sum1 += img.pixels[ii];
    //  perform AVERAGE of every root1 numbers
    if(ii%root1==0)
    {
      colors1.add( int(sum1/root1) );
    } 
  }

// println("colors1.size() : "+colors1.size() );


  //  root2
  for (int ii = 0; ii < colors1.size()-1; ++ii) 
  {  
    sum2 += (int)colors1.get(ii);
    //  perform AVERAGE of every root1 numbers
    if(ii%root2==0)
    {
      colors2.add( int(sum2/root2) );
    } 
  }

println("colors2.size() : "+colors2.size() );


return colors1;


*/


// Store unique items in result.
	ArrayList<Integer> result = new ArrayList<Integer>();
	HashSet<Integer> set = new HashSet<Integer>();

	// UNIQUE
	for (Integer item : img.pixels) {
	    if (!set.contains(item)) {
  		result.add(item);
  		set.add(item);
	    }
	}


root1 = (int)sqrt(result.size())+6;
  //  root1
  for (int ii = 0; ii < result.size()-1; ++ii) 
  {  

    //  perform AVERAGE of every root1 numbers
    if(ii%root1==0)
    {
      colors1.add( result.get(ii) );
    } 
  }


println("result.size(): "+result.size());
println("colors1.size(): "+colors1.size());

return colors1;

}

void dropEvent(DropEvent theDropEvent) {
  loop();
  println("");
  println("isFile()\t"+theDropEvent.isFile());
  println("isImage()\t"+theDropEvent.isImage());
  println("isURL()\t"+theDropEvent.isURL());
  
  // if the dropped object is an image, then 
  // load the image into our PImage.
  if(theDropEvent.isImage()) {
    println("### loading image ...");
    img = theDropEvent.loadImage();
    colors = null;
    dropCt = 1;
    loop();
  }
}