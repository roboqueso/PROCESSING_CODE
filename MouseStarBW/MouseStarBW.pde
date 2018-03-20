// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

/*
Use mouseX,mouseY as the center point for 5 random points ( simulated hand )
*/

PVector a, b, c, d, e;
int sz = 42;  
float xx, yy;

void setup()
{
  size(420, 420);
  background(255);
  strokeWeight(HALF_PI);
  smooth();
}

void draw()
{

  a = GetRandVector( mouseX, mouseY, sz );
  b = GetRandVector( mouseX, mouseY, sz );
  c = GetRandVector( mouseX, mouseY, sz );
  d = GetRandVector( mouseX, mouseY, sz );
  e = GetRandVector( mouseX, mouseY, sz );  


//  if( mouseY < height/2 )
//  {
    stroke( random(sz) );
    fill( random(sz) );
//  }
//  else
//  {
//    fill( random(sz) );
//    stroke(random(mouseX),random(mouseY),random(sz,255));
//  }

  beginShape(QUAD_STRIP);
    vertex(a.x, a.y);
    vertex(b.x, b.y);
    vertex(c.x, c.y);
    vertex(d.x, d.y);
    vertex(e.x, e.y);
  endShape();
  
}

//  Return a random vector based on supplied x,y and sz
PVector GetRandVector( float x, float y, float sz )
{
  return new PVector( 
        x - int( cos(radians( random(360) )) * sz ),
        y - int( sin(radians( random(360) )) * sz )
      );
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