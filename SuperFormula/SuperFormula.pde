
import fixlib.*;

Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
int alf = 42; //37;
int cX;
int cY;
color[] p3 = { #EF0000, #00EF00, #0000EF, #CECE00, #FA7680, #EF1975, #007007, #EFEF00, #FA9187, #007007, #109109 };

int a = 3;  //1;
int b = 3;  //1;
int m = 12;
int n1 = 15;  //5;
int n2 = 18;  //6;
int n3 = alf; //48;
float r, x, y, f;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768, P2D);  //  P2D, P3D, OPENGL, PDF
  background(#EFEFEF);

  rectMode(CENTER);

  //  setup variables
  cX = width/2;
  cY = height/2;

  noFill();
  smooth();
}


////////////////////////////////////////////////////
//
void draw()
{


  //r = noise(frameCount) + pow((pow(abs(cos(m*f/4)/a),n2) + pow(abs(sin(m*f/4)/b), n3)), -(1/n1));
r = noise(frameCount) + pow((pow(abs(cos(m*f/4)/a), random(n2)   ) + pow(abs(sin(m*f/4)/b), random(n3)  )), -(1/n1));


  x = r * cos(f) * int( alf * radians(frameCount) );
  y = r * sin(f) * int( alf * radians(frameCount) );
          //$col = imagecolorallocate($img, 255, 255, 255);
          //imagesetpixel($img, $x, $y, $col);
  
  stroke(random(255), alf, alf);
  strokeWeight(random(TWO_PI));
  point( cX-x, cY-y );


stroke(alf, random(255), alf);
point( y, x );

  stroke(alf, alf, random(255));
  point( width-x, height-y );

  strokeWeight(random(.99));
  // stroke(random(255), alf);
  fix.ranPalStroke(p3);
  rect( x, y, cX-x, cY-y);
  rect( width-x, height-y,width-x, height-y );

smooth();
stroke(random(255),alf);
// ellipse(cX, cY, r*frameCount, r*frameCount);
ellipse(x, y, r*frameCount, r*frameCount);
ellipse(width-x, height-y, r*frameCount, r*frameCount);

  f += 1.5;  //0.0001;

  if( frameCount > width+height ){
save(this+".png");
    exit();
  }

}




// void mouseMoved() {
  
//   stroke(random(255));
//   ellipse( mouseX, mouseY, alf, alf );





// }



///////////////////////////////////////////////////////////
//  End handler, saves png
void exit() 
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
  System.gc();
  super.stop();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 18 ) );
  smooth();

  fill(0);
  text( " "+dailyMsg, 10, this.height-14);
}

