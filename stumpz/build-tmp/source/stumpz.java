import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import fixlib.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class stumpz extends PApplet {

// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);


boolean gotNoise = false, isFinal = true;

float x2=0, y2=0, cX, cY;
PVector thisPV, lastPV;

int sz = 11, angle = 0, nz_ct=1, maxNz = 360;
int[] nz;

public void setup() {
  
  background(210);
  frameRate(303);
  noFill();
  fix.alpha(42);
  cX = width/2;
  cY = height/2;
  nz = new int[967];
  
  //  init and manually reset X&Ys
  thisPV = new PVector(0,0);
  lastPV = new PVector(0,0);
  
  
  strokeWeight(HALF_PI);

  for( int yy = 0; yy <= 768; yy += (768/37) ){

    stroke(random(200,255) );
    line( 0, yy, 1024, yy );
    stroke(random(200,255) );
    line( yy, 0, yy, 1024 );
  }
  
}

public void draw() {

  thisPV.x = cX - PApplet.parseInt( cos(radians(frameCount)) * sz ) + nz[PApplet.parseInt(nz_ct)];
  thisPV.y = cY - PApplet.parseInt( sin(radians(frameCount)) * sz ) + nz[PApplet.parseInt(nz_ct)];
  x2 = cX - PApplet.parseInt( cos(radians(frameCount)) * sz*1.23f ) * nz[PApplet.parseInt(nz_ct)];
  y2 = cY - PApplet.parseInt( sin(radians(frameCount)) * sz*1.23f ) * nz[PApplet.parseInt(nz_ct)];

  //  making noise
  if (frameCount < maxNz )
  {
    nz[frameCount-1] = PApplet.parseInt(random(-11,11)*cos(frameCount)*sin(frameCount));
  }

  
  strokeWeight(TWO_PI);
  stroke(random(200,255), 222);
  point( thisPV.x, thisPV.y );


  strokeWeight(1);
  stroke(random(11,42));
  ellipse( x2, y2, 11, 11 );


//  strokeWeight(HALF_PI);
//  stroke(random(255), random(42), random(11), 100 );
//  line(  thisPV.x - nz[int(nz_ct)],
//          thisPV.y - nz[int(nz_ct)], 
//          x2, y2 );

  //  connect the dots, ah la la la
//  if( lastPV.x > 0 && lastPV.y > 0 ) {
//    strokeWeight(.99999);
//    stroke(random(53),random(35),random(99), 100 );
//
//    bezier( cX, cY, 
//            thisPV.x, thisPV.y,
//            lastPV.y, lastPV.x,
//            x2, y2);
//  }

  if ( frameCount % 360 == 0 ) {
    sz += 21;

  }

  // Keep the nz_ct in sync with the frameCount<360 
  if ( nz_ct < maxNz ) {
    nz_ct++;
  } 
  else {
    nz_ct = 1;
  }

  //  set for next time around
  lastPV = thisPV;


  //  STOPPER
  if ( thisPV.y > 768)
  {

    fill(0xffEFEFEF);
    textFont(createFont("Silom", 23));

    //    TOP RIGHT CORNER-ISH ( between the time and the battery )
    text("ERICFICKES.COM", 3, height-11 );  // 28

    if (isFinal) {
      save( fix.pdeName() + fix.getTimestamp()+".png" );
    }
    noLoop();
    exit();
  }
}




///////////////////////////////////////////////////////////////////////
public void fix.bullsEye( float a, float b, float shapeSize ) {

  int tmp = (int)shapeSize;

  while (  tmp >= 0 ) {

    strokeWeight(tmp/24);
    fill(0);
    stroke(255);

    ellipse( a, b, tmp, tmp);
    tmp -= PApplet.parseInt(shapeSize/6);
  }
}

  public void settings() {  size(1024, 768); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "stumpz" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
