//  Make DXF from P5 -> render in Fusion360

import processing.opengl.*;
import processing.dxf.*;
import fixlib.*;


Fixlib fix = Fixlib.init(this);

int numFrames = 2;
float lastX, lastY, lastZ;

PShape tmp, shpFish, shpWheat, shpChicken;
PVector vv;
PImage text;


/***/
void setup() {

    background(-1);
    size( 1024, 768, P3D);
    smooth();

	noFill();
	strokeWeight(numFrames);

	shpChicken = loadShape("chicken.svg");
	shpFish = loadShape("fish.svg");
	shpWheat = loadShape("wheat.svg");

	// text = loadImage("chickenWheatFish_White.png");
}

void draw()
{
	lights();
	smooth();

if( frameCount == 1 ){
  beginRaw( DXF, fix.pdeName() +".dxf" );
}



 
// chicken
// pushMatrix();
// 	// translate( frameCount*(width*.25), height-frameCount*(height/3), frameCount);
// 	translate( width*.25, ((height/numFrames)*frameCount) , frameCount);
	
	// rotateX(frameCount*numFrames);
	// rotateY(frameCount*numFrames);
	// rotateZ(frameCount*numFrames);

	tmp = shpChicken.getChild(0);
	beginShape(POLYGON);
		for (int i = 0; i < tmp.getVertexCount(); i++) 
		{
			//	EVERY EVEN VERTEX
			//if(i%2==0){
			    vv = tmp.getVertex(i);
			    vertex( vv.x, vv.y, vv.z );
		    //}
  		}
	endShape(CLOSE);

// track last shape coordinate for the next one to start
lastX = vv.x;
lastY = vv.y;
lastZ = vv.z;

// popMatrix();


// wheat
// pushMatrix();
// 	translate( width*.5, ((height/numFrames)*frameCount), frameCount);

	// rotateX(frameCount*numFrames);
	// rotateY(frameCount*numFrames);
	// rotateZ(frameCount*numFrames);


	tmp = shpWheat.getChild(0);
	beginShape(POLYGON);
		for (int i = 0; i < tmp.getVertexCount(); i++) 
		{
			//	EVERY EVEN VERTEX
			//if(i%2==0){
			    vv = tmp.getVertex(i);
			    vertex( (lastX*.42)+vv.x, vv.y, lastZ+vv.z );
		    //}
  		}
	endShape(CLOSE);
// popMatrix();


// track last shape coordinate for the next one to start
lastX = vv.x;
lastY = vv.y;
lastZ = vv.z;

// fish
// pushMatrix();
	// translate( (width*.75), ((height/numFrames)*frameCount), frameCount);

	// rotateX(frameCount*numFrames);
	// rotateY(frameCount*numFrames);
	// rotateZ(frameCount*numFrames);


	tmp = shpFish.getChild(0);
	beginShape(POLYGON);
		for (int i = 0; i < tmp.getVertexCount(); i++) 
		{
			//	EVERY EVEN VERTEX
			//if(i%2==0){
			    vv = tmp.getVertex(i);
				vertex( (lastX*1.25)+vv.x, vv.y, lastZ+vv.z );
		    //}
  		}
	endShape(CLOSE);
// popMatrix();



if( frameCount % numFrames == 0 ){
  endRaw();

  save( fix.pdeName()+".png");

  noLoop();
  exit();
}

}