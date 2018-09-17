import org.processing.wiki.triangulate.*;

/*

Inspired by https://discourse.processing.org/t/fill-a-mesh-delaunay-object/3341/2

*/


int numPoints = 10;
int dimension = 200;

ArrayList<PVector> newPosition;
ArrayList<Triangle> triangles;
ArrayList<PShape> shapes;


void setup() {
  size(1920, 1080, P3D);
  hint(DISABLE_DEPTH_TEST);
  newPosition = new ArrayList<PVector>();
  triangles = new ArrayList<Triangle>();
  shapes = new ArrayList<PShape>();

  for (int i = 0; i < numPoints * 2; i++) {
    PVector newVector = new PVector((int) random(dimension), (int) random(dimension));
    newPosition.add(newVector);
  }
}


void draw() {
  //background(255);
  for (int i = 0; i < shapes.size(); i++) 
  {
    shape(shapes.get(i));
  }
}

void mousePressed() {
  
  for (int i = 0; i < numPoints * 2; i++) {
    //PVector newVector = new PVector((int) random(width-TWO_PI), (int) random(height-TWO_PI));
    PVector newVector = new PVector((int) random(mouseX), (int) random(mouseY));
    newPosition.set(i, newVector);
  }
  
  triangles = Triangulate.triangulate(newPosition);
  
  PShape tria = createShape();
  tria.beginShape();
  for (Triangle t : triangles) {
    
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

  shapes.add(tria);
}
