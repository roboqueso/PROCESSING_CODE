/**
  Using MINIM AudioInput, get funky with live microphone data
**/

import ddf.minim.*;

import fixlib.*;

//  https://github.com/ericfickes/FIXLIB
Fixlib fix = Fixlib.init(this);

Minim minim;
AudioInput in;

Boolean isFinal = true;

int cX, cY, buf;
int alf = 42; //75
float angle, x, y, tX, tY, szW, szH;


void setup()
{
  size(1024, 768);
  frameRate(60);
  ellipseMode(CENTER);
  rectMode(CENTER);
  background(#ACE109);
  cX = width/2;
  cY = height/2;
  
  fix.alpha(alf);
  y = cY;
  
  minim = new Minim(this);
  
  // use the getLineIn method of the Minim object to get an AudioInput
  //in = minim.getLineIn();  //  null
  //  BUILD P5 V4
  in = minim.getLineIn(Minim.MONO);
}

void draw()
{
  smooth();

  //  get the noise
  buf = (int)random(in.bufferSize() - 1);
  szW = in.left.get(buf) * frameCount;
  szH = in.right.get(buf) *frameCount;

  //  start from lower right corner
  x = width - int( cos(radians(angle)*szW) * angle );
  y = height - int( sin(radians(angle)*szH) * angle );


  if( szH < -11 ) {
    
    strokeWeight(6);
    fix.randFill100();
    stroke(frameCount%2==0?0:255,alf);
    ellipse( tX, tY, szW, szH);
    
  } else {
    
    noFill();
    strokeWeight(.75);
    stroke(frameCount%2==0?0:255,alf);
    rect( tX, tY, szW+alf, szH+alf);
//    fix.drawLissajous( tX, tY, szW+alf);
  }
  
    strokeWeight(1);
//  stroke(frameCount%2==0?0:255,alf);
//  fix.drawLissajous( x, y, szH);


  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    //line( i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50 );

    stroke(random(255), 37, 37,alf);    
    point(i, cY + in.right.get(i)*frameCount);
    stroke(random(255), 37, 37,alf);    
    point(i+1, cY + in.right.get(i+1)*frameCount);

    line( i+1, cY + in.right.get(i+1)*frameCount,i, cY + in.right.get(i)*frameCount );
  }



  //  adjust coords for vertical grid
  if( tY > height ) {
    tY = 0;
    tX += alf;
  } else if( tX > width ) {
    tX = 0;
    tY += alf;
    
    background(random(255));
    x = width;
    y = height;
    angle = 0;

  } else {
    tY += alf; 
    angle++;
  }


  //  coords for Lissajous
  if( x < width ) {
    x += alf;
  } else {
    y += alf;
    x = 0;
  }
  
  
//  TODO: We could use frameCount checking to 
//  END or DO SOMETHING at an interval
//  Sketch prints, clears, resets
  if( frameCount > width+height) {
    doExit();
  }
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
