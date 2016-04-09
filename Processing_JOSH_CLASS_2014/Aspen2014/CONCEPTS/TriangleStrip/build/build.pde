import processing.pdf.PGraphicsPDF;


size(1024, 768 );
background(204);
smooth();



Boolean isFinal = true;
int x = width/2;
int y = height/2;
float outerRad = 125;
float innerRad = 50;
float px = 0, py = 0, angle = 0;
float pts = 12;
float rot = 360.0/pts;


  if (isFinal) {
    beginRecord(PDF, "MyRender-####.pdf");
  }


noFill();
strokeWeight(1);

while( innerRad < height ) {
  
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
  innerRad *= HALF_PI;
  outerRad *= HALF_PI;
}



  if ( isFinal )
  {
    save( split( this.toString(), "[")[0] + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );


      endRecord();




  }

  super.stop();
