boolean save = true;
int xx, yy, sz = 42;
PShape shp;

void setup() {
  size(640, 360, P2D);
  //  P2D renders shape() best
  //  P3D renders shape() ok
/*
shapeMode(mode)
  mode  int: either CORNER, CORNERS, CENTER
*/
  noFill();
  smooth();

  xx = yy = -sz;
}

void draw() 
{    
  point( xx, yy );
  
  //if(frameCount % 42 == 0 ){
  
  //  GET SHAPE
  shp = shape7(xx, yy, sz);

  //  DRAW SHAPE
  stroke(random(255));
  strokeWeight(5);
  shape(shp, xx, yy, sz, sz);
  
  stroke(random(255));
  strokeWeight(2);
  shape(shp, xx, yy, sz, sz);
  
  //}
  
  //ellipse( xx, yy, sz, sz );
  //strokeWeight(1);
  //rect( xx, yy, sz, sz );
  
  
  
  //  X/Y STUFF
  if(xx<width)
  {
    xx += sz;
  }
  else
  {
    xx = (int) -sz;
    yy += (int) sz;
  }
  
  if(yy>height)
  {
    yy = (int) random(-sz);
  }
  
  
  //  STOPPER
  if(frameCount>width)
  {
    if(save){  save(fix.pdeName()+fix.getTimestamp()+".png"); }
    exit();
  }
}


//  
//  Create a PShape of 7 points, centered at specified cx, cy
PShape shape7(int cx, int cy, int sz)
{  
  //  createShape(kind, params)
  //  @kind   int: either POINT, LINE, TRIANGLE, QUAD, RECT, ELLIPSE, ARC, BOX, SPHERE
  //  @p      float[]: parameters that match the kind of shape
  PShape shape7;
  
  shape7 = createShape();
  shape7.beginShape();

  //  LET'S BE POSITIVE
  cx = ( cx < 0 ) ? -cx : cx;
  cy = ( cy < 0 ) ? -cy : cy;


  for (int i = 0; i < 6; i = i+1) 
  {
    //  pick seven points using circle logic
    shape7.vertex(   cx - int( cos(radians(random(360))) * sz ),
                      cy - int( sin(radians(random(360))) * sz ) );
  }
  
  shape7.endShape(CLOSE);

  return shape7;
}