/*
P5 App : Record sound wave to gif.

App
- Start / Stop record button
- Always redraw background
- Save each frame to /FRAMES/*.png
- Call GIFSICLE to combine frames into gif
- Open new gif file

** What are app export and distribute options?
** Can you bundle all required libs w/P5 app? ( MINIM, GIFSICLE )


gifsicle ­l ­ O3 —dither —colors=4 ­d5 folder/image­*.gif > output.gif

// ­l loops the gif when it reaches the end of the sequence

// ­O3 applies some optimizations

// —dither applies the default dithering option

// —colors=4 number of colors to use

// ­d5 the delay (speed) between frames

// input files > output file

// generally aim for 500x500 && < 2MB 24­48 frames

*/

import java.io.InputStreamReader;

/**
  * This sketch demonstrates how to an <code>AudioRecorder</code> to record audio to disk. 
  * To use this sketch you need to have something plugged into the line-in on your computer, 
  * or else be working on a laptop with an active built-in microphone. 
  * <p>
  * Press 'r' to toggle recording on and off and the press 's' to save to disk. 
  * The recorded file will be placed in the sketch folder of the sketch.
  * <p>
  * For more information about Minim and additional features, 
  * visit http://code.compartmental.net/minim/
  */

import ddf.minim.*;

Minim minim;
AudioInput in;
//AudioRecorder recorder;
Boolean recording = false;

void setup()
{
  size(512, 200, P3D);
  background(150);
  
  minim = new Minim(this);

  in = minim.getLineIn();
}


//////////////////////////////////////////////////////////////
void draw()
{
  background(recording?0:150); 
  stroke(255);
  
  // draw the waveforms
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
  }
  

  if ( recording )
  {
    save("frames/"+fileStamp() + ".gif");
  }
  else
  { 
    //print  ("Not recording.", 5, 15);
  }

}

//////////////////////////////////////////////////////////////
void keyReleased()
{
  switch(key)
  {
    case 'r':
    {
      if ( recording ) 
      {
        //  stop
        recording = false;
      }
      else 
      {
        //recorder.beginRecord();
        recording = true;
      }
    }
    break;
    
    case 's':
    {
      //  cleanup
      in.close();

      gifsicle();
      exit();
    }
    break;
  }
}

/////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////
void gifsicle()
{
  // UPDATE: Use cmd line ImageMagick CONVERT command to make gif from frames
  // String[] params = { "/opt/ImageMagick/bin/convert", "-delay 0 -loop 0 /Users/ericfickes/Documents/Processing/gif_berzerker_magick/frames/*.png /Users/ericfickes/Documents/Processing/gif_berzerker_magick/" + split( SRC_GIF, ".")[0]+"_"+fileStamp()+".gif" };
  // String params = "/opt/ImageMagick/bin/convert -delay 0 -loop 0 /Users/ericfickes/Documents/Processing/gif_berzerker_magick/frames/*.png /Users/ericfickes/Documents/Processing/gif_berzerker_magick/" + split( SRC_GIF, ".")[0]+"_"+fileStamp()+".gif";
  // String[] params = { "/opt/ImageMagick/bin/convert", "-delay 0 -loop 0 /Users/ericfickes/Documents/Processing/gif_berzerker_magick/frames/*.png /Users/ericfickes/Documents/Processing/gif_berzerker_magick/" + fileStamp()+".gif" };
  String gifName = fileStamp()+".gif";
  
  try {

//  WORKS
String[] params = { "/Users/ericfickes/Documents/Processing3/InputToGif/doit.sh", gifName };
 

  
  
  Process p = exec(params);

    BufferedReader input = new BufferedReader(new InputStreamReader(p.getInputStream()));
println("about to readLine");
    String line;
    while ( (line = input.readLine ()) != null) 
    {
      println("PROCESS :: " + line);
    }
    
  }
  catch(Exception e) 
  {
    println(" !!!! EXCEPTION : " + e  + " !!!! ");
  }
}



/////////////////////////////////////////////////////////////////////////////

public String sketchName(){
  return split( this.toString(), "[")[0];
}
//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}