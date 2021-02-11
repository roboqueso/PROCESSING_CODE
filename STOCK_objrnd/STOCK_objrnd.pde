//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);

float ry;
ArrayList<PShape> shapes = new ArrayList<PShape>();
PShape s, s1, s2, s3, s4, s5, s6, s7;
float x, y;
PVector vect = new PVector();
Boolean fillStyle = false;  //  TRUE: fill w/x,y or FALSE: leave style as is
int radius = 43;  //  circle radius
int getRad = (int)(width/4);  //  Radius increaser
int frameMod = getRad;  //8;  // % frameCount to control how many shapes get laid down
int ss = 0;  //  shape index

/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(1760, 880, P3D); // FX2D can't load OBJs?
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
  background(-1);

//  NOTE: this sketch assumes all Adobe Stock modes live in P5 root/_allmodelsP5/
//  ALL LIST


/*
  < 1MB obj list
  /210882332/stationary_papers_1544.obj
  /172516642/statinoary_003.obj
  /207432973/hexagonal_display_structure_1411.obj
  /190403568/a_business_cards_002.obj
  /184479727/business_cards_001.obj
  /201384220/thermos_289.obj
  /172516539/gift_box_192b.obj
*/
s1 = loadShape( "../_allmodelsP5/210882332/stationary_papers_1544.obj" );
// s2 = loadShape( "../_allmodelsP5/172516642/stationary_003.obj" );
// s3 = loadShape( "../_allmodelsP5/207432973/hexagonal_display_structure_1411.obj" );
// s4 = loadShape( "../_allmodelsP5/190403568/a_business_cards_002.obj" );
// s5 = loadShape( "../_allmodelsP5/184479727/business_cards_001.obj" );
// s6 = loadShape( "../_allmodelsP5/201384220/thermos_289.obj" );
// s7 = loadShape( "../_allmodelsP5/172516539/gift_box_192b.obj" );  

shapes.add( s1 );
// shapes.add( s2 );
// shapes.add( s3 );
// shapes.add( s4 );
// shapes.add( s5 );
// shapes.add( s6 );
// shapes.add( s7 );

  // text(s, 43, 420);

}

void draw() {
  // pick shape
  s = shapes.get( ss );
  
  lights();
  
  translate(width/2, height/2 + 100, -200);
  rotateZ(PI);
  rotateY(ry);
  s.disableStyle();  // Ignore the colors in the SVG
  fill(0, 102, 153);    // Set the SVG fill to blue
  stroke(255); 
  shape(s);
  
  ry += 0.02;
} //<>//
