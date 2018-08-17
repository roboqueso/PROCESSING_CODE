/*
  RAINBOWER - Part of the "SPACE RAINBOWS" theme
  * Draw half a circle, move back sliceWidth, draw another half circle, close shape
  
NOTE: Z is causing a slight shift making slice not look like a flat semi-circl
* fix.circleXY() doens't seem to draw a perfect half circle as expected
* TODO: create a debug circle sketch for fix.circleXY() and tighten up that logic

*/
import fixlib.*;
import processing.dxf.*;

Fixlib fix = Fixlib.init(this);
PVector vect = new PVector();
float cX, cY, angle;
int radius = 320;
int sliceWidth = 100;  // size of sphere and box when not using beginShape and vertex
int spDetails = 16;   // sphereDetails value DON'T GO UNDER 2
boolean saveDXF = true;


/*
8 SLICES ( 100 )
R 520
G 420
B 320

*/


void  settings ()  {
    size(displayWidth, displayHeight, P3D); //"processing.opengl.PGraphics3D");

    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}


/***/
void setup() {

    background(-1);

    //  can improve the appearance of 3D geometry drawn to 2D file formats.  
    hint(ENABLE_DEPTH_SORT);
    strokeWeight(.8);

    fill(#EF4300);
    text( fix.pdeName(), sliceWidth, sliceWidth );

    fill(0);
    noFill();

    cX = width*.444;
    cY = height*.8;
}



/***/
void draw() {


    // rect(0, 0, width, height) after setting the fill() to the background color. Otherwise the background will not be rendered to the file because the background is not shape. 
    if(saveDXF){
      beginRaw( DXF, fix.pdeName()+"_"+radius+"_"+sliceWidth+"_"+spDetails+"_"+fix.getTimestamp() +".dxf" );
    }


    //  START SHAPE HERE
//    beginShape(); 
    
 
    
    //  FIRST OUTER SLICE /////////////////////////////////////////////////////
    for(int fc = 0; fc <= 180; fc++)
    {
      angle = fc;
      //  get the point
      vect = fix.circleXY( cX, cY, radius, angle );
  
//  DEBUG
if(!saveDXF)point(vect.x, vect.y, angle );


      // vertex(vect.x, vect.y, angle );

      pushMatrix();
        translate( vect.x, vect.y, angle );
        // stroke(#EF4300);
        // noFill();
        scale(0.75);
        
        //  sphere or box?
        if(angle%spDetails==0){
          sphereDetail( (int)random(PI,spDetails), (int)random(PI,spDetails));
          sphere( (int)random(PI,sliceWidth) );
        } else {
          box( sliceWidth, random(PI,sliceWidth), random(PI,sliceWidth) );
        }

      popMatrix();
    }

//  NOTE: Bottom half only needed when using beginShape and vertex above

/*
    //  BACK LINE /////////////////////////////////////////////////////////////
    vect = fix.circleXY( cX, cY, radius, angle );
    vertex(vect.x, vect.y, 180 );

if(!saveDXF)point(vect.x, vect.y, 180 );

    radius -= sliceWidth;
    vect = fix.circleXY( cX, cY, radius, angle );
    vertex(vect.x, vect.y, 180 );

if(!saveDXF)point(vect.x, vect.y, 180 );


    //  SECOND SMALLER SLICE //////////////////////////////////////////////////
    for(int fc = 180; fc >= 0; fc--)
    {

      angle = fc;
      vect = fix.circleXY( cX, cY, radius, angle );

// if(fc==180){
//   line(vect.x, vect.y, radius, vect.y);
// }

if(!saveDXF)point(vect.x, vect.y, angle );

      vertex(vect.x, vect.y, angle );
    }


      endShape();
*/

    // rect(0,  0, width, height) after setting the fill() to the background color. Otherwise the background will not be rendered to the file because the background is not shape. 
    if(saveDXF){
      endRaw();
    }
        
      save( fix.pdeName()+"_"+radius+"_"+sliceWidth+"_"+spDetails+"_"+fix.getTimestamp()+".png");
    

    
    println("peace out");
    exit();

}
