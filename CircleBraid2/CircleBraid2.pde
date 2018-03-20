//  IMPORTS  ////////////////////////////////////////////////////


// https://github.com/ericfickes/FIXLIB	
import fixlib.*;

Fixlib fix = Fixlib.init(this);
Boolean isFinal = true, fwd = true;
int alf = 37, sz = 30;
float angle = -90, radius = 66, x, y, x2, y2, cX, cY, strokeSz = 2;


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
    
    x2 = cX - int( sin(radians(-angle)) * radius );
    y2 = cY - int( cos(radians(-angle)) * radius );


    stroke(random(155,255), sz, sz);
    ellipse( x, angle, sz, sz);

    stroke(random(100));
    ellipse( x2, angle, sz, sz);




    // stroke(sz,random(155,255), sz);
    // ellipse( angle, y, sz, sz);

    // stroke(random(100), sz, sz);
    // ellipse( angle, y2, sz, sz);


    if( angle % 270 == 0 )
    {
      cY += sz;
    }


    if(fwd)
      angle ++;
    else
      angle--;


    if ( angle >= height+sz ){
      cX = random(width-sz);
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
		stop();
	break;
}

}
