// SEE :  https://ello.co/ericfickes/post/en4ahtzb23mjdkc9xyqwwa
// GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);

public int color1 = #EF4521, color2 = 75;
public String label = "ERICFICKES.COM";

boolean gotNoise = false;
public Boolean isFinal = true;
float[] nz = new float[1000];
float xx=0,yy=0;
public float dWidth, dHeight;

///////////////////////////////////////////////////////////////////////////////////////////////

void  settings ()  {
    size(displayWidth, displayHeight, FX2D); //"processing.opengl.PGraphics3D");
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */

void setup() {

    background(255);//#373737);
    frameRate(666);
    noFill();

	dWidth = displayWidth;
	dHeight = displayHeight;
}

/////////////////////////////////////////////////////////////////////////////////////////////// 
void draw() {
 
    strokeWeight(random(11));
    stroke(color1 );
    point( random(-yy,yy), random(-xx,xx));
    
    strokeWeight(1);
    stroke(color2, 37 );
    line(random(-yy,yy), yy, xx, yy);
  
    if(frameCount < 999 )
    {
        nz[frameCount-1] = random(-TWO_PI,7)*noise(frameCount-1);
    }

  if(yy <= dHeight){
    xx += nz[int(yy%nz.length)];
    yy += HALF_PI;
  } else {
    yy =0;
    xx += ( xx <= dWidth ) ? QUARTER_PI : -xx;
  }
 
  if( xx < 0 ) xx = random(dWidth);
 
  if(  xx >= dWidth && yy >= dHeight){
    xx = random(PI);
    yy = random(PI);
    strokeWeight(random(TWO_PI));
  }
    
    stroke(random(255));
    strokeWeight(random(PI));
    
    point( xx, yy );

 
 
    if( frameCount>(dWidth+dHeight)*11)
    {

      fill(255);
      textFont(createFont("Silom",23));
      
      //    TOP RIGHT CORNER-ISH ( between the time and the battery )
      text( label, (dWidth/2), 23 );

        
        if(isFinal){
          save( pdeName()+getTimestamp() + ".PNG" );
        }
        
        noLoop();
    }
}
 
 

///////////////////////////////////////////////////////////////////////////////////////////////
String getTimestamp() {
  return ""+month()+day()+year()+hour()+minute()+second()+millis()+"";
}


///////////////////////////////////////////////////////////////////////////////////////////////
//  TODO: Is there a better way to get the current sketch name?
String pdeName() {
  return split( this.toString(), "[")[0];
}
