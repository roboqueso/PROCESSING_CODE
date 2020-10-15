//
//  NOTE: this sketch is incomplete.  The goal is to generate OBJ files out of the wavey line
import nervoussystem.obj.*;
import fixlib.*;
Fixlib fix = Fixlib.init(this);
int strokin = 2;  // 1, 2, or 3 - adjust color

////////////////////////////////////////////////////////////////////////////////////////
public class EPoint {
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


void settings() {
  size(displayWidth, displayHeight, P3D);
  smooth(8);
  pixelDensity(displayDensity());
  sketchSmooth();
}

void setup() {
  background(#EFEFEF);
  cX = (int)width/2;
  cY = (int)height/2;

  cubeA = createGraphics(300, cY, P3D);
} 

void draw() {

  drawAndSave(cubeA, cubeA.width, cubeA.height, eps, xx+frameCount, cY+frameCount);
  
  image(  cubeA, 
          (frameCount%(displayWidth+cubeA.width))-cubeA.width, 
          frameCount%displayHeight );


  if ( xx >= (width+cubeA.width) && yy < height ) {

    xx  = 0;
    yy += 180;

    println("DOES THIS WORK?!?.............................");
    println("biggin: "+eps.size());

    //OBJExport obj = (OBJExport) createGraphics( 666, 666, "nervoussystem.obj.OBJExport", fix.pdeName()+".obj");
    //obj.beginDraw();
    //obj.pushMatrix();
    //obj.beginShape();   //TRIANGLE_STRIP);

    //for (int i = 0; i<eps.size(); i++)
    //{
    //  obj.translate(i, cY);
    //  EPoint pv = (EPoint)eps.get(i);

    //  obj.rotateX(pv.rx);            
    //  obj.rotateY(pv.ry);
    //  obj.rotateX(pv.rz);
    //  obj.vertex( pv.xx, pv.yy, pv.zz );

    //  println(pv);
    //}
    //obj.endShape(CLOSE);
    //obj.popMatrix();

    //obj.endDraw();
    //obj.dispose();



    save(this+"_"+frameCount+".png");
    //exit();
  } else if (xx >= (width+cubeA.width) && yy > height) {



    save(this+"_"+frameCount+".png");
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
  PShape pBox = cube.createShape( RECT, 90, 45, vX, vY);

  cube.blendMode(REPLACE);
  cube.translate(vX, vY);

  cube.strokeWeight(TWO_PI);
  
  switch(strokin){
    case 1:
      cube.stroke(frameCount%255, xx%255, yy%255);
      break;
      
    case 2:
      cube.stroke(xx%255, frameCount%255, yy%255);
      break;
  
    case 3:
      cube.stroke(xx%255, yy%255, frameCount%255);
      break;
  }

  cube.noFill();
  cube.rotateX(frameCount/xd);
  cube.rotateY(frameCount/yd);
  cube.shape(pBox);
  cube.endDraw();


  eps.add( new EPoint(vX, vY, 1, (frameCount/xd), (frameCount/yd), 0) );

  for (int vv = 0; vv <= pBox.getVertexCount(); vv++)
  {
    PVector pv = pBox.getVertex(vv);
    // debug
    println("pt: "+ pv.x + " : " + pv.y + " : " + pv.z);
    eps.add( new EPoint(pv.x+xx, pv.y+yy, pv.z, (frameCount/xd), (frameCount/yd), 0) );
  }
}


//  SIMPLE KEY HANDLER
void keyPressed(){
  
  switch(keyCode) 
  {
      case 's':
      case 'S':
      {
        save(this+"_"+frameCount+".png");
      }
      break;
  }
  

}
