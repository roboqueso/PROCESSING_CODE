//  IMPORTS  ////////////////////////////////////////////////////


// https://github.com/ericfickes/FIXLIB	
import fixlib.*;

Fixlib fix = Fixlib.init(this);
Boolean isFinal = true, fwd = true;
int alf = 37, sz = 30;
float angle = -90, radius = 90, x, y, x2, y2, cX, cY, strokeSz = 4;


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
    
    x2 = cX - int( sin(radians(-angle)) * radius );
    y2 = cY - int( cos(radians(-angle)) * radius );

fill(random(radius));
    stroke(random(155,255), sz, sz);
    ellipse( x, angle, sz, sz);

    stroke(random(100));
    ellipse( x2, angle, sz, sz);

fill(random(sz));

    stroke(sz,random(155,255), sz);
    ellipse( angle, y+x, sz, sz);

    stroke(random(100));
    ellipse( angle, y2+x2, sz, sz);


    if( angle % 270 == 0 )
    {
      cY += sz;
    }


    if(fwd)
      angle ++;
    else
      angle--;


    if ( angle >= width+sz ){
      cX = random(sz,width);
      cY = 0;
      angle = -90;
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



  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }


  noLoop();
  exit();
}



////// S SAVE HANDLER /////////

void keyPressed(){
switch(key){
	case 's':
		save( fix.pdeName() + fix.getTimestamp() + ".png");
	break;

	case ESC:
		save( fix.pdeName() + fix.getTimestamp() + ".png");
		noLoop();
    exit();
	break;
}

}
