/**
 Using MINIM AudioInput, get funky with live microphone data
 //  65535 is a frequently occurring number in the field of computing because it is the highest number which can be represented by an unsigned 16 bit binary number
 **/
import ddf.minim.*;
import fixlib.*;

//  https://github.com/ericfickes/FIXLIB
Fixlib fix = Fixlib.init(this);
Minim minim;
AudioInput in;
Boolean isFinal = true;
int buf;
int alf = 42;
float tX, tY, inLeft, inRight, wvStart,i;



PImage img;
ArrayList p3;



float cX, cY, inc, m; 
float r, g, b;
int tmr_Interval = 10;  // seconds

float x, y, angle, sz=37;
float x2, y2, angle2, sz2; 
float x3, y3, angle3, sz3; 
float x4, y4, angle4, sz4; 


/////////////////////////////////////////////////////////////////////////////////
void setup()
{
  size(1024,768);  //  big:  1024x768
//  size(128,96);  //  thumb:  128x96

  background(#efefef); 
  noFill();
  ellipseMode(CENTER);
  rectMode(CENTER); 
  strokeCap(ROUND); 
  strokeJoin(ROUND);
  textFont( createFont( "AnonymousPro", 22 ) );
  
  fix.alpha(alf);

  cX = width/2;
  cY = height/2;
  sz = 100;
  sz2 = 109;
  sz3 = 150;
  sz4 = 185;


  y = cY;

  minim = new Minim(this);

  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  

    img = loadImage( "MosqueinBaghdad.jpg");
    p3 = fix.getImgColors( img, false );
    image(img, width-2297, 0);
    filter(GRAY);
}

/////////////////////////////////////////////////////////////////
void draw()
{
    smooth();

  // start out getting the noise in sync with frameCount, then random
  buf = ( buf < ( in.bufferSize() - 1 ) ) ? buf+1 : 0;
  inLeft = in.left.get(buf) * frameCount;
  inRight = in.right.get(buf) * frameCount;

  strokeWeight( random(constrain(inRight*noise(inLeft)/TWO_PI, .75, height)) );

  wvStart = cX - 512;



/////////////////////////////////////////////////////////////////////
//  COPY AND PASTE CODE FROM CodeWriter.pde
/////////////////////////////////////////////////////////////////////

cap();

/////////////////////////////////////////////////////////////////////
//  COPY AND PASTE CODE FROM CodeWriter.pde
/////////////////////////////////////////////////////////////////////


 
 
    if (i < (height/2) ) {
        i+=2;
    } else {
        i = 0; 
    }


    
  ////  STOPPER
  if ( frameCount > height*6) {
    doExit();
  }
}


///////////////////////////////////////////////
//  bezier helper
void getFlowery(
  float x, float y,
  float x2, float y2,
  float x3, float y3, 
  float x4, float y4
)
{

    strokeWeight(12);
    stroke(#EF0000);
    bezier( x, y, x2, y2, x3, y3, x4, y4);
 
    strokeWeight(6);
    stroke(#EFEF00);
    bezier( x, y, x2, y2, x3, y3, x4, y4);
 
    strokeWeight(2);
    stroke(#000037);
    bezier( x, y, x2, y2, x3, y3, x4, y4);
}






///////////////////////////////////////////////////////////
//  End handler, saves png
void doExit() 
{

  artDaily( "ERICFICKES.COM" );

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
void artDaily( String dailyMsg ) {

  textFont( createFont( "AppleGaramond", 37 ) );  //  "TrajanPro-Bold"
  smooth();

  fill(#EFEFEF);
  text( " "+dailyMsg, -1, height-2);

  fill(0);
  text( " "+dailyMsg, 0, height-3);
}


///////////////////////////////////////////////////////////


void cap(){
//  BEGIN PASTE HERE
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(0) * frameCount, wvStart+buf+in.left.get(0) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(0) * frameCount, cY+in.right.get(0) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(0) * frameCount, cY+in.right.get(0) * frameCount, 
        wvStart+buf+in.left.get(1) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(1) * cos(frameCount), 
        wvStart+buf+in.left.get(2) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(2)  * sin(frameCount), 
        wvStart+buf+in.left.get(3) * frameCount, cY+in.right.get(3) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(4) * frameCount, wvStart+buf+in.left.get(4) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(4) * frameCount, cY+in.right.get(4) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(8) * frameCount, wvStart+buf+in.left.get(8) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(8) * frameCount, cY+in.right.get(8) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(12) * frameCount, wvStart+buf+in.left.get(12) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(12) * frameCount, cY+in.right.get(12) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(16) * frameCount, wvStart+buf+in.left.get(16) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(16) * frameCount, cY+in.right.get(16) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(16) * frameCount, cY+in.right.get(16) * frameCount, 
        wvStart+buf+in.left.get(17) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(17) * cos(frameCount), 
        wvStart+buf+in.left.get(18) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(18)  * sin(frameCount), 
        wvStart+buf+in.left.get(19) * frameCount, cY+in.right.get(19) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(20) * frameCount, wvStart+buf+in.left.get(20) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(20) * frameCount, cY+in.right.get(20) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(24) * frameCount, wvStart+buf+in.left.get(24) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(24) * frameCount, cY+in.right.get(24) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(28) * frameCount, wvStart+buf+in.left.get(28) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(28) * frameCount, cY+in.right.get(28) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(32) * frameCount, wvStart+buf+in.left.get(32) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(32) * frameCount, cY+in.right.get(32) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(32) * frameCount, cY+in.right.get(32) * frameCount, 
        wvStart+buf+in.left.get(33) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(33) * cos(frameCount), 
        wvStart+buf+in.left.get(34) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(34)  * sin(frameCount), 
        wvStart+buf+in.left.get(35) * frameCount, cY+in.right.get(35) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(36) * frameCount, wvStart+buf+in.left.get(36) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(36) * frameCount, cY+in.right.get(36) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(40) * frameCount, wvStart+buf+in.left.get(40) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(40) * frameCount, cY+in.right.get(40) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(44) * frameCount, wvStart+buf+in.left.get(44) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(44) * frameCount, cY+in.right.get(44) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(48) * frameCount, wvStart+buf+in.left.get(48) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(48) * frameCount, cY+in.right.get(48) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(48) * frameCount, cY+in.right.get(48) * frameCount, 
        wvStart+buf+in.left.get(49) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(49) * cos(frameCount), 
        wvStart+buf+in.left.get(50) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(50)  * sin(frameCount), 
        wvStart+buf+in.left.get(51) * frameCount, cY+in.right.get(51) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(52) * frameCount, wvStart+buf+in.left.get(52) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(52) * frameCount, cY+in.right.get(52) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(56) * frameCount, wvStart+buf+in.left.get(56) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(56) * frameCount, cY+in.right.get(56) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(60) * frameCount, wvStart+buf+in.left.get(60) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(60) * frameCount, cY+in.right.get(60) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(64) * frameCount, wvStart+buf+in.left.get(64) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(64) * frameCount, cY+in.right.get(64) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(64) * frameCount, cY+in.right.get(64) * frameCount, 
        wvStart+buf+in.left.get(65) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(65) * cos(frameCount), 
        wvStart+buf+in.left.get(66) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(66)  * sin(frameCount), 
        wvStart+buf+in.left.get(67) * frameCount, cY+in.right.get(67) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(68) * frameCount, wvStart+buf+in.left.get(68) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(68) * frameCount, cY+in.right.get(68) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(72) * frameCount, wvStart+buf+in.left.get(72) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(72) * frameCount, cY+in.right.get(72) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(76) * frameCount, wvStart+buf+in.left.get(76) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(76) * frameCount, cY+in.right.get(76) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(80) * frameCount, wvStart+buf+in.left.get(80) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(80) * frameCount, cY+in.right.get(80) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(80) * frameCount, cY+in.right.get(80) * frameCount, 
        wvStart+buf+in.left.get(81) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(81) * cos(frameCount), 
        wvStart+buf+in.left.get(82) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(82)  * sin(frameCount), 
        wvStart+buf+in.left.get(83) * frameCount, cY+in.right.get(83) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(84) * frameCount, wvStart+buf+in.left.get(84) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(84) * frameCount, cY+in.right.get(84) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(88) * frameCount, wvStart+buf+in.left.get(88) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(88) * frameCount, cY+in.right.get(88) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(92) * frameCount, wvStart+buf+in.left.get(92) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(92) * frameCount, cY+in.right.get(92) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(96) * frameCount, wvStart+buf+in.left.get(96) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(96) * frameCount, cY+in.right.get(96) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(96) * frameCount, cY+in.right.get(96) * frameCount, 
        wvStart+buf+in.left.get(97) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(97) * cos(frameCount), 
        wvStart+buf+in.left.get(98) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(98)  * sin(frameCount), 
        wvStart+buf+in.left.get(99) * frameCount, cY+in.right.get(99) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(100) * frameCount, wvStart+buf+in.left.get(100) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(100) * frameCount, cY+in.right.get(100) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(104) * frameCount, wvStart+buf+in.left.get(104) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(104) * frameCount, cY+in.right.get(104) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(108) * frameCount, wvStart+buf+in.left.get(108) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(108) * frameCount, cY+in.right.get(108) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(112) * frameCount, wvStart+buf+in.left.get(112) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(112) * frameCount, cY+in.right.get(112) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(112) * frameCount, cY+in.right.get(112) * frameCount, 
        wvStart+buf+in.left.get(113) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(113) * cos(frameCount), 
        wvStart+buf+in.left.get(114) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(114)  * sin(frameCount), 
        wvStart+buf+in.left.get(115) * frameCount, cY+in.right.get(115) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(116) * frameCount, wvStart+buf+in.left.get(116) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(116) * frameCount, cY+in.right.get(116) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(120) * frameCount, wvStart+buf+in.left.get(120) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(120) * frameCount, cY+in.right.get(120) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(124) * frameCount, wvStart+buf+in.left.get(124) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(124) * frameCount, cY+in.right.get(124) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(128) * frameCount, wvStart+buf+in.left.get(128) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(128) * frameCount, cY+in.right.get(128) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(128) * frameCount, cY+in.right.get(128) * frameCount, 
        wvStart+buf+in.left.get(129) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(129) * cos(frameCount), 
        wvStart+buf+in.left.get(130) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(130)  * sin(frameCount), 
        wvStart+buf+in.left.get(131) * frameCount, cY+in.right.get(131) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(132) * frameCount, wvStart+buf+in.left.get(132) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(132) * frameCount, cY+in.right.get(132) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(136) * frameCount, wvStart+buf+in.left.get(136) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(136) * frameCount, cY+in.right.get(136) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(140) * frameCount, wvStart+buf+in.left.get(140) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(140) * frameCount, cY+in.right.get(140) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(144) * frameCount, wvStart+buf+in.left.get(144) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(144) * frameCount, cY+in.right.get(144) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(144) * frameCount, cY+in.right.get(144) * frameCount, 
        wvStart+buf+in.left.get(145) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(145) * cos(frameCount), 
        wvStart+buf+in.left.get(146) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(146)  * sin(frameCount), 
        wvStart+buf+in.left.get(147) * frameCount, cY+in.right.get(147) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(148) * frameCount, wvStart+buf+in.left.get(148) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(148) * frameCount, cY+in.right.get(148) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(152) * frameCount, wvStart+buf+in.left.get(152) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(152) * frameCount, cY+in.right.get(152) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(156) * frameCount, wvStart+buf+in.left.get(156) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(156) * frameCount, cY+in.right.get(156) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(160) * frameCount, wvStart+buf+in.left.get(160) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(160) * frameCount, cY+in.right.get(160) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(160) * frameCount, cY+in.right.get(160) * frameCount, 
        wvStart+buf+in.left.get(161) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(161) * cos(frameCount), 
        wvStart+buf+in.left.get(162) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(162)  * sin(frameCount), 
        wvStart+buf+in.left.get(163) * frameCount, cY+in.right.get(163) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(164) * frameCount, wvStart+buf+in.left.get(164) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(164) * frameCount, cY+in.right.get(164) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(168) * frameCount, wvStart+buf+in.left.get(168) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(168) * frameCount, cY+in.right.get(168) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(172) * frameCount, wvStart+buf+in.left.get(172) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(172) * frameCount, cY+in.right.get(172) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(176) * frameCount, wvStart+buf+in.left.get(176) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(176) * frameCount, cY+in.right.get(176) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(176) * frameCount, cY+in.right.get(176) * frameCount, 
        wvStart+buf+in.left.get(177) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(177) * cos(frameCount), 
        wvStart+buf+in.left.get(178) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(178)  * sin(frameCount), 
        wvStart+buf+in.left.get(179) * frameCount, cY+in.right.get(179) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(180) * frameCount, wvStart+buf+in.left.get(180) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(180) * frameCount, cY+in.right.get(180) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(184) * frameCount, wvStart+buf+in.left.get(184) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(184) * frameCount, cY+in.right.get(184) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(188) * frameCount, wvStart+buf+in.left.get(188) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(188) * frameCount, cY+in.right.get(188) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(192) * frameCount, wvStart+buf+in.left.get(192) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(192) * frameCount, cY+in.right.get(192) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(192) * frameCount, cY+in.right.get(192) * frameCount, 
        wvStart+buf+in.left.get(193) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(193) * cos(frameCount), 
        wvStart+buf+in.left.get(194) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(194)  * sin(frameCount), 
        wvStart+buf+in.left.get(195) * frameCount, cY+in.right.get(195) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(196) * frameCount, wvStart+buf+in.left.get(196) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(196) * frameCount, cY+in.right.get(196) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(200) * frameCount, wvStart+buf+in.left.get(200) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(200) * frameCount, cY+in.right.get(200) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(204) * frameCount, wvStart+buf+in.left.get(204) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(204) * frameCount, cY+in.right.get(204) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(208) * frameCount, wvStart+buf+in.left.get(208) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(208) * frameCount, cY+in.right.get(208) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(208) * frameCount, cY+in.right.get(208) * frameCount, 
        wvStart+buf+in.left.get(209) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(209) * cos(frameCount), 
        wvStart+buf+in.left.get(210) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(210)  * sin(frameCount), 
        wvStart+buf+in.left.get(211) * frameCount, cY+in.right.get(211) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(212) * frameCount, wvStart+buf+in.left.get(212) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(212) * frameCount, cY+in.right.get(212) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(216) * frameCount, wvStart+buf+in.left.get(216) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(216) * frameCount, cY+in.right.get(216) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(220) * frameCount, wvStart+buf+in.left.get(220) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(220) * frameCount, cY+in.right.get(220) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(224) * frameCount, wvStart+buf+in.left.get(224) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(224) * frameCount, cY+in.right.get(224) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(224) * frameCount, cY+in.right.get(224) * frameCount, 
        wvStart+buf+in.left.get(225) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(225) * cos(frameCount), 
        wvStart+buf+in.left.get(226) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(226)  * sin(frameCount), 
        wvStart+buf+in.left.get(227) * frameCount, cY+in.right.get(227) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(228) * frameCount, wvStart+buf+in.left.get(228) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(228) * frameCount, cY+in.right.get(228) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(232) * frameCount, wvStart+buf+in.left.get(232) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(232) * frameCount, cY+in.right.get(232) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(236) * frameCount, wvStart+buf+in.left.get(236) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(236) * frameCount, cY+in.right.get(236) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(240) * frameCount, wvStart+buf+in.left.get(240) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(240) * frameCount, cY+in.right.get(240) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(240) * frameCount, cY+in.right.get(240) * frameCount, 
        wvStart+buf+in.left.get(241) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(241) * cos(frameCount), 
        wvStart+buf+in.left.get(242) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(242)  * sin(frameCount), 
        wvStart+buf+in.left.get(243) * frameCount, cY+in.right.get(243) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(244) * frameCount, wvStart+buf+in.left.get(244) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(244) * frameCount, cY+in.right.get(244) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(248) * frameCount, wvStart+buf+in.left.get(248) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(248) * frameCount, cY+in.right.get(248) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(252) * frameCount, wvStart+buf+in.left.get(252) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(252) * frameCount, cY+in.right.get(252) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(256) * frameCount, wvStart+buf+in.left.get(256) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(256) * frameCount, cY+in.right.get(256) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(256) * frameCount, cY+in.right.get(256) * frameCount, 
        wvStart+buf+in.left.get(257) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(257) * cos(frameCount), 
        wvStart+buf+in.left.get(258) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(258)  * sin(frameCount), 
        wvStart+buf+in.left.get(259) * frameCount, cY+in.right.get(259) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(260) * frameCount, wvStart+buf+in.left.get(260) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(260) * frameCount, cY+in.right.get(260) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(264) * frameCount, wvStart+buf+in.left.get(264) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(264) * frameCount, cY+in.right.get(264) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(268) * frameCount, wvStart+buf+in.left.get(268) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(268) * frameCount, cY+in.right.get(268) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(272) * frameCount, wvStart+buf+in.left.get(272) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(272) * frameCount, cY+in.right.get(272) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(272) * frameCount, cY+in.right.get(272) * frameCount, 
        wvStart+buf+in.left.get(273) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(273) * cos(frameCount), 
        wvStart+buf+in.left.get(274) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(274)  * sin(frameCount), 
        wvStart+buf+in.left.get(275) * frameCount, cY+in.right.get(275) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(276) * frameCount, wvStart+buf+in.left.get(276) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(276) * frameCount, cY+in.right.get(276) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(280) * frameCount, wvStart+buf+in.left.get(280) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(280) * frameCount, cY+in.right.get(280) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(284) * frameCount, wvStart+buf+in.left.get(284) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(284) * frameCount, cY+in.right.get(284) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(288) * frameCount, wvStart+buf+in.left.get(288) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(288) * frameCount, cY+in.right.get(288) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(288) * frameCount, cY+in.right.get(288) * frameCount, 
        wvStart+buf+in.left.get(289) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(289) * cos(frameCount), 
        wvStart+buf+in.left.get(290) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(290)  * sin(frameCount), 
        wvStart+buf+in.left.get(291) * frameCount, cY+in.right.get(291) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(292) * frameCount, wvStart+buf+in.left.get(292) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(292) * frameCount, cY+in.right.get(292) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(296) * frameCount, wvStart+buf+in.left.get(296) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(296) * frameCount, cY+in.right.get(296) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(300) * frameCount, wvStart+buf+in.left.get(300) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(300) * frameCount, cY+in.right.get(300) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(304) * frameCount, wvStart+buf+in.left.get(304) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(304) * frameCount, cY+in.right.get(304) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(304) * frameCount, cY+in.right.get(304) * frameCount, 
        wvStart+buf+in.left.get(305) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(305) * cos(frameCount), 
        wvStart+buf+in.left.get(306) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(306)  * sin(frameCount), 
        wvStart+buf+in.left.get(307) * frameCount, cY+in.right.get(307) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(308) * frameCount, wvStart+buf+in.left.get(308) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(308) * frameCount, cY+in.right.get(308) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(312) * frameCount, wvStart+buf+in.left.get(312) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(312) * frameCount, cY+in.right.get(312) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(316) * frameCount, wvStart+buf+in.left.get(316) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(316) * frameCount, cY+in.right.get(316) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(320) * frameCount, wvStart+buf+in.left.get(320) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(320) * frameCount, cY+in.right.get(320) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(320) * frameCount, cY+in.right.get(320) * frameCount, 
        wvStart+buf+in.left.get(321) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(321) * cos(frameCount), 
        wvStart+buf+in.left.get(322) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(322)  * sin(frameCount), 
        wvStart+buf+in.left.get(323) * frameCount, cY+in.right.get(323) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(324) * frameCount, wvStart+buf+in.left.get(324) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(324) * frameCount, cY+in.right.get(324) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(328) * frameCount, wvStart+buf+in.left.get(328) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(328) * frameCount, cY+in.right.get(328) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(332) * frameCount, wvStart+buf+in.left.get(332) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(332) * frameCount, cY+in.right.get(332) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(336) * frameCount, wvStart+buf+in.left.get(336) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(336) * frameCount, cY+in.right.get(336) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(336) * frameCount, cY+in.right.get(336) * frameCount, 
        wvStart+buf+in.left.get(337) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(337) * cos(frameCount), 
        wvStart+buf+in.left.get(338) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(338)  * sin(frameCount), 
        wvStart+buf+in.left.get(339) * frameCount, cY+in.right.get(339) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(340) * frameCount, wvStart+buf+in.left.get(340) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(340) * frameCount, cY+in.right.get(340) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(344) * frameCount, wvStart+buf+in.left.get(344) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(344) * frameCount, cY+in.right.get(344) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(348) * frameCount, wvStart+buf+in.left.get(348) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(348) * frameCount, cY+in.right.get(348) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(352) * frameCount, wvStart+buf+in.left.get(352) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(352) * frameCount, cY+in.right.get(352) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(352) * frameCount, cY+in.right.get(352) * frameCount, 
        wvStart+buf+in.left.get(353) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(353) * cos(frameCount), 
        wvStart+buf+in.left.get(354) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(354)  * sin(frameCount), 
        wvStart+buf+in.left.get(355) * frameCount, cY+in.right.get(355) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(356) * frameCount, wvStart+buf+in.left.get(356) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(356) * frameCount, cY+in.right.get(356) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(360) * frameCount, wvStart+buf+in.left.get(360) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(360) * frameCount, cY+in.right.get(360) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(364) * frameCount, wvStart+buf+in.left.get(364) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(364) * frameCount, cY+in.right.get(364) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(368) * frameCount, wvStart+buf+in.left.get(368) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(368) * frameCount, cY+in.right.get(368) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(368) * frameCount, cY+in.right.get(368) * frameCount, 
        wvStart+buf+in.left.get(369) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(369) * cos(frameCount), 
        wvStart+buf+in.left.get(370) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(370)  * sin(frameCount), 
        wvStart+buf+in.left.get(371) * frameCount, cY+in.right.get(371) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(372) * frameCount, wvStart+buf+in.left.get(372) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(372) * frameCount, cY+in.right.get(372) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(376) * frameCount, wvStart+buf+in.left.get(376) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(376) * frameCount, cY+in.right.get(376) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(380) * frameCount, wvStart+buf+in.left.get(380) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(380) * frameCount, cY+in.right.get(380) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(384) * frameCount, wvStart+buf+in.left.get(384) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(384) * frameCount, cY+in.right.get(384) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(384) * frameCount, cY+in.right.get(384) * frameCount, 
        wvStart+buf+in.left.get(385) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(385) * cos(frameCount), 
        wvStart+buf+in.left.get(386) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(386)  * sin(frameCount), 
        wvStart+buf+in.left.get(387) * frameCount, cY+in.right.get(387) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(388) * frameCount, wvStart+buf+in.left.get(388) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(388) * frameCount, cY+in.right.get(388) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(392) * frameCount, wvStart+buf+in.left.get(392) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(392) * frameCount, cY+in.right.get(392) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(396) * frameCount, wvStart+buf+in.left.get(396) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(396) * frameCount, cY+in.right.get(396) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(400) * frameCount, wvStart+buf+in.left.get(400) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(400) * frameCount, cY+in.right.get(400) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(400) * frameCount, cY+in.right.get(400) * frameCount, 
        wvStart+buf+in.left.get(401) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(401) * cos(frameCount), 
        wvStart+buf+in.left.get(402) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(402)  * sin(frameCount), 
        wvStart+buf+in.left.get(403) * frameCount, cY+in.right.get(403) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(404) * frameCount, wvStart+buf+in.left.get(404) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(404) * frameCount, cY+in.right.get(404) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(408) * frameCount, wvStart+buf+in.left.get(408) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(408) * frameCount, cY+in.right.get(408) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(412) * frameCount, wvStart+buf+in.left.get(412) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(412) * frameCount, cY+in.right.get(412) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(416) * frameCount, wvStart+buf+in.left.get(416) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(416) * frameCount, cY+in.right.get(416) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(416) * frameCount, cY+in.right.get(416) * frameCount, 
        wvStart+buf+in.left.get(417) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(417) * cos(frameCount), 
        wvStart+buf+in.left.get(418) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(418)  * sin(frameCount), 
        wvStart+buf+in.left.get(419) * frameCount, cY+in.right.get(419) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(420) * frameCount, wvStart+buf+in.left.get(420) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(420) * frameCount, cY+in.right.get(420) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(424) * frameCount, wvStart+buf+in.left.get(424) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(424) * frameCount, cY+in.right.get(424) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(428) * frameCount, wvStart+buf+in.left.get(428) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(428) * frameCount, cY+in.right.get(428) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(432) * frameCount, wvStart+buf+in.left.get(432) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(432) * frameCount, cY+in.right.get(432) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(432) * frameCount, cY+in.right.get(432) * frameCount, 
        wvStart+buf+in.left.get(433) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(433) * cos(frameCount), 
        wvStart+buf+in.left.get(434) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(434)  * sin(frameCount), 
        wvStart+buf+in.left.get(435) * frameCount, cY+in.right.get(435) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(436) * frameCount, wvStart+buf+in.left.get(436) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(436) * frameCount, cY+in.right.get(436) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(440) * frameCount, wvStart+buf+in.left.get(440) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(440) * frameCount, cY+in.right.get(440) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(444) * frameCount, wvStart+buf+in.left.get(444) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(444) * frameCount, cY+in.right.get(444) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(448) * frameCount, wvStart+buf+in.left.get(448) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(448) * frameCount, cY+in.right.get(448) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(448) * frameCount, cY+in.right.get(448) * frameCount, 
        wvStart+buf+in.left.get(449) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(449) * cos(frameCount), 
        wvStart+buf+in.left.get(450) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(450)  * sin(frameCount), 
        wvStart+buf+in.left.get(451) * frameCount, cY+in.right.get(451) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(452) * frameCount, wvStart+buf+in.left.get(452) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(452) * frameCount, cY+in.right.get(452) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(456) * frameCount, wvStart+buf+in.left.get(456) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(456) * frameCount, cY+in.right.get(456) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(460) * frameCount, wvStart+buf+in.left.get(460) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(460) * frameCount, cY+in.right.get(460) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(464) * frameCount, wvStart+buf+in.left.get(464) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(464) * frameCount, cY+in.right.get(464) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(464) * frameCount, cY+in.right.get(464) * frameCount, 
        wvStart+buf+in.left.get(465) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(465) * cos(frameCount), 
        wvStart+buf+in.left.get(466) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(466)  * sin(frameCount), 
        wvStart+buf+in.left.get(467) * frameCount, cY+in.right.get(467) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(468) * frameCount, wvStart+buf+in.left.get(468) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(468) * frameCount, cY+in.right.get(468) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(472) * frameCount, wvStart+buf+in.left.get(472) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(472) * frameCount, cY+in.right.get(472) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(476) * frameCount, wvStart+buf+in.left.get(476) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(476) * frameCount, cY+in.right.get(476) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(480) * frameCount, wvStart+buf+in.left.get(480) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(480) * frameCount, cY+in.right.get(480) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(480) * frameCount, cY+in.right.get(480) * frameCount, 
        wvStart+buf+in.left.get(481) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(481) * cos(frameCount), 
        wvStart+buf+in.left.get(482) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(482)  * sin(frameCount), 
        wvStart+buf+in.left.get(483) * frameCount, cY+in.right.get(483) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(484) * frameCount, wvStart+buf+in.left.get(484) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(484) * frameCount, cY+in.right.get(484) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(488) * frameCount, wvStart+buf+in.left.get(488) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(488) * frameCount, cY+in.right.get(488) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(492) * frameCount, wvStart+buf+in.left.get(492) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(492) * frameCount, cY+in.right.get(492) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(496) * frameCount, wvStart+buf+in.left.get(496) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(496) * frameCount, cY+in.right.get(496) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(496) * frameCount, cY+in.right.get(496) * frameCount, 
        wvStart+buf+in.left.get(497) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(497) * cos(frameCount), 
        wvStart+buf+in.left.get(498) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(498)  * sin(frameCount), 
        wvStart+buf+in.left.get(499) * frameCount, cY+in.right.get(499) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(500) * frameCount, wvStart+buf+in.left.get(500) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(500) * frameCount, cY+in.right.get(500) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(504) * frameCount, wvStart+buf+in.left.get(504) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(504) * frameCount, cY+in.right.get(504) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(508) * frameCount, wvStart+buf+in.left.get(508) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(508) * frameCount, cY+in.right.get(508) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(512) * frameCount, wvStart+buf+in.left.get(512) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(512) * frameCount, cY+in.right.get(512) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(512) * frameCount, cY+in.right.get(512) * frameCount, 
        wvStart+buf+in.left.get(513) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(513) * cos(frameCount), 
        wvStart+buf+in.left.get(514) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(514)  * sin(frameCount), 
        wvStart+buf+in.left.get(515) * frameCount, cY+in.right.get(515) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(516) * frameCount, wvStart+buf+in.left.get(516) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(516) * frameCount, cY+in.right.get(516) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(520) * frameCount, wvStart+buf+in.left.get(520) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(520) * frameCount, cY+in.right.get(520) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(524) * frameCount, wvStart+buf+in.left.get(524) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(524) * frameCount, cY+in.right.get(524) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(528) * frameCount, wvStart+buf+in.left.get(528) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(528) * frameCount, cY+in.right.get(528) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(528) * frameCount, cY+in.right.get(528) * frameCount, 
        wvStart+buf+in.left.get(529) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(529) * cos(frameCount), 
        wvStart+buf+in.left.get(530) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(530)  * sin(frameCount), 
        wvStart+buf+in.left.get(531) * frameCount, cY+in.right.get(531) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(532) * frameCount, wvStart+buf+in.left.get(532) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(532) * frameCount, cY+in.right.get(532) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(536) * frameCount, wvStart+buf+in.left.get(536) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(536) * frameCount, cY+in.right.get(536) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(540) * frameCount, wvStart+buf+in.left.get(540) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(540) * frameCount, cY+in.right.get(540) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(544) * frameCount, wvStart+buf+in.left.get(544) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(544) * frameCount, cY+in.right.get(544) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(544) * frameCount, cY+in.right.get(544) * frameCount, 
        wvStart+buf+in.left.get(545) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(545) * cos(frameCount), 
        wvStart+buf+in.left.get(546) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(546)  * sin(frameCount), 
        wvStart+buf+in.left.get(547) * frameCount, cY+in.right.get(547) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(548) * frameCount, wvStart+buf+in.left.get(548) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(548) * frameCount, cY+in.right.get(548) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(552) * frameCount, wvStart+buf+in.left.get(552) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(552) * frameCount, cY+in.right.get(552) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(556) * frameCount, wvStart+buf+in.left.get(556) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(556) * frameCount, cY+in.right.get(556) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(560) * frameCount, wvStart+buf+in.left.get(560) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(560) * frameCount, cY+in.right.get(560) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(560) * frameCount, cY+in.right.get(560) * frameCount, 
        wvStart+buf+in.left.get(561) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(561) * cos(frameCount), 
        wvStart+buf+in.left.get(562) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(562)  * sin(frameCount), 
        wvStart+buf+in.left.get(563) * frameCount, cY+in.right.get(563) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(564) * frameCount, wvStart+buf+in.left.get(564) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(564) * frameCount, cY+in.right.get(564) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(568) * frameCount, wvStart+buf+in.left.get(568) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(568) * frameCount, cY+in.right.get(568) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(572) * frameCount, wvStart+buf+in.left.get(572) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(572) * frameCount, cY+in.right.get(572) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(576) * frameCount, wvStart+buf+in.left.get(576) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(576) * frameCount, cY+in.right.get(576) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(576) * frameCount, cY+in.right.get(576) * frameCount, 
        wvStart+buf+in.left.get(577) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(577) * cos(frameCount), 
        wvStart+buf+in.left.get(578) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(578)  * sin(frameCount), 
        wvStart+buf+in.left.get(579) * frameCount, cY+in.right.get(579) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(580) * frameCount, wvStart+buf+in.left.get(580) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(580) * frameCount, cY+in.right.get(580) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(584) * frameCount, wvStart+buf+in.left.get(584) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(584) * frameCount, cY+in.right.get(584) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(588) * frameCount, wvStart+buf+in.left.get(588) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(588) * frameCount, cY+in.right.get(588) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(592) * frameCount, wvStart+buf+in.left.get(592) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(592) * frameCount, cY+in.right.get(592) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(592) * frameCount, cY+in.right.get(592) * frameCount, 
        wvStart+buf+in.left.get(593) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(593) * cos(frameCount), 
        wvStart+buf+in.left.get(594) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(594)  * sin(frameCount), 
        wvStart+buf+in.left.get(595) * frameCount, cY+in.right.get(595) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(596) * frameCount, wvStart+buf+in.left.get(596) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(596) * frameCount, cY+in.right.get(596) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(600) * frameCount, wvStart+buf+in.left.get(600) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(600) * frameCount, cY+in.right.get(600) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(604) * frameCount, wvStart+buf+in.left.get(604) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(604) * frameCount, cY+in.right.get(604) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(608) * frameCount, wvStart+buf+in.left.get(608) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(608) * frameCount, cY+in.right.get(608) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(608) * frameCount, cY+in.right.get(608) * frameCount, 
        wvStart+buf+in.left.get(609) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(609) * cos(frameCount), 
        wvStart+buf+in.left.get(610) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(610)  * sin(frameCount), 
        wvStart+buf+in.left.get(611) * frameCount, cY+in.right.get(611) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(612) * frameCount, wvStart+buf+in.left.get(612) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(612) * frameCount, cY+in.right.get(612) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(616) * frameCount, wvStart+buf+in.left.get(616) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(616) * frameCount, cY+in.right.get(616) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(620) * frameCount, wvStart+buf+in.left.get(620) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(620) * frameCount, cY+in.right.get(620) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(624) * frameCount, wvStart+buf+in.left.get(624) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(624) * frameCount, cY+in.right.get(624) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(624) * frameCount, cY+in.right.get(624) * frameCount, 
        wvStart+buf+in.left.get(625) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(625) * cos(frameCount), 
        wvStart+buf+in.left.get(626) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(626)  * sin(frameCount), 
        wvStart+buf+in.left.get(627) * frameCount, cY+in.right.get(627) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(628) * frameCount, wvStart+buf+in.left.get(628) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(628) * frameCount, cY+in.right.get(628) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(632) * frameCount, wvStart+buf+in.left.get(632) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(632) * frameCount, cY+in.right.get(632) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(636) * frameCount, wvStart+buf+in.left.get(636) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(636) * frameCount, cY+in.right.get(636) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(640) * frameCount, wvStart+buf+in.left.get(640) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(640) * frameCount, cY+in.right.get(640) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(640) * frameCount, cY+in.right.get(640) * frameCount, 
        wvStart+buf+in.left.get(641) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(641) * cos(frameCount), 
        wvStart+buf+in.left.get(642) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(642)  * sin(frameCount), 
        wvStart+buf+in.left.get(643) * frameCount, cY+in.right.get(643) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(644) * frameCount, wvStart+buf+in.left.get(644) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(644) * frameCount, cY+in.right.get(644) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(648) * frameCount, wvStart+buf+in.left.get(648) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(648) * frameCount, cY+in.right.get(648) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(652) * frameCount, wvStart+buf+in.left.get(652) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(652) * frameCount, cY+in.right.get(652) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(656) * frameCount, wvStart+buf+in.left.get(656) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(656) * frameCount, cY+in.right.get(656) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(656) * frameCount, cY+in.right.get(656) * frameCount, 
        wvStart+buf+in.left.get(657) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(657) * cos(frameCount), 
        wvStart+buf+in.left.get(658) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(658)  * sin(frameCount), 
        wvStart+buf+in.left.get(659) * frameCount, cY+in.right.get(659) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(660) * frameCount, wvStart+buf+in.left.get(660) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(660) * frameCount, cY+in.right.get(660) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(664) * frameCount, wvStart+buf+in.left.get(664) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(664) * frameCount, cY+in.right.get(664) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(668) * frameCount, wvStart+buf+in.left.get(668) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(668) * frameCount, cY+in.right.get(668) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(672) * frameCount, wvStart+buf+in.left.get(672) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(672) * frameCount, cY+in.right.get(672) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(672) * frameCount, cY+in.right.get(672) * frameCount, 
        wvStart+buf+in.left.get(673) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(673) * cos(frameCount), 
        wvStart+buf+in.left.get(674) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(674)  * sin(frameCount), 
        wvStart+buf+in.left.get(675) * frameCount, cY+in.right.get(675) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(676) * frameCount, wvStart+buf+in.left.get(676) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(676) * frameCount, cY+in.right.get(676) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(680) * frameCount, wvStart+buf+in.left.get(680) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(680) * frameCount, cY+in.right.get(680) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(684) * frameCount, wvStart+buf+in.left.get(684) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(684) * frameCount, cY+in.right.get(684) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(688) * frameCount, wvStart+buf+in.left.get(688) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(688) * frameCount, cY+in.right.get(688) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(688) * frameCount, cY+in.right.get(688) * frameCount, 
        wvStart+buf+in.left.get(689) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(689) * cos(frameCount), 
        wvStart+buf+in.left.get(690) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(690)  * sin(frameCount), 
        wvStart+buf+in.left.get(691) * frameCount, cY+in.right.get(691) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(692) * frameCount, wvStart+buf+in.left.get(692) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(692) * frameCount, cY+in.right.get(692) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(696) * frameCount, wvStart+buf+in.left.get(696) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(696) * frameCount, cY+in.right.get(696) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(700) * frameCount, wvStart+buf+in.left.get(700) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(700) * frameCount, cY+in.right.get(700) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(704) * frameCount, wvStart+buf+in.left.get(704) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(704) * frameCount, cY+in.right.get(704) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(704) * frameCount, cY+in.right.get(704) * frameCount, 
        wvStart+buf+in.left.get(705) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(705) * cos(frameCount), 
        wvStart+buf+in.left.get(706) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(706)  * sin(frameCount), 
        wvStart+buf+in.left.get(707) * frameCount, cY+in.right.get(707) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(708) * frameCount, wvStart+buf+in.left.get(708) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(708) * frameCount, cY+in.right.get(708) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(712) * frameCount, wvStart+buf+in.left.get(712) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(712) * frameCount, cY+in.right.get(712) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(716) * frameCount, wvStart+buf+in.left.get(716) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(716) * frameCount, cY+in.right.get(716) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(720) * frameCount, wvStart+buf+in.left.get(720) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(720) * frameCount, cY+in.right.get(720) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(720) * frameCount, cY+in.right.get(720) * frameCount, 
        wvStart+buf+in.left.get(721) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(721) * cos(frameCount), 
        wvStart+buf+in.left.get(722) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(722)  * sin(frameCount), 
        wvStart+buf+in.left.get(723) * frameCount, cY+in.right.get(723) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(724) * frameCount, wvStart+buf+in.left.get(724) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(724) * frameCount, cY+in.right.get(724) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(728) * frameCount, wvStart+buf+in.left.get(728) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(728) * frameCount, cY+in.right.get(728) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(732) * frameCount, wvStart+buf+in.left.get(732) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(732) * frameCount, cY+in.right.get(732) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(736) * frameCount, wvStart+buf+in.left.get(736) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(736) * frameCount, cY+in.right.get(736) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(736) * frameCount, cY+in.right.get(736) * frameCount, 
        wvStart+buf+in.left.get(737) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(737) * cos(frameCount), 
        wvStart+buf+in.left.get(738) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(738)  * sin(frameCount), 
        wvStart+buf+in.left.get(739) * frameCount, cY+in.right.get(739) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(740) * frameCount, wvStart+buf+in.left.get(740) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(740) * frameCount, cY+in.right.get(740) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(744) * frameCount, wvStart+buf+in.left.get(744) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(744) * frameCount, cY+in.right.get(744) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(748) * frameCount, wvStart+buf+in.left.get(748) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(748) * frameCount, cY+in.right.get(748) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(752) * frameCount, wvStart+buf+in.left.get(752) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(752) * frameCount, cY+in.right.get(752) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(752) * frameCount, cY+in.right.get(752) * frameCount, 
        wvStart+buf+in.left.get(753) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(753) * cos(frameCount), 
        wvStart+buf+in.left.get(754) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(754)  * sin(frameCount), 
        wvStart+buf+in.left.get(755) * frameCount, cY+in.right.get(755) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(756) * frameCount, wvStart+buf+in.left.get(756) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(756) * frameCount, cY+in.right.get(756) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(760) * frameCount, wvStart+buf+in.left.get(760) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(760) * frameCount, cY+in.right.get(760) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(764) * frameCount, wvStart+buf+in.left.get(764) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(764) * frameCount, cY+in.right.get(764) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(768) * frameCount, wvStart+buf+in.left.get(768) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(768) * frameCount, cY+in.right.get(768) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(768) * frameCount, cY+in.right.get(768) * frameCount, 
        wvStart+buf+in.left.get(769) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(769) * cos(frameCount), 
        wvStart+buf+in.left.get(770) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(770)  * sin(frameCount), 
        wvStart+buf+in.left.get(771) * frameCount, cY+in.right.get(771) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(772) * frameCount, wvStart+buf+in.left.get(772) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(772) * frameCount, cY+in.right.get(772) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(776) * frameCount, wvStart+buf+in.left.get(776) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(776) * frameCount, cY+in.right.get(776) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(780) * frameCount, wvStart+buf+in.left.get(780) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(780) * frameCount, cY+in.right.get(780) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(784) * frameCount, wvStart+buf+in.left.get(784) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(784) * frameCount, cY+in.right.get(784) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(784) * frameCount, cY+in.right.get(784) * frameCount, 
        wvStart+buf+in.left.get(785) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(785) * cos(frameCount), 
        wvStart+buf+in.left.get(786) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(786)  * sin(frameCount), 
        wvStart+buf+in.left.get(787) * frameCount, cY+in.right.get(787) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(788) * frameCount, wvStart+buf+in.left.get(788) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(788) * frameCount, cY+in.right.get(788) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(792) * frameCount, wvStart+buf+in.left.get(792) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(792) * frameCount, cY+in.right.get(792) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(796) * frameCount, wvStart+buf+in.left.get(796) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(796) * frameCount, cY+in.right.get(796) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(800) * frameCount, wvStart+buf+in.left.get(800) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(800) * frameCount, cY+in.right.get(800) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(800) * frameCount, cY+in.right.get(800) * frameCount, 
        wvStart+buf+in.left.get(801) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(801) * cos(frameCount), 
        wvStart+buf+in.left.get(802) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(802)  * sin(frameCount), 
        wvStart+buf+in.left.get(803) * frameCount, cY+in.right.get(803) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(804) * frameCount, wvStart+buf+in.left.get(804) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(804) * frameCount, cY+in.right.get(804) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(808) * frameCount, wvStart+buf+in.left.get(808) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(808) * frameCount, cY+in.right.get(808) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(812) * frameCount, wvStart+buf+in.left.get(812) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(812) * frameCount, cY+in.right.get(812) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(816) * frameCount, wvStart+buf+in.left.get(816) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(816) * frameCount, cY+in.right.get(816) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(816) * frameCount, cY+in.right.get(816) * frameCount, 
        wvStart+buf+in.left.get(817) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(817) * cos(frameCount), 
        wvStart+buf+in.left.get(818) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(818)  * sin(frameCount), 
        wvStart+buf+in.left.get(819) * frameCount, cY+in.right.get(819) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(820) * frameCount, wvStart+buf+in.left.get(820) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(820) * frameCount, cY+in.right.get(820) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(824) * frameCount, wvStart+buf+in.left.get(824) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(824) * frameCount, cY+in.right.get(824) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(828) * frameCount, wvStart+buf+in.left.get(828) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(828) * frameCount, cY+in.right.get(828) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(832) * frameCount, wvStart+buf+in.left.get(832) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(832) * frameCount, cY+in.right.get(832) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(832) * frameCount, cY+in.right.get(832) * frameCount, 
        wvStart+buf+in.left.get(833) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(833) * cos(frameCount), 
        wvStart+buf+in.left.get(834) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(834)  * sin(frameCount), 
        wvStart+buf+in.left.get(835) * frameCount, cY+in.right.get(835) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(836) * frameCount, wvStart+buf+in.left.get(836) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(836) * frameCount, cY+in.right.get(836) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(840) * frameCount, wvStart+buf+in.left.get(840) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(840) * frameCount, cY+in.right.get(840) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(844) * frameCount, wvStart+buf+in.left.get(844) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(844) * frameCount, cY+in.right.get(844) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(848) * frameCount, wvStart+buf+in.left.get(848) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(848) * frameCount, cY+in.right.get(848) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(848) * frameCount, cY+in.right.get(848) * frameCount, 
        wvStart+buf+in.left.get(849) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(849) * cos(frameCount), 
        wvStart+buf+in.left.get(850) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(850)  * sin(frameCount), 
        wvStart+buf+in.left.get(851) * frameCount, cY+in.right.get(851) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(852) * frameCount, wvStart+buf+in.left.get(852) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(852) * frameCount, cY+in.right.get(852) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(856) * frameCount, wvStart+buf+in.left.get(856) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(856) * frameCount, cY+in.right.get(856) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(860) * frameCount, wvStart+buf+in.left.get(860) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(860) * frameCount, cY+in.right.get(860) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(864) * frameCount, wvStart+buf+in.left.get(864) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(864) * frameCount, cY+in.right.get(864) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(864) * frameCount, cY+in.right.get(864) * frameCount, 
        wvStart+buf+in.left.get(865) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(865) * cos(frameCount), 
        wvStart+buf+in.left.get(866) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(866)  * sin(frameCount), 
        wvStart+buf+in.left.get(867) * frameCount, cY+in.right.get(867) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(868) * frameCount, wvStart+buf+in.left.get(868) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(868) * frameCount, cY+in.right.get(868) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(872) * frameCount, wvStart+buf+in.left.get(872) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(872) * frameCount, cY+in.right.get(872) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(876) * frameCount, wvStart+buf+in.left.get(876) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(876) * frameCount, cY+in.right.get(876) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(880) * frameCount, wvStart+buf+in.left.get(880) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(880) * frameCount, cY+in.right.get(880) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(880) * frameCount, cY+in.right.get(880) * frameCount, 
        wvStart+buf+in.left.get(881) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(881) * cos(frameCount), 
        wvStart+buf+in.left.get(882) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(882)  * sin(frameCount), 
        wvStart+buf+in.left.get(883) * frameCount, cY+in.right.get(883) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(884) * frameCount, wvStart+buf+in.left.get(884) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(884) * frameCount, cY+in.right.get(884) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(888) * frameCount, wvStart+buf+in.left.get(888) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(888) * frameCount, cY+in.right.get(888) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(892) * frameCount, wvStart+buf+in.left.get(892) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(892) * frameCount, cY+in.right.get(892) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(896) * frameCount, wvStart+buf+in.left.get(896) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(896) * frameCount, cY+in.right.get(896) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(896) * frameCount, cY+in.right.get(896) * frameCount, 
        wvStart+buf+in.left.get(897) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(897) * cos(frameCount), 
        wvStart+buf+in.left.get(898) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(898)  * sin(frameCount), 
        wvStart+buf+in.left.get(899) * frameCount, cY+in.right.get(899) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(768) * frameCount, wvStart+buf+in.left.get(768) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(768) * frameCount, cY+in.right.get(768) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(904) * frameCount, wvStart+buf+in.left.get(904) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(904) * frameCount, cY+in.right.get(904) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(908) * frameCount, wvStart+buf+in.left.get(908) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(908) * frameCount, cY+in.right.get(908) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(912) * frameCount, wvStart+buf+in.left.get(912) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(912) * frameCount, cY+in.right.get(912) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(912) * frameCount, cY+in.right.get(912) * frameCount, 
        wvStart+buf+in.left.get(913) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(913) * cos(frameCount), 
        wvStart+buf+in.left.get(914) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(914)  * sin(frameCount), 
        wvStart+buf+in.left.get(915) * frameCount, cY+in.right.get(915) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(916) * frameCount, wvStart+buf+in.left.get(916) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(916) * frameCount, cY+in.right.get(916) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(920) * frameCount, wvStart+buf+in.left.get(920) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(920) * frameCount, cY+in.right.get(920) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(924) * frameCount, wvStart+buf+in.left.get(924) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(924) * frameCount, cY+in.right.get(924) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(928) * frameCount, wvStart+buf+in.left.get(928) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(928) * frameCount, cY+in.right.get(928) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(928) * frameCount, cY+in.right.get(928) * frameCount, 
        wvStart+buf+in.left.get(929) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(929) * cos(frameCount), 
        wvStart+buf+in.left.get(930) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(930)  * sin(frameCount), 
        wvStart+buf+in.left.get(931) * frameCount, cY+in.right.get(931) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(932) * frameCount, wvStart+buf+in.left.get(932) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(932) * frameCount, cY+in.right.get(932) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(936) * frameCount, wvStart+buf+in.left.get(936) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(936) * frameCount, cY+in.right.get(936) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(940) * frameCount, wvStart+buf+in.left.get(940) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(940) * frameCount, cY+in.right.get(940) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(944) * frameCount, wvStart+buf+in.left.get(944) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(944) * frameCount, cY+in.right.get(944) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(944) * frameCount, cY+in.right.get(944) * frameCount, 
        wvStart+buf+in.left.get(945) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(945) * cos(frameCount), 
        wvStart+buf+in.left.get(946) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(946)  * sin(frameCount), 
        wvStart+buf+in.left.get(947) * frameCount, cY+in.right.get(947) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(948) * frameCount, wvStart+buf+in.left.get(948) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(948) * frameCount, cY+in.right.get(948) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(952) * frameCount, wvStart+buf+in.left.get(952) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(952) * frameCount, cY+in.right.get(952) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(956) * frameCount, wvStart+buf+in.left.get(956) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(956) * frameCount, cY+in.right.get(956) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(960) * frameCount, wvStart+buf+in.left.get(960) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(960) * frameCount, cY+in.right.get(960) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(960) * frameCount, cY+in.right.get(960) * frameCount, 
        wvStart+buf+in.left.get(961) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(961) * cos(frameCount), 
        wvStart+buf+in.left.get(962) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(962)  * sin(frameCount), 
        wvStart+buf+in.left.get(963) * frameCount, cY+in.right.get(963) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(964) * frameCount, wvStart+buf+in.left.get(964) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(964) * frameCount, cY+in.right.get(964) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(968) * frameCount, wvStart+buf+in.left.get(968) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(968) * frameCount, cY+in.right.get(968) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(972) * frameCount, wvStart+buf+in.left.get(972) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(972) * frameCount, cY+in.right.get(972) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(976) * frameCount, wvStart+buf+in.left.get(976) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(976) * frameCount, cY+in.right.get(976) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(976) * frameCount, cY+in.right.get(976) * frameCount, 
        wvStart+buf+in.left.get(977) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(977) * cos(frameCount), 
        wvStart+buf+in.left.get(978) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(978)  * sin(frameCount), 
        wvStart+buf+in.left.get(979) * frameCount, cY+in.right.get(979) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(980) * frameCount, wvStart+buf+in.left.get(980) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(980) * frameCount, cY+in.right.get(980) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(984) * frameCount, wvStart+buf+in.left.get(984) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(984) * frameCount, cY+in.right.get(984) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(988) * frameCount, wvStart+buf+in.left.get(988) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(988) * frameCount, cY+in.right.get(988) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(992) * frameCount, wvStart+buf+in.left.get(992) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(992) * frameCount, cY+in.right.get(992) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(992) * frameCount, cY+in.right.get(992) * frameCount, 
        wvStart+buf+in.left.get(993) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(993) * cos(frameCount), 
        wvStart+buf+in.left.get(994) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(994)  * sin(frameCount), 
        wvStart+buf+in.left.get(995) * frameCount, cY+in.right.get(995) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(996) * frameCount, wvStart+buf+in.left.get(996) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(996) * frameCount, cY+in.right.get(996) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(1000) * frameCount, wvStart+buf+in.left.get(1000) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(1000) * frameCount, cY+in.right.get(1000) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(1004) * frameCount, wvStart+buf+in.left.get(1004) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(1004) * frameCount, cY+in.right.get(1004) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(1008) * frameCount, wvStart+buf+in.left.get(1008) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(1008) * frameCount, cY+in.right.get(1008) * frameCount); 
stroke(random(75),random(75),random(75),alf);bezier( wvStart+buf+in.left.get(1008) * frameCount, cY+in.right.get(1008) * frameCount, 
        wvStart+buf+in.left.get(1009) * sin(radians(width-frameCount) * width-frameCount), cY+in.right.get(1009) * cos(frameCount), 
        wvStart+buf+in.left.get(1010) * cos(radians(width-frameCount) * width-frameCount), cY+in.right.get(1010)  * sin(frameCount), 
        wvStart+buf+in.left.get(1011) * frameCount, cY+in.right.get(1011) * frameCount );

stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(1012) * frameCount, wvStart+buf+in.left.get(1012) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(1012) * frameCount, cY+in.right.get(1012) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(1016) * frameCount, wvStart+buf+in.left.get(1016) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(1016) * frameCount, cY+in.right.get(1016) * frameCount); 
stroke(frameCount%2==0?0:255,alf);point( cY+in.right.get(1020) * frameCount, wvStart+buf+in.left.get(1020) * frameCount ); 
fix.ranPalStroke100(p3);point( wvStart+buf+in.left.get(1020) * frameCount, cY+in.right.get(1020) * frameCount); 


//  END PASTE HERE
}
