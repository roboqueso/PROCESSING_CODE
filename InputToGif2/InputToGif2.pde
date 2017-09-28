import ddf.minim.*;

Minim minim;
AudioInput in;
//AudioRecorder recorder;
Boolean recording = false;

int y, x, z, cx, cy, bfSz, radSz, mod;
float x1, x2;
import java.io.InputStreamReader;

void setup()
{
  size(420, 210);
  
  // Pulling the display's density dynamically
  
  cx = int(width/2);
  cy = int(height/2);

  minim = new Minim(this);
  
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  bfSz = in.bufferSize();

}


//////////////////////////////////////////////////////////////
void draw()
{
  background(recording?255:111); 
  stroke(255);
  
  /*
  // draw the waveforms
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
  }
  */
  for(int i = 0; i < bfSz - 1; i++)
  {

//  WAVEFORM    
    x1 = map( i, 0, bfSz, 0, width );
    x2 = map( i+1, 0, bfSz, 0, width );
  
  
    //  LOWER WAVEFORMS
    strokeWeight(TWO_PI);
    stroke( ((bfSz/x1+1)%255),  ((bfSz/x1+1)%200),  ((bfSz/x1+1)%100), 75);
    point( x1, cy - (in.left.get(i) * 50) - (in.left.level()*cy) ); 
    point( x2, cy + (in.right.get(i+1)* 50) + (in.right.level()*cy) );

    strokeWeight(PI);
    stroke( x%255,  x%200,  x%155, 175);
    point( x1, cy - (in.left.get(i) * 50) - (in.left.level()*cy) ); 
    point( x2, cy + (in.right.get(i+1)* 50) + (in.right.level()*cy) );




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
String[] params = { "/Users/ericfickes/Documents/Processing3/InputToGif2/doit.sh", gifName };
 

  
  
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