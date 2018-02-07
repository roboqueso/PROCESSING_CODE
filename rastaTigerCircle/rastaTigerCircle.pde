float xx, yy, zz, cX, cY, sz;

void setup()
{
  size( displayWidth, displayHeight );
  background(0);
  frameRate(110);
  smooth();
  rectMode(CENTER);
  cX = width/2;
  cY = height/2;
  sz = PI;
   strokeWeight(sz);
}

void draw()
{
  xx = cX - int( cos(radians( frameCount )) * sz+noise(frameCount*.2) );
  yy = cY - int( sin(radians( frameCount )) * sz+noise(frameCount*.2) ); 

  stroke( (frameCount%xx)-sz, (frameCount%yy)-sz, (frameCount%sz)-sz);
  fill( yy-xx+sz, xx-sz, yy-sz);
  rect(xx, yy, TWO_PI+noise(sz), TWO_PI+noise(sz), random(-TWO_PI,TWO_PI) );

  sz += .016;
  
  if(sz>=height){
    save(pdeName() + getTimestamp() + ".png");
    noLoop();
  }
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

