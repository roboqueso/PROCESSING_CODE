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

public class NeverGUNeverSur extends PApplet {


// https://github.com/ericfickes/FIXLIB	


Fixlib fix = Fixlib.init(this);
Boolean isFinal = true;

//  
int alf = 37;

//  circle vars
float angle1 = 0, xx1, yy1, startX1, startY1, radius1 = alf;
float angle2 = 0, xx2, yy2, startX2, startY2, radius2 = alf*5;
float angle3 = 0, xx3, yy3, startX3, startY3, radius3 = alf*7;
float angle4 = 0, xx4, yy4, startX4, startY4, radius4 = alf*9;

int cX;
int cY;

int[] p1 = { 0xffEF0000, 0xff00EF00, 0xff0000EF, 0xffCECE00, 0xffFA7680, 0xffEF1975, 0xff007007, 0xffEFEF00, 0xffFA9187, 0xff007007, 0xff109109 };
PImage b;
ArrayList p3;

//  VECTOR ACTION - http://processing.org/reference/PVector.html
PVector v1, v2;


////////////////////////////////////////////////////
//
public void setup() {
  // setup core sketch settings items
  
  frameRate(666);
  fix.alpha(alf);
b = loadImage("white-flower.jpg");
p3 = fix.getImgColors(b);
//  background(b);
background(alf);

  //  setup variables
  cX = width/2;
  cY = height/2;

  startX1 = startX2 = startX3 = startX4 = cX;
  startY1 = startY2 = startY3 = startY4 = cY;
  
  v1 = new PVector(cX, cY, alf);
  v2 = new PVector(cX, cY-alf, alf); 
  
  stroke(0);
  strokeWeight(.37f);
  xx1 = yy1 = -alf;
}


////////////////////////////////////////////////////
//
public void draw()
{
  smooth();


  //  VECTOR
  ellipse(v1.x, v1.y, alf, alf);
  ellipse(v2.x, v2.y, frameCount, frameCount);
  v2.add(v1);
  ellipse(v2.x, v2.y, frameCount-alf, frameCount-alf);


fix.evenOddStroke(0xffEFEFEF);
line( xx1, 0, xx1, height );
fix.drawLissajous( xx1, yy1, frameCount/TWO_PI );  //  PI  
fix.evenOddFill(0);//  #EF2012




scale(0.1f);

fix.ranPalStroke100(p3);
fix.ranPalFill100(p3);

for (float p = 0.9f; p < 5; p += 0.1f) 
{
  pushMatrix();
  translate (1024 * p, 768 * p);

  noFill();
  strokeWeight(13);

  stroke(50 * p); // Just to distinguish the stars

  beginShape(LINES);
fix.ranPalStroke100(p3);
fix.ranPalFill100(p3);
  vertex(115*noise(p), 460*noise(p));//1
  vertex(460*noise(p), 460*noise(p));//2
  vertex(575*noise(p), 115*noise(p));//3
  vertex(690*noise(p), 460*noise(p));//4
  vertex(1035*noise(p), 460*noise(p));//5
fix.ranPalStroke100(p3);
fix.ranPalFill100(p3);
  vertex(747.5f*noise(p), 690*noise(p));//6
  vertex(862.5f*noise(p), 1035*noise(p));//7
  vertex(575*noise(p), 805*noise(p));//8
  vertex(285.5f*noise(p), 1035*noise(p));//9
  vertex(402.5f*noise(p), 690*noise(p));//10
  endShape(CLOSE);
  popMatrix();
}






if( xx1 < width ) {
 
 xx1 += alf*2.4f; 
 
} else if( xx1 > width && yy1 > height ) {
  
  doExit();

} else {

 xx1 = -alf;
 yy1 += alf*2.4f;  
}

 //  vector
 v1.x = xx1;
 v1.y = yy1;
 
 v2.x = v1.x;
 v2.y = v1.y+noise(v1.y);





  //
  //  STOP
  //  
  if ( frameCount > (height+width)/2 )
  {    
    doExit();
  }
 
  
}


///////////////////////////////////////////////////////////
//  
//  End handler, saves png
public void doExit() 
{

  artDaily("Never give up... and never surrender"+ fix.getTimestamp() );

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

  textFont( createFont( "AnonymousPro", 37 ) );  //  "Silom"
  smooth();

  fill(0xffEF2012);
  text( dailyMsg, 0, height-10 );

}

  public void settings() {  size(1024, 768); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "NeverGUNeverSur" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
