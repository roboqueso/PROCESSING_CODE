/**
 * Load and Display an OBJ Shape. 
 * 
 * The loadShape() command is used to read simple SVG (Scalable Vector Graphics)
 * files and OBJ (Object) files into a Processing sketch. This example loads an
 * OBJ file of a rocket and displays it to the screen. 
 */





  
/**
stock_ModelSpiral
*/


// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);
float ry;
ArrayList<PShape> shapes = new ArrayList<PShape>();
PShape s, s1, s2, s3, s4, s5, s6, s7;
float x, y;
PVector vect = new PVector();
Boolean fillStyle = false;  //  TRUE: fill w/x,y or FALSE: leave style as is
int radius = 50;  //  circle radius
int getRad = (int)(width/4);  //  Radius increaser
int frameMod = getRad;  //8;  // % frameCount to control how many shapes get laid down
int ss = 0;  //  shape index
int xx = 0;

//	HUNDIES1.obj - HUNDIES27.obj in ../FIXOBJ_DATA/ ( processing root )
String DATA_PATH = "../FIXOBJ_DATA/";
String OBJ_NAME = "HUNDIES27.obj";
String SAVE_TYPE = ".PNG";	// ".TIF" -> for final print

PImage txt;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(2000, 1000, P3D); // FX2D can't load OBJs?
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
  background(-1);
  hint(ENABLE_OPTIMIZED_STROKE);
  hint(ENABLE_STROKE_PERSPECTIVE);
  hint(ENABLE_TEXTURE_MIPMAPS);
  hint(ENABLE_STROKE_PURE);
  // these hints fix HCylinder.noFill()
  hint(ENABLE_DEPTH_SORT);

// txt = loadImage(DATA_PATH+"ash.png");
txt = loadImage(DATA_PATH+"ash.jpg");

s1 = loadShape( DATA_PATH+OBJ_NAME );
s1.scale(.6);
s2 = loadShape( DATA_PATH+OBJ_NAME );
s2.scale(.2);

s2.disableStyle();
// s2.setTexture(txt);


// s2 = loadShape( "../_allmodelsP5/172516642/stationary_003.obj" );
// s3 = loadShape( "../_allmodelsP5/207432973/hexagonal_display_structure_1411.obj" );
// s4 = loadShape( "../_allmodelsP5/190403568/a_business_cards_002.obj" );
// s5 = loadShape( "../_allmodelsP5/184479727/business_cards_001.obj" );
// s6 = loadShape( "../_allmodelsP5/201384220/thermos_289.obj" );
// s7 = loadShape( "../_allmodelsP5/172516539/gift_box_192b.obj" );  

// shapes.add( s1 );
// shapes.add( s2 );
// shapes.add( s3 );
// shapes.add( s4 );
// shapes.add( s5 );
// shapes.add( s6 );
// shapes.add( s7 );

  // text(s., 43, 420);

}

void draw() {


//	BACKGROUND ACTION

  lights();
  camera();

  //	LEFT to RIGHT
  translate( xx, height/2, 0);
  // pushMatrix();
	// rotate(ry);
	rotateX(ry*.09);
	rotateY(ry);
	rotateZ(ry*.43);

	s1.disableStyle();
	fill( (102+frameCount)%202, frameCount%69, 50);
	stroke(frameCount%255);

	shape(s1);
// ortho();

  ry += 0.02;


//	CENTER SPINNER
  lights();
  camera();

translate( width/2, height/2, 300);
// rotate(ry);
rotateX(PI);
rotateY(ry);
rotateZ(ry*.69);

s2.disableStyle();
s2.setStroke(false);
s2.setFill( (int)random(240,250) );
shape(s2);


  if(xx > width){



  	save(fix.pdeName()+'_'+OBJ_NAME+'_'+fix.getTimestamp()+".png");
  	exit();
  } else {

	xx+=2;

  }
} //<>//
