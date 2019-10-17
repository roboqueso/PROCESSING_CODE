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
Boolean fillStyle = true;  //  TRUE: fill w/x,y or FALSE: leave style as is
// int radius = 50;  //  circle radius
// int getRad = (int)(width/4);  //  Radius increaser
// int frameMod = getRad;  //8;  // % frameCount to control how many shapes get laid down
int ss = 0;  //  shape index
int xx = 0;
int cX, cY;

String SAVE_TYPE = ".TIF";	// ".TIF" -> for final print

String DATA_PATH = "";//"../FIXOBJ_DATA/";

//	HUNDIES1.obj - HUNDIES27.obj in ../FIXOBJ_DATA/ ( processing root )

// String OBJ_NAME = "NuObj-9s1.obj";
// String OBJ_NAME = "NuObj-9s2.obj";
String OBJ_NAME = "RoShape-11s1.obj";


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
  background(0x090909);
  hint(ENABLE_OPTIMIZED_STROKE);
  hint(ENABLE_STROKE_PERSPECTIVE);
  hint(ENABLE_TEXTURE_MIPMAPS);
  hint(ENABLE_STROKE_PURE);
  // these hints fix HCylinder.noFill()
  hint(ENABLE_DEPTH_SORT);
	noStroke();

s1 = loadShape( DATA_PATH+OBJ_NAME );
s1.scale( .6);
s2 = loadShape( DATA_PATH+OBJ_NAME );
s2.scale( .2 );

cX = (int)width/2;
cY = (int)height/2;

}

void draw() {


//	BACKGROUND ACTION

  lights();
  camera();

  //	LEFT to RIGHT
  translate( xx, (height/2 ) + (TWO_PI*noise(frameCount)*random(-.69, .69)) , -420 );

	// rotateX(ry*.09);
	// rotateY(ry*noise(frameCount));
	// rotateZ(ry*.43);

	rotateX(ry*.43);
	rotateY(ry*TWO_PI);
	rotateZ(ry*.69+noise(frameCount));
	// rotateZ(frameCount%360 + (ry*.69+noise(frameCount)) );

	// s1.disableStyle();
	//s1.noStroke();
	
	if(fillStyle){
	//	RED-ISH
	// fill( (102+frameCount)%202, frameCount%69, 50+ry );

	//St.Patrick's GREEN?
	// fill( ry, frameCount%43, frameCount%69 );

	//	tealium
	// fill( frameCount%75, random(frameCount, frameCount%43), random(frameCount, frameCount%24) );

	//	earth tones
	fill( frameCount%90, frameCount%69, frameCount%43 );

	//	B&W
	// fill(frameCount%255);

	//	brownish
	// fill( frameCount%255, 9, frameCount%255);
	// ambientLight( frameCount%255, 9, frameCount%255);
	// ambientLight( frameCount%255, 9, frameCount%255);


	//	redish / purple
	// fill( 24+(frameCount%75)%255, 9, 24);


	//	REDISH?
	// fill( (43+frameCount%90)%180, frameCount%24, (frameCount%18) );


	//	DEEP PURPLE
	// fill( frameCount%69, frameCount%9, frameCount%69 );

	//	purps / greens
	// fill( frameCount%75, frameCount%43, frameCount%75 );
	}

	shape(s1);

  // ry += 0.024;
  // ry += 0.043;
  ry += 0.43;
  // ry += .69;


//	CENTER SPINNER
	fill( frameCount%255,  frameCount%255,  frameCount%255 );
	ambient( 255,  255,  255 );
	ambientLight( 255,  255,  255 );
	lightSpecular(255, 255, 255);
	centerSpinner();

  if(xx > width){

  	save(fix.pdeName()+'_'+OBJ_NAME+'_'+fix.getTimestamp()+SAVE_TYPE);
  	exit();
  } else {

	xx+= TWO_PI;

  }
} //<>//


void centerSpinner(){
	// lights();
	// camera();

	translate( width/2, height/2, 420);

	rotateX(ry*.15);
	rotateY(ry*.30);
	rotateZ(ry*.45);


	// s2.disableStyle();
	specular(0,0,255);
    shininess(10.0);
    // ambient(255,0,0);
    // emissive(255,0,0);

	shape(s2);

}