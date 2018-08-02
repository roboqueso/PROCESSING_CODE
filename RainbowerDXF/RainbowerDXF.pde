/*
  RAINBOWER - Part of the "SPACE RAINBOWS" themeds
  * Draw half a circle, move back sliceWidth, draw another half circle, close shape
  
 //  TODO: FIX RAINBOW LOGIC TO MAKE CLEAN SLICE SHAPE 
  
fix.circleXY() doens't seem to draw a perfect half circle as expected

//  TODO: create a debug circle sketch for fix.circleXY() and tighten up that logic

*/
import fixlib.*;
import processing.dxf.*;

Fixlib fix = Fixlib.init(this);
PVector vect = new PVector();
float cX, cY, radius, angle, sliceWidth;
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
    // hint(ENABLE_DEPTH_SORT);
    strokeWeight(HALF_PI);

    fill(#EF4300);
    text( fix.pdeName(), 11, height-100 );


    cX = width/2;
    cY = height*.75;
    radius = 420;
    sliceWidth = 43;
}

/***/
void draw() {


    // rect(0, 0, width, height) after setting the fill() to the background color. Otherwise the background will not be rendered to the file because the background is not shape. 
    if(saveDXF){
      beginRaw( DXF, fix.pdeName()+fix.getTimestamp() +".dxf" );
    }


// //  DEBUG CIRCLE
// if(!saveDXF){
//   for(int fc = 0; fc >= 360; fc++)
//   {

//     angle = fc;
//     vect = fix.circleXY( cX, cY, radius, angle );
//     stroke(#EF4300);
//     point(vect.x, vect.y, angle );
//   }
// }




    //  START SHAPE HERE
    beginShape(); 
    
 
    
    //  FIRST OUTER SLICE /////////////////////////////////////////////////////
    for(int fc = 0; fc <= 180; fc++)
    {
      angle = fc;

      vect = fix.circleXY( cX, cY, radius, angle );
  
      //  DEBUG
      //println("vect.x " + vect.x + ", vect.y " + vect.y +", angle " + angle );
if(!saveDXF)point(vect.x, vect.y, angle );

// if(fc==0){
//   line(vect.x, vect.y, radius, vect.y);
// }



    vertex(vect.x, vect.y, angle );
    }


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

    // rect(0,  0, width, height) after setting the fill() to the background color. Otherwise the background will not be rendered to the file because the background is not shape. 
    if(saveDXF){
      endRaw();
    }
        
      save(fix.pdeName()+"_"+fix.getTimestamp()+".png");
    

    
    println("peace out");
    exit();

}
