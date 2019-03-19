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
// int radius = 50;  //  circle radius
// int getRad = (int)(width/4);  //  Radius increaser
// int frameMod = getRad;  //8;  // % frameCount to control how many shapes get laid down
int ss = 0;  //  shape index
int xx = 0;

String SAVE_TYPE = ".TIF";	// ".TIF" -> for final print

String DATA_PATH = "";//"../FIXOBJ_DATA/";

//	HUNDIES1.obj - HUNDIES27.obj in ../FIXOBJ_DATA/ ( processing root )

String OBJ_NAME = "WavyObj31320191481153_18.obj";
// String OBJ_NAME = "HUNDIES1.obj";
// String OBJ_NAME = "HUNDIES2.obj";
// String OBJ_NAME = "HUNDIES3.obj";
// String OBJ_NAME = "HUNDIES4.obj";
// String OBJ_NAME = "HUNDIES5.obj";
// String OBJ_NAME = "HUNDIES6.obj";
// String OBJ_NAME = "HUNDIES7.obj";
// String OBJ_NAME = "HUNDIES8.obj";
// String OBJ_NAME = "HUNDIES9.obj";
// String OBJ_NAME = "HUNDIES10.obj";
// String OBJ_NAME = "HUNDIES11.obj";
// String OBJ_NAME = "HUNDIES12.obj";
// String OBJ_NAME = "HUNDIES13.obj";
// String OBJ_NAME = "HUNDIES14.obj";
// String OBJ_NAME = "HUNDIES15.obj";
// String OBJ_NAME = "HUNDIES16.obj";
// String OBJ_NAME = "HUNDIES17.obj";
// String OBJ_NAME = "HUNDIES18.obj";
// String OBJ_NAME = "HUNDIES19.obj";
// String OBJ_NAME = "HUNDIES20.obj";
// String OBJ_NAME = "HUNDIES21.obj";
// String OBJ_NAME = "HUNDIES22.obj";
// String OBJ_NAME = "HUNDIES23.obj";
// String OBJ_NAME = "HUNDIES24.obj";
// String OBJ_NAME = "HUNDIES25.obj";
// String OBJ_NAME = "HUNDIES26.obj";
// String OBJ_NAME = "HUNDIES27.obj";



/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(2000, 1000, P3D); // FX2D can't load OBJs?
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
  background(0x242424);
  hint(ENABLE_OPTIMIZED_STROKE);
  hint(ENABLE_STROKE_PERSPECTIVE);
  hint(ENABLE_TEXTURE_MIPMAPS);
  hint(ENABLE_STROKE_PURE);
  // these hints fix HCylinder.noFill()
  hint(ENABLE_DEPTH_SORT);


s1 = loadShape( DATA_PATH+OBJ_NAME );
s1.scale(.50);
s2 = loadShape( DATA_PATH+OBJ_NAME );
s2.scale(.25);


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
	s1.noStroke();
	
	
	//	RED-ISH
	// fill( (102+frameCount)%202, frameCount%69, 50+ry );

//St.Patrick's GREEN?
	// fill( ry, frameCount%43, frameCount%69 );

	//	tealium
	// fill( frameCount%75, random(frameCount, frameCount%43), random(frameCount, frameCount%24) );

	fill(frameCount%45);
	shape(s1);

  ry += 0.03;


//	CENTER SPINNER
  lights();
  camera();

translate( width/2, height/2, 300);

// rotate(ry);
rotateX(ry*.5);
rotateY(ry);
rotateZ(ry*2);

s2.disableStyle();
s2.noStroke();
fill( random(245, 255) );
shape(s2);


  if(xx > width){



  	save(fix.pdeName()+'_'+OBJ_NAME+'_'+fix.getTimestamp()+SAVE_TYPE);
  	exit();
  } else {

	xx+=2;

  }
} //<>//
