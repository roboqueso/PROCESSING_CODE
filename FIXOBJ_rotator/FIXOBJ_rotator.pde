/**
 STOCK_rotator
 * Load and Display an OBJ Shape -> rotate RnD
 ** Kaleidescope
 ** rotate OBJ around circle to point proper direction like clock face
 
 */






/**
 stock_ModelSpiral
 */


// https://github.com/ericfickes/FIXLIB 
import fixlib.*;
Fixlib fix = Fixlib.init(this);
PShape s;
float cX, cY, x, y;
int preScale = 1;
int inc = 9;	// rotate angle incrementor ( this many += up until 361 )

//	NOTE: lights isn't currently working
Boolean lights =  true;  //  EXTRA light
Boolean fillStyle = true;  //  TRUE: fill w/x,y or FALSE: leave style as is
PVector v;


		// //  * DISPLAYS *
// String MODEL_PATH = "";  String MODEL_NAME = "RoShape-9s1.obj";
// String MODEL_PATH = "";  String MODEL_NAME = "RoShape-10s1.obj";
// String MODEL_PATH = "";  String MODEL_NAME = "RoShape-11s1.obj";
// String MODEL_PATH = "";  String MODEL_NAME = "RoShape-12s1.obj";
// String MODEL_PATH = "";  String MODEL_NAME = "RoShape-13s1.obj";
// String MODEL_PATH = "";  String MODEL_NAME = "RoShape-14s1.obj";
// String MODEL_PATH = "";  String MODEL_NAME = "RoShape-15s1.obj";
// String MODEL_PATH = "";  String MODEL_NAME = "RoShape-16s1.obj";
// String MODEL_PATH = "";  String MODEL_NAME = "RoShape-17s1.obj";
String MODEL_PATH = "";  String MODEL_NAME = "RoShape-18s1.obj";

// String MODEL_PATH = "../_allmodelsP5/210882136/";  String MODEL_NAME = "pos_big_booth_1455.obj";
// String MODEL_PATH = "../_allmodelsP5/212779556/";  String MODEL_NAME = "pos_store_shelves_1441.obj";
// String MODEL_PATH = "../_allmodelsP5/207431428/";  String MODEL_NAME = "pos_store_steps_1447.obj";
// String MODEL_PATH = "../_allmodelsP5/209727994/";  String MODEL_NAME = "promotional_booth_1496.obj";
// String MODEL_PATH = "../_allmodelsP5/208142394/";  String MODEL_NAME = "round_display_table_1375.obj";
// String MODEL_PATH = "../_allmodelsP5/212779653/";  String MODEL_NAME = "slat_rack_display_1434.obj";
// String MODEL_PATH = "../_allmodelsP5/210882383/";  String MODEL_NAME = "tall_jewelry_display_1427.obj";
// String MODEL_PATH = "../_allmodelsP5/212779768/";  String MODEL_NAME = "tiered_corner_table_1386.obj";
// String MODEL_PATH = "../_allmodelsP5/214005530/";  String MODEL_NAME = "woven_basket_display_1438.obj";
// String MODEL_PATH = "../_allmodelsP5/207431046/";  String MODEL_NAME = "assorted_display_cubes_1433.obj";
// String MODEL_PATH = "../_allmodelsP5/212779366/";  String MODEL_NAME = "boxes_wall_display_1391.obj";
// String MODEL_PATH = "../_allmodelsP5/212779421/";  String MODEL_NAME = "cube_display_box_1367.obj";




 

/* ------------------------------------------------------------------------- */

void  settings () {
  size(2000, 1000, P3D); // FX2D can't load OBJs?
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
  background(-1);
  cX = width/2;
  cY = height/2;

  //	NOTE: this sketch assumes all Adobe Stock modes live in P5 root/_allmodelsP5/
  //	HACKY time saver
println("load: "+ MODEL_PATH + MODEL_NAME );
  s = loadShape( MODEL_PATH + MODEL_NAME );
  // s.scale(preScale); 


	fill(#EF4300);
	text( MODEL_NAME, preScale, height-preScale );  
}



void draw() {

	if(s!=null){

  x = cX;  // - (s.width/2);
  y = cY;

  // debug
  println("s.height, s.width : " + s.height +", "+ s.width );


  // 3D code
  // hint(DISABLE_DEPTH_TEST);
  camera();
  // noLights();
  lights();


  translate(x, y, frameCount );

  for (int i = 0; i < 361; i += inc )
  {
    pushMatrix();

    	//	P5 has shape rotate bug now
		// s.rotate(i);
		rotate(i);

    	//	get first vertex in shape for coloring
    	// v = s.getVertex( s.getVertexCount()-1 );

		if(lights)
		{
			//	TODO: hook these lights into dynamic shape coordinates
			//	getVertex not working?!?!?
			// ambientLight((frameCount%111), v.x%111, v.y%111 );
			// emissive( v.y%111,(frameCount%111), v.x%111 );
			// specular( v.x%111, v.y%111,(frameCount%111));
			
			//	NOTE: can only create 8 lights
			if(i<8){
			ambientLight((frameCount*i%111), (cX*i)%111, (cY*i)%111 );
			emissive( (cY*i)%111,(frameCount*i%111), (cX*i)%111 );
			specular( (cX*i)%111, (cY*i)%111,(frameCount*i%111));
			}
		}

	  	if(fillStyle)
	    {
	  		s.disableStyle();
			//	TODO: hook these lights into dynamic shape coordinates
			//	getVertex not working?!?!?

	  		s.setStroke( color((frameCount*i%255), (cX*i)%255, (cY*i)%255 ) );
	  		stroke((frameCount*i%255), (cX*i)%255, (cY*i)%255  );
	  		fill((frameCount*i%255), (cX*i)%255, (cY*i)%255 );
	    	tint((frameCount*i%255), (cX*i)%255, (cY*i)%255  );
	  	}
		
		shape(s);

    popMatrix();


  }

  doExit();

  }
}




/**
  End of sketch closer
*/
void doExit(){
	
  // 2D code
  hint(ENABLE_DEPTH_TEST);

	String msg = MODEL_NAME.toUpperCase() + "_" + preScale + "_" + inc + "_" + lights + "_" + fillStyle;// + " - ericfickes.com";

	//	NOTE: 3D has dimensions all jacked up
	//  stamp bottom right based on textSize
	fill(#EF4300);
	textSize(43);
	// text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());
	text(msg, cY-(textWidth(msg)+textAscent()), cY-preScale);

  //	SAVE W/META FOR RE-RUN HELP
  save( fix.pdeName() + "-"+ MODEL_NAME.toUpperCase() + "_" + preScale + "_" + inc + "_" + lights + "_" + fillStyle + "-" + fix.getTimestamp()+".tif" );    //  USE .TIF IF COLOR  
  
  //  cleanup
  fix = null;
  s = null;

  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
