import nervoussystem.obj.*;
//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);



/*
1 Currate the hotness in OBJs
Create OBJ of sphere with sphereDetails(X)

where X is a number from this fibonacchi sequence :

2, 3, 5, 8, 13, 21, 34, 55, 89
*/



int cY, cX;

Integer fn = 89;


Integer tmpShpW;

///////////////////////////////////////////////////////////////////////////////
void setup() {
  size(666, 666,P3D);
  background(-1);  //0x16161E);
  sphereDetail(fn);

  cX = (int)width/2;
  cY = (int)height/2;
  	
	// OBJExport obj = (OBJExport) createGraphics( width, height, "nervoussystem.obj.OBJExport", fix.pdeName()+"-"+fn+(s1?"s1":"")+(s2?"s2":"")+(s3?"s3":"")+".obj");
	OBJExport obj = (OBJExport) createGraphics( width, height, "nervoussystem.obj.OBJExport", fix.pdeName()+"-"+fn+".obj");
    obj.beginDraw();

      obj.sphereDetail(fn);
      obj.translate(cX, cY, cY);
      obj.sphere(cX);

    obj.endDraw();
    obj.dispose();

obj = null;


    exit();
}

///////////////////////////////////////////////////////////////////////////////
void draw() {

}
