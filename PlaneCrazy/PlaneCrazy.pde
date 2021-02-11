import processing.video.*;
//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);



Capture cam;
PImage imgFace;

float sX, sY;
PVector pv;

/***/
void setup() {
    background(-1);
    size( displayWidth, displayHeight, P3D);
    
    smooth(8);

    shapeMode(CENTER);

    cam = new Capture(this, displayWidth, displayHeight);
    cam.start();


    textSize(42);
    fill(#EF2018);
    text( fix.pdeName(), 11, height-100 );
    noFill();
    noTint();
    strokeWeight(PI);

    sX = width/2;
    sY = height/2;
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

    tint(255, random(42,120 ) );
    image( imgFace.get( 0,0, (int)random(imgFace.width), (int)random(8,21) ), frameCount%width, frameCount%height );
    noTint();
    

    //ambientLight(frameCount%255, frameCount%100, frameCount%50);
    emissive( imgFace.get( (int)(frameCount%imgFace.width), (int)(frameCount%imgFace.height) ));
    specular( imgFace.get( (int)(frameCount%imgFace.width), (int)(frameCount%imgFace.height) ));

    tint( imgFace.get( (int)(frameCount%imgFace.width), (int)(frameCount%imgFace.height) ), random(42, 185) );

    if(frameCount%5==0)
      imgFace.filter(DILATE);
    else if ( frameCount%13==0)
      imgFace.filter(INVERT);
    else
      imgFace.filter(POSTERIZE, random(42,255));


    fill( imgFace.get( (int)(frameCount%imgFace.width), (int)(frameCount%imgFace.height) ) );
    stroke( imgFace.get( (int)(frameCount%imgFace.width), (int)(frameCount%imgFace.height) ), 80 );
    strokeWeight(HALF_PI);
    pushMatrix();
      translate(sX, sY, frameCount );
        sphereDetail((int)random(8,21));
        sphere( random(42) );
    popMatrix();
    

    beginShape(POLYGON);    
      texture(imgFace);

      for(int aa = 0; aa < 360; aa+=8 ) 
      {
        pv = fix.circleXY( sX, sY, random(sY), aa );  //random(42,420)
        vertex(pv.x, pv.y, pv.z, sX, sY );
      }
    endShape(CLOSE);

    // mix up where the starting X/Y lives
    sX = random( width ) + frameCount;
    sY = random( height ) + frameCount;
                         
  }

  if(frameCount>210){
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
