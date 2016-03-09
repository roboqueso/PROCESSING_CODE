//  IMPORTS  ////////////////////////////////////////////////////


//
//  This is a PRocessing sketch
//
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
    	exit();
    }
}



	
///////////////////////////////////////////////////////////
//  End handler, saves png
void exit() 
{



  //  if final, save output to png
  if ( isFinal )
  {
    save( pdeName() + "-" + getTimestamp()+".png" );
  }


  noLoop();
  System.gc();
  super.stop();
}



////// S SAVE HANDLER /////////

void keyPressed(){
switch(key){
	case 's':
		save(pdeName() + getTimestamp() + ".png");
	break;

	case ESC:
		save(pdeName() + getTimestamp() + ".png");
		stop();
	break;
}

}

public String getTimestamp() {
	return ""+month()+day()+year()+hour()+minute()+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
public String pdeName() {
	return split( this.toString(), "[")[0];
}

