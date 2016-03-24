float cX, cY, xx, yy, xx2, yy2, rad, angle, sw = 11;

void setup()
{
  size(displayWidth, displayHeight);
  // background(1);
  textAlign(CENTER, CENTER);
  smooth();
  noFill();
  frameRate(111);
  cX = width/2;
  cY = height/2;
  rad = cX;
}



void draw()
{
  angle = frameCount+sw;
  xx = cX - int( cos(radians(angle)) * rad*2 );
  yy = cY - int( sin(radians(angle)) * rad*2 );
  xx2 = cX - int( cos(radians(angle)) * random(cY) );
  yy2 = cY - int( sin(radians(angle)) * random(cY) );


  // ellipse( xx, yy, rad, rad );
  stroke(sw*PI);
  strokeWeight(sw);
  line(xx, yy, xx2, yy2);
  
  stroke(frameCount%255, 50);
  strokeWeight(sw/2);
  line(xx, yy, xx2, yy2);

  fill(frameCount%255);
  textSize(random(sw, (sw*PI)));
  text("one can only be understood by itself", xx2, yy2 );

  if(frameCount%360==0)
  {
    rad-=sw;
    sw-=HALF_PI;
  }

  if( sw < 1 ){
    fill(0);
    textSize(sqrt(width)+1);
    text("one can only be understood by itself", cX-1, cY-1 );

    fill(255);
    textSize(sqrt(width));
    text("one can only be understood by itself", cX, cY );
    
    save(this+".png");

    noLoop();
  }

}
