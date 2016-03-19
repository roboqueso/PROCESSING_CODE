//  
//  Use beginShape to create X based patterns
//  1. Create a good looking shape
//  2. Duplicate that shape to come out of each corner
//  3. Get rad

FixLib fix = new FixLib();
Boolean isFinal = true;

//  controls mashup
Boolean showDrawing2 = true;

int i, cX, cY;
float alf = 42, x2, y2, angle2, sz2=69;

//  CIRCLICIOUS
float ii, shapeSize =420, ct=0, maxCt=768;
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
  frameRate(303);//);  
  background(0);

    cX = width/2;
    cY = height/2;

} 
//////////////////////////////////////////////
void draw() {
    smooth();
    noFill();


    x2 = cX + ( cos(radians(angle2)) * sz2 ) + cos(frameCount) * alf/PI;
    y2 = cY + ( sin(radians(angle2)) * sz2 ) + sin(frameCount) * alf/PI;
 
stroke(#EF0000,alf);
strokeWeight(noise(frameCount)*alf);
point(angle2, sz2);
point( y2, x2);
point(x2, y2);
point(sz2, angle2);
point( width-angle2, sz2 ); point( width-y2, x2 ); point( width-x2, y2 ); point( width-sz2,angle2 );
point( angle2, height-sz2 ); point( y2, height-x2 ); point( x2, height-y2 ); point( sz2, height-angle2 );
point( width-angle2, height-sz2 ); point( width-y2, height-x2 ); point( width-x2, height-y2 ); point( width-sz2, height-angle2 );
 
 
 
 
strokeWeight(.75);
 
    if( frameCount < (width+height)*.94 ) {
      stroke(frameCount%2==0?0:255, alf);
    } else {
      stroke(random(255), random(11), random(11),alf);
    }
    fix.makeShape( angle2, sz2, y2, x2, x2, y2, sz2, angle2, QUADS );    
    fix.makeShape( width-angle2, sz2, width-y2, x2, width-x2, y2, width-sz2, angle2, QUADS );
    fix.makeShape( angle2, height-sz2, y2, height-x2, x2, height-y2, sz2, height-angle2, QUADS );
    fix.makeShape( width-angle2, height-sz2, width-y2, height-x2, width-x2, height-y2, width-sz2, height-angle2, QUADS );

    // move over a pixel
    if (i < width) {
        i += sz2;
    } else {
        i = 0;
        sz2 += noise(sz2);
    }
 
    angle2+= TWO_PI;


////////////////  CIRCLICIOUS  //////////////////////
////////////////  CIRCLICIOUS  //////////////////////
if(showDrawing2){
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
}
////////////////  CIRCLICIOUS  //////////////////////
////////////////  CIRCLICIOUS  //////////////////////


    if( frameCount > width ){
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

  textFont( createFont( "STSong", 37 ) );  //  "TrajanPro-Bold"
  smooth();

  fill(#20EF12);
  text( " "+dailyMsg, -1, height-9);

  fill(0);
  text( " "+dailyMsg, 0, height-10);
}

