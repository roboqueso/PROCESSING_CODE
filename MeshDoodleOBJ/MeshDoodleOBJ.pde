//  RTFM, this originated as a sample
//  NOTE: this code is loosy goosy globals and shit
//  get it rockin, come back and ellegantify

import fixlib.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import java.util.Iterator;


Fixlib fix = Fixlib.init(this);
TriangleMesh mesh;

Vec3D prev=new Vec3D();
Vec3D p=new Vec3D();
Vec3D q=new Vec3D();
Vec3D a=new Vec3D();
Vec3D b = new Vec3D();
Vec2D rotation=new Vec2D();

float weight=0;
PVector tmpV;


//////////////////////////////////////////////////////////////////////////////
void setup() {
  size(displayWidth, displayHeight,P3D);
  // start here
  mesh = new TriangleMesh("doodle");
}

//////////////////////////////////////////////////////////////////////////////
void draw() {
  background(0);
  lights();
  translate(width/2,height/2, 1 );
  rotateX(rotation.x);
  rotateY(rotation.y);
  //rotateX(frameCount);
  noStroke();

  // draw the MESH
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
  rotation.addSelf(0.001,0.000);
}

void vertex(Vec3D v) {
  vertex(v.x,v.y,v.z);
}


//////////////////////////////////////////////////////////////////////////////
//  RECORD the mesh
void mouseMoved() {
  // get 3D rotated mouse position
  Vec3D pos=new Vec3D(mouseX-width/2,mouseY-height/2, 1);
  pos.rotateX(rotation.x);
  pos.rotateY(rotation.y);
  
  weight = mouseX - pmouseX;
  // use distance to previous point as target stroke weight
  weight+=(sqrt(pos.distanceTo(prev))*2-weight)*0.1;
  // define offset points for the triangle strip
  Vec3D a=pos.add(pos.x+weight, pos.y+weight, pos.z+weight);
  Vec3D b=pos.add(pos.x-weight, pos.y-weight, pos.z-weight);

  
//TODO: use mouseX, mouseY as center point of "extrusion"  
  //// add 2 faces to the mesh
  
  mesh.addFace(pos,a,b);
  mesh.addFace(pos,b,a);

  mesh.addFace(pos,a,q);
  mesh.addFace(pos,q,a);

  mesh.addFace(pos,b,q);
  mesh.addFace(pos,q,b);

//  X
  a=pos.add(pos.x+TWO_PI, pos.y-TWO_PI, pos.z+TWO_PI);
  b=pos.add(pos.x-TWO_PI, pos.y+TWO_PI, pos.z-TWO_PI);
  mesh.addFace(pos,a,b);
  mesh.addFace(pos,b,a);

  mesh.addFace(pos,a,q);
  mesh.addFace(pos,q,a);

  mesh.addFace(pos,b,q);
  mesh.addFace(pos,q,b);


//  Y
  a=pos.add(pos.x-TWO_PI, pos.y+TWO_PI, pos.z-TWO_PI);
  b=pos.add(pos.x+TWO_PI, pos.y-TWO_PI, pos.z+TWO_PI);
  mesh.addFace(a,b,pos);
  mesh.addFace(b,a,pos);

  mesh.addFace(a,q,pos);
  mesh.addFace(q,a,pos);

  mesh.addFace(b,q,pos);
  mesh.addFace(q,b,pos);

  // TEST
  //for( int aa = 15; aa <= 360; aa +=15 )
  //{
  
  //  tmpV = fix.circleXY( pos.x, pos.y, weight, aa );
    
  //  a = pos.add( tmpV.x, tmpV.y, weight+ tmpV.z );
    
  //  tmpV = fix.circleXY( pos.x, pos.y, weight, 90 );
    
  //  b = pos.add( tmpV.x, tmpV.y, weight-tmpV.z );
  
  //  //// add 2 faces to the mesh
  //  mesh.addFace(a,b, pos);
  //  mesh.addFace(b,a, pos);
  //}



  // store current points for next iteration
  prev=pos;
  p=a;
  q=b;
  
  
  // TODO: sub out FIXLIB coordinate generation
//  tmpVect = fix.GetRandVector( float x, float y, float sz )
//  tmpVect = fix.circleXY( float centerX, float centerY, float radius, float angle )
//  tmpVect = juiceXY( x, y, z );  // local beta function
  
  //tmpV = fix.circleXY( pos.x, pos.y, weight, 45 );
  //a=pos.add( tmpV.x, tmpV.y, weight+ tmpV.z );
  //tmpV = fix.circleXY( pos.x, pos.y, weight, 90 );
  //b=pos.add( tmpV.x, tmpV.y, weight-tmpV.z );
  
  ////// add 2 faces to the mesh
  //mesh.addFace(pos,a,b);
  //mesh.addFace(pos,b,a);

  //mesh.addFace(pos,a,q);
  //mesh.addFace(pos,q,a);

  //mesh.addFace(pos,b,q);
  //mesh.addFace(pos,q,b);

  //tmpV = fix.circleXY( pos.x, pos.y, weight, 135 );
  //a=pos.add( tmpV.x, tmpV.y, weight+ tmpV.z );
  //tmpV = fix.circleXY( pos.x, pos.y, weight, 180 );
  //b=pos.add( tmpV.x, tmpV.y, weight-tmpV.z );
  
  ////// add 2 faces to the mesh
  //mesh.addFace(pos,a,b);
  //mesh.addFace(pos,b,a);

  //mesh.addFace(pos,a,q);
  //mesh.addFace(pos,q,a);

  //mesh.addFace(pos,b,q);
  //mesh.addFace(pos,q,b);

  
    
  //tmpV = juiceXY( pos.x, pos.y, weight );
  //a=pos.add( tmpV.x, tmpV.y, weight+ tmpV.z );
  //tmpV = juiceXY( pos.x, pos.y, weight*.25 );
  //b=pos.add( tmpV.x, tmpV.y, weight-tmpV.z );

  
  ////// add 2 faces to the mesh
  //mesh.addFace(a,b,q);
  //mesh.addFace(a,q,b);

  //// store current points for next iteration
  //prev=pos;
  //p=a;
  //q=b;
}


//////////////////////////////////////////////////////////////////////////////
void keyPressed() {
  if (key=='s') {

    mesh.saveAsOBJ( sketchPath(fix.pdeName()+fix.getTimestamp()+".obj"));

    //  RESET MESH
    mesh = new TriangleMesh("doodle");
  } 
  else {
    mesh.clear();
  }
}


//  EXPERIMENTAL X,Y PVector generator

  //////////////////////////////////////////////////////
  //
  // TODO: get this working, move into FIXLIB
  PVector juiceXY(float a, float b, float amp )
  {
    //  float amp = 33;
    float x, y;
    float sz = amp / PI;  //TWO_PI;
    int t = (int)random( (amp%360), 360 );

    //for ( float t = 0; t <= 360; t += 1)
    //{
      x = a - amp * PApplet.sin(a * t * PI/180);
      y = b - amp * PApplet.sin(b * t * PI/180);
      
      return new PVector( x, y, t );
    //  app.noFill();
    //  app.ellipse(x, y, sz, sz);
    //}
  }
