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
  stroke(recording ?0:255);
  

  strokeWeight( (1 + in.left.level() + in.right.level()) );

  // draw the waveforms
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  for(int i = 0; i < bfSz - 1; i++)
  {
    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
  }


//  DON'T RECORD LOW NOISE FRAMES
if( (in.left.level() + in.right.level()) > 0.011 ){

    println( "GOOD: levels : " + (in.left.level() + in.right.level()) );

  if ( recording )
  {
    save("frames/"+fileStamp() + ".gif");
  }


}

}



////////////////////////////////////////////////////////////////////////////////////
void gifsicle()
{
/*
TODO:
  
*/
  String gifName = fileStamp()+".gif";
  
  try {
    //  NOTE:
    //  - This assumes doit.sh script is in the same folder as this pde
    //  - ARG1 = the path to this sketch directory
    //  - ARG2 = the final output gif name
    String[] params = { sketchPath("") + "doit.sh", sketchPath(""), gifName };
    Process p = exec(params);

    BufferedReader input = new BufferedReader(new InputStreamReader(p.getInputStream()));
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


/////////////////////////////////////////////////////////////////////////////

public String sketchName(){
  return split( this.toString(), "[")[0];
}
//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}