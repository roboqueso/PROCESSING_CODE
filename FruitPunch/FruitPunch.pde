
import fixlib.*;
Fixlib fix = Fixlib.init(this);

int strokin = 3;  // 1, 2, or 3 - adjust color
int min = 45;
int max = 666;
boolean saveFrames = false; // saves to frames/THIS

/*
DIFFERENCE - subtract colors from underlying image.
EXCLUSION - similar to DIFFERENCE, but less extreme

REPLACE - the pixels entirely replace the others and don't utilize alpha (transparency) values
++ BREAKS TRANSPARENT PGRAPHICS, still might be interesting

SUBTRACT - subtractive blending with black clip: C = max(B - A*factor, 0)
* duper dark

DARKEST - only the darkest color succeeds: C = min(A*factor, B)

MULTIPLY - multiply the colors, result will always be darker

BLEND - linear interpolation of colors: C = A*factor + B. This is the default.
*/
public static int BLMODE = DIFFERENCE;
public static int BGCLR = 0;
int innerMin = 32;
Boolean clear = false; //  clean child PGraphic before draw

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
  sketchSmooth(); //  WTF does this do?
}

void setup() {
  background(BGCLR,innerMin);
  blendMode( BLMODE );
  // rectMode(CENTER);

  cX = (int)displayWidth/2;
  cY = (int)displayHeight/2;

  cubeA = recycle(null);
  cubeB = recycle(null);

} 

void draw() {

  drawAndSave(cubeA, cubeA.width, cubeA.height, eps, xx+frameCount+randomGaussian()+noise(frameCount), (cY-frameCount-randomGaussian())%displayHeight );
  image(  cubeA, 
          (frameCount%(displayWidth+cubeA.width))-cubeA.width, 
          frameCount%displayHeight );


  drawAndSave(cubeB, cubeB.height, cubeB.width, eps, (cY-frameCount-randomGaussian()), (xx+frameCount+randomGaussian()+noise(frameCount))%displayHeight );
  image(  cubeB, 
          (frameCount%(displayWidth+cubeB.width))-cubeB.width, 
          (displayHeight-frameCount)%displayHeight );


  if ( xx >= (displayWidth+cubeA.width) && yy < height ) {

    xx  = 0;
    yy += 180;


//  BETA BACON
//  stamp the canvas before resetting 
    println("GITIT BEACH!!!!!!!!!!!!!!!!!!!!!.............................");
    println("biggin: "+eps.size());

    
  switch(strokin){
    case 1:
      stroke(frameCount%255, xx%255, yy%255);
      break;
      
    case 2:
      stroke(xx%255, frameCount%255, yy%255);  
      break;
  
    case 3:
      stroke(xx%255, yy%255, frameCount%255);
      break;
  }

    beginShape();
    pushMatrix();  
  //  THIS POINT DUMP NEEDS A FIXIN
    EPoint lastPv = new EPoint(0,0,0,0,0,0);
    for (int i = 0; i<eps.size(); i++)
    {
//  HACKY UNIQUE CHECK

      EPoint pv = (EPoint)eps.get(i);
      
      if( (lastPv.rx != pv.rx) &&  (lastPv.ry != pv.ry) &&  (lastPv.rz != pv.rz) ) 
      {
        translate( pv.rx, pv.ry, pv.rz );

        rotateX(pv.rx);            
        rotateY(pv.ry);
        rotateX(pv.rz);
        vertex( pv.xx, pv.yy, pv.zz );
  
        // keep track of previous point
        lastPv = pv;
      } else {
//println("SAME POINT FOUND");
      }
    }
    popMatrix();
    endShape();
 

//  END BETA BACON

    sv();
    cubeA = recycle(cubeA);
    cubeB = recycle(cubeB);


  } else if (xx >= (displayWidth+cubeA.width) && yy > height) {
    
    exit();
  } else {
    xx++;
  }

if(saveFrames){
  //  TEST : save frame, reassemble in QT??
  saveFrame("frames/"+this+"######.tiff"); //  tiff are hotter, but 21MB each
}

}


