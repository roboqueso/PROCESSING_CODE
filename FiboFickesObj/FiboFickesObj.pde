/*
1, 2, 3, 5, 8, 13, 21, 34, 55

Nine OBJs of FIBONACCI numbers

box()	2	sphere()
box()	3	sphere()
box()	5	sphere()
box()	8	sphere()
box()	13	sphere()
box()	21	sphere()
box()	34	sphere()
box()	55	sphere()
box()	89	sphere()
*/

import nervoussystem.obj.*;
//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);



int numFrames = 9;
int sd = 2;	//	2, 3, 5, 8, 13, 21, 34, 55, 89
int txtSz = 100;
int bxSz;
float cX, cY;
String fnt = "DoppioOne-Regular";

PShape psSphere, psBox;

/* ------------------------------------------------------------------------- */
void  settings ()  {
    size( 1000, 1000, P3D);
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}


/*****************************************************************************/
void setup() {
	background(-1);
	rectMode(CENTER);
	shapeMode(CENTER);
	textMode(SHAPE);

	cX = width/2;
	cY = height/2;
	
	bxSz = (int)(width/3);
	txtSz = (int)(width/PI);

	sphereDetail(sd); //  outer marble
}




/*****************************************************************************/
void draw() {
	psSphere = fix.shapeJous( cX, cY, bxSz, sd );// createShape( SPHERE, bxSz );
	psBox = fix.shapeJous( cX, cY, bxSz, sd );// createShape( BOX, bxSz, bxSz, bxSz );



	beginRecord("nervoussystem.obj.OBJExport", this+"-"+sd+".obj");
		noFill();		

		// rotateZ(45);
		// rotateY(45);
		// rotateZ(90);

	translate(cX, cY);
	pushMatrix();
		// sphereDetail(9, sd ); //  outer marble
		shape(psSphere, bxSz, cY );
		
		shape(psBox, bxSz*2, cY );
		
		sphereDetail(sd,9); //  outer marble
		shape(psSphere, bxSz*3, cY );

	popMatrix();

	textSize(bxSz);
	text(sd, cX, cY );

	endRecord();

  if(frameCount==numFrames ){

	save(this+ "-" + sd +".png");
    noLoop();
    exit();
  } else {
  	
  	perspective();

  }

}
