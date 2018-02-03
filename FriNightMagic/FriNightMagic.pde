//	IMPORTS	////////////////////////////////////////////////////

import fixlib.*;

Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
float alf = 42; //37;

color[] p3 = { #001919, #191919, #000019, #331919, #176819, #4C1919, #663333, #7F4C33, #191768, #331768, #661919, #994C33, #7F3319, #99664C, #4C3333, #993319, #B24C19, #7F3333, #663319, #7F1768, #4C0000, #7F1919, #330000, #4C1768, #B24C33, #661768, #994C19, #176800, #B23319, #993300, #7F3300, #991768, #993333, #4C3319, #333319, #333333, #193319, #334C33, #4C4C33, #4C6633, #4C664C, #667F4C, #66664C, #193333, #331933, #4C4C4C, #666666, #664C4C, #001768, #7F6666, #667F66, #7F7F66, #4C6666, #334C19, #334C4C, #7F664C, #7F7F7F, #B24C4C, #7F997F, #B26633, #CC4C33, #CC6633, #4C4C19, #99997F, #664C33, #4C6619, #666633, #667F7F, #4C4C66, #667F33, #33334C, #4C334C, #191933, #666619, #664C66, #4C6600, #667F19, #997F7F, #193300, #333300, #7F7F33, #7F7F19, #7F7F4C, #997F4C, #99994C, #999999, #7F994C, #997F33, #B2B2B2, #B2B299, #B29999, #99B299, #999933, #999966, #997F66, #B2997F, #B29966, #CCB2B2, #CCCCB2, #B2CCB2, #B2B27F, #CCB299, #CCB27F, #CCCC99, #CCCCCC, #E5CCB2, #E5CCCC, #E5E5CC, #000000, #CCE5CC, #336619, #E5E5E5, #E5FFE5, #E5E5B2, #FFE5E5, #FFFFE5, #CCCC7F, #CCCC66, #B2B266, #FFFFFF, #CCB266, #CCCC4C, #B2B24C, #CCB24C, #B2B233, #B29933, #B2994C, #E5CC99, #997F19, #999919, #7F6619, #7F6633, #664C19, #4C4C00, #CCE599, #E5E599, #FFFFCC, #E5FFCC, #334C00, #CCE5B2, #99B27F, #FFE5CC, #FFE5B2, #FFFFB2, #E5B299, #CC9966, #B27F33, #B27F4C, #FFCCB2, #CC994C, #FFCC99, #E5B27F, #E5B266, #CC997F, #B27F66, #B26619, #CC6619, #CC7F66, #CC7F33, #CC7F4C, #CC4C19, #B2664C, #996633, #B27F19, #7F4C19, #B26600, #B24C00, #E5B2B2, #7F4C4C, #996666, #CC7F19, #CC6600, #B23300, #B2CC99, #994C00, #4C3300, #E57F33, #996619, #E57F19, #7F4C00, #7F9933, #663300, #7F9919, #E59933, #E59919 }; 

float angle, radius = TWO_PI, x, y, cX, cY;
Boolean flip = false;


////////////////////////////////////////////////////
//
void setup() {
  size(1024,768);  //  big:  1024x768

  background(#1975EF);  //  #A1B1C1
  
  ellipseMode(CENTER);
  rectMode(CENTER);
  
  frameRate(303);
  smooth();
  strokeWeight(PI);

  cX = width/2;
  cY = height/2;

  noFill();

}



////////////////////////////////////////////////////
//
void draw()
{

    angle = frameCount;


  if(angle % 303 == 0 ){
    flip = true;
  }
  if(angle % 345 == 0 ){
    flip = false;
  }



    if(flip){
      // strokeWeight(PI);

      x = cX - int( cos(radians(angle)) * radius );
      y = cY - int( sin(radians(angle)) * radius );

    } else {

      // strokeWeight(HALF_PI);

      x = cX - int( cos(radians(angle)) * radius+TWO_PI );
      y = cY - int( sin(radians(angle)) * radius+TWO_PI );

    }
    noFill();
    strokeWeight(PI);

    //stroke(flip?0:255);
    if(flip){
      stroke(random(255));
    } else {
      stroke(0);
    }
    point( x, y );


    if(flip){
      stroke(0);
    } else {
      stroke(random(255));
    }
    ellipse( x, y, TWO_PI, TWO_PI);

 
    if( angle % 363 == 0  ) {
      radius += (TWO_PI*2);
    }

    //if( frameCount > (width+height)*4.2 ) {
    if( x < -alf ) {

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

