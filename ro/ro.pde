PImage img;
float xx, yy, cX, cY;
int sz = 3;

void setup() {
  size(displayWidth, displayHeight );
	background(255);
  noFill();
  strokeWeight(1);
  smooth(); 
  rectMode(CENTER);
  cX = width/2;
  cY = height/2;
}

void draw() {
//  background(0);
 // translate(width/2 *noise(frameCount), height/2 *noise(frameCount));

 xx = ( cX - cos( radians(frameCount) ) * sz ) + noise(frameCount);
 yy = cY - sin( radians(frameCount) ) * sz + noise(frameCount);


if( frameCount % 360 == 0 ){
	stroke(random(sz));
	sz *= 1.34;

	cX = random(width);
	cY = random(height);

	stroke(xx, yy, sz);
	bezier( xx, yy, lerp(xx, yy, random(1)), lerp( yy, xx, random(1)), yy, xx, cX, cY );
}

  



  stroke(frameCount%120);
  rect( xx, yy, sz,sz, sz*noise(frameCount));
  ellipse( xx, yy, sz,sz);
 
if( sz >= (height/2)){
save(this+".png");
	noLoop();

}

}
