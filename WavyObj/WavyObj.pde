//  SEE:   https://ello.co/ericfickes/post/vh01bkcjgfiydr5t-x1ega
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;
import nervoussystem.obj.*;

boolean record = true;

int cX;
int cY;
float x,y, t;
float angle = 0;
float xx, yy, startX, startY;
Integer pStep = 93;  //  SMALLER = more complex shapes
//Integer pStep = 90;  //  SMALLER = more complex shapes

Fixlib fix = Fixlib.init(this);
PVector pStart, pEnd, pt, pt2;
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

- vertex : http://processing.org/reference/vertex_.html

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
  sphereDetail(9);

  hint(ENABLE_OPTIMIZED_STROKE);
  hint(ENABLE_STROKE_PERSPECTIVE);
  hint(ENABLE_TEXTURE_MIPMAPS);
  hint(ENABLE_STROKE_PURE);
  // these hints fix HCylinder.noFill()
  hint(ENABLE_DEPTH_SORT);


  // create start and end points
  pStart = new PVector( 0, random(pStep));
  pEnd = new PVector( width, random(height));
  //  get path between points
  fullPath = fix.GeneratePath( pStart, pEnd, pStep);

  beginRecord("nervoussystem.obj.OBJExport", fix.pdeName()+""+fix.getTimestamp()+"_"+pStep+".obj");
}

///////////////////////////////////////////////////////
void draw() {

  //ellipse(pStart.x, pStart.y, pStep, pStep);
  //ellipse(pEnd.x, pEnd.y, pStep, pStep);

  beginShape();

// shape( createShape( SPHERE, pStep), pStart.x, pStart.y );


  
    vertex( pStart.x, pStart.y, pStart.z  );
    
  
    // for (int i = fullPath.size()-1; i>0; i-=9)
    for (int i = fullPath.size()-1; i>0; i-=pStep)
    {
      pt = (PVector)fullPath.get(i);
      // shape( createShape( SPHERE, pStep), pt.x, pt.y );
      // shape( createShape( RECT, pt.x, pt.y, pStep, pStep ), pt.x, pt.y );
/*        
      //vertex(pt.x, pt.y, pt.z);
      rotateX(45);
      vertex(pt.x, pt.y, -width);
      vertex(pt.y, pt.x, width);
      rotateY(45);
      vertex(pt.x, pt.y, -width);
      vertex(pt.y, pt.x, width);
*/

      for( int aa = 20; aa <= 360; aa += pStep ) {
        
        pt2 = fix.circleXY( pt.x, pt.y, pStep, aa );
        // shape( createShape( SPHERE, pStep), pt2.x, pt2.y );
		// shape( createShape( RECT, pt2.x, pt2.y, pStep, pStep ), pt2.x, pt2.y );

        rotateX(15);
        rotateY(45);
        rotateZ(45);
        vertex(pt.x, pt.y, -(int)random(width) );
        

        rotateX(15);
        rotateY(45);
        rotateZ(45);
        vertex(pt.y, pt.x, (int)random(width) );
        

        rotateX(15);
        rotateY(45);
        rotateZ(45);
        vertex(pt.x, pt.y, -(int)random(width) );
        
/*
        rotateX(15);
        rotateY(45);
        rotateZ(45);
        vertex(pt.y, pt.x, (int)random(width) );
        */
      }
      // HOW TO FAN OUT AROUND CONTROL POINTS?
      //  BETA - fan out around point?
    
    }

    vertex( pEnd.x, pEnd.y, pEnd.z);

// shape( createShape( SPHERE, pStep), pEnd.x, pEnd.y );

  endShape(CLOSE);


/*
  stroke(random(255),random(155),random(55));
  strokeWeight(PI);

  ellipse(pStart.x, pStart.y, pStep, pStep);
  ellipse(pEnd.x, pEnd.y, pStep, pStep);

  beginShape();
    vertex( pStart.x, pStart.y  );
    for (int i = 0; i<fullPath.size(); i++)
    {
      pt = (PVector)fullPath.get(i);
      vertex(pt.x, pt.y);
    }
    vertex( pEnd.x, pEnd.y);
  endShape();
*/

  pStep = int(pStep+TWO_PI);
  // create start and end points
  pStart = new PVector( random(width), pStart.y+pStep );
  pEnd = new PVector( random(width), random(height));
  //  get path between points
  fullPath = fix.GeneratePath( pStart, pEnd, pStep );


  //  STOPPER
  if( pStart.y > height)
  {
  /* ... */
  //if (record) {
    endRecord();
    record = false;
  //}
    
    
    fill(#EFEFEF);
    text("ericfickes.com", width-100, height-11);
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    noLoop();
    exit();
  }

}
