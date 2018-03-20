/*

making the movie with FFMPEG

ffmpeg -framerate 6 -pattern_type glob -i 'OUT/*.tif' -i 'mp3/150rollwiddit.mp3' -c:v libx264 -pix_fmt yuv420p out.mp4

HACK: https://vimeo.com/235855181

used QT Screen Record

iMovie to drop music back on top then post to Vimeo

*/

import ddf.minim.*;
// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);


Minim minim;
//AudioInput in;
AudioPlayer player;

int FRAME_CT = 986;

int y, x, z, cx, cy, bfSz, radSz, mod;
float x1, x2;

int cirX, cirY, cirSz = 11, cirAng;

PImage bgFrame;

/////////////////////////////////////////////////////////////////////////////
void setup()
{
  size(1280, 720, "processing.opengl.PGraphics3D");

  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());

        //  Using hint(ENABLE_DEPTH_SORT) can improve the appearance of 3D geometry drawn to 2D file formats.
        hint(ENABLE_DEPTH_SORT);

  background(-1);

  strokeCap(PROJECT);
  
  cx = int(width/2);
  cy = int(height/2);

  minim = new Minim(this);
  
  
  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  player = minim.loadFile("mp3/150rollwiddit.mp3");
  
  // use the getLineIn method of the Minim object to get an AudioInput
  //in = minim.getLineIn();
  bfSz = player.bufferSize();  //player.bufferSize();
 
}


/////////////////////////////////////////////////////////////////////////////
void draw()
{
  
  
  

  
  
  //  FADE IN BACKGROUNDERS ( remember to change % to max number of PNGS )
  bgFrame = loadImage(frameCount%FRAME_CT +".png");
  if(bgFrame!=null && frameCount % 4 == 0){
    //background(bgFrame);
    tint(255, int(21 * (1 + player.left.level() + player.right.level()) ));
    image(bgFrame,0,0);

  }
   //<>//
  x = (frameCount%width);
  y = (frameCount%height);

  // the value returned by the level method is the RMS (root-mean-square) 
  // value of the current buffer of audio.
  // see: http://en.wikipedia.org/wiki/Root_mean_square
  //  EX: 0.022453465
  radSz = int(11 * (1 + player.left.level() + player.right.level()) );
  z = (frameCount%radSz);

  stroke(random(75));
  strokeWeight(11);
  line(  x, (cy - (player.left.level()*height))%height,
        x, (cy + (player.right.level()*height))%height );
  
    

  stroke(random(255),random(155),random(55));
  strokeWeight(TWO_PI);
  line(  x, (cy - (player.left.level()*height))%height,
        x, (cy + (player.right.level()*height))%height );





//drawLissajous( x, y, ( radSz + player.left.level() + player.right.level()) );

  //  WAVEFORMS
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  // note that if the file is MONO, left.get() and right.get() will return the same value
  

  for(int i = 0; i < bfSz - 1; i++)
  {

    //  CIRCLE CIRCLE DOT DOT
    cirAng = (i % 359);
      
    // hack circle increaser
    if(cirAng % 360 == 0)
    {
      cirSz *= 1.5;
    }
    cirSz = cirSz%width;
     
    cirX    = int(cx - int( cos(radians(cirAng)) * (cirSz + (player.left.level()*cx) ) ) );
    cirY    = int(cy - int( sin(radians(cirAng)) * (cirSz + (player.right.level()*cy) ) ) );
    //  hack safety
    cirX = cirX%width;
    cirY = cirY%height;

    strokeWeight(PI+(player.left.level()+player.right.level()));
    stroke(frameCount%255, 10*(player.left.level()+player.right.level()));
    point(cirX, cirY);
    
    if(radSz >= 16 && i % 4 == 0 ) {
    
    //  WAVEFORM    
        x1 = map( i, 0, bfSz, 0, width );
        x2 = map( i+1, 0, bfSz, 0, width );
      
      // hack
      //radSz = 50;
      
        //  LOWER WAVEFORMS
        strokeWeight(TWO_PI);
        stroke( radSz, 210 );
        point( x1, cy - (player.left.get(i) * 50) - (player.left.level()*cy) ); 
        point( x2, cy + (player.right.get(i+1)* 50) + (player.right.level()*cy) );
    
        strokeWeight(PI);
        stroke( random(200,255) );
        point( x1, cy - (player.left.get(i) * 50) - (player.left.level()*cy) ); 
        point( x2, cy + (player.right.get(i+1)* 50) + (player.right.level()*cy) );
    
    }
  }


  strokeWeight(.75+player.left.level()+player.right.level());
  noFill();  
  stroke(  x*(player.left.level()*height)%height,
           (player.right.level()*width)%width,
           radSz*PI,
           100);
           
  ellipse(cx, cy, 
            ( radSz + (player.left.level()*height))%height,
            ( radSz + (player. right.level()*width))%width );
 
 
 //if(frameCount % 2 == 0){

  //}
  
  
  
  // if the player is at the end of the file,
  // we have to rewind it before telling it to play again
  if ( player.position() == 181368 )  //player.length() )  // rollwidit length is 181368, not player.length()
  {
    // debug
    println( "pos : " + player.position() + " of " +  player.length() );
    save( fix.pdeName() + fix.getTimestamp() + ".png");

    player.pause();
    player = null;
    noLoop();
    exit();
    
  }
  else if ( ! player.isPlaying() )
  {
    player.play();
  }

  //  AUTO SAVER - to later re-assemble using movie maker and SAME mp3 from above
  //save("OUT/" + pdeName() + frameCount + ".png");
  //saveFrame("OUT/####.tif");


}



/////////////////////////////////////////////////////////////////////////////
void keyPressed()
{
  
  switch(key)
  {
    case 's':
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    break;
  }
  
  
}
