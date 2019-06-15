int linearDetail = 4;
int radialDetail = 6;
PGraphicsOpenGL pogl;

/* ... */
Bezier curve = new Bezier();
int detail = 18;
Transform[] ts = new Transform[detail];
float sclr = 1.1;
Transform trns;

PImage txtr;
PVector[][] sduvs = new PVector[linearDetail][radialDetail + 1];
PVector[][] vs = new PVector[linearDetail][radialDetail];
PVector[] cpuvs = new PVector[radialDetail];
PVector uvOff = new PVector();
float uvScl = 1;
float uvRot = 0;

void setup() {
  /* ... */
  size(666, 666, P3D);
  pogl = (PGraphicsOpenGL)g;
  //txtr = loadImage("uvGridClr.png");
  textureMode(NORMAL);
  textureWrap(REPEAT);
}

void draw() {
  uvOff.add(.01, .01);

  if( frameCount > 43 )
  {
        endRecord();
    save(this+".png");
    exit();

  }
}

void setVertices() {

  int rdDtlf = 6;
    float t = PI;


  for (int j = 0; j < radialDetail; ++j) {
    /* ... */
    cpuvs[j] = new PVector(cos(t) * .5 + .5, 
      sin(t) * .5 + .5);
    cpuvs[j].rotate(uvRot).add(uvOff).mult(uvScl);
  }
  
  for (int i = 0, j; i < linearDetail; ++i) {
    /* ... */
    for (j = 0; j < radialDetail + 1; ++j) {
      float istp, jstp;
      istp = 1.1;
      if (j < radialDetail) {
        jstp = j / rdDtlf;
        
        //float t = TWO_PI * jstp;
        t = TWO_PI * jstp;
        

        vs[i][j] = trns.model(pogl, 
          cos(t) * sclr, sin(t) * sclr, 0);
      }
      jstp = j / rdDtlf;
      sduvs[i][j] = new PVector(istp, jstp);
      sduvs[i][j].rotate(uvRot).add(uvOff).mult(uvScl);
    }
  }
}

void drawCaps(int i) {
  beginShape(TRIANGLE_FAN);
  //texture(txtr);
  for (int j = 0; j < radialDetail; ++j) {
    vertex(vs[i][j].x, vs[i][j].y, vs[i][j].z, 
      cpuvs[j].x, cpuvs[j].y);
  }
  endShape(CLOSE);
}

void drawTube() {
  for (int i = 0, j; i < linearDetail; ++i) {
    for (j = 0; j < radialDetail; ++j) {
      /* ... */
      beginShape(QUADS);
      texture(txtr);
      vertex(vs[i][j].x, vs[i][j].y, vs[i][j].z, 
        sduvs[i][j].x, sduvs[i][j].y);
      vertex(vs[i][j].x, vs[i][j].y, vs[i][j].z, 
        sduvs[i][j].x, sduvs[i][j].y);
      vertex(vs[i][j].x, vs[i][j].y, vs[i][j].z, 
        sduvs[i][j].x, sduvs[i][j].y);
      vertex(vs[i][j].x, vs[i][j].y, vs[i][j].z, 
        sduvs[i][j].x, sduvs[i][j].y);
      endShape();
    }
  }
}

// Helper function to model and screen.
PVector convertCoord(PMatrix3D a, PMatrix3D b, float... arr) {
  float[] c = new float[4];
  float[] d = new float[4];
  a.mult(arr, c);
  b.mult(c, d);

  if (d[3] != 0 && d[3] != 1) {
    d[0] /= d[3];
    d[1] /= d[3];
    d[2] /= d[3];
  }

  return new PVector(d[0], d[1], d[2]);
}

PVector model(PGraphicsOpenGL pogl, float x, float y, float z) {
  return convertCoord(pogl.modelview, pogl.cameraInv, x, y, z, 1);
}

PVector screen(PGraphicsOpenGL pogl, float x, float y, float z) {
  PVector o = convertCoord(pogl.modelview, pogl.projection, x, y, z, 1);
  return new PVector(pogl.width * (1 + o.x) * .5,
    pogl.height - (pogl.height * (1 + o.y) * .5),
    (1 + o.z) * .5);
}

PVector model(PGraphicsOpenGL pogl, PVector v) {
  return model(pogl, v.x, v.y, v.z);
}

PVector model(PGraphicsOpenGL pogl, float x, float y) {
  return model(pogl, x, y, 0);
}

PVector screen(PGraphicsOpenGL pogl, PVector v) {
  return screen(pogl, v.x, v.y, v.z);
}

PVector screen(PGraphicsOpenGL pogl, float x, float y) {
  return screen(pogl, x, y, 0);
}


