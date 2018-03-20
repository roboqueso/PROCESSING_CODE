//  Make DXF from P5 -> render in Fusion360

import processing.opengl.*;
import processing.dxf.*;
import fixlib.*;


Fixlib fix = Fixlib.init(this);


/***/
void setup() {
    background(-1);
    size( 640, 480, P3D);
    smooth();

    textSize(42);
    fill(#EF2018);
    text( fix.pdeName(), 11, height-100 );

}

void draw()
{

if( frameCount <= 1 ){
  beginRaw( DXF, this+".dxf" );
}

lights();

    // stroke(frameCount%255);
    // fill(random(frameCount%width), random(height), frameCount%42, 100);

    beginShape();
        shape( fix.shapeJous( random(width), random(height), 42, frameCount ) );
    endShape(CLOSE);

if( frameCount % 11 == 0 ){
  endRaw();

  save(this+".png");

  noLoop();
  exit();
}
}