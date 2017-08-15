PShape cube;
PShader lineShader;
float angle;

float weight = 21;

int clr = 0;
int boxSz = 140;
int boxY = boxSz;

boolean fwd = true;

//////////////////////////////////////
void setup() {

  size(1024, 768, P3D);
  background(255);
  smooth();
  pixelDensity(displayDensity());

  strokeCap(ROUND);
  strokeJoin(MITER);

  lineShader = loadShader("linefrag.glsl", "linevert.glsl");
  lineShader.set("weight", weight);

  
  hint(DISABLE_DEPTH_MASK);  //  without this, the sketch has redraw artifacts from

}

//////////////////////////////////////
void draw() {
  
  translate((frameCount%width), boxY );
  rotateX(angle);
  rotateY(angle);

  shader(lineShader, LINES);  //  POINTS, LINES, or TRIANGLES

  cube = createShape(BOX, boxSz+noise(clr) );

  cube.setStrokeWeight(weight+noise(clr) );
  // cube.setFill(  color(  boxY, angle, clr ) );
  // cube.setStroke(  color(  angle, clr, boxY ) );

  cube.setFill(  color(  (frameCount+angle)%255  ) );
  cube.setStroke(  color(  (frameCount+clr)%255 ) );

  
  shape(cube);
  
  angle += 0.01;
  
  //  if X hit's right border
  //  drop Y down a boxSz
  if( frameCount % width == 0 ){
    boxY += boxSz;
  }
  
  
 
 if(frameCount%255==0) fwd = !fwd;
  if(fwd)
    clr++;
  else
    clr--;

  clr = (fwd) ? clr++ : clr--;
  clr = constrain(clr, 0, 255);


  if( boxY> height ){
  
    save(this+".png");
    noLoop();
    super.exit();
  }

}