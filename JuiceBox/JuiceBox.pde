import nervoussystem.obj.*;
import fixlib.*;
Fixlib fix = Fixlib.init(this);


////////////////////////////////////////////////////////////////////////////////////////
public class EPoint{
    public float xx = 0;
    public float yy = 0;
    public float zz = 0;
    
    public float rx = 0;
    public float ry = 0;
    public float rz = 0;

    EPoint(float x, float y, float z, float rx, float ry, float rz)
    {
        xx = x;
        yy = y;
        zz = z;
    
        rx = rx;
        ry = ry;
        rz = rz;
    }
    
    // public float x() { return _xx; }
    // public float y() { return _yy; }
    // public float z() { return _zz; }
    
    // public float rx() { return _rx; }
    // public void rx( float rx ) { _rx = rx; }

    // public float ry() { return _ry; }
    // public float rz() { return _rz; }

}

ArrayList<EPoint> eps = new ArrayList<EPoint>();
////////////////////////////////////////////////////////////////////////////////////////
PGraphics cubeA;
PGraphics cubeB;
PImage texture;
PVector pt;
int cX, cY;
float xx, yy = 0;


ArrayList<PVector> biggin = new ArrayList<PVector>();


void settings(){
    size(2000, 1000, P3D);
    smooth(8);
    pixelDensity(displayDensity());
    sketchSmooth();
}

void setup() {
  background(#EFEFEF);
  cX = (int)width/2;
  cY = (int)height/2;
  
  cubeA = createGraphics(300,300, P3D);
    
} 

void draw() {
  
  drawAndSave(cubeA, 100, 200, eps, xx, cY);
  image(cubeA, xx, cY);
 

  if( xx >= width && yy < height ){

    xx  = 0;
    yy += 180;

println("DOES THIS WORK?!?.............................");
println("biggin: "+eps.size());

    OBJExport obj = (OBJExport) createGraphics( width, height, "nervoussystem.obj.OBJExport", fix.pdeName()+".obj");
    obj.beginDraw();
    obj.pushMatrix();
    obj.beginShape();   //TRIANGLE_STRIP);

        for (int i = 0; i<eps.size(); i++)
        {
            obj.translate(i, cY);
            EPoint pv = (EPoint)eps.get(i);

            obj.rotateX(pv.rx);            
            obj.rotateY(pv.ry);
            obj.rotateX(pv.rz);
            obj.vertex( pv.xx, pv.yy, pv.zz );

            println(pv);
        }
    obj.endShape(CLOSE);
    obj.popMatrix();

    obj.endDraw();
    obj.dispose();



    save(this+".png");
    exit();


  } else if(xx >= width && yy > height){



    save(this+".png");
    exit();
  } else {
    xx++;

  }
}

void drawAndSave(PGraphics cube, float xd, float yd, ArrayList<EPoint> rt, float xx, float yy) {

    int vX = cube.width/2;
    int vY = cube.height/2;

    cube.beginDraw();
    cube.lights();
    cube.clear();
    /*
LIGHTEST - only the lightest colour succeeds: C = max(A*factor, B)

DIFFERENCE - subtract colors from underlying image.

EXCLUSION - similar to DIFFERENCE, but less extreme.

SCREEN - opposite multiply, uses inverse values of the colors.

REPLACE - the pixels entirely replace the others and don't utilize alpha (transparency) values
*/
// PShape pBox = cube.createShape( BOX, 80, vX, vY);
PShape pBox = cube.createShape( RECT, 90, 44, vX, vY);

    cube.blendMode(LIGHTEST);
    cube.translate(vX, vY);

    cube.strokeWeight(TWO_PI);
    cube.stroke(frameCount%255, xx%255, yy%255);
    cube.noFill();
    cube.rotateX(frameCount/xd);
    cube.rotateY(frameCount/yd);
    // cube.box(80);
    cube.shape(pBox);
    cube.endDraw();


    eps.add( new EPoint(vX, vY, 1, (frameCount/xd), (frameCount/yd), 0) );

    for(int vv = 0; vv <= pBox.getVertexCount(); vv++)
    {
        PVector pv = pBox.getVertex(vv);
// debug
println("pt: "+ pv.x + " : " + pv.y + " : " + pv.z);
        eps.add( new EPoint(pv.x+xx, pv.y+yy, pv.z, (frameCount/xd), (frameCount/yd), 0) );
    }
}
