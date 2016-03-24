size(1024, 768 );
background(204);
smooth();

Boolean isFinal = true;
int x = width/2;
int y = height/2;
float outerRad = 10;//min(width, height) * 0.4;
float innerRad = 5;//outerRad * 0.6;
float px = 0, py = 0, angle = 0;
float pts = 36;
float rot = 360.0/pts;

while( outerRad < height ) {
  
  beginShape(TRIANGLE_STRIP); 
  for (int i = 0; i < pts; i++) {
    px = x + cos(radians(angle))*outerRad;
    py = y + sin(radians(angle))*outerRad;
    angle += rot;
    vertex(px, py);
    px = x + cos(radians(angle))*innerRad;
    py = y + sin(radians(angle))*innerRad;
    vertex(px, py); 
    angle += rot;
  }
  endShape();
 
  //  make bigger
  innerRad += 5;
  outerRad += 5;
}

fill(#1975EF);
text("ERICFICKES.COM", 0, height-11);


  if ( isFinal )
  {
    save( split( this.toString(), "[")[0] + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
  }

  super.stop();
