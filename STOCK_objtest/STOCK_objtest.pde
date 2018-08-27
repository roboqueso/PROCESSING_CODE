/**
NOTE: large OBJs cause this sketch to choke
** local machine problem perhaps?
*/


// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

ArrayList<PShape> shapes = new ArrayList<PShape>();
PShape s;
float x, y;
PVector vect = new PVector();

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

  shapes.add( loadShape( "../_allmodelsP5/172516642/stationary_003.obj" ) );
  // shapes.add( loadShape("keychain/key_chain_031.obj"));
  // shapes.add( loadShape("openfolder/open_folder_1582.obj"));
  // shapes.add( loadShape("rolledupnewspaper/rolled_up_newspaper_1554.obj"));
  // shapes.add( loadShape("smallcardboardtube/small_cardboard_tube_1555.obj"));
  // shapes.add( loadShape("talljewelrydisplay/tall_jewelry_display_1427.obj"));
  // shapes.add( loadShape("twoenvelopes/two_envelopes_1562.obj"));
  // shapes.add( loadShape("blankpackaginghandles1518/blank_packaging_handles_1518.obj") );
  // shapes.add( loadShape("boxtallClosed/box_tallClosed.obj") );
  // shapes.add( loadShape("canvastotebag1488/canvas_tote_bag_1488.obj") );
  // shapes.add( loadShape("cdSleevehalfOut/cdSleeve_halfOut.obj") );
  // shapes.add( loadShape("compositionnotebook1529/composition_notebook_1529.obj") );
  // shapes.add( loadShape("deskcalendar/desk_calendar_004.obj") );
  // shapes.add( loadShape("keychain/key_chain_031.obj") );
  // shapes.add( loadShape("openfolder/open_folder_1582.obj") );
  // shapes.add( loadShape("rolledupnewspaper/rolled_up_newspaper_1554.obj") );
  // shapes.add( loadShape("smallcardboardtube/small_cardboard_tube_1555.obj") );
  // shapes.add( loadShape("talljewelrydisplay/tall_jewelry_display_1427.obj") );
  // shapes.add( loadShape("twoenvelopes/two_envelopes_1562.obj") );




}


void draw() 
{
  // pick random shape
  // s = shapes.get( (int)random(shapes.size()-1) );
s = shapes.get( frameCount%shapes.size() );

  if(s!=null){

	// 3D code
	hint(DISABLE_DEPTH_TEST);
	camera();
	lights(); //    because P3D


//  get the point
	x = random(frameCount,width);
	y = random(frameCount,height);
	vect = fix.circleXY( x, y, frameCount%(width/2), frameCount%360 );


	ambientLight(vect.x, vect.y,(frameCount%255));
	emissive(vect.x, vect.y,(frameCount%255) );
	specular(vect.x, vect.y,(frameCount%255) );
 
	s.disableStyle();

	  
	translate(x,y,frameCount%y);
	  
	pushMatrix();

  		s.rotateX(frameCount%360);
  		s.rotateY(frameCount%360);
  		s.rotateZ(frameCount%360);
	  	shape(s, x, y);

	  popMatrix();

	} 
  else 
  {
		delay(666); // maybe just chill for a bit
    println("no S? " + shapes.size() );
	}

  if(frameCount >= width )
  {
    save(fix.pdeName()+fix.getTimestamp()+".png");
    noLoop();
    exit();
  }
  
}