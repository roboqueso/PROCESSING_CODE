//  SEE:   https://ello.co/ericfickes/post/ar97gf_wsduyrjs-egppvq     
//  GOTO:  https://github.com/ericfickes/FIXLIB
import org.processing.wiki.triangulate.*;
import fixlib.*;

/*
ClickTheJewelz : Using a custom Triangulate JAVA class from Inspired by https://discourse.processing.org/t/fill-a-mesh-delaunay-object/3341/2

click to generate a jewel

*/
Fixlib fix = Fixlib.init(this);

boolean debug = false;
int numPoints = 10;
int dimension = 200;

int maxFrameNum = 1080;


ArrayList<PVector> newPosition;
ArrayList<Triangle> triangles;
ArrayList<PShape> shapes;

  float orbitRadius;//= mouseX/2+50;
  float ypos;//= mouseY/3;
  float xpos;//= cos(radians(rotation))*orbitRadius;
  float zpos;//= sin(radians(rotation))*orbitRadius;

void settings(){
  size(displayWidth, displayHeight, P3D);
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}


void setup() {

  hint(DISABLE_DEPTH_TEST);  
  newPosition = new ArrayList<PVector>();
  triangles = new ArrayList<Triangle>();
  shapes = new ArrayList<PShape>();

  // TODO: pre pick, or pre-inflate ArrayList???
  for (int i = 0; i < numPoints * 2; i++) {
    PVector newVector = new PVector((int) random(dimension), (int) random(dimension), i);
    newPosition.add(newVector);
  }
}


void draw() {
  
  //  calculate camera position
  orbitRadius= (mouseX/2)+75; // OG : /2+50
  ypos= mouseY;///HALF_PI;  // OG : 3
  xpos= cos(radians(frameCount))*orbitRadius;
  zpos= sin(radians(frameCount))*orbitRadius;
  
  perspective();  
  hint(DISABLE_DEPTH_TEST);
  camera(xpos, ypos, zpos, 0, 0, 0, 0, -1, 0);
  lights(); //    because P3D
  
  //  debug
  if(debug){
    noFill();
    stroke(frameCount%255);
    box(75);
  }
  
  //  ENDER
  if(frameCount>maxFrameNum)
  {
    String saveName = fix.pdeName() + "-" + fix.getTimestamp();
    save( saveName +".png" );
    exit();
  }

  //  text
   if(frameCount%420==0){
    text("Click me " + frameCount, random(width), random(height) );
   }
   
}



/**
Drop a JEWEL on stage
*/
void mousePressed() {
  
  for (int i = 0; i < numPoints * 2; i++) {
    //PVector newVector = new PVector((int) random(width-TWO_PI), (int) random(height-TWO_PI));
    PVector newVector = new PVector((int) random(mouseX), (int) random(mouseY), i);
    newPosition.set(i, newVector);
  }
  
  triangles = Triangulate.triangulate(newPosition);
  
  PShape tria = createShape();
  
  float lx=0;
  float ly=0;
  float lz=0;
  
  
  tria.beginShape();
  for (Triangle t : triangles) {
  
    
    lx = t.p1.x%255;
    ly = t.p1.y%255;
    lz = frameCount%255; 
    
    tria.fill(t.p1.x, t.p1.y, random(255));
    tria.stroke(t.p1.x, t.p1.y, frameCount%255 );
    tria.vertex(t.p1.x, t.p1.y);

    tria.fill(t.p2.x, random(255), t.p2.y);
    tria.stroke(t.p2.x, frameCount%255, t.p2.y);
    tria.vertex(t.p2.x, t.p2.y);

    tria.fill(random(255), t.p3.x, t.p3.y);
    tria.stroke(frameCount%255, t.p3.x, t.p3.y);
    tria.vertex(t.p3.x, t.p3.y);
  }
  tria.endShape();



// lights
//ambientLight( lx, ly, lz );
//emissive( lx, ly, lz );
//specular( lx, ly, lz );


//  MOVE CAMERA
  perspective();
  camera(xpos, ypos, zpos, 0, 0, 0, 0, -1, 0);

  
  //  DROP IT!
  shape(tria);
  
  tria = null;
  
}
