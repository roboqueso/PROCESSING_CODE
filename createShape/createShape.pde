import nervoussystem.obj.*;
import fixlib.*;


boolean record = true;
float noiseScale = .05;

//PShape lj = fix.shapeJous( float a, float b, float amp, int inc )
Fixlib fix = Fixlib.init(this);
PShape fl;

void setup() {
  size(900, 900,P3D);
}

void draw() {
  background(255);
  
   if(record) {
    //X3DExport x3d = (X3DExport) createGraphics(10,10,"nervoussystem.obj.X3DExport","colored.x3d");
    OBJExport obj = (OBJExport) createGraphics(10,10,"nervoussystem.obj.OBJExport","colored.obj");
    obj.setColor(false);
    obj.beginDraw();
    	drawNoise(obj);
    obj.endDraw();
    obj.dispose();
  //   record = false;
  }
  // noStroke();
  // translate(width/2,height/2,-50);
  // rotateX(PI/6.0);
  // rotateZ(frameCount*PI/360.0);
  // translate(-100,-100,0);
  // scale(4);
  // drawNoise(this.g);

endRecord();
noLoop();
exit();
}

void drawNoise(PGraphics pg) {
  
//	TODO: clone into drawJous

  pg.beginShape(TRIANGLES);
  for(int i=0;i<50;i++) {
    for(int j=0;j<50;j++) {

      float z = noise(i*noiseScale,j*noiseScale);
      pg.fill( lerpColor( color(255,0,0),color(0,0,255),z ));
      pg.vertex(i,j,z);

      z = noise((i+1)*noiseScale,j*noiseScale);
      pg.fill( lerpColor( color(255,0,0),color(0,0,255),z ));
      pg.vertex(i+1,j,z);
      
      z = noise((i+1)*noiseScale,(j+1)*noiseScale);
      pg.fill( lerpColor( color(255,0,0),color(0,0,255),z ));
      pg.vertex(i+1,j+1,z);

      z = noise((i+1)*noiseScale,(j+1)*noiseScale);
      pg.fill( lerpColor( color(255,0,0),color(0,0,255),z ));
      pg.vertex(i+1,j+1,z);
      
      z = noise(i*noiseScale,(j+1)*noiseScale);
      pg.fill( lerpColor( color(255,0,0),color(0,0,255),z ));
      pg.vertex(i,j+1,z);
      
      z = noise(i*noiseScale,j*noiseScale);
      pg.fill( lerpColor( color(255,0,0),color(0,0,255),z ));
      pg.vertex(i,j,z);
    }
  }
  pg.endShape();  


}