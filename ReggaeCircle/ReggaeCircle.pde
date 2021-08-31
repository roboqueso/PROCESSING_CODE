//  SEE:   https://ello.co/ericfickes/post/onbilgi2_pa5eye8qtiisa
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
  sz = 24;
  strokeWeight(PI);
}

void draw()
{
	xx = cX - int( cos(radians( frameCount )) * sz+noise(frameCount*.69) );
	yy = cY - int( sin(radians( frameCount )) * sz+noise(frameCount*.69) ); 
	
	
	stroke( (frameCount%xx)-sz, (frameCount%yy)-sz, (frameCount%sz)-sz);
  fill( xx-sz, yy-sz, yy-xx+sz);
	rect(xx, yy, TWO_PI+noise(sz), TWO_PI+noise(sz), random(PI,TWO_PI) );

	sz += .069;
  
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
