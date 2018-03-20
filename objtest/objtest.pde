/**
NOTE: large OBJs cause this sketch to choke
** local machine problem perhaps?
*/


// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

ArrayList<PShape> shapes = new ArrayList<PShape>();
PShape s;
float x, y;

void setup() {
  size(displayWidth, displayHeight, P3D);
  background(0);
  frameRate(100);
  smooth();
  strokeWeight(PI);

  shapes.add( loadShape("Scan_20150106_200205.obj"));
  shapes.add( loadShape("Scan_20150106_200543.obj"));
  shapes.add( loadShape("Scan_20150106_201424.obj"));
  shapes.add( loadShape("Scan_20150106_201603.obj"));
  shapes.add( loadShape("Scan_20150106_202334.obj"));
  shapes.add( loadShape("Scan_20150106_202923.obj"));
  shapes.add( loadShape("Scan_20150106_203046.obj"));
  //  THIS LAST OBJ IS 7.2 MB, causes sketch to choke
  // shapes.add( loadShape("Scan_20150106_203343.obj"));
}


void draw() 
{
  // pick random shape
  s = shapes.get( (int)random(shapes.size()-1) );

  s.disableStyle();
  
  x = random(width);
  y = random(height);
  
  rotateX( radians(frameCount) );
  shape(s, y,x);
  
  translate(x,y,frameCount%y);
  
  fill(frameCount%255,y,x);
  s.rotate(random(frameCount));
  shape(s, x, y);
    
  if(frameCount >= width+height )
  {
    save(fix.pdeName()+fix.getTimestamp()+".png");
    noLoop();
    exit();
  }
  
}