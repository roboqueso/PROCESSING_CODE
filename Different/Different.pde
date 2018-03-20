//  
//  Different 
//  http://ericfickes.com
//  
import fixlib.*;

//  https://github.com/ericfickes/FIXLIB
Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
int alf = 137;
PImage img;
ArrayList p3;

float a, x, y, co, bri, i, sz, h;
int cX, cY;

float angle = 0, angle2 = 0;
float x2, y2;

////////////////////////////////////////////////////////////////////////
void setup() {
  size(1024, 768, P3D);

  background(255);
  noFill();

  fix.alpha(alf);

  cX = width/2;
  cY = height/2;

  img = loadImage("apple-models.jpg");
  p3 = fix.getImgColors(img);  

  image( img, width-400, height-300);

  //  vertical scan lines
  for ( int w = 0; w < width; w+=2 ) {
    fix.randStroke();
    line( w, 0, w, height );
  }
}

/////////////////////////////////////////////////////////////////////////
void draw() {
  smooth();


  if ( frameCount > width*.75 ) {
    stroke(random(255), random(255), random(255), 11);
    noFill();
  } 
  else {
    fix.ranPalStroke100(p3);
    fill(fix.getRanColor(p3), 3);
  }

  // color or no color?
  if ( frameCount > height*.75 ) {
    strokeWeight(.5);

    beginShape();

    vertex( cX-i* cos( radians(i) * i ), cY-i* sin( radians(i) * i ) );

    bezierVertex( cX-i* cos( radians(i) * i ), cY-i* sin( radians(i) * i ), 
    i*noise(i), i*cos(frameCount), 
    i*cos(frameCount), i*noise(i), 
    cX*noise(frameCount), cY*noise(frameCount), 
    width-frameCount
      );

    curveVertex( cX-i* cos( radians(i) * i ), cY-i* sin( radians(i) * i ), width-frameCount );

    vertex( i*noise(i), i*cos(frameCount) );

    curveVertex( i*noise(i), i*cos(frameCount), width-frameCount );

    vertex( i*cos(frameCount), i*noise(i) );

    curveVertex( i*cos(frameCount), i*noise(i), width-frameCount );

    curveVertex( cX*noise(frameCount), cY*noise(frameCount), width-frameCount );

    vertex( cX*noise(frameCount), cY*noise(frameCount) );

    endShape();
  } 
  else {

    strokeWeight(1);

    bezier( cX-i* cos( radians(i) * i ), cY-i* sin( radians(i) * i ), 
    i*noise(i), i*cos(frameCount), 
    i*cos(frameCount), i*noise(i), 
    cX*noise(frameCount), cY*noise(frameCount)
      );
  }


  strokeWeight( random(frameCount)/ TWO_PI*noise(frameCount) );
  point( cX-i* cos( radians(i) * i ), cY-i* sin( radians(i) * i ) );
  point( i*noise(i), i*cos(frameCount) );
  point( i*cos(frameCount), i*noise(i) );
  point( cX*noise(i), cY*noise(i) );

  // move over a pixel
  if (i < height) {
    i++;
  } 
  else {
    i = 0;
  }

  if ( frameCount > width ) {
    //  stamp apple logo 
    imageMode(CENTER);
    img = loadImage("Apple-Logo-rainbow.png");

    alpha(37);
    tint(255, 37); 
    image( img, cX, cY);

    doExit();
  }
}




///////////////////////////////////////////////////////////
//  End handler, saves png
void doExit() 
{
save(fix.pdeName()+fix.getTimestamp()+".png");
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

