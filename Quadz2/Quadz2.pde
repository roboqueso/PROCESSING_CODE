//  
//  Use beginShape to create X based patterns
//  1. Create a good looking shape
//  2. Duplicate that shape to come out of each corner
//  3. Get rad

FixLib fix = new FixLib();
Boolean isFinal = true;

int i, cX, cY;
float alf = 96, x2, y2, angle2, sz2;

//  CIRCLICIOUS
float ii, shapeSize =10, ct=0, maxCt=768;
Boolean flip = true;
//  CIRCLICIOUS

//float r,g,b;
//int tmr_Interval = 10;  // seconds
//
//float x, y, angle, sz;
//float x2, y2, angle2, sz2; 
//float x3, y3, angle3, sz3; 
//float x4, y4, angle4, sz4; 

//////////////////////////////////////////////
void setup() { 

  size(1024, 768);
  frameRate(303);  
  background(0);

    cX = width/2;
    cY = height/2;
    sz2 = 75;//11;

} 
//////////////////////////////////////////////
void draw() {
    smooth();
    noFill();


    x2 = cX + ( cos(radians(angle2)) * sz2 );
    y2 = cY + ( sin(radians(angle2)) * sz2 );
 
    if( frameCount < (width+height)*.8 ) {
      stroke(frameCount%2==0?255:0,alf);
    } else {
      stroke(random(11), random(37), random(11));
    }
    makeShape( angle2, sz2, y2, x2, x2, y2, sz2, angle2 );
    makeShape( width-angle2, sz2, width-y2, x2, width-x2, y2, width-sz2, angle2 );
    makeShape( angle2, height-sz2, y2, height-x2, x2, height-y2, sz2, height-angle2 );
    makeShape( width-angle2, height-sz2, width-y2, height-x2, width-x2, height-y2, width-sz2, height-angle2 );

    // move over a pixel
    if (i < width) {
        i += TWO_PI;
    } else {
        i = 0;
        sz2 += random(sz2);
    }
 
    angle2+= TWO_PI;


////////////////  CIRCLICIOUS  //////////////////////
////////////////  CIRCLICIOUS  //////////////////////
////////////////  CIRCLICIOUS  //////////////////////
////////////////  CIRCLICIOUS  //////////////////////
  strokeWeight( .25 );
 
 
  fix.randStroke100();
  //  vertical
  line( ii, 0, ii, height );
  //  horizontal
//  line( 0, ii, width, ii );
 
  if(flip) {
      stroke( #363600 );
  } else {
      stroke( #003600 );
  }
    strokeWeight( 1 );
  // top
  fix.circle( ii, 0, shapeSize, shapeSize, alf*3 ); 
  // bottom
  fix.circle( ii, height, shapeSize, shapeSize, alf*3 );
   
  // left
//  circle( 0, ii, shapeSize, shapeSize, alf );
  // right
//  circle( width, ii, shapeSize, shapeSize, alf );
 
 
 
  if( ii >= width ) {
    shapeSize += shapeSize;
    flip = !flip;
  } else if( ii < 0 ) {
    ii = 0;
   flip = !flip;
  }
 
//  control the counter ( fwd or bwd )
if(flip) {
 ii += shapeSize;
} else {
  ii -= shapeSize;
}
 
 
  // max count or size is too big
if (shapeSize > width) {
     shapeSize = floor( sqrt( shapeSize ) );
  }
 
  // keep track of the loop
  ct++;

////////////////  CIRCLICIOUS  //////////////////////
////////////////  CIRCLICIOUS  //////////////////////
////////////////  CIRCLICIOUS  //////////////////////
////////////////  CIRCLICIOUS  //////////////////////



    if( frameCount > width+height ){
    exit();
  }
}


////////////////////////////////////////////////////
//  Sketch specific shape helper
void makeShape( float v1, float v2, float v3, float v4, float v5, float v6, float v7, float v8 ) {
    beginShape(LINES);  //  POLYGON
      vertex( v1, v2 );
      vertex( v3, v4 );
      vertex( v5, v6 );
      vertex( v7, v8 );
    endShape(CLOSE);
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

  textFont( createFont( "STSong", 37 ) );  //  "TrajanPro-Bold"
  smooth();

  fill(#2012EF);
  text( " "+dailyMsg, -1, height-2);

  fill(#1975ef);
  text( " "+dailyMsg, 0, height-3);
}

