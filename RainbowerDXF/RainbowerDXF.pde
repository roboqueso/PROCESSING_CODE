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
float radius = 420;
int sliceWidth = 43;  // size of sphere and box when not using behinShape and vertex
int spDetails = 2;    // sphereDetails value DON'T GO UNDER 2
boolean saveDXF = true;


void  settings ()  {
    size(displayWidth, displayHeight, P3D); //"processing.opengl.PGraphics3D");

    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}


/***/
void setup() {

    background(255);

    //  can improve the appearance of 3D geometry drawn to 2D file formats.  
    hint(ENABLE_DEPTH_SORT);
    strokeWeight(.8);

    fill(#EF4300);
    text( fix.pdeName(), 11, height-100 );

    sphereDetail(spDetails);

    cX = width/2;
    cY = height*.75;
}



/***/
void draw() {


    // rect(0, 0, width, height) after setting the fill() to the background color. Otherwise the background will not be rendered to the file because the background is not shape. 
    if(saveDXF){
      beginRaw( DXF, fix.pdeName()+"_"+sliceWidth+"_"+spDetails+"_"+fix.getTimestamp() +".dxf" );
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
        stroke(#EF4300);
        noFill();
        scale(0.75);

        sphere( sliceWidth );
        // box( sliceWidth );

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
        
      save( fix.pdeName()+"_"+sliceWidth+"_"+spDetails+"_"+fix.getTimestamp()+".png");
    

    
    println("peace out");
    exit();

}
