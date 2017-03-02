import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.*; 
import drop.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class DropImageColorMaker1 extends PApplet {

//	JAVA

//	//



//  image action
PImage img;
int randColor;
int imgPixCt;

// see: http://docs.oracle.com/javase/1.4.2/docs/api/java/util/ArrayList.html


SDrop drop;

public void setup() {
  
  background(255);
  drop = new SDrop(this);
}

public void draw() {

  if(img!=null)
  {
    background(255);

//  NOTE: this shit is wack

    //  LOWER COLOR COUNT
    img.filter(ERODE);
    suck(img);
    image(img,10,10);
    noLoop();

  } else {

      fill(0);
      textSize(66);
      textAlign(CENTER);
      text("DON'T HAVE COW", (width/2), (height/2) );
    }
}




public void suck(PImage img){
  String tmpHx;
  println("suck " + img);
  /*
  delay(1000);

  // ArrayList _colors = new ArrayList();
  StringList _colors = new StringList();

   // #AAAAAA, #BBBBBB, #CCCCCC, #DDDDDD, #EEEEEE, #FFFFFF, #666000, #066600, #006660, #000666 
  for( int cc = 0; cc <= img.pixels.length-1; cc++)
  {
    // if( cc % 666 == 0 )
    // {
      //  cast to String as haxor technique for tracking UNIQUE HEX colors
      tmpHx = hex(img.pixels[ cc ], 6);

      if( ! _colors.hasValue( tmpHx ) )
      {        
          //  track the colors
          _colors.append( tmpHx );
      }
    // }
  }
*/

// Store unique items in result.
	ArrayList<Integer> result = new ArrayList<Integer>();
	HashSet<Integer> set = new HashSet<Integer>();

	
	for (Integer item : img.pixels) {
	    if (!set.contains(item)) {
		result.add(item);
		set.add(item);
	    }
	}

//	Replace ALL image pixesl with de-duped set?
// img.pixels.clear();
// img.pixels.addAll(hs);
img.pixels = result.toArray();

img.updatePixels();

delay(1000);


      //  SPIT OUT ARRAY
      // for (String ii : _colors) {
      for (Integer ii : result) {
        println( "#" + hex(ii, 6) + ", " );
      }
}

public void dropEvent(DropEvent theDropEvent) 
{
  
  // if the dropped object is an image, then 
  // load the image into our PImage.
  if(theDropEvent.isImage()) {
    println("### loading image ...");
    img = theDropEvent.loadImage();
    img.loadPixels();
    img.resize(width/2,height/2);
    // loop();
  }
}
  public void settings() {  size(666,666); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "DropImageColorMaker1" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
