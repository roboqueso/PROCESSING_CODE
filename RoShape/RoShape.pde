//  see:  https://ello.co/ericfickes/post/x7-7pbhkacqeawhntok2cq
import nervoussystem.obj.*;
import fixlib.*;
Fixlib fix = Fixlib.init(this);

/*
1 Currate the hotness in OBJs
9, 11, 13, 18, 24, 27, 35, 44, 69

2 Run the individual shapes indidivudally for each winner

3 Assemble full shape in F360 via individual shapes

4 Each shape has diff appearance
*/



boolean s1 = false;	//	vertex
boolean s2 = false;	//	sphere
boolean s3 = false;	//	box
boolean s4 = true;	//	triangle *BETA
float z;
int cY, cX;
ArrayList<PVector> alPath;


Integer minP = 9;	//	9, 11, 13, 18, 24, 27, 35, 44, 69
Integer maxP = 18;	//	9, 11, 13, 18, 24, 27, 35, 44, 69
Integer pStep;


Integer tmpShpW;
float angleX, angleY, angleZ; // rotation of 3D shape


///////////////////////////////////////////////////////////////////////////////
void setup() {
  size(666, 666,P3D);
  background(-1);  //0x16161E);

  cX = (int)random(width);
  cY = (int)random(height);
  pStep = minP;

  for(pStep = minP; pStep<=maxP; pStep++)
  {
  	
	OBJExport obj = (OBJExport) createGraphics( width, height, "nervoussystem.obj.OBJExport", fix.pdeName()+"-"+pStep+
								(s1?"s1":"")+(s2?"s2":"")+(s3?"s3":"")+(s4?"s4":"")+
								".obj");
	obj.beginDraw();

      drawNoise(obj);

    obj.endDraw();
    obj.dispose();

obj = null;

  }

    exit();
}

///////////////////////////////////////////////////////////////////////////////
void draw() {

}


