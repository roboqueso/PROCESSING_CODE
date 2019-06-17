class Transform {
  final static String toStrFmt =
    "(%.2f, %.2f, %.2f, %.2f,\n"
    + " %.2f, %.2f, %.2f, %.2f,\n"
    + " %.2f, %.2f, %.2f, %.2f,\n"
    + " %.2f, %.2f, %.2f, %.2f)\n";

  PMatrix3D m = new PMatrix3D();

  Transform() {
  }

  Transform(PVector pt, PVector right,
    PVector up, PVector forward) {
    set(pt, right, up, forward);
  }

  String toString() {
    return String.format(toStrFmt,
      m.m00, m.m01, m.m02, m.m03,
      m.m10, m.m11, m.m12, m.m13,
      m.m20, m.m21, m.m22, m.m23,
      m.m30, m.m31, m.m32, m.m33);
  }

  boolean equals(Object o) {
    return m.equals(o);
  }

  int hashCode() {
    return m.hashCode();
  }

  void set(PMatrix3D n) {
    set(n.m00, n.m01, n.m02, n.m03,
      n.m10, n.m11, n.m12, n.m13,
      n.m20, n.m21, n.m22, n.m23,
      n.m30, n.m31, n.m32, n.m33);
  }

  void set(PVector pt, PVector x,
    PVector y, PVector z) {
    set(x.x, y.x, z.x, pt.x,
      x.y, y.y, z.y, pt.y,
      x.z, y.z, z.z, pt.z,
      0, 0, 0, 1);
  }

  void set(float m00, float m01, float m02, float m03,
    float m10, float m11, float m12, float m13,
    float m20, float m21, float m22, float m23,
    float m30, float m31, float m32, float m33) {
    m.set(m00, m01, m02, m03,
      m10, m11, m12, m13,
      m20, m21, m22, m23,
      m30, m31, m32, m33);
  }

  void draw(float scale, float strokeWeight) {
    draw((PGraphicsOpenGL)g, scale, strokeWeight);
  }

  void draw(PApplet pa, float scale, float strokeWeight) {
    draw((PGraphicsOpenGL)pa.g, scale, strokeWeight);
  }

  void draw(PGraphicsOpenGL pogl, float scale, float strokeWeight) {
    pogl.pushStyle();
    pogl.strokeWeight(strokeWeight);

    if (m.m33 != 0 && m.m33 != 1) {
      scale /= m.m33;
    }

    // X Axis
    pogl.stroke(0xffff0000);
    pogl.line(m.m03, m.m13, m.m23,
      m.m03 + m.m00 * scale,
      m.m13 + m.m10 * scale,
      m.m23 + m.m20 * scale);

    // Y Axis
    pogl.stroke(0xff00ff00);
    pogl.line(m.m03, m.m13, m.m23,
      m.m03 + m.m01 * scale,
      m.m13 + m.m11 * scale,
      m.m23 + m.m21 * scale);

    // Z Axis
    pogl.stroke(0xff0000ff);
    pogl.line(m.m03, m.m13, m.m23,
      m.m03 + m.m02 * scale,
      m.m13 + m.m12 * scale,
      m.m23 + m.m22 * scale);
    pogl.popStyle();
  }

  PVector getPosition() {
    return new PVector(m.m03, m.m13, m.m23);
  }

  PVector getXAxis() {
    PVector v = new PVector(m.m00, m.m10, m.m20);
    if (m.m33 != 0 && m.m33 != 1) {
      v.div(m.m33);
    }
    return v;
  }

  PVector getYAxis() {
    PVector v = new PVector(m.m01, m.m11, m.m21);
    if (m.m33 != 0 && m.m33 != 1) {
      v.div(m.m33);
    }
    return v;
  }

  PVector getZAxis() {
    PVector v = new PVector(m.m02, m.m12, m.m22);
    if (m.m33 != 0 && m.m33 != 1) {
      v.div(m.m33);
    }
    return v;
  }

//  TODO : IS THIS THE RIGHT SPOT?
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

}
