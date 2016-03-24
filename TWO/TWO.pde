float cX, cY, xx, yy, xx2, yy2, rad, angle, sw = 11;

void setup()
{
  size(displayWidth, displayHeight);
  smooth();
  noFill();
  frameRate(666);
  cX = width/2;
  cY = height/2;
  rad = 250;
  strokeWeight(2);
}



void draw()
{
  angle = frameCount+sw;
  xx = cX - int( cos(radians(angle)) * rad );
  yy = cY - int( sin(radians(angle)) * rad );
  xx2 = cX - int( cos(radians(angle)) * random(cY) );
  yy2 = cY - int( sin(radians(angle)) * random(cY) );




  // stroke(frameCount%-255,100);
  // strokeWeight(sw);
  // // point(xx, yy);
  // point(xx2, yy2);

  
  // stroke(frameCount%255,100);
  // strokeWeight(sw/2);
  // point(xx, yy);

stroke(frameCount%255);
// strokeWeight(HALF_PI);
ellipse( xx, yy, rad*1.5, rad*1.5 );
ellipse( xx, yy, rad*2, rad*2 );

  if(frameCount%360==0)
  {
    rad-=sw;
    if(sw>PI){
    	sw-=.75;	
    } else{
    	sw = 11;
    }
    
  }

  if( rad < 9 ){
    
    save(this+".png");

    noLoop();
  }

}
