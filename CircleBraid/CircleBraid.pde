import fixlib.*;

//  https://github.com/ericfickes/FIXLIB
Fixlib fix = Fixlib.init(this);

//
//  
//
Boolean isFinal = true, fwd = true;
int alf = 42, sz = 30;
float angle = 90, radius = 42, x, y, x2, y2, cX, cY, strokeSz = 2;


////////////////////////////////////////////////////
//
void setup() {


  // setup core sketch settings items
  size(1024, 768);
  background(#EFEFEF);
  strokeWeight(strokeSz);
  frameRate(303);
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
      cX = random(width);
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


