import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HColorPool;
import nervoussystem.obj.*;
import fixlib.*;

// HDrawablePool pool;
int shpSz = 43;
float xx, yy, cX, cY;
HOscillator hoss;
Fixlib fix = Fixlib.init(this);


/* ------------------------------------------------------------------------- */

void  settings ()  {
    size( 1600, 1600, P3D);
    pixelDensity(displayDensity());
    smooth(8);  //  smooth() can only be used in settings();
}

/* ------------------------------------------------------------------------- */
void setup() {
  
  frameRate(420);
  background(-1);

  beginRecord("nervoussystem.obj.OBJExport", fix.pdeName()+""+fix.getTimestamp()+"_"+shpSz+".obj");

  hint(ENABLE_OPTIMIZED_STROKE);
  hint(ENABLE_STROKE_PERSPECTIVE);
  hint(ENABLE_TEXTURE_MIPMAPS);
  hint(ENABLE_STROKE_PURE);
//  // these hints fix HCylinder.noFill()
//  //hint(ENABLE_DEPTH_SORT);
//hint(DISABLE_DEPTH_SORT);


  //  init HYPE
  H.init(this).background(-1).use3D(true).autoClear(true);

  cX = width*.5;
  cY = height*.5;

  //  
  hoss = new HOscillator()
    .range(cX,width)
    .speed(.75)
    .freq(1.3);



  ellipseMode(CENTER);
  imageMode(CORNERS);
  rectMode(CENTER);
  noFill();

  sphereDetail(3);
}



void draw() {

  xx = cX + int( cos(radians(frameCount)) * (shpSz*hoss.nextRaw()) );
  yy = cY + int( sin(radians(frameCount)) * (shpSz*hoss.nextRaw()) );


  //ellipse(xx,yy, shpSz, shpSz);
  rotateX(xx);
  rotateY(yy);
  rotateZ(xx+yy);
  shape( createShape(SPHERE,shpSz), xx, yy );



  if(frameCount%363==0){

    shpSz += 18;

  } else if ( shpSz >= 96 ){

  //  bullseye out
  for( int sz = 2; sz <= shpSz; sz +=6 )
  {
    sphereDetail(sz);
    rotateX(xx);
    rotateY(yy);
    rotateZ(xx+yy+sz);

    shape( createShape(SPHERE,shpSz+sz), -xx-sz, -yy-sz );
    shape( createShape(SPHERE,shpSz+sz), xx+sz, yy+sz );
    
    
    shape( createShape(SPHERE,shpSz+sz), -yy-sz, -xx-sz );
    shape( createShape(SPHERE,shpSz+sz), yy+sz, xx+sz );
  }
  
//  // resest center and shapeSize
//  cX = random(width);
//  cY = random(height);
//  shpSz = 4;

//  // connect the balls

//  //  ellipse
//  bezier( xx, yy, 
//    random(width), random(height), 
//    random(width), random(height), 
//    cX + int( cos(radians(frameCount)) * (shpSz*hoss.nextRaw()) ),
//    cY + int( sin(radians(frameCount)) * (shpSz*hoss.nextRaw()) )
//    );

//  //  rect
//  curve( yy, xx, 
//    random(width), random(height), 
//    random(width), random(height), 
//    cY + int( sin(radians(frameCount)) * (shpSz*hoss.nextRaw()) ),
//    cX + int( cos(radians(frameCount)) * (shpSz*hoss.nextRaw()) )
//    );



//  //} else if ( frameCount >= (width+height)*42 ){
//} else if ( frameCount >= (width+height)*9 ){
    
    
    String sname = split(this.toString(),'[')[0];
    fill(#EF2013);
    text(sname, 0, height-11);
    save( sname+hour()+minute()+second()+millis()+".png");
    noLoop();
    endRecord();
    exit();
  }
}
