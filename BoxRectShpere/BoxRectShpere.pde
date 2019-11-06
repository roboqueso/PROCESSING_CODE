import nervoussystem.obj.*;
import fixlib.*;
Fixlib fix = Fixlib.init(this);

boolean s1 = false;  //  vertex
boolean s2 = false;  //  sphere
boolean s3 = true;  //  box
// boolean s4 = false;  //  triangle *BETA
float z;
int cY, cX;
ArrayList<PVector> alPath;


Integer minP = 9;  //  9, 11, 13, 18, 24, 27, 35, 44, 69
Integer maxP = 9;  //  9, 11, 13, 18, 24, 27, 35, 44, 69
Integer pStep;


Integer tmpShpW;
float angleX, angleY, angleZ; // rotation of 3D shape


///////////////////////////////////////////////////////////////////////////////
void setup() {
  size(900, 900,P3D);
  background(-1);  //0x16161E);

  cX = (int)width/2;	//random(width);
  cY = (int)height/2;	//random(height);
  pStep = minP;

  for(pStep = minP; pStep<=maxP; pStep++)
  {
    
  OBJExport obj = (OBJExport) createGraphics( width, height, "nervoussystem.obj.OBJExport", fix.pdeName()+"-"+pStep+
                (s1?"s1":"")+(s2?"s2":"")+(s3?"s3":"")+
                ".obj");
  obj.beginDraw();
  obj.rectMode(CENTER);
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
pv.x = (int)((frameCount+TWO_PI)*pStep)%width;
pv.y = (int)((frameCount+TWO_PI)*pStep)%height;
pv.z = (int)random(pStep, cY);

println("pv: "+pv.x + " "+pv.y + " "+pv.z);


// pg.rectMode(CENTER);
pg.beginShape(POLYGON);
pg.sphereDetail(9);

  //  DON'T REMOVE THIS
  pg.vertex(pv.x, pv.y, pv.z);

  // sj = fix.shapeJous( pv.x, pv.y, width, (int)random(3,18) );
  // sj = fix.shapeJous( pv.x, pv.y, width, 2 );  //  9 & 12 are nice
  sj = shapeJous9( pv.x, pv.y, width, 3 );  //  9 & 12 are nice

// pg.translate(-pv.x, -pv.y, pv.z);



  for( int vv = 0; vv <= sj.getVertexCount()-1; vv++){
	tmpV = sj.getVertex(vv);
	//  get NEXT point
	tmpV2 = sj.getVertex(  ((vv+1)%sj.getVertexCount()) );
	// //  LERP
	lrpV = PVector.lerp(tmpV, tmpV2, random(.1, .9) );

  //  cool flat background grid shifting action
  if(s1){
	  pg.shape( createShape( BOX, (PI+vv)*pStep, vv, pStep+vv ), tmpV.x, tmpV.y );  //  box(w, h, d)
	  pg.shape( createShape( BOX, (PI+vv)*pStep, vv, pStep+vv ), tmpV2.x, tmpV2.y );  //  box(w, h, d)
	  pg.shape( createShape( BOX, (PI+vv)*pStep, vv, pStep+vv ), lrpV.x, lrpV.y );  //  box(w, h, d)
  }

	if(s2){
		pg.shape( createShape( RECT, tmpV.x, tmpV.y, sqrt(vv*pStep), vv*pStep ) );  // rect(a, b, c, d)
		pg.shape( createShape( RECT, tmpV2.x, tmpV2.y, sqrt(vv*pStep), vv*pStep ) );  // rect(a, b, c, d)
		pg.shape( createShape( RECT, lrpV.x, lrpV.y, sqrt(vv*pStep), vv*pStep ) );  // rect(a, b, c, d)
	}

	if(s3){
		pg.shape( createShape( SPHERE, pStep ), tmpV.x, tmpV.y, vv, vv );  //  sphere(r)
		pg.shape( createShape( SPHERE, pStep ), tmpV2.x, tmpV2.y, vv, vv );  //  sphere(r)
		pg.shape( createShape( SPHERE, pStep ), lrpV.x, lrpV.y, vv, vv );  //  sphere(r)
	}

}

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




	public PShape shapeJous9( float a, float b, float amp, int inc )
	{
		int juicePts = 180; //  160 is the NEW hotness -> slightly less points, no blank frames 9-36
		int z = 0;

		//  PROTOTYPING : trying to locate universal ideal INCrementor for lisajouss loop
		//  Ideal range is someplace between 1 and 36
		if( ( inc < 1 ) || ( inc > 36 ) ) {
			inc = 1;
		}

		PShape shp = createShape();
		shp.beginShape(POLYGON);

		float x, y;

		for ( int t = 0; t <= juicePts  ; t+=inc)
		{
			//  NEW HOTNESS!
			x = a - amp * PApplet.cos((a * t * TWO_PI)/360);
			y = b - amp * PApplet.sin((b * t * TWO_PI)/360);

			//	give shapes up and down Z-depth
			z = ( t < (juicePts*.5) ) ? t : juicePts-t;

			shp.vertex(x, y, z);
		}

		shp.endShape(CLOSE);

		return shp;
	}