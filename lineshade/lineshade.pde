PShape cube;
PShader lineShader;
float angle;

float weight = 11;

int clr = 0;
int boxSz = 150;
int boxY = boxSz;

boolean fwd = true;

//////////////////////////////////////
void setup() {

  size(1024, 768, P3D);
  background(255);

  lineShader = loadShader("linefrag.glsl", "linevert.glsl");
  lineShader.set("weight", weight);
  
  cube = createShape(BOX, boxSz);
  cube.setFill(false);
  
  cube.setStrokeWeight(weight);
  
  hint(DISABLE_DEPTH_MASK);
}

//////////////////////////////////////
void draw() {
  
  translate((frameCount%width), boxY );
  rotateX(angle);
  rotateY(angle);

  shader(lineShader, LINES);
  
  cube.setStroke(color(clr));
//println("clr = " + clr );
  
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
  
    save(fix.pdeName()+fix.getTimestamp()+".png");
    noLoop();
    super.exit();
  }

}