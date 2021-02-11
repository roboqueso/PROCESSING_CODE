//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);


PVector a, b, c;
int sz = 42;

void setup()
{
  size(420, 420);
  background(255);
  strokeWeight(1);
}

void draw()
{
  /*
  Take mouse coordinates and draw a triangle around the mouse
  mouseX,mouseY = center point
  sz = radius?
  a
  |
  M
  |
b--- c
*/
  a = new PVector( mouseX, mouseY-sz );
  b = new PVector( mouseX-(sz*2), mouseY+sz);
  c = new PVector( mouseX+(sz*2), mouseY+sz);
  
  triangle( a.x, a.y, b.x, b.y, c.x, c.y );

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
