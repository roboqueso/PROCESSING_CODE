//  Make DXF from P5 -> render in Fusion360

import processing.opengl.*;
import processing.dxf.*;
//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);


int numFrames = 8;

PImage txt;
PShape tmp;
PVector vv;

/***/
void setup() {
    background(-1);
    size( 1024, 768, P3D);
    smooth();

	txt = loadImage("chickenWheatFish_White.png");

	stroke(0);
	strokeWeight(PI);

    // textSize(42);
    // fill(#EF2018);
    // text( fix.pdeName(), random(width), random(height) );
}

void draw()
{

if( frameCount <= 1 ){
  beginRaw( DXF, fix.pdeName() +".dxf" );
}

lights();

// box
pushMatrix();
	translate( random(width), random(height), frameCount);
	
	rotateX(frameCount);
	rotateY(frameCount);
	rotateZ(frameCount);
	
	tmp = createShape(BOX, 210 );
	tmp.setTexture(txt);

	shape( tmp );
popMatrix();


// box
pushMatrix();
	translate( random(width), random(height), frameCount);
	rotateX(frameCount);
	rotateY(frameCount);
	rotateZ(frameCount);

// Load an image
	sphereDetail(numFrames);
	tmp = createShape(SPHERE, 210 );
	tmp.setTexture(txt);

  shape(tmp);

popMatrix();

// // box
// pushMatrix();
// 	translate( width/2, height/2, frameCount );
	
// 	rotateX(frameCount*numFrames);
// 	rotateY(frameCount*numFrames);
// 	rotateZ(frameCount*numFrames);

// 		tmp = fix.shapeJous( random(width), random(height), frameCount, frameCount*numFrames );
// 		tmp.setTexture(txt);

// 	beginShape();
// 		texture(txt);

// 		for (int i = 0; i < tmp.getVertexCount(); i++) 
// 		{
// 		  vv = tmp.getVertex(i);
// 		  vertex( vv.x, vv.y, vv.z, random(txt.width), random(txt.height) );
// 		}

// 	endShape();
// popMatrix();


/*
FUSION360 notes

Assign physical material to bodies or components, 
	and visual material to bodies, components, and faces.

DFX objects to bodies, components and faces

Currently there is no way to create a drawing from a sketch. 
The drawing cannot be created without a solid body in a design. 
**** ( P5 DXF ) orkaround is to extrude the sketch to make solids and 
generate a drawing.



*/



// noStroke();
// noFill();



// // //	sphere
// pushMatrix();	
// 	sphereDetail(numFrames);
// 	translate(frameCount*(width/numFrames), random(frameCount*(height/numFrames)), frameCount);
// 	texture(txt);
// 	sphere(800);
// popMatrix();





if( frameCount % numFrames == 0 ){
  endRaw();

  save( fix.pdeName()+".png");

  noLoop();
  exit();
}
}