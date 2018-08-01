/*
  RAINBOWER - Part of the "SPACE RAINBOWS" themeds
  * Draw half a circle, move back sliceWidth, draw another half circle, close shape
  
 //  TODO: FIX RAINBOW LOGIC TO MAKE CLEAN SLICE SHAPE 
  
*/
import fixlib.*;
import processing.dxf.*;

Fixlib fix = Fixlib.init(this);
PVector vect = new PVector();
float cX, cY, radius, angle, sliceWidth;



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


    fill(#EF4300);
    text( fix.pdeName(), 11, height-100 );
    noFill();
    strokeWeight(11); 
    stroke(0);

    cX = width/2;
    cY = height/2;
    radius = 420;
    sliceWidth = 43;
    
 //rect(0, 0, width, height) after setting the fill() to the background color. Otherwise the background will not be rendered to the file because the background is not shape. 


    

}

/***/
void draw() {

    beginRaw( DXF, fix.pdeName()+fix.getTimestamp() +".dxf" );
    //  START SHAPE HERE
    beginShape(); 
    
 
    
    
    for(int fc = 1; fc <361; fc++)
    {
      angle = fc%181;
      
      //  SKIP THE FIRST POINT THAT LOOPS PAST 180
      if( angle==0.0)
      {
        radius -= sliceWidth;
      }
      else
      {
      
      vect = fix.circleXY( cX, cY, radius, angle );
  
      //  DEBUG
      //println("vect.x " + vect.x + ", vect.y " + vect.y +", angle " + angle );
      //point(vect.x, vect.y, angle );
      vertex(vect.x, vect.y, angle );

    pushMatrix();
      translate(vect.x, vect.y, angle);
      stroke(#4D4D4D);
      noFill();
      //sphereDetail( (int)(sDetail/PI) );
      scale(0.75);
  
      //sphere( drawW+(frameCount*sdInc) );
      //box( drawW+(frameCount*sdInc) );
      //vertex( 0,0,0 );
    popMatrix();
    
  
      
      }
    }      
      endShape(); 
      endRaw();
        
      save(fix.pdeName()+"_"+fix.getTimestamp()+".png");
    

    
    println("peace out");
    exit();

}
