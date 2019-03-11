import nervoussystem.obj.*;
import fixlib.*;




boolean record = false;
float noiseScale = .05;

int cX;
int cY;
float x,y, t;
float angle = 0;
float xx, yy, startX, startY;
//Integer pStep = 3;  //  SMALLER = more complex shapes
Integer pStep = 18;  //  SMALLER = more complex shapes

Fixlib fix = Fixlib.init(this);
PVector pStart, pEnd, pt;
ArrayList<PVector> fullPath;


/*
liner

1. define start and stop points

2. calculate left to right coordinates between start and stop

3. return PVector[] fullPath[]

4. Draw path 

* increment starting Y to avoid overlaps

- ellipse

- vertex : http://processing.org/reference/vertex_.html

- bezierVertex : http://processing.org/reference/bezierVertex_.html

- curveVertex : http://processing.org/reference/curveVertex_.html

- quadraticVertex : http://processing.org/reference/quadraticVertex_.html

*/


/* ------------------------------------------------------------------------- */
void  settings ()  {
    //  For best results, change size() to match dimensions of mainImgFile
    size( 666, 666, P3D);
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}


///////////////////////////////////////////////////////
void setup() {
  background(-1);  //0x16161E);
  
  cX = width/2;
  cY = height/2;
  
  // create start and end points
  pStart = new PVector( 0, random(-pStep,pStep));
  pEnd = new PVector( width, random(-height,height));
  
  //  get path between points
  fullPath = fix.GeneratePath( pStart, pEnd, pStep);

  beginRecord("nervoussystem.obj.OBJExport", fix.pdeName()+""+fix.getTimestamp()+"_"+pStep+".obj");

  //sphereDetail(3);
  //strokeWeight(HALF_PI);
  noFill();

} 

///////////////////////////////////////////////////////
void draw() {
  

  // CURVE VERTEX
  curveTightness(random(frameCount));
  sphereDetail((int)random(3, 45) );
  
  //ellipse(pStart.x, pStart.y, pStep, pStep);
  //ellipse(pEnd.x, pEnd.y, pStep, pStep);
  shape( createShape(SPHERE,pStep), pStart.x, pStart.y, pStep, pStep);
  shape( createShape(SPHERE,pStep), pEnd.x, pEnd.y, pStep, pStep);
  
  beginShape();
    vertex( pStart.x, pStart.y, random(-width, width) );
    
    for (int i = 0; i<fullPath.size(); i++)
    {
      pt = (PVector)fullPath.get(i);
      
      rotateX(-i);
      rotateY(-i);
      rotateZ(-i);
      
      curveVertex(pt.x, pt.y, pt.z);
      curveVertex(pt.y, pt.x, pt.z);
      // test
      curveVertex(-pt.x, -pt.y, -pt.z);
      curveVertex(-pt.y, -pt.x, -pt.z);

    }
    
    vertex( pEnd.x, pEnd.y, random(-width, width) );
    
  endShape();



  //// CURVE VERTEX
  curveTightness(random(frameCount));
  sphereDetail((int)random(3, 9) );
  


   //ellipse(pStart.x, pStart.y, pStep, pStep);
  //ellipse(pEnd.x, pEnd.y, pStep, pStep);
  shape( createShape(SPHERE,pStep), pStart.x, pStart.y, pStep, pStep);
  shape( createShape(SPHERE,pStep), pEnd.x, pEnd.y, pStep, pStep);



  beginShape();
    vertex( pStart.y, pStart.x, random(-width, width) );

    for (int i = 0; i<fullPath.size(); i++)
    {
      pt = (PVector)fullPath.get(i);
      
      rotateX(i);
      rotateY(i);
      rotateZ(i);

      curveVertex(pt.x, pt.y, pt.z);
      curveVertex(pt.y, pt.x, pt.z);
      // test
      curveVertex(-pt.x, -pt.y, -pt.z);
      curveVertex(-pt.y, -pt.x, -pt.z);

    }
    vertex( pEnd.y, pEnd.x, random(-width, width) );
  endShape();


  pStep = int(pStep+TWO_PI);
  // create start and end points
  pStart = new PVector( random(width), pStart.y+pStep );
  pEnd = new PVector( random(width), random(height));
  //  get path between points
  fullPath = fix.GeneratePath( pStart, pEnd, pStep );


  //  STOPPER
  if( pStart.y > height)
  {
    fill(#EFEFEF);
    text("ericfickes.com", width-100, height-11);
    noLoop();
    
    save( fix.pdeName() + fix.getTimestamp() + ".png");    
    endRecord();

    exit();
  }

}
