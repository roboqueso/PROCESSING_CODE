//	IMPORTS	////////////////////////////////////////////////////
import processing.opengl.*;
import fixlib.*;

Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
float alf = 42; //37;


color[] p2 = { #000000, #000055, #005555, #555555, #5555AA, #55AAAA, #555500, #AAAAAA, #AA5500, #AA5555, #AAAA55, #FFAA00, #FFAA55, #AAAA00, #005500, #550000, #FFFFFF, #FFAAAA, #FFFFAA, #55AA55, #FFFF55, #AA55AA, #FFAAFF, #AAAAFF, #AAFFFF, #55AAFF, #550055, #FF5500, #AAFFAA, #0055AA, #FF5555, #AA0000, #AA0055, #FF55AA }; 

float angle, radius = TWO_PI, x, y, cX, cY;

//  controls at which angle % == 0 starts and stops the noise
int flipStart = 180, flipEnd = 360;
Boolean flip = false;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);  //  P2D, P3D, OPENGL, PDF
  background(#000011);
  
  ellipseMode(CENTER);
  rectMode(CENTER);
  
  frameRate(100);
  // smooth();

  cX = width/2;
  cY = height/2;

  noFill();

  stroke(255);
}



////////////////////////////////////////////////////
//
void draw()
{

  angle = frameCount;

  if(angle % flipStart == 0 ){
    flip = true;
  }
  if(angle % flipEnd == 0 ){
    flip = false;
  }

  if(flip){

    x = cX - int( cos(radians(angle)) * (radius + random(1,TWO_PI)  ) );
    y = cY - int( sin(radians(angle)) * (radius + random(1,TWO_PI)  ) );

    fill(random(255), alf);
    stroke(random(255));


  } else {

    x = cX - int( cos(radians(angle)) * radius );
    y = cY - int( sin(radians(angle)) * radius );

    fix.ranPalStroke100(p2);
    fix.ranPalFill(p2);
  }


  ellipse( x, y , PI, PI );

  if(flip){
    fix.circle(x,y,TWO_PI, TWO_PI);
  } else {
    ellipse(x,y,TWO_PI, TWO_PI);

    beginShape();
      vertex(x,y);
      bezierVertex(cX, cY, random(width), random(height), x,y);
      curveVertex(x,y);



    endShape();


  }


  if( angle % 360 == 0  ) {
    radius += 30;
  }


  if( angle > (height+width)*4 )
  {
      exit();
      
  }
}




///////////////////////////////////////////////////////////
//  End handler, saves png
void exit() 
{


	// artDaily("ERICFICKES.COM" );
	artDaily( "ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

//	debug
// println("exit()");
java.awt.Toolkit.getDefaultToolkit().beep();


  noLoop();
  System.gc();
  super.stop();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  // textFont( createFont( "Silom", 18 ) );
  // smooth();

  fill(255);
  text( " "+dailyMsg, 11, height-11 );
}

