//	NOTE: this sketch writes raw OBJs via PrintWrite and OBJ syntax
/*

v
vn
vt
f

  # List of geometric vertices, with (x, y, z [,w]) coordinates, w is optional and defaults to 1.0.
  v 0.123 0.234 0.345 1.0
  v ...
  ...
  # List of texture coordinates, in (u, [v ,w]) coordinates, these will vary between 0 and 1, v and w are optional and default to 0.
  vt 0.500 1 [0]
  vt ...
  ...
  # List of vertex normals in (x,y,z) form; normals might not be unit vectors.
  vn 0.707 0.000 0.707
  vn ...
  ...
  # Parameter space vertices in ( u [,v] [,w] ) form; free form geometry statement ( see below )
  vp 0.310000 3.210000 2.100000
  vp ...
  ...
  # Polygonal face element (see below)
  f 1 2 3
  f 3/1 4/2 5/3
  f 6/4/1 3/5/3 7/6/5
  f 7//1 8//2 9//3
  f ...
  ...
  # Line element (see below)
  l 5 8 1 2 4 9

*/
// https://github.com/ericfickes/FIXLIB	
// import nervoussystem.obj.*;
import fixlib.*;

Fixlib fix = Fixlib.init(this);
PShape ps;
int sz = 90;
int sx, sy;

/***/
void setup() {
  background(-1);
  size( displayWidth, displayHeight);
  smooth(8);
  pixelDensity(displayDensity());

  textSize(42);
  fill(#EF2018);
  text( fix.pdeName(), 11, height-100 );
}

/***/
void draw() {

  sx = (int) (frameCount*sz)%width;	//(frameCount*sz)%width+sz;
  sy = (int) (frameCount*sz)%height;	//random( (height/2)-sz, height-sz );//(int)(frameCount+sz+random(height));

  fill( sx, sy, (frameCount+PI)%90, 88);


  ps = fix.shapeJous( sx, sy, sz, 9 );

  // translate(sx, sy, sz);

  beginShape();
  	shape( ps );
  endShape();

  writeObj(ps);

  if (frameCount>44) {
    save(this+".tif");
    println("peace out");
    exit();
  }
}

/**
see:
	- http://www.martinreddy.net/gfx/3d/OBJ.spec   
	- http://paulbourke.net/dataformats/obj/ 
	- https://en.wikipedia.org/wiki/Wavefront_.obj_file
*/
private void writeObj(PShape mesh) {

  StringBuilder verts = new StringBuilder();
  StringBuilder faces = new StringBuilder();
  final int vertsNum = mesh.getVertexCount();
  // debug
  println("vertsNum: " +vertsNum );


  final PVector v1 = new PVector();
  final PVector v2 = new PVector();
  final PVector v3 = new PVector();

  for ( int i = 0; i<vertsNum; i+=3) {
    try {
      mesh.getVertex( i, v1);
      mesh.getVertex( (i+1)%vertsNum, v2);
      mesh.getVertex( (i+2)%vertsNum, v3);
// 	debug
// println("v1: "+ v1.x + " "+ v1.y  + " "+ v1.z );
// println("v2: "+ v2.x + " "+ v2.y  + " "+ v2.z );
// println("v3: "+ v3.x + " "+ v3.y  + " "+ v3.z );


  // # List of geometric vertices, with (x, y, z [,w]) coordinates, w is optional and defaults to 1.0.
  // v 0.123 0.234 0.345 1.0
  verts.append("v " +v1.x + " " + v1.y + " " + v1.z + " " + sz + "\n");
  verts.append("v " +v2.x + " " + v2.y + " " + v2.z + " " + sz + "\n");
  verts.append("v " +v3.x + " " + v3.y + " " + v3.z + " " + sz + "\n");
/*
  // # List of texture coordinates, in (u, [v ,w]) coordinates, these will vary between 0 and 1, v and w are optional and default to 0.
  // vt 0.500 1 [0]
  verts.append("vt " +v1.x + " " + v1.y + " " + sz + "\n");
  verts.append("vt " +v2.x + " " + v2.y + " " + sz + "\n");
  verts.append("vt " +v3.x + " " + v3.y + " " + sz + "\n");

  // # List of vertex normals in (x,y,z) form; normals might not be unit vectors.
  // vn 0.707 0.000 0.707
  verts.append("vn " +v1.x/100 + " " + v1.y/100 + " " + v1.z/100 + "\n");
  verts.append("vn " +v2.x/100 + " " + v2.y/100 + " " + v2.z/100 + "\n");
  verts.append("vn " +v3.x/100 + " " + v3.y/100 + " " + v3.z/100 + "\n");

  // # Parameter space vertices in ( u [,v] [,w] ) form; free form geometry statement ( see below )
  // vp 0.310000 3.210000 2.100000
  verts.append("vp " +v1.x + " " + v1.y + " " + sz + "\n");
  verts.append("vp " +v2.x + " " + v2.y + " " + sz + "\n");
  verts.append("vp " +v3.x + " " + v3.y + " " + sz + "\n");
*/



  // # Polygonal face element (see below)
  // f 1 2 3
  // f 3/1 4/2 5/3
  // f 6/4/1 3/5/3 7/6/5


      // f v1[/vt1][/vn1] v2[/vt2][/vn2] v3[/vt3][/vn3] ...
          // f 1/1/1 2/2/2 3//3 4//4

      verts.append("f " +i+"/"+i+"/"+i+ " " +(i+2)+"/"+(i+2)+"/"+(i+2)+ " "  +(i+3)+"/"+(i+3)+"/"+(i+3) + "\n");

      PrintWriter output = createWriter(fix.pdeName()+frameCount+".obj");

      //	NOTE: optional?
      output.println("o Shape: \n");
      // output.println("g: \n");
      output.println("s 1 \n");

      output.println(verts);
      output.println(faces);
      output.flush();
      output.close();
    } 
    catch( Exception exc ) {
      println("Exception i+2 : " + exc.getMessage() );
    }
  }
}
