import processing.opengl.*;
import processing.dxf.*;
//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);



PShape tmp;
int numFrames = 6;
int col;

/***/
void setup() {
    background(-1);
    // size( 1024, 768, P3D);
    size( displayWidth, displayHeight, P3D);
    smooth();

    strokeWeight(4);
    
    col = (int)width/6;  // colum 
}



void draw()
{

	if( frameCount <= 1 ){
	  beginRaw( DXF, fix.pdeName() +".dxf" );
	}

lights();


pushMatrix();

	translate( width/2, height/2, frameCount+col);

	
// rotateX(frameCount);
// rotateY(frameCount);
// rotateZ(frameCount);
rotate(frameCount);
	
  triangle(18, 18, 18, 360, 81, 360);
  
  rect(90, 81, 63, 63);
  
  quad(189, 18, 216, 18, 216, 360, 144, 360);
  
  ellipse(col+11, col, 72, 72);
  
  triangle(288, 18, 351, 360, 288, 360); 
  
  arc(col, 300, 280, 280, PI, TWO_PI);

popMatrix();


if( frameCount % numFrames == 0 ){
  endRaw();

  save( fix.pdeName()+".png");

  noLoop();
  exit();
}
}