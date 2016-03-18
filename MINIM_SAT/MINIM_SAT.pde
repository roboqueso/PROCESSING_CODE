//import processing.opengl.*;

/**
 Using MINIM AudioInput, get funky with live microphone data
 //  65535 is a frequently occurring number in the field of computing because it is the highest number which can be represented by an unsigned 16 bit binary number
 **/

import ddf.minim.*;

Minim minim;
AudioInput in;
FixLib fix = new FixLib();
Boolean isFinal = true;
int buf;
float alf = 37, tX, tY, inLeft, inRight, wvStart;

int i, cX, cY;
float sz;
float x2, y2, angle2, sz2;


/////////////////////////////////////////////////////////////////////////////////
void setup()
{
  size(1024, 768);
  frameRate(303);//,P3D);//, OPENGL);
  background(#192114); 
  noFill();
  ellipseMode(CENTER);
  rectMode(CENTER); 
  strokeCap(ROUND); 
  strokeJoin(ROUND);
  textFont( createFont( "AnonymousPro", 22 ) );
  
  cX = width/2;
  cY = height/2;

  minim = new Minim(this);

  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
}

/////////////////////////////////////////////////////////////////
void draw()
{
    smooth();
    noFill();

  // start out getting the noise in sync with frameCount, then random
  buf = ( buf < ( in.bufferSize() - 1 ) ) ? buf+1 : 0;
  inLeft = in.left.get(buf) * frameCount;
  inRight = in.right.get(buf) * frameCount;

  strokeWeight( random(constrain(inRight*noise(inLeft)/TWO_PI, .75, height)) );

  wvStart = cX - 512;
  
  
  for (int i = 0; i < in.bufferSize(); i++)
  {
    inLeft = in.left.get(i) * frameCount;
    inRight = in.right.get(i) * frameCount;
    


 // SHADOW BOX HELP GIVE DEPTH TO THE WAVEFORM?
    strokeWeight(11);
    stroke(0,11);
    point(wvStart+ i, cY+inLeft);  
    point(wvStart+ i+1, cY+inRight);

    strokeWeight(TWO_PI);
    stroke(#377537);
    point(wvStart+ i, cY+inLeft);

    strokeWeight(PI);
    stroke(#efefef);
    point(wvStart+ i+1, cY+inRight);

    

  }

    smooth();
    noFill();
 
//    x2 = cX + ( cos(radians(angle2)) * sz2*noise(frameCount) )*inLeft*frameCount;
//    y2 = cY + ( sin(radians(angle2)) * sz2*noise(frameCount) )*inRight*frameCount;
 
x2 = cX + cos(radians(sz2)*angle2) * inLeft;
y2 = cX + sin(radians(sz2)*angle2) * inRight; 
 

 strokeWeight(.75);
    stroke( frameCount%2==0? 0:255, alf);
    beginShape();
      vertex( inLeft*frameCount, inRight*frameCount );
      vertex( inRight*frameCount, inLeft*frameCount );

        vertex( x2, y2 );
        vertex( y2, x2 );
        vertex( angle2, sz2 );
        vertex( sz2, angle2 );

        vertex( width-angle2, sz2 );
        vertex( width-y2, x2 );
        vertex( width-x2, y2 );
        vertex( width-sz2, angle2 );

        vertex( width-angle2, height-sz2 );
        vertex( width-y2, height-x2 );
        vertex( width-x2, height-y2 );
        vertex( width-sz2, height-angle2 );

        vertex( angle2, height-sz2 );
        vertex( y2, height-x2 );
        vertex( x2, height-y2 );
        vertex( sz2, height-angle2 );
    endShape();
 
    // move over a pixel
    if (i < width) {
        i += alf;
    } else {
        i = 0;
        sz2 += sz2*noise(sz2);
    }
 
    angle2+= TWO_PI; 

    
  ////  STOPPER
  if ( frameCount > height) {
    exit();
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
void exit() 
{

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

  textFont( createFont( "AppleGaramond", 37 ) );  //  "TrajanPro-Bold"
  smooth();

  fill(#00EF00);
  text( " "+dailyMsg, 0, height-1);

  fill(0);
  text( " "+dailyMsg, 1, height-3);
}


///////////////////////////////////////////////////////////


void cap(){
  float fc=frameCount;
  wvStart = cX - 512;    smooth();
//              "bezier( , fc, "+_delim+
//      "        ), "+_delim +
//      "        , "+_delim +
//      "        wvStart+buf+in.right.get("+(ct+3)+") * noise(fc), in.left.get("+(ct+3)+") * fc*noise(fc), fc );"+_delim+
  
//  BEGIN PASTE HERE --------------------------------------
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(0) * fc, height-cY+in.right.get(0) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(0), (cY/2)+in.right.get(0) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(0), (cY/2)+in.right.get(0) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(0), (cY/2)+in.right.get(0) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(4) * fc, height-cY+in.right.get(4) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(8) * fc, height-cY+in.right.get(8) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(12) * fc, height-cY+in.right.get(12) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(16) * fc, height-cY+in.right.get(16) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(16), (cY/2)+in.right.get(16) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(16), (cY/2)+in.right.get(16) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(16), (cY/2)+in.right.get(16) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(20) * fc, height-cY+in.right.get(20) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(24) * fc, height-cY+in.right.get(24) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(28) * fc, height-cY+in.right.get(28) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(32) * fc, height-cY+in.right.get(32) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(32), (cY/2)+in.right.get(32) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(32), (cY/2)+in.right.get(32) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(32), (cY/2)+in.right.get(32) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(36) * fc, height-cY+in.right.get(36) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(40) * fc, height-cY+in.right.get(40) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(44) * fc, height-cY+in.right.get(44) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(48) * fc, height-cY+in.right.get(48) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(48), (cY/2)+in.right.get(48) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(48), (cY/2)+in.right.get(48) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(48), (cY/2)+in.right.get(48) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(52) * fc, height-cY+in.right.get(52) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(56) * fc, height-cY+in.right.get(56) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(60) * fc, height-cY+in.right.get(60) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(64) * fc, height-cY+in.right.get(64) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(64), (cY/2)+in.right.get(64) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(64), (cY/2)+in.right.get(64) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(64), (cY/2)+in.right.get(64) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(68) * fc, height-cY+in.right.get(68) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(72) * fc, height-cY+in.right.get(72) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(76) * fc, height-cY+in.right.get(76) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(80) * fc, height-cY+in.right.get(80) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(80), (cY/2)+in.right.get(80) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(80), (cY/2)+in.right.get(80) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(80), (cY/2)+in.right.get(80) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(84) * fc, height-cY+in.right.get(84) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(88) * fc, height-cY+in.right.get(88) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(92) * fc, height-cY+in.right.get(92) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(96) * fc, height-cY+in.right.get(96) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(96), (cY/2)+in.right.get(96) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(96), (cY/2)+in.right.get(96) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(96), (cY/2)+in.right.get(96) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(100) * fc, height-cY+in.right.get(100) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(104) * fc, height-cY+in.right.get(104) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(108) * fc, height-cY+in.right.get(108) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(112) * fc, height-cY+in.right.get(112) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(112), (cY/2)+in.right.get(112) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(112), (cY/2)+in.right.get(112) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(112), (cY/2)+in.right.get(112) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(116) * fc, height-cY+in.right.get(116) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(120) * fc, height-cY+in.right.get(120) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(124) * fc, height-cY+in.right.get(124) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(128) * fc, height-cY+in.right.get(128) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(128), (cY/2)+in.right.get(128) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(128), (cY/2)+in.right.get(128) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(128), (cY/2)+in.right.get(128) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(132) * fc, height-cY+in.right.get(132) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(136) * fc, height-cY+in.right.get(136) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(140) * fc, height-cY+in.right.get(140) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(144) * fc, height-cY+in.right.get(144) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(144), (cY/2)+in.right.get(144) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(144), (cY/2)+in.right.get(144) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(144), (cY/2)+in.right.get(144) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(148) * fc, height-cY+in.right.get(148) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(152) * fc, height-cY+in.right.get(152) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(156) * fc, height-cY+in.right.get(156) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(160) * fc, height-cY+in.right.get(160) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(160), (cY/2)+in.right.get(160) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(160), (cY/2)+in.right.get(160) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(160), (cY/2)+in.right.get(160) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(164) * fc, height-cY+in.right.get(164) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(168) * fc, height-cY+in.right.get(168) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(172) * fc, height-cY+in.right.get(172) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(176) * fc, height-cY+in.right.get(176) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(176), (cY/2)+in.right.get(176) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(176), (cY/2)+in.right.get(176) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(176), (cY/2)+in.right.get(176) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(180) * fc, height-cY+in.right.get(180) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(184) * fc, height-cY+in.right.get(184) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(188) * fc, height-cY+in.right.get(188) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(192) * fc, height-cY+in.right.get(192) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(192), (cY/2)+in.right.get(192) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(192), (cY/2)+in.right.get(192) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(192), (cY/2)+in.right.get(192) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(196) * fc, height-cY+in.right.get(196) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(200) * fc, height-cY+in.right.get(200) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(204) * fc, height-cY+in.right.get(204) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(208) * fc, height-cY+in.right.get(208) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(208), (cY/2)+in.right.get(208) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(208), (cY/2)+in.right.get(208) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(208), (cY/2)+in.right.get(208) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(212) * fc, height-cY+in.right.get(212) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(216) * fc, height-cY+in.right.get(216) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(220) * fc, height-cY+in.right.get(220) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(224) * fc, height-cY+in.right.get(224) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(224), (cY/2)+in.right.get(224) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(224), (cY/2)+in.right.get(224) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(224), (cY/2)+in.right.get(224) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(228) * fc, height-cY+in.right.get(228) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(232) * fc, height-cY+in.right.get(232) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(236) * fc, height-cY+in.right.get(236) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(240) * fc, height-cY+in.right.get(240) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(240), (cY/2)+in.right.get(240) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(240), (cY/2)+in.right.get(240) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(240), (cY/2)+in.right.get(240) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(244) * fc, height-cY+in.right.get(244) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(248) * fc, height-cY+in.right.get(248) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(252) * fc, height-cY+in.right.get(252) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(256) * fc, height-cY+in.right.get(256) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(256), (cY/2)+in.right.get(256) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(256), (cY/2)+in.right.get(256) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(256), (cY/2)+in.right.get(256) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(260) * fc, height-cY+in.right.get(260) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(264) * fc, height-cY+in.right.get(264) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(268) * fc, height-cY+in.right.get(268) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(272) * fc, height-cY+in.right.get(272) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(272), (cY/2)+in.right.get(272) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(272), (cY/2)+in.right.get(272) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(272), (cY/2)+in.right.get(272) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(276) * fc, height-cY+in.right.get(276) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(280) * fc, height-cY+in.right.get(280) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(284) * fc, height-cY+in.right.get(284) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(288) * fc, height-cY+in.right.get(288) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(288), (cY/2)+in.right.get(288) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(288), (cY/2)+in.right.get(288) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(288), (cY/2)+in.right.get(288) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(292) * fc, height-cY+in.right.get(292) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(296) * fc, height-cY+in.right.get(296) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(300) * fc, height-cY+in.right.get(300) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(304) * fc, height-cY+in.right.get(304) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(304), (cY/2)+in.right.get(304) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(304), (cY/2)+in.right.get(304) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(304), (cY/2)+in.right.get(304) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(308) * fc, height-cY+in.right.get(308) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(312) * fc, height-cY+in.right.get(312) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(316) * fc, height-cY+in.right.get(316) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(320) * fc, height-cY+in.right.get(320) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(320), (cY/2)+in.right.get(320) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(320), (cY/2)+in.right.get(320) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(320), (cY/2)+in.right.get(320) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(324) * fc, height-cY+in.right.get(324) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(328) * fc, height-cY+in.right.get(328) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(332) * fc, height-cY+in.right.get(332) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(336) * fc, height-cY+in.right.get(336) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(336), (cY/2)+in.right.get(336) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(336), (cY/2)+in.right.get(336) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(336), (cY/2)+in.right.get(336) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(340) * fc, height-cY+in.right.get(340) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(344) * fc, height-cY+in.right.get(344) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(348) * fc, height-cY+in.right.get(348) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(352) * fc, height-cY+in.right.get(352) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(352), (cY/2)+in.right.get(352) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(352), (cY/2)+in.right.get(352) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(352), (cY/2)+in.right.get(352) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(356) * fc, height-cY+in.right.get(356) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(360) * fc, height-cY+in.right.get(360) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(364) * fc, height-cY+in.right.get(364) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(368) * fc, height-cY+in.right.get(368) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(368), (cY/2)+in.right.get(368) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(368), (cY/2)+in.right.get(368) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(368), (cY/2)+in.right.get(368) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(372) * fc, height-cY+in.right.get(372) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(376) * fc, height-cY+in.right.get(376) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(380) * fc, height-cY+in.right.get(380) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(384) * fc, height-cY+in.right.get(384) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(384), (cY/2)+in.right.get(384) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(384), (cY/2)+in.right.get(384) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(384), (cY/2)+in.right.get(384) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(388) * fc, height-cY+in.right.get(388) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(392) * fc, height-cY+in.right.get(392) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(396) * fc, height-cY+in.right.get(396) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(400) * fc, height-cY+in.right.get(400) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(400), (cY/2)+in.right.get(400) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(400), (cY/2)+in.right.get(400) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(400), (cY/2)+in.right.get(400) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(404) * fc, height-cY+in.right.get(404) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(408) * fc, height-cY+in.right.get(408) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(412) * fc, height-cY+in.right.get(412) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(416) * fc, height-cY+in.right.get(416) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(416), (cY/2)+in.right.get(416) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(416), (cY/2)+in.right.get(416) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(416), (cY/2)+in.right.get(416) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(420) * fc, height-cY+in.right.get(420) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(424) * fc, height-cY+in.right.get(424) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(428) * fc, height-cY+in.right.get(428) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(432) * fc, height-cY+in.right.get(432) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(432), (cY/2)+in.right.get(432) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(432), (cY/2)+in.right.get(432) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(432), (cY/2)+in.right.get(432) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(436) * fc, height-cY+in.right.get(436) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(440) * fc, height-cY+in.right.get(440) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(444) * fc, height-cY+in.right.get(444) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(448) * fc, height-cY+in.right.get(448) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(448), (cY/2)+in.right.get(448) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(448), (cY/2)+in.right.get(448) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(448), (cY/2)+in.right.get(448) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(452) * fc, height-cY+in.right.get(452) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(456) * fc, height-cY+in.right.get(456) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(460) * fc, height-cY+in.right.get(460) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(464) * fc, height-cY+in.right.get(464) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(464), (cY/2)+in.right.get(464) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(464), (cY/2)+in.right.get(464) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(464), (cY/2)+in.right.get(464) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(468) * fc, height-cY+in.right.get(468) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(472) * fc, height-cY+in.right.get(472) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(476) * fc, height-cY+in.right.get(476) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(480) * fc, height-cY+in.right.get(480) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(480), (cY/2)+in.right.get(480) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(480), (cY/2)+in.right.get(480) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(480), (cY/2)+in.right.get(480) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(484) * fc, height-cY+in.right.get(484) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(488) * fc, height-cY+in.right.get(488) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(492) * fc, height-cY+in.right.get(492) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(496) * fc, height-cY+in.right.get(496) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(496), (cY/2)+in.right.get(496) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(496), (cY/2)+in.right.get(496) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(496), (cY/2)+in.right.get(496) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(500) * fc, height-cY+in.right.get(500) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(504) * fc, height-cY+in.right.get(504) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(508) * fc, height-cY+in.right.get(508) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(512) * fc, height-cY+in.right.get(512) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(512), (cY/2)+in.right.get(512) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(512), (cY/2)+in.right.get(512) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(512), (cY/2)+in.right.get(512) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(516) * fc, height-cY+in.right.get(516) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(520) * fc, height-cY+in.right.get(520) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(524) * fc, height-cY+in.right.get(524) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(528) * fc, height-cY+in.right.get(528) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(528), (cY/2)+in.right.get(528) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(528), (cY/2)+in.right.get(528) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(528), (cY/2)+in.right.get(528) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(532) * fc, height-cY+in.right.get(532) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(536) * fc, height-cY+in.right.get(536) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(540) * fc, height-cY+in.right.get(540) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(544) * fc, height-cY+in.right.get(544) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(544), (cY/2)+in.right.get(544) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(544), (cY/2)+in.right.get(544) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(544), (cY/2)+in.right.get(544) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(548) * fc, height-cY+in.right.get(548) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(552) * fc, height-cY+in.right.get(552) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(556) * fc, height-cY+in.right.get(556) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(560) * fc, height-cY+in.right.get(560) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(560), (cY/2)+in.right.get(560) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(560), (cY/2)+in.right.get(560) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(560), (cY/2)+in.right.get(560) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(564) * fc, height-cY+in.right.get(564) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(568) * fc, height-cY+in.right.get(568) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(572) * fc, height-cY+in.right.get(572) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(576) * fc, height-cY+in.right.get(576) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(576), (cY/2)+in.right.get(576) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(576), (cY/2)+in.right.get(576) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(576), (cY/2)+in.right.get(576) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(580) * fc, height-cY+in.right.get(580) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(584) * fc, height-cY+in.right.get(584) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(588) * fc, height-cY+in.right.get(588) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(592) * fc, height-cY+in.right.get(592) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(592), (cY/2)+in.right.get(592) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(592), (cY/2)+in.right.get(592) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(592), (cY/2)+in.right.get(592) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(596) * fc, height-cY+in.right.get(596) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(600) * fc, height-cY+in.right.get(600) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(604) * fc, height-cY+in.right.get(604) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(608) * fc, height-cY+in.right.get(608) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(608), (cY/2)+in.right.get(608) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(608), (cY/2)+in.right.get(608) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(608), (cY/2)+in.right.get(608) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(612) * fc, height-cY+in.right.get(612) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(616) * fc, height-cY+in.right.get(616) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(620) * fc, height-cY+in.right.get(620) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(624) * fc, height-cY+in.right.get(624) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(624), (cY/2)+in.right.get(624) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(624), (cY/2)+in.right.get(624) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(624), (cY/2)+in.right.get(624) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(628) * fc, height-cY+in.right.get(628) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(632) * fc, height-cY+in.right.get(632) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(636) * fc, height-cY+in.right.get(636) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(640) * fc, height-cY+in.right.get(640) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(640), (cY/2)+in.right.get(640) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(640), (cY/2)+in.right.get(640) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(640), (cY/2)+in.right.get(640) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(644) * fc, height-cY+in.right.get(644) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(648) * fc, height-cY+in.right.get(648) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(652) * fc, height-cY+in.right.get(652) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(656) * fc, height-cY+in.right.get(656) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(656), (cY/2)+in.right.get(656) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(656), (cY/2)+in.right.get(656) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(656), (cY/2)+in.right.get(656) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(660) * fc, height-cY+in.right.get(660) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(664) * fc, height-cY+in.right.get(664) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(668) * fc, height-cY+in.right.get(668) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(672) * fc, height-cY+in.right.get(672) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(672), (cY/2)+in.right.get(672) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(672), (cY/2)+in.right.get(672) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(672), (cY/2)+in.right.get(672) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(676) * fc, height-cY+in.right.get(676) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(680) * fc, height-cY+in.right.get(680) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(684) * fc, height-cY+in.right.get(684) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(688) * fc, height-cY+in.right.get(688) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(688), (cY/2)+in.right.get(688) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(688), (cY/2)+in.right.get(688) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(688), (cY/2)+in.right.get(688) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(692) * fc, height-cY+in.right.get(692) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(696) * fc, height-cY+in.right.get(696) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(700) * fc, height-cY+in.right.get(700) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(704) * fc, height-cY+in.right.get(704) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(704), (cY/2)+in.right.get(704) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(704), (cY/2)+in.right.get(704) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(704), (cY/2)+in.right.get(704) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(708) * fc, height-cY+in.right.get(708) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(712) * fc, height-cY+in.right.get(712) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(716) * fc, height-cY+in.right.get(716) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(720) * fc, height-cY+in.right.get(720) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(720), (cY/2)+in.right.get(720) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(720), (cY/2)+in.right.get(720) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(720), (cY/2)+in.right.get(720) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(724) * fc, height-cY+in.right.get(724) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(728) * fc, height-cY+in.right.get(728) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(732) * fc, height-cY+in.right.get(732) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(736) * fc, height-cY+in.right.get(736) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(736), (cY/2)+in.right.get(736) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(736), (cY/2)+in.right.get(736) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(736), (cY/2)+in.right.get(736) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(740) * fc, height-cY+in.right.get(740) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(744) * fc, height-cY+in.right.get(744) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(748) * fc, height-cY+in.right.get(748) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(752) * fc, height-cY+in.right.get(752) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(752), (cY/2)+in.right.get(752) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(752), (cY/2)+in.right.get(752) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(752), (cY/2)+in.right.get(752) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(756) * fc, height-cY+in.right.get(756) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(760) * fc, height-cY+in.right.get(760) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(764) * fc, height-cY+in.right.get(764) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(768) * fc, height-cY+in.right.get(768) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(768), (cY/2)+in.right.get(768) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(768), (cY/2)+in.right.get(768) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(768), (cY/2)+in.right.get(768) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(772) * fc, height-cY+in.right.get(772) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(776) * fc, height-cY+in.right.get(776) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(780) * fc, height-cY+in.right.get(780) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(784) * fc, height-cY+in.right.get(784) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(784), (cY/2)+in.right.get(784) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(784), (cY/2)+in.right.get(784) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(784), (cY/2)+in.right.get(784) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(788) * fc, height-cY+in.right.get(788) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(792) * fc, height-cY+in.right.get(792) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(796) * fc, height-cY+in.right.get(796) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(800) * fc, height-cY+in.right.get(800) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(800), (cY/2)+in.right.get(800) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(800), (cY/2)+in.right.get(800) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(800), (cY/2)+in.right.get(800) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(804) * fc, height-cY+in.right.get(804) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(808) * fc, height-cY+in.right.get(808) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(812) * fc, height-cY+in.right.get(812) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(816) * fc, height-cY+in.right.get(816) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(816), (cY/2)+in.right.get(816) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(816), (cY/2)+in.right.get(816) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(816), (cY/2)+in.right.get(816) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(820) * fc, height-cY+in.right.get(820) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(824) * fc, height-cY+in.right.get(824) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(828) * fc, height-cY+in.right.get(828) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(832) * fc, height-cY+in.right.get(832) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(832), (cY/2)+in.right.get(832) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(832), (cY/2)+in.right.get(832) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(832), (cY/2)+in.right.get(832) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(836) * fc, height-cY+in.right.get(836) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(840) * fc, height-cY+in.right.get(840) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(844) * fc, height-cY+in.right.get(844) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(848) * fc, height-cY+in.right.get(848) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(848), (cY/2)+in.right.get(848) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(848), (cY/2)+in.right.get(848) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(848), (cY/2)+in.right.get(848) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(852) * fc, height-cY+in.right.get(852) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(856) * fc, height-cY+in.right.get(856) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(860) * fc, height-cY+in.right.get(860) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(864) * fc, height-cY+in.right.get(864) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(864), (cY/2)+in.right.get(864) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(864), (cY/2)+in.right.get(864) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(864), (cY/2)+in.right.get(864) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(868) * fc, height-cY+in.right.get(868) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(872) * fc, height-cY+in.right.get(872) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(876) * fc, height-cY+in.right.get(876) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(880) * fc, height-cY+in.right.get(880) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(880), (cY/2)+in.right.get(880) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(880), (cY/2)+in.right.get(880) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(880), (cY/2)+in.right.get(880) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(884) * fc, height-cY+in.right.get(884) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(888) * fc, height-cY+in.right.get(888) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(892) * fc, height-cY+in.right.get(892) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(896) * fc, height-cY+in.right.get(896) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(896), (cY/2)+in.right.get(896) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(896), (cY/2)+in.right.get(896) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(896), (cY/2)+in.right.get(896) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(768) * fc, height-cY+in.right.get(768) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(904) * fc, height-cY+in.right.get(904) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(908) * fc, height-cY+in.right.get(908) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(912) * fc, height-cY+in.right.get(912) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(912), (cY/2)+in.right.get(912) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(912), (cY/2)+in.right.get(912) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(912), (cY/2)+in.right.get(912) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(916) * fc, height-cY+in.right.get(916) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(920) * fc, height-cY+in.right.get(920) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(924) * fc, height-cY+in.right.get(924) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(928) * fc, height-cY+in.right.get(928) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(928), (cY/2)+in.right.get(928) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(928), (cY/2)+in.right.get(928) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(928), (cY/2)+in.right.get(928) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(932) * fc, height-cY+in.right.get(932) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(936) * fc, height-cY+in.right.get(936) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(940) * fc, height-cY+in.right.get(940) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(944) * fc, height-cY+in.right.get(944) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(944), (cY/2)+in.right.get(944) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(944), (cY/2)+in.right.get(944) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(944), (cY/2)+in.right.get(944) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(948) * fc, height-cY+in.right.get(948) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(952) * fc, height-cY+in.right.get(952) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(956) * fc, height-cY+in.right.get(956) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(960) * fc, height-cY+in.right.get(960) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(960), (cY/2)+in.right.get(960) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(960), (cY/2)+in.right.get(960) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(960), (cY/2)+in.right.get(960) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(964) * fc, height-cY+in.right.get(964) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(968) * fc, height-cY+in.right.get(968) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(972) * fc, height-cY+in.right.get(972) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(976) * fc, height-cY+in.right.get(976) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(976), (cY/2)+in.right.get(976) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(976), (cY/2)+in.right.get(976) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(976), (cY/2)+in.right.get(976) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(980) * fc, height-cY+in.right.get(980) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(984) * fc, height-cY+in.right.get(984) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(988) * fc, height-cY+in.right.get(988) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(992) * fc, height-cY+in.right.get(992) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(992), (cY/2)+in.right.get(992) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(992), (cY/2)+in.right.get(992) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(992), (cY/2)+in.right.get(992) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(996) * fc, height-cY+in.right.get(996) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(1000) * fc, height-cY+in.right.get(1000) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(1004) * fc, height-cY+in.right.get(1004) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(1008) * fc, height-cY+in.right.get(1008) * fc, random(alf) ); 
strokeWeight(.37+noise(fc));stroke(fc%2==0?0:255,alf);
bezier(  cX, (cY/2),         wvStart+buf+in.left.get(1008), (cY/2)+in.right.get(1008) * fc *cos(radians(fc)*fc),         wvStart+buf+in.left.get(1008), (cY/2)+in.right.get(1008) * fc *sin(radians(fc)*fc),         wvStart+buf+in.left.get(1008), (cY/2)+in.right.get(1008) * fc );

strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(1012) * fc, height-cY+in.right.get(1012) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(1016) * fc, height-cY+in.right.get(1016) * fc, random(alf) ); 
strokeWeight(QUARTER_PI);stroke(fc%2==0?0:255,alf);point( wvStart+buf+in.left.get(1020) * fc, height-cY+in.right.get(1020) * fc, random(alf) ); 


//  END PASTE HERE
}