PGraphics recycle(PGraphics g)
{
  if(null!=g)
   g = null;
  return createGraphics( (int)random(min, max), (int)random(min,max), P3D);
}


//  master PNG saver
void sv(){
  save(this+"_"+strokin+"_"+BLMODE+"_"+BGCLR+"_"+frameCount+".tiff");
}

void drawAndSave(PGraphics cube, float xd, float yd, ArrayList<EPoint> rt, float xx, float yy) {

  int vX = cube.width/2;
  int vY = cube.height/2;
  
  cube.beginDraw();
  if(clear) cube.clear();
  cube.background(BGCLR,0); // clear background with color??
  cube.blendMode( BLMODE );
  cube.camera();
  cube.lights();
  // cube.rectMode(CENTER);
  cube.smooth(8);
  cube.strokeCap(ROUND);
  cube.strokeJoin(ROUND);
  cube.strokeWeight(HALF_PI);
  cube.translate( vX, vY );
  
  
  // Haveen't decided which shape is best, but TRIANGLE is the current hotness
    //PShape pBox = cube.createShape( RECT, 0,0,cube.width, cube.height );
    //PShape pBox = cube.createShape( BOX, vY );
    PShape pBox = cube.createShape( RECT, 0,0,cube.width, cube.height, cube.width*.5, cube.height*.5, cube.width*.25, cube.height*.25 );



  
  switch(strokin){
    case 1:
      cube.ambientLight(frameCount%255, xx%255, yy%255 );
      cube.emissive(frameCount%255, xx%255, yy%255 );
      cube.specular(frameCount%255, xx%255, yy%255 );

      //cube.fill(frameCount%255, xx%255, yy%255, (frameCount%innerMin) );
      cube.stroke(frameCount%255, xx%255, yy%255 );
      break;
      
    case 2:
      cube.ambientLight(xx%255, frameCount%255, yy%255 );
      cube.emissive(xx%255, frameCount%255, yy%255 );
      cube.specular(xx%255, frameCount%255, yy%255 );
      
      //cube.fill(xx%255, frameCount%255, yy%255, (frameCount%innerMin) );
      cube.stroke(xx%255, frameCount%255, yy%255 );
      break;
  
    case 3:
      cube.ambientLight(xx%255, yy%255, frameCount%255 );
      cube.emissive(xx%255, yy%255, frameCount%255 );
      cube.specular(xx%255, yy%255, frameCount%255 );

      //cube.fill(xx%255, yy%255, frameCount%255, (frameCount%innerMin) );
      cube.stroke(xx%255, yy%255, frameCount%255 );
      break;
  }

  cube.noFill();
  //cube.rotateX(frameCount/xd);
  //cube.rotateY(frameCount/yd);
  cube.rotateX(frameCount/xd);
  cube.rotateY(frameCount/yd);
  cube.shape(pBox);
  cube.endDraw();

  eps.add( new EPoint(vX+(frameCount/xd), vY+(frameCount/yd), frameCount%xd, frameCount%xd, vY+(frameCount/yd), vX+(frameCount/xd)  ) );

  for (int vv = 0; vv < pBox.getVertexCount(); vv++)
  {
    PVector pv = pBox.getVertex(vv);
    // debug
    println("pt: "+ pv.x + " : " + pv.y + " : " + pv.z);
    eps.add( new EPoint(pv.x+xx, pv.y+yy, pv.z, pv.z, pv.x+xx, pv.y+yy ) );
  }
}


//  SIMPLE KEY HANDLER
void keyPressed(){
  
  switch(keyCode) 
  {
      case 's':
      case 'S':
      {
        sv();
      }
      break;
  }
  

}



////////////////////////////////////////////////////////////////////////////////////////
public class EPoint {
  public float xx = 0;
  public float yy = 0;
  public float zz = 0;

  public float rx = 0;
  public float ry = 0;
  public float rz = 0;

  EPoint(float x, float y, float z , float rx, float ry, float rz)
  {
    xx = x;
    yy = y;
    zz = z;
    rx = x;
    ry = y;
    rz = z;
  }
}
