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

color[] p3 = { 0x3F2C3F, 0x857D85, 0x442B3F, 0x685461, 0x796872, 0x4B2A3D, 0x887981, 0x82717A, 0x553344, 0x54293B, 0x8A787F, 0x71515D, 0x856C75, 0x5C283A, 0x8D747C, 0x653544, 0x622839, 0x662738, 0x907078, 0x6B2737, 0x702C3B, 0x907077, 0x8C626B, 0x732635, 0x927D81, 0x7E303E, 0x946C73, 0x7C2534, 0x97676F, 0x915F67, 0x97686F, 0x883743, 0x842432, 0x8A2A37, 0x9B646B, 0x9E5E66, 0x8C2330, 0x94222F, 0x9E6067, 0x9C535B, 0x8E4E55, 0x9B6D72, 0x9E303B, 0xA6565E, 0xA25B62, 0x9C212D, 0xA44F57, 0xA5585F, 0xA4202C, 0xAE4D55, 0xA9535A, 0xA9202B, 0xAD1F2A, 0xA85A60, 0xAC5057, 0xAB3F47, 0xB23F47, 0xB7353E, 0xB14A51, 0xB41E28, 0xB2484F, 0xB81E28, 0xBC1D27, 0xB5454C, 0xB7262F, 0x99787A, 0xB84148, 0xBC343C, 0xB94047, 0xA76165, 0xBC3C43, 0xC41C25, 0xBF383F, 0xC0383F, 0xCA2B33, 0xC4232B, 0xC3343B, 0xC63037, 0xC72F36, 0xCB1C24, 0xCD282F, 0xCE262D, 0xB35256, 0xD2232A, 0xD42027, 0xD51C23, 0xC23C41, 0xD91A21, 0xD2292E, 0xD32F32, 0xA37575, 0xDC3735, 0xB46564, 0xD7433F, 0xD24E49, 0x988584, 0xE14940, 0xA6827D, 0xE66553, 0xDF6857, 0xCB7B6C, 0xC28677, 0xBF8879, 0xEC886A, 0xAC9186, 0xEF9A75, 0xC99982, 0xBC9075, 0xF0B78A, 0xF7C491, 0xCAB293, 0xF9D29B, 0xB1A794, 0xD8C49C, 0xF9DEA2, 0xB3A176, 0xC5B181, 0xA8976E, 0xF1D99F, 0xBDAA7C, 0xEBD6A3, 0xE7D098, 0xFCE3A6, 0xCCB887, 0xCAB685, 0xDFC993, 0xAD9C72, 0xC2AF80, 0xC1AE7F, 0xEBD49B, 0xCEBA88, 0xB9A77A, 0xB7A578, 0xA4946C, 0xE3CD96, 0xF7E0A6, 0xEFD89E, 0xD7C28D, 0xD9C48F, 0xB09F74, 0xA8986F, 0xDBC690, 0x9F9069, 0x9E8F68, 0x9C8D66, 0xD2BE8A, 0xF3DEA5, 0xABA594, 0xECDAA5, 0xE7D8A5, 0xE3D5A5, 0xDCD1A4, 0xD9CFA4, 0xD3CDA4, 0x9B9A92, 0xCDC9A3, 0xC9C7A3, 0x002F49, 0x00334C, 0x053750, 0x063951, 0x0A3B53, 0x0B324A, 0x0F4057, 0x104157, 0x14445A, 0x133148, 0x17485D, 0x19495E, 0x173047, 0x183148, 0x1D4D61, 0x204E63, 0x1B3047, 0x245366, 0x275568, 0x285769, 0x1F2F46, 0x2C5A6C, 0x264458, 0x315D6F, 0x325F70, 0x346172, 0x232F45, 0x304D60, 0x396676, 0x3D6979, 0x355466, 0x283146, 0x2D3B50, 0x426E7C, 0x45707F, 0x477280, 0x4B7583, 0x466776, 0x4F7986, 0x507A87, 0x2B2E43, 0x547D8A, 0x57808C, 0x465D6D, 0x5A828E, 0x5E8691, 0x332D42, 0x648C95, 0x5A7985, 0x678E98, 0x648892, 0x688F98, 0x3B2C40, 0x536977, 0x6C929B, 0x434B5D, 0x3A3549, 0x70969E, 0x5B737F, 0x3E4254, 0x7399A0, 0x68838D, 0x74999E, 0x61727E, 0x453748, 0x454758, 0x759097, 0x7B9C9F, 0x84A19F, 0x778E96, 0xC4C4A3, 0x89A49F, 0x7A9398, 0x809E9E, 0x8CA6A0, 0xBDC0A2, 0xBABEA2, 0x7A8B92, 0x90A7A0, 0x717C86, 0xB3BBA2, 0x575866, 0x94AAA0, 0xB2B49D, 0xAEB8A2, 0x7C888F, 0xAAB6A1, 0x9BAEA0, 0x9FB0A1, 0xA4AD9C, 0xA3B2A1, 0x696672, 0x7E868D, 0x889797, 0x98A59A, 0x79747E, 0x81828A, 0x838087, 0x89868A };

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
    fix.ranPalStroke100(p3);
    point(wvStart+ i, cY+inLeft);

    strokeWeight(PI);
    fix.ranPalStroke100(p3);
    point(wvStart+ i+1, cY+inRight);

    

  }

    smooth();
    noFill();
 
//    x2 = cX + ( cos(radians(angle2)) * sz2*noise(frameCount) )*inLeft*frameCount;
//    y2 = cY + ( sin(radians(angle2)) * sz2*noise(frameCount) )*inRight*frameCount;
 
x2 = cX + cos(radians(sz2)*angle2) * inLeft;
y2 = cX + sin(radians(sz2)*angle2) * inRight; 
 

 strokeWeight(.75);
    fix.ranPalStroke100(p3);
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
save(this+".png");
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
