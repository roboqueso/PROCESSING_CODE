// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

/*
Inspired by:

Bally Experiments in Random Visual Display
from Phil Morton PLUS 3 years ago NOT YET RATED
phil morton + dan sandin
https://vimeo.com/20847029
*/
int x, y;

void setup(){
  size(1024,768);
  background(#D7DBCF);
  frameRate(111);
  strokeWeight(HALF_PI);
}


void draw(){

    y += random(-2,4)-2;

    fill(0);
    stroke(random(x),random(y),random(255));
	rect(y,x, TWO_PI, TWO_PI, TWO_PI);



	stroke(0);
    rect(x,y,TWO_PI*noise(x),TWO_PI*noise(y), random(-PI,TWO_PI));
  
  x = (frameCount%width)+14;
  
  if(y<0 || y > height ){
    y = (int)random(height);
  }
  
}






////// S SAVE HANDLER /////////

void keyPressed(){
switch(key)
{
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