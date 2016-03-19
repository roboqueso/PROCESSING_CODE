float xx, yy;
String msg;

void setup(){
  size(1024,768);
  background(255);
  smooth();
}

void draw(){

  msg = hex(frameCount,6);

  textSize( (frameCount%75)+2 );
  fill( xx%255,frameCount%255, yy%255);
  text( msg, xx, yy+1 );

  textSize(frameCount%75);
  fill(frameCount%255,200);
  text( msg, xx+PI, yy );
   
  yy = (yy+(frameCount%75))%height;
  
  if(yy >= height-11 )
  {
    xx = (xx+msg.length()*42)%width;
  }

}



////// S SAVE HANDLER /////////

void keyPressed(){
switch(key){
  case 's':
    // image(hirez,0,0);
    save(pdeName() + getTimestamp() + ".png");
    // save( pdeName() + getTimestamp() + "_BIG2.tiff");
  break;

  case ESC:

    save(pdeName() + getTimestamp() + ".png");
    // save( pdeName() + getTimestamp() + "_BIG2.tiff");
    exit();
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