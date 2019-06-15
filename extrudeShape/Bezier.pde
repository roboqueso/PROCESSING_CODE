class Bezier {
  final static String toStrFmt = "(%4.2f, %4.2f, %4.2f,\n"
    + " %4.2f, %4.2f, %4.2f,\n"
    + " %4.2f, %4.2f, %4.2f,\n"
    + " %4.2f, %4.2f, %4.2f)\n";

  PVector[] pt = {new PVector(), new PVector(), 
    new PVector(), new PVector()};

  Bezier() {
  }

  Bezier(PVector a0, PVector c0, 
    PVector c1, PVector a1) {
    set(a0.x, a0.y, a0.z, 
      c0.x, c0.y, c0.z, 
      c1.x, c1.y, c1.z, 
      a1.x, a1.y, a1.z);
  }

  Bezier(float a0x, float a0y, 
    float c0x, float c0y,
    float c1x, float c1y,
    float a1x, float a1y) {
    set(a0x, a0y, 0, 
      c0x, c0y, 0, 
      c1x, c1y, 0, 
      a1x, a1y, 0);
  }

  Bezier(float a0x, float a0y, float a0z, 
    float c0x, float c0y, float c0z, 
    float c1x, float c1y, float c1z,
    float a1x, float a1y, float a1z) {
    set(a0x, a0y, a0z, 
      c0x, c0y, c0z, 
      c1x, c1y, c1z, 
      a1x, a1y, a1z);
  }

  String toString() {
    return String.format(toStrFmt, 
      pt[0].x, pt[0].y, pt[0].z, 
      pt[1].x, pt[1].y, pt[1].z, 
      pt[2].x, pt[2].y, pt[2].z, 
      pt[3].x, pt[3].y, pt[3].z);
  }

  void set(PVector a0, PVector c0, 
    PVector c1, PVector a1) {
    pt[0].set(a0);
    pt[1].set(c0);
    pt[3].set(a1);
    pt[2].set(c1);
  }

  void set(float a0x, float a0y, float a0z, 
    float c0x, float c0y, float c0z,
    float c1x, float c1y, float c1z,
    float a1x, float a1y, float a1z) {
    pt[0].set(a0x, a0y, a0z);
    pt[1].set(c0x, c0y, c0z);
    pt[2].set(c1x, c1y, c1z);
    pt[3].set(a1x, a1y, a1z);
  }

  Bezier copy() {
    return new Bezier(pt[0], pt[1], pt[2], pt[3]);
  }

  void draw() {
    draw((PGraphicsOpenGL)g);
  }

  void draw(PApplet pa) {
    pa.g.bezier(pt[0].x, pt[0].y, pt[0].z, 
      pt[1].x, pt[1].y, pt[1].z, 
      pt[2].x, pt[2].y, pt[2].z, 
      pt[3].x, pt[3].y, pt[3].z);
  }

  void draw(PGraphicsOpenGL pg) {
    pg.bezier(pt[0].x, pt[0].y, pt[0].z, 
      pt[1].x, pt[1].y, pt[1].z, 
      pt[2].x, pt[2].y, pt[2].z, 
      pt[3].x, pt[3].y, pt[3].z);
  }

  PVector getPoint(float st) {
    st = st < 0 ? 0 : st > 1 ? 1 : st;
    float inv = 1 - st;
    float inv2 = inv * inv;
    float st2 = st * st;
    return PVector.mult(pt[0], inv2 * inv)
      .add(PVector.mult(pt[1], 3 * inv2 * st))
      .add(PVector.mult(pt[2], 3 * inv * st2))
      .add(PVector.mult(pt[3], st * st2));
  }

  PVector getTangent(float st) {
    st = st < 0 ? 0 : st > 1 ? 1 : st;
    float inv = 1 - st;
    return PVector.sub(pt[1], pt[0]).mult(3 * inv * inv)
      .add(PVector.sub(pt[2], pt[1]).mult(6 * inv * st))
      .add(PVector.sub(pt[3], pt[2]).mult(3 * st * st));
  }

  Transform getTransform(float st) {
    PVector point = getPoint(st);

    PVector zaxis = getTangent(st).normalize();

    PVector yaxis = new PVector();
    PVector.cross(point, zaxis, yaxis);
    yaxis.normalize();

    PVector xaxis = new PVector();
    PVector.cross(yaxis, zaxis, xaxis);
    xaxis.normalize();

    return new Transform(point, xaxis, yaxis, zaxis);
  }
}
