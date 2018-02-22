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

public class darkideaCloud extends PApplet {


// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);
//
Boolean isFinal = true;
int alf = 42;
float shapeSize = 400;

int cX;
int cY;

float xx, yy;

//  #A59DA1, #D96D55, #F36613, #A9ABEA, #D23301, #F6FAFD, #AB6E9C, #D6F9FF, #F8751E, #768A00, #F05510, #FFEE51, #FFB02A, #D7D5FA
int[] palette = { 
0xffEF0000, 0xff00EF00, 0xff0000EF, 0xffEFEFEF
};

int outerXX = 0;
int outerYY = 0;

float angle = 0;
float maxAngle;
float radius = 150;
float outerRadius;

int offsetX = 0;
int offsetY = 0;


int ct = 0;
int maxCt = 0;

////////////////////////////////////////////////////
//
public void setup() {
  // setup core sketch settings items
  
  frameRate(303);
  background(69);
  fix.alpha(alf);
  //  setup variables
  cX = width/2;
  cY = height/2;

  offsetX = cX;
  offsetY = cY;

  maxCt = 360 * 36;
  
  // white scan lines
    stroke(255, alf );
    for ( int ll = 0; ll <= width; ll += 2 ) 
    {  
      strokeWeight( random(alf) );
  
      line( 0, ll, width, ll );
      line( ll, 0, ll, height );
    }
}


////////////////////////////////////////////////////
//

public void draw()
{
  smooth();
  strokeWeight( random(50) );
  
  xx = ( offsetX - PApplet.parseInt( cos(radians(angle)) * radius ) );
  yy = ( offsetY - PApplet.parseInt( sin(radians(angle)) * radius ) );

  outerXX = ( offsetX - PApplet.parseInt( cos(radians(angle)) * outerRadius ) );
  outerYY = ( offsetY - PApplet.parseInt( sin(radians(angle)) * outerRadius ) );

stroke(random(255), alf*2);
point(xx, yy);

stroke(random(222), alf*2);
point(outerXX, outerYY);

stroke(random(199), alf);
point( random(xx, outerXX), random( yy, outerYY ) );

stroke(random(69), alf);
point( lerp(xx, outerXX, random(.9f) ), lerp( yy, outerYY, random(.9f) ) );

  
if( angle >= maxCt ) {
  doExit();
}

if( frameCount % 40 == 0 ) {
  angle+= 10;
  radius+=3;
  offsetY = (int)random(cY);
  offsetX = (int)random(cX);
  
  stroke(random(255));
  line( xx, yy, outerXX, outerYY );
  stroke(random(255));
  line( outerXX, outerYY, offsetX, offsetY );
  
  
} else {
  angle += 5;
}

}


//  interactive Zoog
public void zoog2() {

  smooth();
  noFill();
  
  ellipseMode(CENTER);
  rectMode(CENTER);
  /*
  fix.ranPalStroke(palette);
  randFillUser();
  rect(mouseX, mouseY, alf, alf*5);
  */  
  fix.ranPalStroke(palette);
//  randFillUser();
  ellipse( mouseX, mouseY-30, 60, 60 );

  
  fix.ranPalStroke(palette);
//  randFillUser();
  ellipse( mouseX-19, mouseY-30, 16, 32 );
  ellipse( mouseX+19, mouseY-30, 16, 32 );
  
  fix.ranPalStroke(palette);
//  randFillUser();
  line( mouseX-alf, mouseY+(alf*5), pmouseX-alf, pmouseY+(alf*5));
  line( mouseX+alf, mouseY+(alf*5), pmouseX-alf, pmouseY+(alf*5));  
}












public void zoog() {

  ellipseMode(CENTER);
  rectMode(CENTER);
  stroke(0);
  fill(150);
  rect(100, 100, 20, 100 );
  fill(255);
  ellipse(100, 70, 60, 60);
  fill(0);
  ellipse(81, 70, 16, 32 );
  ellipse(119, 70, 16, 32);
  stroke(0);
  line(90, 150, 80, 160);
  line(110, 150, 120, 160);
}



///////
//  draw frame
public void drawFrame() {

  rectMode(CORNER);

  strokeWeight( 100 );
  rect( 0, 0, width, height);

  strokeWeight( 5 );
  rect( 64, 65, width-128, height-129 );

  strokeWeight( 15 );
  rect( 84, 85, width-168, height-168 );

  //  dashed line
  strokeWeight(6);
  int x = 110;
  int y = 110;

  strokeCap(PROJECT);

  for ( int pp = 0; pp <= (width*height); pp++ ) { 

    if ( x <= (width-110) ) {
      // top row    
      point( x, y );
      //  bottom row
      point( x, 790 );

      x += 10;
    } 
    else if ( y <= 780 ) {

      // left row    
      point( (width-110), y );
      //  right row
      point( 110, y );
      y += 10;
    }
  }

  strokeWeight( 5 );
  rect( 122, 122, width-245, height-245 );
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
    save( fix.pdeName() + fix.getTimestamp() + ".png" );
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

  //  stroke(#EFEFEF);
  fill(0xffEE0000);
  text( " "+dailyMsg, this.width*.45f, this.height-18);
}
  public void settings() {  size(1024, 768); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "darkideaCloud" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
