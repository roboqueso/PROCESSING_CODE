import nervoussystem.obj.*;
import fixlib.*;




boolean record = false;
float noiseScale = .05;

int cX;
int cY;
float x,y, t;
float angle = 0;
float xx, yy, startX, startY;
int w = 33;
Fixlib fix = Fixlib.init(this);

/* ------------------------------------------------------------------------- */
void  settings ()  {
    //  For best results, change size() to match dimensions of mainImgFile
    size( 420, 420, P3D);
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}


/* ------------------------------------------------------------------------- */
void setup() {
  background(-1);

    //  setup variables
    cX = width/2;
    cY = height/2;
    startX = cX;
    startY = cY;
    xx = yy = -(w/2);
}



/*********************************************************************/
void draw() {
  
  
// translate( xx, yy, w);
  
  //if(record) {
    //X3DExport x3d = (X3DExport) createGraphics(10,10,"nervoussystem.obj.X3DExport","colored.x3d");
    OBJExport obj = (OBJExport) createGraphics( w, w,"nervoussystem.obj.OBJExport", ""+xx+""+yy+".obj");
    obj.setColor(false);

    obj.beginDraw();
      drawNoise(obj, xx+frameCount, yy+frameCount, w+noise(frameCount));
    obj.endDraw();
    

  image(obj, frameCount%width, random(yy,xx) );
    
    obj.dispose();
    obj = null;
  
  if( yy > height ) {
    save(this+".png");
    exit();
  }
  
  t++;

  if( xx > height ) {
    xx = -(w/2);
    yy += w*2;
  } else {
    xx += w*2; 
  }
}



/*********************************************************************/
void drawNoise(PGraphics pg,  float a, float b, float amp ) {
    pg.strokeWeight(PI);
  pg.beginShape();

//  TODO: build a P5 GIF maker that runs this shapeJous and increments the T+ value by .5
//  record frames and animate, include spitting out of T value so you know 
  for ( float t = 0; t <= 360; t+=9)
  {
    // x = a - amp * sin(a * t * PI/180);
    // y = b - amp * sin(b * t * PI/180);

    x = amp * sin(a * t * PI/180);
    y = amp * sin(b * t * PI/180);

    pg.vertex(x, y, t );

  }  
  pg.endShape(CLOSE);  

  
}
