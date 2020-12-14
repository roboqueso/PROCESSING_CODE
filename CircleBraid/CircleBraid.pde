//  SEE:   https://ello.co/ericfickes/post/8amiyontj72jdsyjtqfzqg
//  GOTO:  https://github.com/ericfickes/FIXLIB

import fixlib.*;
Fixlib fix = Fixlib.init(this);


Boolean isFinal = true, fwd = true;
int alf = 45, sz = 33;
float angle = 90, radius = 45, x, y, x2, y2, cX, cY, strokeSz = 2;


void settings(){
  size(displayWidth, displayHeight, P3D);
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}

////////////////////////////////////////////////////
//
void setup() {

  background(#BEEEEF);
  strokeWeight(strokeSz);
  frameRate(420);
  fix.alpha(alf);

  //  setup variables
  cX = width/2;
  cY = 0;

}


////////////////////////////////////////////////////
//
void draw()
{

    x = cX - int( cos(radians(angle)) * radius );
    y = cY - int( sin(radians(angle)) * radius );
    x2 = cX - int( cos(radians(-angle)) * radius );
    y2 = cY - int( sin(radians(-angle)) * radius );

    stroke(angle*sz/radius%255);
    ellipse( x, y, sz, sz);

    stroke(random(sz));
    ellipse( x2, y2, sz, sz);


    if( angle % 270 == 0 )
    {
      cY += radius;
    }

    if(fwd)
      angle ++;
    else
      angle--;


    if ( y >= height ){
      cX = frameCount%width;
      cY = random(sz);
    }

    // STOPPER
    if( frameCount > (width+height)*radius ){
    	doExit();
    }
}



	
///////////////////////////////////////////////////////////
//  End handler, saves png
void doExit() 
{


  // artDaily("ERICFICKES.COM" );
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

textFont( createFont( "Silom", 21 ) );
smooth();

  fill(255);
  text( " "+dailyMsg, 0, height-21 );
  fill(#1975EF);
  text( " "+dailyMsg, 0, height-22 );
}