///////////////////////////////////////////////////////////////////////////////
void drawNoise(PGraphics pg) {

PShape sj;
PVector tmpV, tmpV2, lrpV;
PShape tmpShp,tmpShp2;


PVector pv = new PVector();
pv.x = random(width);
pv.y = random(height);
pv.z = (int)random(pStep, cY);

println("pv: "+pv.x + " "+pv.y + " "+pv.z);

	tmpShp2 = createShape(BOX, pStep );
	tmpShp = createShape(SPHERE, pStep );


	// drawTriangle(pg, pv, pStep);

pg.rectMode(CENTER);
pg.beginShape(POLYGON);
pg.sphereDetail(44);

	//	DON'T REMOVE THIS
	pg.vertex(pv.x, pv.y, pv.z);

	// sj = fix.shapeJous( pv.x, pv.y, width, (int)random(3,18) );
	sj = fix.shapeJous( pv.x, pv.y, width-pStep, 3 );	//	9 & 12 are nice

pg.translate(-pv.x, -pv.y, pv.z);

if(s1){

	for( int vv = 0; vv <= sj.getVertexCount()-1; vv++){
	    tmpV = sj.getVertex(vv);
	    //	get NEXT point
	    tmpV2 = sj.getVertex(  ((vv+1)%sj.getVertexCount()) );
		//	LERP
		lrpV = PVector.lerp(tmpV, tmpV2, .5 );

	//	cool flat background grid shifting action
	pg.shape( createShape( RECT, tmpV.x, tmpV.y, vv*pStep, vv+pStep ) );	// rect(a, b, c, d)
	pg.shape( createShape( SPHERE, pStep ), tmpV.x, tmpV.y, pStep, pStep+vv );	//	sphere(r)
	pg.shape( createShape( BOX, pStep+vv, pStep, pStep+vv ), tmpV.x, tmpV.y );	//	box(w, h, d)

	}
}

if(s2){
	for( int vv = 0; vv <= sj.getVertexCount()-1; vv++){

		angleX += radians(0.913f);
		angleY += radians(0.799f);
		angleZ += radians(1.213f);

		pg.rotateX(angleX);
		pg.rotateY(angleY);
		pg.rotateZ(angleZ);

	    tmpV = sj.getVertex(vv);
	    //	get NEXT point
	    tmpV2 = sj.getVertex(  ((vv+1)%sj.getVertexCount()) );
		//	LERP
		lrpV = PVector.lerp(tmpV, tmpV2, .5 );

		// pg.shape(tmpShp, -tmpV.y, -tmpV.x, tmpV.z+vv, tmpV.z+pStep);
		// // lerpski
		// pg.shape(tmpShp, -lrpV.y, -lrpV.x, lrpV.z+vv, lrpV.z);
		// //	next
		// pg.shape(tmpShp, -tmpV2.x, -tmpV2.y, tmpV2.z+vv, tmpV2.z);

	//	cool flat background grid shifting action
	pg.shape( createShape( RECT, tmpV.x, tmpV.y, vv*pStep, vv ) );	// rect(a, b, c, d)
	pg.shape( createShape( SPHERE, pStep ), tmpV.x, tmpV.y, pStep, pStep+vv );	//	sphere(r)
	pg.shape( createShape( BOX, pStep+vv, pStep, pStep+vv ), tmpV.x, tmpV.y );	//	box(w, h, d)
	}

}

if(s3){
	for( int vv = 0; vv <= sj.getVertexCount()-1; vv++){
		angleX += radians(0.913f);
		angleY += radians(0.799f);
		angleZ += radians(1.213f);

		// pg.rotateX(angleX);
		// pg.rotateY(angleY);
		// pg.rotateZ(angleZ);
		pg.rotateX(vv);
		pg.rotateY(vv);
		pg.rotateZ(vv);

	    tmpV = sj.getVertex(vv);
	    //	get NEXT point
	    tmpV2 = sj.getVertex(  ((vv+1)%sj.getVertexCount()) );
		//	LERP
		lrpV = PVector.lerp(tmpV, tmpV2, .5 );

		// pg.shape(tmpShp2, -tmpV.y, -tmpV.x, tmpV.z+vv, tmpV.z);
		// // lerpski
		// pg.shape(tmpShp2, -lrpV.y, -lrpV.x, lrpV.z, lrpV.z+vv);
		// //	next
		// pg.shape(tmpShp2, -tmpV2.x, -tmpV2.y, tmpV2.z+vv, tmpV2.z);
		//	cool flat background grid shifting action
		pg.shape( createShape( RECT, tmpV.x, tmpV.y, vv*pStep, vv ) );	// rect(a, b, c, d)
		pg.shape( createShape( SPHERE, pStep ), tmpV.x, tmpV.y, pStep, pStep+vv );	//	sphere(r)
		pg.shape( createShape( BOX, pStep+vv, pStep, pStep+vv ), tmpV.x, tmpV.y );	//	box(w, h, d)
	}
}

if(s4){
println("SHAPE4: "+sj.getVertexCount() + "vertices");
	for( int vv = 0; vv <= sj.getVertexCount()-1; vv++){
	    tmpV = sj.getVertex(vv);
	    //	get NEXT point
	    tmpV2 = sj.getVertex(  ((vv+1)%sj.getVertexCount()) );
		//	LERP
		lrpV = PVector.lerp(tmpV, tmpV2, .5 );

	drawTriangle(pg, tmpV, vv);
	drawTriangle(pg, lrpV, vv);
	drawTriangle(pg, tmpV2, vv);

	}
}
	// for( int vv = 0; vv <= sj.getVertexCount()-1; vv++){
	//     tmpV2 = sj.getVertex(vv);	
	// 	pg.rotateZ(90);	

	// 	pg.vertex(tmpV2.x, tmpV2.y, tmpV2.z);
	// 	pg.curveVertex(tmpV2.x, tmpV2.y, tmpV2.z);

	// 	pg.vertex(tmpV2.x, tmpV2.y, -tmpV2.z);
	// 	pg.curveVertex(tmpV2.x, tmpV2.y, -tmpV2.z);
	// }





  pg.endShape();  
  
  
}

/**
	pg -> PGraphics to draw to
	pv -> PVector to draw the triangle at
	pStep -> size s

*/
void drawTriangle( PGraphics pg, PVector pv, int pStep){
	// pg.translate(pv.x, pv.y, pv.z);
	// pg.translate(pv.x, pv.y, pv.z);
pg.stroke(255);
pg.rotateX(PI/2);
pg.rotateZ(-PI/6);
pg.noFill();

pg.beginShape();
	pg.vertex(pv.x-pStep, pv.y-pStep, pv.z-pStep);
	pg.vertex(pv.x+pStep, pv.y-pStep, pv.z-pStep);
	pg.vertex(pv.x,  pv.y,  pv.z+pStep);

	pg.vertex( pv.x+pStep, pv.y-pStep, pv.z-pStep);
	pg.vertex( pv.x+pStep, pv.y+pStep, pv.z-pStep);
	pg.vertex( pv.x, pv.y, pv.z+pStep);

	pg.vertex( pv.x+pStep, pv.y+pStep, pv.z-pStep);
	pg.vertex(pv.x-pStep, pv.y+pStep,  pv.z-pStep);
	pg.vertex( pv.x, pv.y, pv.z+pStep);

	pg.vertex(pv.x-pStep,  pv.y+pStep, pv.z-pStep);
	pg.vertex(pv.x-pStep, pv.y-pStep, pv.z-pStep);
	pg.vertex( pv.x, pv.y, pv.z+pStep);
pg.endShape(CLOSE);
}
