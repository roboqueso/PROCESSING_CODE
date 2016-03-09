//  IMPORTS  ////////////////////////////////////////////////////


//
//  This is a PRocessing sketch
//
Boolean isFinal = true, fwd = true;
int alf = 37, sz = 30;
float angle = 90, radius = 66, x, y, x2, y2, cX, cY, strokeSz = 2;

FixLib fix = new FixLib();

////////////////////////////////////////////////////
//
void setup() {


  // setup core sketch settings items
  size(1024, 768);
  background(#EFEFEF);
  strokeWeight(strokeSz);
  frameRate(303);

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

    stroke(random(sz));
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
      cX = random(width);
      cY = random(sz);
    }

    // STOPPER
    if( frameCount > (width+height)*radius ){
    	exit();
    }
}



	
///////////////////////////////////////////////////////////
//  End handler, saves png
void exit() 
{


  // artDaily("ERICFICKES.COM" );
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

textFont( createFont( "Silom", 21 ) );
smooth();

  fill(255);
  text( " "+dailyMsg, 0, height-21 );
  fill(#1975EF);
  text( " "+dailyMsg, 0, height-22 );
}


