//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);



float xx, yy, zz, cX, cY, sz;

void setup()
{
  //size( displayWidth, displayHeight );
  //  boardpusher.com 8.5 board template dimensions
  //size( 9900, 2700 );
  // size( 4950, 1350 );
  size( displayWidth, displayHeight );

  background(0);
  frameRate(404);
  smooth();
  rectMode(CENTER);
  cX = width/2;
  cY = height/2;
  sz = 21;
  strokeWeight(PI);
}

void draw()
{
	xx = cX - int( cos(radians( frameCount )) * sz+noise(frameCount*.3) );
	yy = cY - int( sin(radians( frameCount )) * sz+noise(frameCount*.3) ); 
	
	
	stroke( (frameCount%xx)-sz, (frameCount%yy)-sz, (frameCount%sz)-sz);
	fill( yy-xx+sz, xx-sz, yy-sz);
	rect(xx, yy, TWO_PI+noise(sz), TWO_PI+noise(sz), random(-TWO_PI,TWO_PI) );

//	strokeWeight(HALF_PI);
	// noFill();
 //  stroke( (xx%frameCount)-sz, (yy%frameCount)-sz, (sz%frameCount)-sz);
	// ellipse(xx, yy, TWO_PI*noise(sz), TWO_PI*noise(sz) );

	sz += .036;
  
	if(sz>=height){
		save( fix.pdeName() + fix.getTimestamp() + ".png");
		noLoop();
    exit();
	}
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