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

public class nightMist extends PApplet {


// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);


Boolean isFinal = true;
int alf = 11;
float shapeSize = alf;

int cX;
int cY;

//  #A59DA1, #D96D55, #F36613, #A9ABEA, #D23301, #F6FAFD, #AB6E9C, #D6F9FF, #F8751E, #768A00, #F05510, #FFEE51, #FFB02A, #D7D5FA
int[] palette = { 
0xffEF0000, 0xff00EF00, 0xff0000EF
};


int ct = 0;
int maxCt = 0;

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

  noFill();
  ellipseMode(CENTER);  
  maxCt = 333;


  // RED  - stroke( #B00B13, alf*3 );
  // GREEN - stroke( #20EF12, alf*3 );  
//  stroke( #B00B13, alf*3 );
//  fix.drawFrame();
}


////////////////////////////////////////////////////
//

float _x = 135;
float _y = 135;
PVector thisPt, lastPt, pv1, pv2, pv3, pv4 = new PVector();

public void draw()
{
  _x = lerp( 200, random(width*2), .75f );
  _y = lerp( 404, random(height), .75f );

  strokeWeight( random(1.5f) );  // 3.3
  smooth();
  noFill();

  //  zoogMouse();
  if ( pmouseX != 0 ) {

    strokeWeight( abs( pmouseX-mouseX ) );  // 3.3
    stroke(0, alf*10);

    line( mouseX, mouseY, pmouseX, pmouseY );


    randStrokeUser();
    hexagon( mouseX-alf, mouseY-alf, shapeSize+alf );

    randStrokeUser();
    hexagon( pmouseX+alf, pmouseY+alf, shapeSize+alf );

    strokeWeight( random(1.5f) );  // 3.3
  }
  
  if( frameCount % 15 == 0 )
  {
      zoog2();
  }


randStrokeUser();
  arc( _x, _y, cX*alf, cY*alf, TWO_PI, PI);
randStrokeUser();
  curve( _y, _x, random(cX), random(cY), cX+alf+_x, cY+alf+_y, cX*.5f, cY);
randStrokeUser();
  quad( _x, _y, cX*alf, cY*alf, _x+shapeSize, _y+shapeSize, cX*1.5f, cY );
randStrokeUser();
  triangle( _y, _x, _x, _y, random(cX), random(cY) );

  //  end CH2


  if ( ct >= maxCt ) {

    //  scan lines
    stroke(0xff000000, alf );
    for ( int ll = 0; ll <= width; ll += 2 ) 
    {  
      strokeWeight( random(alf) );  
      line( 0, ll, width, ll );

      strokeWeight( random(alf*.5f) );
      line( ll, 0, ll, height );
    }
    
    stroke(18, 200);// #20EF12, alf*3 );
    fix.drawFrame();

    exit();
  }

  ct++;
}


public void mousePressed() {
  println("mousePressed()");  
}


public void keyPressed() {
  println("keyPressed()");
}


//  interactive Zoog
public void zoog2() {

  smooth();
  //frameRate(30);
  noFill();
  
  ellipseMode(CENTER);
  rectMode(CENTER);
  /*
  randStrokeUser();
  randFillUser();
  rect(mouseX, mouseY, alf, alf*5);
  */  
  randStrokeUser();
//  randFillUser();
  ellipse( mouseX, mouseY-30, 60, 60 );

  
  randStrokeUser();
//  randFillUser();
  ellipse( mouseX-19, mouseY-30, 16, 32 );
  ellipse( mouseX+19, mouseY-30, 16, 32 );
  
  randStrokeUser();
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



//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
//  ellipse(x, y, width, height)

float radius = 18, xx, yy;

public void circle( float startX, float startY, float w, float h ) {

  float angle = 0;

  while ( angle < 360 ) {
    xx = startX - PApplet.parseInt( cos(radians(angle)) * radius );
    yy = startY - PApplet.parseInt( sin(radians(angle)) * radius );


    ellipse( xx, yy, w, h );

    angle++;
  }
}

//////////////////////////////////////////////////////////////////////////
//  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
public void hexagon( float startX, float startY, float shapeSize ) {

  line( startX, startY+(shapeSize*.5f), startX+(shapeSize*.25f), startY );
  line( startX+(shapeSize*.25f), startY, startX+(shapeSize*.75f), startY );
  line( startX+(shapeSize*.75f), startY, startX+(shapeSize), startY+(shapeSize*.5f) );

  line( startX+(shapeSize), startY+(shapeSize*.5f), startX+(shapeSize*.75f), startY+shapeSize );
  line( startX+(shapeSize*.75f), startY+shapeSize, startX+(shapeSize*.25f), startY+shapeSize );
  line( startX+(shapeSize*.25f), startY+shapeSize, startX, startY+(shapeSize*.5f) );
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

  super.stop();
}

///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
public void randFill() {  
  fill( random(255), random(255), random(255), alf );
}
public void randStroke() {  
  stroke( random(255), random(255), random(255), alf );
}
public void randStroke100() {  
  stroke( random(255), random(255), random(255), 100 );
}

////////////////////////////////////////////////////
//  Randomly stroke using image from color list
public void randStrokeUser()
{
  // pallete
  stroke( palette[ PApplet.parseInt(random( palette.length-1 )) ], alf*.75f );
}
public void randFillUser()
{
  fill( palette[ PApplet.parseInt(random( palette.length-1 )) ], alf*.75f );
}




///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
public void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 18 ) );
  smooth();

  //  stroke(#EFEFEF);
  fill(255);
  text( " "+dailyMsg, this.width*.45f, this.height-18);
}

  public void settings() {  size(1024, 768); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "nightMist" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
