/*
CircleOfShapes

draw circle
  shape on each angle

PVector circleXY( float centerX, float centerY, float radius, float angle )
*/
import fixlib.*;
import processing.video.*;

Fixlib fix = Fixlib.init(this);


Capture cam;
PImage imgFace;

/***/
void setup() {
    background(-1);
    size( displayWidth, displayHeight, P3D);
    
    smooth(8);

    shapeMode(CENTER);

    cam = new Capture(this, displayWidth, displayHeight);
    cam.start();
    noStroke();
}



/***/
void draw() {
  
  // 3D code
  hint(DISABLE_DEPTH_TEST);
  camera();
  lights(); //    because P3D
  

  //  grab camera
  if(cam.available()){
    imgFace = cam;
    
  }
  
  //  draw shape if we have imgFace
  if(imgFace!=null){

tint(255, random(8,88) );
image( imgFace.get( 0,0, (int)random(imgFace.width), (int)random(42) ), frameCount%width, frameCount%height );
noTint();
    
    ambientLight(frameCount%255, frameCount%100, frameCount%50);
    emissive( imgFace.get( (int)(frameCount%imgFace.width), (int)(frameCount%imgFace.height) ));
    specular( imgFace.get( (int)(frameCount%imgFace.width), (int)(frameCount%imgFace.height) ));

    tint( imgFace.get( (int)(frameCount%imgFace.width), (int)(frameCount%imgFace.height) ), random(104, 240) );

    if(frameCount%5==0)
      imgFace.filter(DILATE);
    else if ( frameCount%13==0)
      imgFace.filter(INVERT);
    else
      imgFace.filter(POSTERIZE, random(42,255));

    shape( fix.makeJous( ( (frameCount+random(8,60)) %width), 
                         random(height+random(210))%height, 
                         random( 42, 210 ), 
                         (int)random(4,32), imgFace ) );
                         

  }

  if(frameCount>width){
    doExit();
  }
  
}

void doExit(){
    println("peace out");
    
    cam.stop();
    imgFace = null;

    save(fix.pdeName()+"_"+fix.getTimestamp()+".png");
    
    exit();
}

void keyPressed()
{
  switch(key)
  {
    case 's':
    case 'S':
      doExit();
    break;
  }
}

void captureEvent(Capture c) {
  c.read();
}
