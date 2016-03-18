/**
 Using MINIM AudioInput, get funky with live microphone data
 **/

import ddf.minim.*;

Minim minim;
AudioInput in;
FixLib fix = new FixLib();
Boolean isFinal = true;
int buf;
float alf = 37, tX, tY, szW, szH;


////  CIRCLEY THING
float cX, cY, inc, m; 
float r, g, b;
int tmr_Interval = 10;  // seconds

float x, y, angle, sz;
float x2, y2, angle2, sz2; 
float x3, y3, angle3, sz3; 
float x4, y4, angle4, sz4; 


/////////////////////////////////////////////////////////////////////////////////
void setup()
{
  size(1024, 768);
  background(#000011); 
  noFill();
  ellipseMode(CENTER);
  rectMode(CENTER);  
  //  drawing font
  textFont( createFont( "AnonymousPro", 22 ) );
  
  cX = width/2;
  cY = height/2;
  sz = 11;
  sz2 = 37;
  sz3 = 75;
  sz4 = 185;


  y = cY;

  minim = new Minim(this);

  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
}

/////////////////////////////////////////////////////////////////
void draw()
{
  smooth();

  // start out getting the noise in sync with frameCount, then random
  buf = ( frameCount < ( in.bufferSize() - 1 ) ) ? frameCount : (int)random(in.bufferSize() - 1);
  szW = in.left.get(buf) * frameCount;
  szH = in.right.get(buf) * frameCount;

  ////  DRAW WAVEFORM  ////

  //  1024
  for (int i = 0; i < in.bufferSize() - 1; i++)
  {
//  ** X adjusted by cX+  
    
    strokeWeight(random(PI));
    //  OG WAVEFORM

    stroke(0,alf);
    point( cX+ i, cY + in.right.get(i)*frameCount);
    stroke(255,alf);
    point(cX+  i+1, cY + in.right.get(i+1)*frameCount);
    
    strokeWeight(1);
    stroke(255,alf);
    point( cX-512+i, cY + in.right.get(i)*frameCount);
    point( cX-512+i+1, cY + in.right.get(i+1)*frameCount);
    stroke(#EF1975,alf);
    
    strokeWeight(.37);
    stroke(#000022,alf);
    line( cX-512+i, cY + in.right.get(i)*frameCount, cX+512+i, cY + in.right.get(i)*frameCount );
    line( cX-512+i+1, cY + in.right.get(i+1)*frameCount, cX+512+i+1, cY + in.right.get(i)*frameCount );
    //  OG WAVEFORM
    
    

    strokeWeight(.75);
    stroke( random(37), random(255), random(37), alf);
    point( i+205*szW, cY + in.right.get(i)*frameCount*szH*cos(szW), frameCount);

    point( i, cY + in.right.get(i+1)*szW, frameCount);
    point( width-i, cY + in.right.get(i)*szH,frameCount );

    strokeWeight(3);
    stroke( random(11), random(255), random(11), alf);
    point( i, cY + in.right.get(i+1)*szW, frameCount); 
    point( width-i, cY + in.right.get(i)*szH, frameCount);
          
    strokeWeight(2);
    stroke(random(11), random(255), random(11) , alf*2 );
    point( i, cY + in.right.get(i+1)*szW, frameCount); 
    point( width-i, cY + in.right.get(i)*szH, frameCount);
          
    strokeWeight(.75);
    stroke(random(255), alf*4 );
    point( i, cY + in.right.get(i+1)*szW, frameCount); 
    point( width-i, cY + in.right.get(i)*szH, frameCount);
          
    stroke(#000037, alf/PI);
    point( i, cY + in.right.get(i+1)*szW, frameCount);
    point(width-i,  cY + in.right.get(i)*szH, frameCount);


  ////  WAVE LINES  ////

    strokeWeight(4);
    stroke(frameCount%2==0?0:255, alf);
    line( i, cY + in.right.get(i+1)*szW, width-i, cY + in.right.get(i)*szH );

    strokeWeight(3);
    stroke( random(11), random(255), random(11), alf);
    line( i, cY + in.right.get(i+1)*szW, width-i, cY + in.right.get(i)*szH );
          
    strokeWeight(2);
    stroke(random(11), random(255), random(11) , alf*2 );
    line( i, cY + in.right.get(i+1)*szW, width-i, cY + in.right.get(i)*szH );
          
    strokeWeight(.75);
    stroke(#EFEFEF, alf*4 );
    line( i, cY + in.right.get(i+1)*szW, width-i, cY + in.right.get(i)*szH );          
          
    stroke(#000037, alf/PI);
    line( i, cY + in.right.get(i+1)*szW, width-i,  cY + in.right.get(i)*szH );     
    
    

  
  ////  WAVE LINES  ////
 
  }
  ////  DRAW WAVEFORM  ////
  
  
  
  ////  SHOW CHANNEL LEVELS  ////
  //  LEFT
  fix.randFill100();
  text( in.left.get((int)random(in.bufferSize() - 1)), alf+szW*szH*noise(frameCount), random(height) );
  
  //  RIGHT
  fix.randFill100();
  text( in.right.get((int)random(in.bufferSize() - 1)), (width*.96)-(alf+szW*szH*noise(frameCount)*TWO_PI), random(height) );
  noFill();


  ////  SHOW CHANNEL LEVELS  ////
  
  
  x = cX - int( cos(radians(angle)) * sz+szW ) * noise(in.left.get(buf));
  y = cY - int( sin(radians(angle)) * sz+szH ) * noise(in.right.get(buf));
  x2 = cX - int( cos(radians(angle2)) * sz2+szW ) * noise(in.left.get(buf));
  y2 = cY - int( sin(radians(angle2)) * sz2+szH ) * noise(in.right.get(buf));
  x3 = cX - int( cos(radians(angle3)) * sz3+szW ) * noise(in.left.get(buf));
  y3 = cY - int( sin(radians(angle3)) * sz3+szH ) * noise(in.right.get(buf));
  x4 = cX - int( cos(radians(angle4)) * sz4+szW ) * noise(in.left.get(buf));
  y4 = cY - int( sin(radians(angle4)) * sz4+szH ) * noise(in.right.get(buf));

  //BLINKY TO INDICATE ACTION
  m = random(height);
  stroke(37,random(255),37, alf*PI);
//  fill(random(11),random(37),random(11), PI);
  ellipse( cX, cY, m, m );


  strokeWeight(random(TWO_PI));
  stroke(frameCount%2==0?0:255,alf);
  point( x, y, frameCount);
  point( x2, y2, frameCount);
  point( x3, y3, frameCount);
  point( x4, y4, frameCount);
  
  strokeWeight(random(PI));
  stroke(frameCount%2==0?0:255);
  point( x, y, frameCount);
  point( x2, y2, frameCount);
  point( x3, y3, frameCount);
  point( x4, y4, frameCount);




  if ( szH < -11 ) {
    //  green
    stroke(random(75), random(255), random(75), alf);    
    strokeWeight(10);
    bezier(x, y, x2, y2, x3, y3, x4, y4 );
    bezier(x2, y2, x3, y3, x4, y4, x, y );
    bezier(x3, y3, x4, y4, x, y, x2, y2 );
    bezier(x4, y4, x, y, x2, y2, x3, y3 );

    //  black
    stroke(0,alf);
    strokeWeight(3);
    bezier(x, y, x2, y2, x3, y3, x4, y4 );
    bezier(x2, y2, x3, y3, x4, y4, x, y );
    bezier(x3, y3, x4, y4, x, y, x2, y2 );
    bezier(x4, y4, x, y, x2, y2, x3, y3 );
    
    
    
    //  orange
    stroke(#AD9D2C);
    strokeWeight(3);
    bezier(x, y, x2, y2, x3, y3, x4, y4 );
    bezier(x2, y2, x3, y3, x4, y4, x, y );
    bezier(x3, y3, x4, y4, x, y, x2, y2 );
    bezier(x4, y4, x, y, x2, y2, x3, y3 );


    //  LEGACY - MIGHT NOT JIVE WITH THE SKETCH
    strokeWeight(noise(szH)*noise(frameCount));
//    fix.randFill();
      r = random(37);
      g = random(255);
      b = random(37);
      stroke(b,r,g,alf);
      fill(r,g,b,alf*szW*szH);
    stroke(frameCount%2==0?#2012EF:#1975EF, alf*PI);
    ellipse( cX-tX, cY-tY, szW*TWO_PI, szH*TWO_PI);
  } 
  else {

///, TWO_PI*frameCount);
    strokeWeight(noise(y));
    stroke(37, 37, random(255) );
    point(x, y, TWO_PI*frameCount);
    stroke(75, 75, random(255) );
    point(x2, y2, TWO_PI*frameCount);
    point(x3, y3, TWO_PI*frameCount);
    point(x4, y4, TWO_PI*frameCount);

    //  LEGACY - MIGHT NOT JIVE WITH THE SKETCH    
//    noFill();
    strokeWeight(.75);
    stroke(frameCount%2==0?0:255, alf);
    rect( cX-tX, cY-tY, szW+alf*szW, szH+alf*szH);
    fix.hexagon( tX, tY, szW+alf);
  }






  // -5
  if ( szH < -4 ) {
      strokeWeight(noise(frameCount));
      r = random(255);
      g = random(37);
      b = random(37);
      stroke(r,g,b,alf*2);
//      m = random(angle2,angle3);
      fix.circle(r, g, b, m);
      stroke(r,g,b,alf*2);
      fix.circle(width-r, height-g, b, m);
  } 


  angle += 10;
  angle2 += 15;
  angle3 += 20;
  angle4 -= 5;

  if ( angle2 % 360 == 0 ) {
    inc += TWO_PI;//cos(frameCount)*cos(frameCount)+PI;
    sz += inc;
    sz2 += inc;
    sz3 += inc;
    sz4 += inc;

    //  safe it
    if ( sz > height || sz4 > height ) {
      sz = alf;
      sz2 = sz+5; 
      sz3 = sz+10;
      sz4 = sz+15;
    }
  }



  ////  STOPPER
  if ( frameCount > width) {
save(this+".png");
    exit();
  }
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

  fill(#EFEFEF);
  text( " "+dailyMsg, -1, height-2);

  fill(0);
  text( " "+dailyMsg, 0, height-3);
}

