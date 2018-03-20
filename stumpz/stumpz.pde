// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);


boolean gotNoise = false, isFinal = true;

float x2=0, y2=0, cX, cY;
PVector thisPV, lastPV;

int sz = 11, angle = 0, nz_ct=1, maxNz = 360;
int[] nz;

void setup() {
  size(1024, 768);
  background(210);
  frameRate(303);
  noFill();
  fix.alpha(42);
  cX = width/2;
  cY = height/2;
  nz = new int[967];
  
  //  init and manually reset X&Ys
  thisPV = new PVector(0,0);
  lastPV = new PVector(0,0);
  
  
  strokeWeight(HALF_PI);

  for( int yy = 0; yy <= 768; yy += (768/37) ){

    stroke(random(200,255) );
    line( 0, yy, 1024, yy );
    stroke(random(200,255) );
    line( yy, 0, yy, 1024 );
  }
  
}

void draw() {

  thisPV.x = cX - int( cos(radians(frameCount)) * sz ) + nz[int(nz_ct)];
  thisPV.y = cY - int( sin(radians(frameCount)) * sz ) + nz[int(nz_ct)];
  x2 = cX - int( cos(radians(frameCount)) * sz*1.23 ) * nz[int(nz_ct)];
  y2 = cY - int( sin(radians(frameCount)) * sz*1.23 ) * nz[int(nz_ct)];

  //  making noise
  if (frameCount < maxNz )
  {
    nz[frameCount-1] = int(random(-11,11)*cos(frameCount)*sin(frameCount));
  }

  
  strokeWeight(TWO_PI);
  stroke(random(200,255), 222);
  point( thisPV.x, thisPV.y );


  strokeWeight(1);
  stroke(random(11,42));
  ellipse( x2, y2, 11, 11 );


//  strokeWeight(HALF_PI);
//  stroke(random(255), random(42), random(11), 100 );
//  line(  thisPV.x - nz[int(nz_ct)],
//          thisPV.y - nz[int(nz_ct)], 
//          x2, y2 );

  //  connect the dots, ah la la la
//  if( lastPV.x > 0 && lastPV.y > 0 ) {
//    strokeWeight(.99999);
//    stroke(random(53),random(35),random(99), 100 );
//
//    bezier( cX, cY, 
//            thisPV.x, thisPV.y,
//            lastPV.y, lastPV.x,
//            x2, y2);
//  }

  if ( frameCount % 360 == 0 ) {
    sz += 21;

  }

  // Keep the nz_ct in sync with the frameCount<360 
  if ( nz_ct < maxNz ) {
    nz_ct++;
  } 
  else {
    nz_ct = 1;
  }

  //  set for next time around
  lastPV = thisPV;


  //  STOPPER
  if ( thisPV.y > 768)
  {

    fill(#EFEFEF);
    textFont(createFont("Silom", 23));

    //    TOP RIGHT CORNER-ISH ( between the time and the battery )
    text("ERICFICKES.COM", 3, height-11 );  // 28

    if (isFinal) {
      save( fix.pdeName() + fix.getTimestamp()+".png" );
    }
    noLoop();
    exit();
  }
}