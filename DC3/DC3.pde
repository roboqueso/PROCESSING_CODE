//	IMPORTS	////////////////////////////////////////////////////
import processing.opengl.*;
import fixlib.*;

Fixlib fix = Fixlib.init(this);Boolean isFinal = true;
int alf = 37;
float angle, radius = alf, x, y, cX, cY, strokeSz = 1;

color[] p2 = { #001919, #191919, #000019, #331919, #176819, #4C1919, #663333, #7F4C33, #191768, #331768, #661919, #994C33, #7F3319, #99664C, #4C3333, #993319, #B24C19, #7F3333, #663319, #7F1768, #4C0000, #7F1919, #330000, #4C1768, #B24C33, #661768, #994C19, #176800, #B23319, #993300, #7F3300, #991768, #993333, #4C3319, #333319, #333333, #193319, #334C33, #4C4C33, #4C6633, #4C664C, #667F4C, #66664C, #193333, #331933, #4C4C4C, #666666, #664C4C, #001768, #7F6666, #667F66, #7F7F66, #4C6666, #334C19, #334C4C, #7F664C, #7F7F7F, #B24C4C, #7F997F, #B26633, #CC4C33, #CC6633, #4C4C19, #99997F, #664C33, #4C6619, #666633, #667F7F, #4C4C66, #667F33, #33334C, #4C334C, #191933, #666619, #664C66, #4C6600, #667F19, #997F7F, #193300, #333300, #7F7F33, #7F7F19, #7F7F4C, #997F4C, #99994C, #999999, #7F994C, #997F33, #B2B2B2, #B2B299, #B29999, #99B299, #999933, #999966, #997F66, #B2997F, #B29966, #CCB2B2, #CCCCB2, #B2CCB2, #B2B27F, #CCB299, #CCB27F, #CCCC99, #CCCCCC, #E5CCB2, #E5CCCC, #E5E5CC, #000000, #CCE5CC, #336619, #E5E5E5, #E5FFE5, #E5E5B2, #FFE5E5, #FFFFE5, #CCCC7F, #CCCC66, #B2B266, #FFFFFF, #CCB266, #CCCC4C, #B2B24C, #CCB24C, #B2B233, #B29933, #B2994C, #E5CC99, #997F19, #999919, #7F6619, #7F6633, #664C19, #4C4C00, #CCE599, #E5E599, #FFFFCC, #E5FFCC, #334C00, #CCE5B2, #99B27F, #FFE5CC, #FFE5B2, #FFFFB2, #E5B299, #CC9966, #B27F33, #B27F4C, #FFCCB2, #CC994C, #FFCC99, #E5B27F, #E5B266, #CC997F, #B27F66, #B26619, #CC6619, #CC7F66, #CC7F33, #CC7F4C, #CC4C19, #B2664C, #996633, #B27F19, #7F4C19, #B26600, #B24C00, #E5B2B2, #7F4C4C, #996666, #CC7F19, #CC6600, #B23300, #B2CC99, #994C00, #4C3300, #E57F33, #996619, #E57F19, #7F4C00, #7F9933, #663300, #7F9919, #E59933, #E59919 }; 
color[] p3 = { #7F7F7F, #FFFFFF, #FFBFFF, #BFBFFF, #BFBFBF, #FFBFBF, #BF7FBF, #BF7F7F, #BFBF7F, #BF7F3F, #FFBF7F, #7F7F3F, #7F3F3F, #7F3F00, #3F3F00, #FFFFBF, #FFBF3F, #BF7F00, #BF3F00, #BFBF3F, #FF7F00, #3F0000, #7F0000, #FFBF00, #FFFF7F, #000000, #FF7F3F, #BF0000, #FF3F00, #BFBF00, #BF3F3F, #FF7F7F, #7F7F00, #FF0000, #FFFF3F, #FFFF00, #3F3F3F, #BFFFFF, #003F00, #3F7F3F, #003F3F, #3F7F00, #3F7F7F, #007F3F, #007F7F };


float rX, rY, r2X, r2Y;
int i = 0; 
int a = 1;
int b = 1;
int m = 12;
int n1 = 5;
int n2 = 6;
int n3 = alf; //48;
float r, f;

PVector pvLast;	// used to draw lines around the SUPER circle

////////////////////////////////////////////////////
//
void setup() {
size(1024,768);  //  big:  1024x768

  background(19);

  //  setup variables
  cX = width/2;
  cY = height/2;

  ellipseMode(CENTER);
  rectMode(CENTER);
  smooth();
  noFill();



}


////////////////////////////////////////////////////
//
void draw()
{
    x = cX - int( cos(radians(frameCount)) * radius );
    y = cY - int( sin(radians(frameCount)) * radius );

// TODO: update this with superformula    
	r = noise(frameCount) + pow((pow(abs(cos(m*f/4)/a),n2) + pow(abs(sin(m*f/4)/b), n3)), -(1/n1));

    rX = cX - int( cos(radians(frameCount)) * (radius*r) );
    rY = cY - int( sin(radians(frameCount)) * (radius*r) );


    stroke(11);
    strokeWeight(random(13));
    point(x,y);

    stroke(random(255));
    strokeWeight(random(11));
    point(x,y);

    if(frameCount%2==0)
    	fix.ranPalStroke100(p3);
    else 
    	fix.ranPalStroke100(p2);

    strokeWeight(TWO_PI);
    point(x,y);

	// // fix.ranPalStroke100(p3);
 // //    point(rX, rY);

	// strokeWeight(11);
 //    fix.ranPalStroke(p3);
 //    point( lerp(x, rX, noise(frameCount)),  lerp(y, rY, noise(frameCount)));

    if( null != pvLast ){

		curveTightness(random(-5,5));


    	strokeWeight(3);
    	stroke(#EF1975,alf);
    	bezier( x, y, lerp(x, rX, noise(frameCount)),  lerp(y, rY, noise(frameCount)), pvLast.x, pvLast.y, rX, rY);
    	line( pvLast.x, pvLast.y, rX, rY);

    	strokeWeight(2);
		stroke(0,alf*2);
    	line( pvLast.x, pvLast.y, rX, rY);

    	strokeWeight(1);
    	stroke(#EF2012,alf);
    	curve( x, y, lerp(x, rX, noise(frameCount)),  lerp(y, rY, noise(frameCount)), pvLast.x, pvLast.y, rX, rY);

    	line( pvLast.x, pvLast.y, rX, rY);




    }

    f+=PI;

    //	persist this point for the next time through the loop
    pvLast = new PVector(rX, rY);

    // if( frameCount % 360 == 0 ){//////////////////////////////////////
if( frameCount % 360 == 0 ){

        radius += radius/PI;

		a+=PI;  //1;
		b+=PI;  //1;
		m+=PI;
		n1+=PI;  //5;
		n2+=PI;  //6;
		n3+=PI; //48;
		f += QUARTER_PI;
    }
 
    // move over a pixel
    if (i < width) {
        i++;
    } else {
        i = 0; 
    }
 
    if(radius*PI > height){
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

  noLoop();
  System.gc();
  super.stop();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

textFont( createFont( "Silom", 21 ) );
smooth();

  fill(0);
  text( " "+dailyMsg, 0, height-21 );
  fill(#EF2012);
  text( " "+dailyMsg, 0, height-22 );
}

