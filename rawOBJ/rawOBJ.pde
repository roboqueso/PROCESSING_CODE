//	NOTE: this sketch writes raw OBJs via PrintWrite and OBJ syntax

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


  fill(random(frameCount%width), random(height), (frameCount+PI)%90, 88);
  sx = (int)(frameCount*TWO_PI)%width+sz;
  sy = frameCount%height;//(int)(frameCount+sz+random(height));

  ps = fix.shapeJous( sx, sy, sz, 4 );

  translate(sx, sy, sz);

  beginShape();
  	shape( ps );
  endShape();

  hamoidExport(ps);

  if (frameCount>11) {
    save(this+".tif");
    println("peace out");
    exit();
  }
}

// from @hamoid
//	https://twitter.com/hamoid/status/816682493793472512
private void hamoidExport(PShape mesh) {

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
      mesh.getVertex(i, v1);
      mesh.getVertex( (i+1)%vertsNum, v2);
      mesh.getVertex( (i+2)%vertsNum, v3);
// 	debug
println("v1: "+ v1.x + " "+ v1.y  + " "+ v1.z );
println("v2: "+ v2.x + " "+ v2.y  + " "+ v2.z );
println("v3: "+ v3.x + " "+ v3.y  + " "+ v3.z );

      verts.append("v " +v1.x + " " + v1.y + " " + v1.z + "\n");
      verts.append("v " +v2.x + " " + v2.y + " " + v2.z + "\n");
      verts.append("v " +v3.x + " " + v3.y + " " + v3.z + "\n");

      verts.append("vn " +v1.x + " " + v1.y + " " + v1.z + "\n");
      verts.append("vn " +v2.x + " " + v2.y + " " + v2.z + "\n");
      verts.append("vn " +v3.x + " " + v3.y + " " + v3.z + "\n");


      verts.append("vp " +v1.y + " " + v1.z + " " + v1.x + "\n");
      verts.append("vp " +v2.y + " " + v2.z + " " + v2.x + "\n");
      verts.append("vp " +v3.y + " " + v3.z + " " + v3.x + "\n");

      // f v1[/vt1][/vn1] v2[/vt2][/vn2] v3[/vt3][/vn3] ...
      verts.append("f " + i + " " + (i+1) + " " + (i+2) + "\n");

      PrintWriter output = createWriter(mesh+".obj");

      //	NOTE: optional?
      // output.println("o Sphere: \n");
      output.println("g: \n");
      // output.println("s 1 \n");

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
