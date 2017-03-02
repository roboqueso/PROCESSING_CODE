/**
 * loading an image from the web or the harddisk with sDrop.
 */

import drop.*;

SDrop drop;

PImage m;

int dropCt = 0;

void setup() {
  size(400,400);
  frameRate(30);
  drop = new SDrop(this);
}

void draw() {
  background(frameCount%255);
  if(m !=null) 
  {
    loop();

    //  NOTE: if images get too big this doesn't work
    if(dropCt == 11) 
    {
      image(m,10,10);


      // NOTE: colors don't fully load until a handful of cycles through draw() 
      println("[draw]  m.pixels.length: "+m.pixels.length);

      noLoop();

    }
    else
    {
      dropCt++;
    }
  }
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
    m = theDropEvent.loadImage();

    dropCt = 1;
    loop();
  }
}