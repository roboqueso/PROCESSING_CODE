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

public class SuperFormula extends PApplet {



//  https://github.com/ericfickes/FIXLIB
Fixlib fix = Fixlib.init(this);


Boolean isFinal = true;
int alf = 42; //37;
int cX;
int cY;
int[] p3 = { 0xffEF0000, 0xff00EF00, 0xff0000EF, 0xffCECE00, 0xffFA7680, 0xffEF1975, 0xff007007, 0xffEFEF00, 0xffFA9187, 0xff007007, 0xff109109 };

int a = 3;  //1;
int b = 3;  //1;
int m = 12;
int n1 = 15;  //5;
int n2 = 18;  //6;
int n3 = alf; //48;
float r, x, y, f;

////////////////////////////////////////////////////
//
public void setup() {
  // setup core sketch settings items
    //  P2D, P3D, OPENGL, PDF
  background(0xffEFEFEF);
  fix.alpha(alf);
  rectMode(CENTER);

  //  setup variables
  cX = width/2;
  cY = height/2;

  noFill();
  
}


////////////////////////////////////////////////////
//
public void draw()
{


  //r = noise(frameCount) + pow((pow(abs(cos(m*f/4)/a),n2) + pow(abs(sin(m*f/4)/b), n3)), -(1/n1));
r = noise(frameCount) + pow((pow(abs(cos(m*f/4)/a), random(n2)   ) + pow(abs(sin(m*f/4)/b), random(n3)  )), -(1/n1));


  x = r * cos(f) * PApplet.parseInt( alf * radians(frameCount) );
  y = r * sin(f) * PApplet.parseInt( alf * radians(frameCount) );
          //$col = imagecolorallocate($img, 255, 255, 255);
          //imagesetpixel($img, $x, $y, $col);
  
  stroke(random(255), alf, alf);
  strokeWeight(random(TWO_PI));
  point( cX-x, cY-y );


stroke(alf, random(255), alf);
point( y, x );

  stroke(alf, alf, random(255));
  point( width-x, height-y );

  strokeWeight(random(.99f));
  // stroke(random(255), alf);
  fix.ranPalStroke(p3);
  rect( x, y, cX-x, cY-y);
  rect( width-x, height-y,width-x, height-y );

smooth();
stroke(random(255),alf);
// ellipse(cX, cY, r*frameCount, r*frameCount);
ellipse(x, y, r*frameCount, r*frameCount);
ellipse(width-x, height-y, r*frameCount, r*frameCount);

  f += 1.5f;  //0.0001;

  if( frameCount > width+height ){
    doExit();
  }

}




// void mouseMoved() {
  
//   stroke(random(255));
//   ellipse( mouseX, mouseY, alf, alf );





// }



///////////////////////////////////////////////////////////
//  End handler, saves png
public void doExit() 
{

  artDaily( "ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( split( this.toString(), "[")[0] + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
  }

  //  BEEP!
  java.awt.Toolkit.getDefaultToolkit().beep();


  noLoop();
  exit();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
public void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 18 ) );
  smooth();

  fill(0);
  text( " "+dailyMsg, 10, this.height-14);
}

  public void settings() {  size(1024, 768, P2D);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "SuperFormula" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
