/**
STOCK_ModelSpiralUno
  - same as STOCK_ModelSpiral, only this only lays out one of each shape then bounces
  - groups by category ( re-run on PC for textures )

*/


// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

ArrayList<PShape> shapes = new ArrayList<PShape>();
PShape s;
float cX, cY, x, y;
PVector vect = new PVector();
Boolean lights =  true;  //  EXTRA lights
Boolean fillStyle = true;  //  TRUE: fill w/x,y or FALSE: leave style as is
Boolean mouseCam = false;  // Maps camera() to mouse movement See: https://processing.org/tutorials/p3d/
int radius = 222;  //303; //222;	//24;	//	circle radius
// int getRad = 111; //100;	//	Radius increaser
// int frameMod = 12;//13;  //8;	// % frameCount to control how many shapes get laid down
int preScale = 3;//13; //3;	//	pre-scale up shapes if needed
int ss = 0;	//	shape index
String GROUP =  "BOXES";	// "BOXES", "BRAND", "BUSINESS", "DISPLAYS", "LIQUIDS"


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
  cX = width/2;
  cY = height/2;

//  DEBUG FOR DN
println("cX, cY: "+ cX +"," +cY );
println("radius (start): "+ radius );

//  NOTE: this sketch assumes all Adobe Stock modes live in P5 root/_allmodelsP5/

switch(GROUP){

  case "BOXES":
  {
    //  * BOXES *
    shapes.add( loadShape( "../_allmodelsP5/184479554/b_decorative_box_175.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/209726889/box_dispenser_1487.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/124822996/box_tallClosed.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/212779366/boxes_wall_display_1391.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/212779421/cube_display_box_1367.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/172516539/gift_box_192b.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/190403630/juice_box_a_082.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/218401617/product_package_box_1286.obj" ) );
  }
  break;
  

	case "BRAND":
	{
		//  * BRAND *
    shapes.add( loadShape( "../_allmodelsP5/212779421/cube_display_box_1367.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/213242412/small_cardboard_tube_1555.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/190403568/a_business_cards_002.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/213242160/open_magazine_back_1568.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/184479727/business_cards_001.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/124822938/box_drawerOpened.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/172516539/gift_box_192b.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/199461298/can_insulator_128.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/172516460/business_cards_002b.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/208142479/tall_spray_can_1530.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/123690361/bag_cutoutHandled_wide.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/212779386/clamp_top_bottle_1531.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/218401617/product_package_box_1286.obj" ) );    
    shapes.add( loadShape( "../_allmodelsP5/184479554/b_decorative_box_175.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/207433028/male_mannequin_head_1325.obj" ) );
	}
	break;
	
	case "BUSINESS":
	{

		//  * FOR THE BUSINESS *
		//	these need to be scaled up
		shapes.add( loadShape( "../_allmodelsP5/209727496/two_envelopes_1562.obj" ) );
		shapes.add( loadShape( "../_allmodelsP5/214005311/two_business_cards_1581.obj" ) );
		shapes.add( loadShape( "../_allmodelsP5/209728013/stack_envelopes_1574.obj" ) );
		shapes.add( loadShape( "../_allmodelsP5/207431140/business_card_pile_1580.obj" ) );
		shapes.add( loadShape( "../_allmodelsP5/213241878/business_card_fan_1579.obj" ) );
		shapes.add( loadShape( "../_allmodelsP5/190403568/a_business_cards_002.obj" ) );
		shapes.add( loadShape( "../_allmodelsP5/184479727/business_cards_001.obj" ) );
		shapes.add( loadShape( "../_allmodelsP5/172516460/business_cards_002b.obj" ) );

	}
	break;
	
	case "DISPLAYS":
	{
		// //  * DISPLAYS *

		shapes.add( loadShape( "../_allmodelsP5/210882136/pos_big_booth_1455.obj" ) );
		shapes.add( loadShape( "../_allmodelsP5/212779556/pos_store_shelves_1441.obj" ) );
		shapes.add( loadShape( "../_allmodelsP5/207431428/pos_store_steps_1447.obj" ) );
		shapes.add( loadShape( "../_allmodelsP5/209727994/promotional_booth_1496.obj" ) );
		shapes.add( loadShape( "../_allmodelsP5/208142394/round_display_table_1375.obj" ) );
		shapes.add( loadShape( "../_allmodelsP5/212779653/slat_rack_display_1434.obj" ) );
		shapes.add( loadShape( "../_allmodelsP5/210882383/tall_jewelry_display_1427.obj" ) );
		shapes.add( loadShape( "../_allmodelsP5/212779768/tiered_corner_table_1386.obj" ) );
		shapes.add( loadShape( "../_allmodelsP5/214005530/woven_basket_display_1438.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/207431046/assorted_display_cubes_1433.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/212779366/boxes_wall_display_1391.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/212779421/cube_display_box_1367.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/207432973/hexagonal_display_structure_1411.obj" ) );
	}
	break;

	case "LIQUIDS":
	{
		//  * LIQUIDS *
		//	NUMERICAL ORDER, these models are rather small
    shapes.add( loadShape( "../_allmodelsP5/124690437/bottle_sprayLid.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/134633983/can_drink.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/182473223/a_pill_bottle_1_204.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/190403630/juice_box_a_082.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/199461298/can_insulator_128.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/201384220/thermos_289.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/205410505/bottle_with_dropper_196.obj" ) );
    shapes.add( loadShape( "../_allmodelsP5/211014911/plastic_cup_lid_1512.obj" ) );
	}
	break;
}









