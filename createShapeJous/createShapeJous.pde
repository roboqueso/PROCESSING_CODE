/*
rough beginnings of shapeJouse OBJ maker
*/
import nervoussystem.obj.*;
//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);




boolean record = true;
float noiseScale = .05;
float cX, cY;
int bxSz = 43;
int sd = 3;
int numFrames = 1;

//PShape lj = fix.shapeJous( float a, float b, float amp, int inc )

PShape psSphere, psBox;

void setup() {
  size(900, 900,P3D);
  cX = width/2;
  cY = height/2;
}

void draw() {
  // background(255);
    OBJExport obj = (OBJExport) createGraphics( (int)width, (int)height,"nervoussystem.obj.OBJExport",this+fix.getTimestamp()+".obj");
    
    obj.setColor(true);
    obj.texture(get());
    
    obj.beginDraw();

      // drawShapeJous(obj, (int)random(cX),  (int)random(cY), bxSz, sd );

      drawShapeJous(obj, (int)random(width),  (int)random(height), bxSz, 3 );

      // drawShapeJous(obj, (int)random(-cX,cX), (int)random(-cY,cY), (int)(bxSz*TWO_PI), 4 );
    obj.endDraw();
    obj.dispose();
  //   record = false;


/*
  noStroke();
  translate(width/2,height/2,-50);
  rotateX(PI/6.0);
  rotateZ(frameCount*PI/360.0);
  scale(2);
  drawShapeJous(this.g, cX, cY, bxSz, sd);

  translate(-100,-100,0);

  scale(4);
  drawShapeJous(this.g, cX, cY, bxSz, sd);
*/

if(frameCount > numFrames )
{
  endRecord();
  exit();
} else {
  sd++;
}

}

/**
**/
void drawShapeJous(PGraphics pg, float a, float b, float amp, int inc ) 
{
    int juicePts = 180; //160; //  160 is the NEW hotness -> slightly less points, no blank frames 9-36
    int z = 0;

// TODO: try various shape modes
  pg.beginShape(TRIANGLES);
  //pg.beginShape(POLYGON);

  // for(int i=0;i<50;i++) {
  //   for(int j=0;j<50;j++) {
  //     float z = noise(i*noiseScale,j*noiseScale);
  //     pg.fill( lerpColor( color(255,0,0),color(0,0,255),z ));
  //     pg.vertex(i,j,z*50);
  //     z = noise((i+1)*noiseScale,j*noiseScale);
  //     pg.fill( lerpColor( color(255,0,0),color(0,0,255),z ));
  //     pg.vertex(i+1,j,z*50);
  //     z = noise((i+1)*noiseScale,(j+1)*noiseScale);
  //     pg.fill( lerpColor( color(255,0,0),color(0,0,255),z ));
  //     pg.vertex(i+1,j+1,z*50);

  //     z = noise((i+1)*noiseScale,(j+1)*noiseScale);
  //     pg.fill( lerpColor( color(255,0,0),color(0,0,255),z ));
  //     pg.vertex(i+1,j+1,z*50);
  //     z = noise(i*noiseScale,(j+1)*noiseScale);
  //     pg.fill( lerpColor( color(255,0,0),color(0,0,255),z ));
  //     pg.vertex(i,j+1,z*50);
  //     z = noise(i*noiseScale,j*noiseScale);
  //     pg.fill( lerpColor( color(255,0,0),color(0,0,255),z ));
  //     pg.vertex(i,j,z*50);
  //   }
  // }

    //  PROTOTYPING : trying to locate universal ideal INCrementor for lisajouss loop
    //  Ideal range is someplace between 1 and 36
    if( ( inc < 1 ) || ( inc > 36 ) ) {
      inc = 1;
    }

    float x, y;

    for ( int t = 0; t <= juicePts  ; t+=inc)
    {
      //  NEW HOTNESS!
      x = a - amp * PApplet.cos((a * t * TWO_PI)/360);
      y = b - amp * PApplet.sin((b * t * TWO_PI)/360);

      //  give shapes up and down Z-depth
      z = ( t < (juicePts*.5) ) ? t : juicePts-t;

      pg.vertex(x, y, z*noise(juicePts));
    }

    // pg.endShape(CLOSE);
    pg.endShape();  


}
