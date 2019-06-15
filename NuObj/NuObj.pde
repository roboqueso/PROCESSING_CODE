import nervoussystem.obj.*;
import fixlib.*;
Fixlib fix = Fixlib.init(this);

// based on colorNoise example
// Generate landscape ground object
// TODO: look at sphere() for tips
// https://github.com/processing/processing/blob/master/core/src/processing/core/PGraphics.java

//  https://processing.org/reference/bezierVertex_.html
//  bezierVertex(x2, y2, z2, x3, y3, z3, x4, y4, z4)

//  https://processing.org/reference/curveVertex_.ht-pStepml
//  curveVertex(x, y, -pStepz)

//  https://processing.org/reference/quadraticVertex_.html
//  quadraticVertex(cx, cy, cz, x3, y3, z3)


/*
1 Currate the hotness in OBJs
9, 11, 13, 18, 24, 27, 35, 44, 69

2 Run the individual shapes indidivudally for each winner

3 Assemble full shape in F360 via individual shapes

4 Each shape has diff appearance
*/



boolean s1 = true;
boolean s2 = true;
boolean s3 = true;
float z;
int cY, cX;
ArrayList<PVector> alPath;


Integer minP = 24;	//	9, 11, 13, 18, 24, 27, 35, 44, 69
Integer maxP = 24;	//	9, 11, 13, 18, 24, 27, 35, 44, 69
Integer pStep;


Integer tmpShpW;

///////////////////////////////////////////////////////////////////////////////
void setup() {
  size(666, 666,P3D);
  background(-1);  //0x16161E);

  cX = (int)random(width);
  cY = (int)random(height);
  pStep = minP;

  for(pStep = minP; pStep<=maxP; pStep++)
  {
  	
	OBJExport obj = (OBJExport) createGraphics( 444, 444, "nervoussystem.obj.OBJExport", fix.pdeName()+"-"+pStep+(s1?"s1":"")+(s2?"s2":"")+(s3?"s3":"")+".obj");
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
PVector tmpV, tmpV2;
PShape tmpShp,tmpShp2;

  pg.beginShape(POLYGON);
  pg.sphereDetail(4);

PVector pv = new PVector();
pv.x = random(width);
pv.y = random(height);
pv.z = (int)random(pStep, cY);

println("pv: "+pv.x + " "+pv.y + " "+pv.z);

	tmpShp2 = createShape(BOX, TWO_PI );
	tmpShp = createShape(SPHERE, TWO_PI);

// sj = fix.shapeJous( pv.x, pv.y, random(width), (int)random(3,18) );
sj = fix.shapeJous( pv.x, pv.y, pStep, (int)random(3,sqrt(pStep)) );


for( int vv = 0; vv <= sj.getVertexCount()-1; vv++){
    tmpV2 = sj.getVertex(vv);	


pg.shape( tmpShp, tmpV2.x, tmpV2.y, tmpV2.z, tmpV2.z );

for(int aa = 0; aa < 360; aa+=10){

	pv = fix.circleXY( tmpV2.x, tmpV2.y, pStep+aa, aa);
	pg.vertex(pv.x, pv.y, pv.z);
	pg.vertex(pv.y, pv.x, -pv.z);

if(s1){
	pg.rotateX(aa);
	pg.rotateY(45);
	pg.rotateZ(aa);    
    pg.shape(tmpShp, pv.x, pv.y, pStep+(aa%180), pStep);
}

if(s2){
	pg.rotateX(aa);
	pg.rotateY(45);
	pg.rotateZ(aa);    
    pg.shape(tmpShp, pv.x+pStep, pv.y-pStep, aa, pStep+(aa%180));
}

if(s3){
	pg.rotateX(aa);
	pg.rotateY(45);
	pg.rotateZ(aa);
    pg.shape(tmpShp2, pStep+pv.x-aa, pStep+pv.y-aa, -aa, -aa);
}
	// pg.rotateX(aa);
	// pg.rotateZ(aa);
 //    pg.shape(tmpShp2, pv.x, pv.y, pv.z-pStep, pStep);
    
	// pg.rotateX(aa);
	// pg.rotateZ(aa);
 //    pg.shape(tmpShp, pv.x+pStep, pv.y, pv.z, pStep);

	// pg.rotateX(aa);
	// pg.rotateZ(aa);
 //    pg.shape(tmpShp2, pv.x, pv.y+pStep, pv.z, pStep);

	// pg.rotateX(aa);
	// pg.rotateZ(aa);
 //    pg.shape(tmpShp, pv.x, pv.y, pv.z+pStep, pStep);
    

    
    // pg.rotateX(aa);
    // pg.rotateZ(aa);
    // pg.shape(tmpShp2, pv.x+aa, pv.y+aa, aa, pStep );


 //    pg.rotateX(aa);
 //    pg.rotateZ(aa);
 // //    // pg.curveVertex(pv.x-pStep, pv.y-pStep, 0 );
 //    pg.shape(tmpShp, pv.x+aa, pv.y+aa, aa, aa );

	// pg.rotateZ(60);
 //    // pg.curveVertex(pv.x+pStep, pv.y+pStep, pStep );
 //    pg.shape(tmpShp, pv.x+pStep, pv.y+pStep, pStep, pStep );

	// pg.rotateZ(60);
 //    // pg.curveVertex(pv.x-pStep, pv.y-pStep, pStep );
	// pg.shape(tmpShp, pv.x-pStep, pv.y-pStep, pStep, pStep );

	// pg.rotateZ(60);
 //    // pg.curveVertex(pv.x, pv.y, pv.z );
	// pg.shape(tmpShp, pv.x, pv.y, pv.z , pv.z );
}



}




  pg.endShape();  
  
  
}

