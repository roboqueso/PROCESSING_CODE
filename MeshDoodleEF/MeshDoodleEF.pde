
import toxi.geom.*;
import toxi.geom.mesh.*;
import java.util.Iterator;

TriangleMesh mesh=new TriangleMesh("doodle");

Vec3D prev=new Vec3D();
Vec3D p=new Vec3D();
Vec3D q=new Vec3D();

Vec2D rotation=new Vec2D();

float weight=0;

void setup() {
  size(600,600,P3D);
}

void draw() {
  background(0);
  lights();
  translate(width/2,height/2,0);
  rotateX(rotation.x);
  rotateY(rotation.y);
  noStroke();
  beginShape(TRIANGLES);
  // iterate over all faces/triangles of the mesh
  for(Iterator i=mesh.faces.iterator(); i.hasNext();) {
    Face f=(Face)i.next();
    // create vertices for each corner point
    vertex(f.a);
    vertex(f.b);
    vertex(f.c);
  }
  endShape();
  // udpate rotation
  //rotation.addSelf(0.014,0.0237);
  rotation.addSelf(0.0,0.024);
}


void vertex(Vec3D v) {
  vertex(v.x,v.y,v.z);
}


void mouseMoved() {
  // get 3D rotated mouse position
  Vec3D pos = new Vec3D(mouseX-width/2,mouseY-height/2,0);
    pos.rotateX(rotation.x);
    pos.rotateY(rotation.y);
    
    // use distance to previous point as target stroke weight
    weight+=(sqrt(pos.distanceTo(prev))*2-weight)*0.1;
    
  // define offset points for the triangle strip
  Vec3D a=pos.add( -(weight/2), PI, 0 );
  Vec3D b=pos.add( (weight/2), -TWO_PI, 0 );

  // add faces
  mesh.addFace(p,b,q);
  mesh.addFace(p,a,b);

  
  mesh.addFace(q,b,p);
  mesh.addFace(b, a, q);
  
  //mesh.addFace( a, p, b );
  //mesh.addFace( p, b, a );
  
  /////  
  //a = pos.add( TWO_PI, -(weight/2), 0 );
  //b = pos.add( TWO_PI, (weight/2), 0 );


  //mesh.addFace( a, b, q );
  //mesh.addFace( b, a, q );
///  

  // store current points for next iteration
  prev=pos;
  p=a;
  q=b;
  

}

void keyPressed() {
  if (key=='s') {
    mesh.saveAsOBJ(sketchPath( this+""+millis()+"MdEF.obj") );
    mesh.clear();
    //mesh.saveAsSTL(sketchPath("doodle.stl"));
  } 
}
