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

public class NoiseOutsideThePyramid extends PApplet {

// https://github.com/ericfickes/FIXLIB	


Fixlib fix = Fixlib.init(this);
Boolean isFinal = true;
int alf = 11;

int cX;
int cY;

float x,y, t;

int[] p1 = { 0xffFEFEFC,0xff89776E,0xffECE9E8,0xffAA9991,0xff322D2B,0xffDBD7D8,0xffD2C7BA,0xffB2A699,0xffCAC7C7,0xffD8CDC9,0xffBAB6B7,0xffC9BDB9,0xff918678,0xffE9DED9,0xffEEE7DD,0xffAAA6A7,0xffB8ACA8,0xff999596,0xffDFDC6A,0xff888584,0xff787574,0xff6A6456,0xff665854,0xff4D4337,0xff686564,0xff575453,0xff978B87,0xffF7EFEA,0xff474443,0xffDCD6CC,0xff423833,0xff766A65,0xffC8B5AE,0xffF8F7F3,0xff554946,0xffBBB6AA,0xffC6B192,0xffE8D6CF,0xff787368,0xff9A9489,0xffA98A79,0xffCEA070,0xff565348,0xffF8F785,0xffDDDEE1,0xffD2CB92,0xffBBBDC1,0xffB4AE73,0xffCDCED2,0xff100B0B,0xffE7D0B5,0xffABADB1,0xff9B9CA0,0xffEEEFF1,0xffC7BDC6,0xffEFEEB6,0xff8F8754,0xffBDC6CB,0xffDEE7EA,0xffB3AE52,0xff8B8C8F,0xffC7ACA6,0xff9BA5AA,0xffA79C9E,0xffCED6DB,0xffD7CED6,0xff7A7B7E,0xff29211F,0xff7A8589,0xffD4BBAB,0xffB6ADB6,0xffD7BDB7,0xff595A5D,0xffADB5BA,0xff958C95,0xff6A6B6E,0xff867B7D,0xff211715,0xffC49789,0xffEFF7F8,0xff494A4D,0xff8B9499,0xff645A63,0xffE7DEE7,0xff7F8474,0xff746B74,0xffE9B48E,0xff5A6467,0xff596357,0xffE8CDC7,0xff443942,0xff6A7476,0xffE4D897,0xff534A52,0xff6A7369,0xff8F5544,0xff37363A,0xffF8DBC9,0xffBF785E,0xffEABDA7,0xffC4C6B0,0xff4A5248,0xff394245,0xffA2A03F,0xffA2985A,0xff4A5355,0xffE0E7D3,0xffA4A59A,0xff8B948A,0xffF7EFF7,0xffACB5A8,0xff414239,0xffFBE2DA,0xff211821,0xffCED6CA,0xff7E3827,0xffD9AB9D,0xffEFF7EE,0xff212223,0xffC26642,0xffC7C468,0xffCAABBA,0xff18181B,0xffD0CA4A,0xffE39E80,0xff182117,0xffE6E588,0xffA2A075 };
float angle = 0;
float xx, yy, startX, startY;
float w = 40;

////////////////////////////////////////////////////
//
public void setup() {
  // setup core sketch settings items
  
  frameRate(303);
  background(9);
  fix.alpha(alf);
  //  setup variables
  cX = width/2;
  cY = height/2;

  startX = cX;
  startY = cY;

}


////////////////////////////////////////////////////
//
public void draw()
{

//    randStroke();
    noFill();
    
    fix.ranPalStroke( p1 );
    fix.drawLissajous( xx, yy, random(alf) );

if( t > (width*2) ) {
  doExit();
}

t++;

  if( xx > width ) {
    xx = 0;
    yy += w;
  } else {
    xx += w; 
  }

  if( yy > height ){
    yy = random(yy);
  }


}


///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
public void doExit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
}



///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
public void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 18 ) );
  smooth();

  fill(0xffEFEFEF);
  text( " "+dailyMsg, this.width-430, this.height-14);
/*
float yy = 0;
while( yy <= height ) {

  fill(#EFEFEF, yy*.15);
 text( " "+dailyMsg, 5, yy);
 yy += 18; 
}
*/

}

  public void settings() {  size(1024, 768); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "NoiseOutsideThePyramid" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