//	PRE-SCALE IF NEEDED
if(preScale>1){

//  DEBUG FOR DN
println("preScale: "+ preScale );

	for(PShape shp : shapes){
		println("preScaling: " + shp);
		shp.scale(preScale);
	}
}
  // pick shape
  s = shapes.get( ss );

println("\n   Here we go! \n ");

}


void draw() 
{
  //  ENDER
  if( ss > shapes.size() )
  {
    println("ss: "+ss);
    doExit();
  }
  else
  {

  if(s!=null )
  {
    //  get the point
    vect = fix.circleXY( cX, cY, radius, ss*(width/shapes.size()) );
    // reset X/Y to circle coordinates
    
    x = vect.x;// DISPLAY MODELS ARE UPSIDE DOWN?
    y = vect.y;

   if(mouseCam)
   {
  	camera(mouseX, cY, (cY) / tan(PI/6), mouseX, cY, 0, 0, 1, 0);
   }
  //  else{
  //   camera(cX, cY, (cY) / tan(PI/6), cX, cY, 0, 0, 1, 0);
  // }

   
  lights(); //    because P3D

  if(lights){
    ambientLight((frameCount%111), x%111, y%111 );
    emissive(y%111,(frameCount%111),x%111 );
    specular(x%111, y%111,(frameCount%111));
  }

	translate(x,y, ss+frameCount);

//  DEBUG FOR DN
println("translate(x,y, ss+frameCount) : " + x+","+y+","+(ss+frameCount) );

  
  pushMatrix();

  	// s.rotateX(frameCount);	//radians(frameCount));
  	// s.rotateY( ss*(width/shapes.size()) );
  	// s.rotateZ(frameCount);

//  DISPLAY MODELS ARE UPSIDE DOWN?
s.rotateX(cos(frameCount));
s.rotateY(sin(frameCount));
s.rotateZ(frameCount);

    // s.rotateY( cos( radians(frameCount)) );
    // s.rotate( frameCount);
//  DEBUG FOR DN
println("rotate: "+ frameCount +"\n\n");  //  *(width/shapes.size())

  	if(fillStyle)
    {
  		s.disableStyle();
  		//	TODO: you can't stroke shapes?
  		s.setStroke( color((frameCount%255), x%255, y%255 ) );
  		stroke((frameCount%255), x%255, y%255  );
  		fill((frameCount%255),x%255, y%255 );
    	tint((frameCount%255), x%255, y%255  );
  	}
  	shape(s);

  popMatrix();

  // pick shape
  s=null;
  ss++;
  // radius+=getRad;
// }	// end frameChecker

//     //  increase radius every full circle
//     if( frameCount % 360==0 )
//     {
//       radius += getRad;

//       // increase shape counter to next one
//       ss = (ss+1)%shapes.size();

//       //  debug
//       println("level up: "+ radius + " : " + s);
//     }

  } 
  else 
  {
      s = shapes.get(ss%shapes.size());
  }

}
  
}

/**
  End of sketch closer
*/
void doExit(){
  String msg = GROUP;// + " - ericfickes.com";
  //  stamp bottom right based on textSize
  fill(0);
  textSize(16);
  text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());

  //	SAVE W/META FOR RE-RUN HELP
  //	NAME-GROUP-lights_fillStyle_radius_preScale-TIMESTAMP
  save( fix.pdeName() + "-"+ GROUP + "_" + lights + "_" + fillStyle + "_" + radius + "_" + preScale + "-"+ fix.getTimestamp()+".png" );    //  USE .TIF IF COLOR  
  
  //  cleanup
  fix = null;
  shapes = null;

  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
