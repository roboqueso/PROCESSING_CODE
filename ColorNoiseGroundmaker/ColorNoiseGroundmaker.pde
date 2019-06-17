import nervoussystem.obj.*;
import fixlib.*;
Fixlib fix = Fixlib.init(this);

// based on colorNoise example
// Generate landscape ground object
// TODO: look at sphere() for tips
// https://github.com/processing/processing/blob/master/core/src/processing/core/PGraphics.java

boolean record = true;
float z;
int cY, cX;
ArrayList<PVector> alPath;
PVector tmpV, tmpV2;
Integer pStep = 95;  //  SMALLER = more complex shapes
PShape sj;
PShape tmpShp;
Integer tmpShpW;


///////////////////////////////////////////////////////////////////////////////
void setup() {
  size(2000, 1000,P3D);
  background(-1);  //0x16161E);

  cX = (int)width/2;
  cY = (int)height/2;

  alPath = fix.GeneratePath(new PVector(0, 0, 0), new PVector(2000, 1000, cX), pStep );
  

  
  // if(record) {
    //X3DExport x3d = (X3DExport) createGraphics(10,10,"nervoussystem.obj.X3DExport","colored.x3d");
    OBJExport obj = (OBJExport) createGraphics( 2000, 1000, "nervoussystem.obj.OBJExport", fix.pdeName()+"-"+pStep+".obj");
    obj.setColor(false);
    obj.sphereDetail(9);
    obj.beginDraw();

      drawNoise(obj);

    obj.endDraw();
    obj.dispose();
    record = false;
  // }
  //noStroke();
  //translate(width/2,height/2,-cY);
  //rotateX(PI/6.0);
  //rotateZ(frameCount*PI/360.0);
  //translate(-100,-100,0);
  //scale(4);
  //drawNoise(this.g);
  
  exit();
}

///////////////////////////////////////////////////////////////////////////////
void draw() {
  exit();
}


///////////////////////////////////////////////////////////////////////////////
void drawNoise(PGraphics pg) {
  
  pg.beginShape(TRIANGLE_STRIP);
 

// FIXLIB 
//  1. ArrayList<PVector> GeneratePath( PVector startPt, PVector endPt, Integer step )
for( PVector pv : alPath)
{



      

  //  1. main vector
	//pv.z = random(pv.x,pv.y);


println("pv: "+pv.x + " "+pv.y + " "+pv.z);


      // pg.vertex(pv.x,pv.y,pv.z);
      // pg.vertex(pv.y,pv.x,pv.z);

//PShape shapeJous( float a, float b, float amp, int inc )
tmpShpW = pStep*(int)random(9,alPath.size());

sj = fix.shapeJous( pv.y, pv.x, tmpShpW*pStep, pStep );

for( int vv = 0; vv <= sj.getVertexCount()-1; vv++){
    tmpV2 = sj.getVertex(vv);
	
	pg.normal(0, -1, 0);
	pg.vertex(0, -tmpShpW, 0);

	// pg.normal( tmpV2.x, tmpV2.y, tmpV2.z );
	// pg.vertex(pStep * tmpV2.x, pStep * tmpV2.y, pStep * tmpV2.z);

  	pg.rotateX(pStep);
	pg.normal( tmpV2.x, tmpV2.y, tmpV2.z );
  	pg.vertex( tmpV2.x, tmpV2.y, tmpV2.z );

	// pg.normal( tmpV2.x+pStep, tmpV2.y+pStep, tmpV2.z+pStep );
 //  	pg.vertex( tmpV2.x+pStep, tmpV2.y+pStep, tmpV2.z+pStep );

 //  	pg.rotateX(90);
	// pg.normal( tmpV2.x, tmpV2.y, tmpV2.z );
 //  	pg.vertex( tmpV2.x, tmpV2.y, tmpV2.z );




      // pg.vertex( tmpV2.x, tmpV2.y, tmpV2.z );
}



}


 
/*

    edge(false);


    // 1st ring from south pole
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sphereDetailU; i++) {
      normal(0, -1, 0);
      vertex(0, -r, 0);
      normal(sphereX[i], sphereY[i], sphereZ[i]);
      vertex(r * sphereX[i], r * sphereY[i], r * sphereZ[i]);
    }
    normal(0, -r, 0);
    vertex(0, -r, 0);
    normal(sphereX[0], sphereY[0], sphereZ[0]);
    vertex(r * sphereX[0], r * sphereY[0], r * sphereZ[0]);
    endShape();

    int v1,v11,v2;

    // middle rings
    int voff = 0;
    for (int i = 2; i < sphereDetailV; i++) {
      v1 = v11 = voff;
      voff += sphereDetailU;
      v2 = voff;
      beginShape(TRIANGLE_STRIP);
      for (int j = 0; j < sphereDetailU; j++) {
        normal(sphereX[v1], sphereY[v1], sphereZ[v1]);
        vertex(r * sphereX[v1], r * sphereY[v1], r * sphereZ[v1++]);
        normal(sphereX[v2], sphereY[v2], sphereZ[v2]);
        vertex(r * sphereX[v2], r * sphereY[v2], r * sphereZ[v2++]);
      }
      // close each ring
      v1 = v11;
      v2 = voff;
      normal(sphereX[v1], sphereY[v1], sphereZ[v1]);
      vertex(r * sphereX[v1], r * sphereY[v1], r * sphereZ[v1]);
      normal(sphereX[v2], sphereY[v2], sphereZ[v2]);
      vertex(r * sphereX[v2], r * sphereY[v2], r * sphereZ[v2]);
      endShape();
    }

    // add the northern cap
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sphereDetailU; i++) {
      v2 = voff + i;
      normal(sphereX[v2], sphereY[v2], sphereZ[v2]);
      vertex(r * sphereX[v2], r * sphereY[v2], r * sphereZ[v2]);
      normal(0, 1, 0);
      vertex(0, r, 0);
    }
    normal(sphereX[voff], sphereY[voff], sphereZ[voff]);
    vertex(r * sphereX[voff], r * sphereY[voff], r * sphereZ[voff]);
    normal(0, 1, 0);
    vertex(0, r, 0);
    endShape();

    edge(true);

*/

  pg.endShape();  
  
  
}
void keyPressed()
{
  if (key == 'r') {
    record = true;
  }
}
