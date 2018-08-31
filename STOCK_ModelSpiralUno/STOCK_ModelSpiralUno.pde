/**
STOCK_ModelSpiralUno
  - same as STOCK_ModelSpiral, only this only lays out one of each shape then bounces
  - groups by category ( re-run on PC for textures )

https://stock.adobe.com/collections/G8eYeCWZyF0PMNOZZxgVNzpNFPADcljj?content_id=209726889

// TODO: Run 100% of the free stock.adobe.com OBJs through this

	172516642/stationary_003.obj
210882332/stationary_papers_1544.obj
190403568/a_business_cards_002.obj
184479727/business_cards_001.obj
201384220/thermos_289.obj
172516539/gift_box_192b.obj
207432973/hexagonal_display_structure_1411.obj
177154561/id_card_021.obj
214005311/two_business_cards_1581.obj
184479554/b_decorative_box_175.obj
190403630/juice_box_a_082.obj
207432898/closed_wide_envelope_1566.obj
207431342/open_folder_1582.obj
205410505/bottle_with_dropper_196.obj
212779366/boxes_wall_display_1391.obj
212779421/cube_display_box_1367.obj
207432882/closed_long_envelope_1565.obj
182473223/a_pill_bottle_1_204.obj
213242244/rectangular_chalkboard_1349.obj
209727496/two_envelopes_1562.obj
213242412/small_cardboard_tube_1555.obj
213242160/open_magazine_back_1568.obj
208142303/neck_jewelry_display_1418.obj
169851082/desk_calendar_004.obj
208142394/round_display_table_1375.obj
199461298/can_insulator_128.obj
208142389/portable_perfume_spray_1460.obj
220282959/rolled_up_newspaper_1554.obj
207431428/pos_store_steps_1447.obj
210882383/tall_jewelry_display_1427.obj
124690437/bottle_sprayLid.obj
172516644/key_chain_031.obj
124698794/recordCover_halfOut.obj
207431140/business_card_pile_1580.obj
213241878/business_card_fan_1579.obj
124822996/box_tallClosed.obj
207433028/male_mannequin_head_1325.obj
210882136/pos_big_booth_1455.obj
218401617/product_package_box_1286.obj
124824860/dvdCase_closed.obj
212779768/tiered_corner_table_1386.obj
124695116/led_singleSign2.obj
134633983/can_drink.obj
209726892/blank_packaging_handles_1518.obj
209726889/box_dispenser_1487.obj
190403607/button_030.obj
125240735/box_handledClosed.obj
208142479/tall_spray_can_1530.obj
209728101/tied_string_card_1546.obj
209727034/open_envelope_card_1572.obj
209727039/open_envelope_letter_1571.obj
207431394/pos_store_display_1431.obj
124701290/tube_flipTop.obj
125101964/food_pouchZip.obj
212779386/clamp_top_bottle_1531.obj
124700429/stand_doubleSigns.obj
178262537/lanyard_022.obj
125101917/food_cartonPour.obj
212779475/modern_jar_1473.obj
182469832/a_luggage_tag_231.obj
213242292/resealable_packaging_1523.obj
124822938/box_drawerOpened.obj
212779478/long_tied_envelope_1557.obj
212779556/pos_store_shelves_1441.obj
125240811/cdSleeve_halfOut.obj
124696601/outdoor_poleSign.obj
213242425/takeaway_box_handles_1507.obj
124693258/food_barStout.obj
123690361/bag_cutoutHandled_wide.obj
209727335/tied_string_box_1547.obj
207431046/assorted_display_cubes_1433.obj
213242116/matte_coffee_bag_1509.obj
214005530/woven_basket_display_1438.obj
209727135/open_tied_envelope_1558.obj
124701338/twistJar_labeled.obj
209726949/canvas_tote_bag_1488.obj
208142166/composition_notebook_1529.obj
172516460/business_cards_002b.obj
125241092/phone_4_3.obj
209728013/stack_envelopes_1574.obj
124821335/bag_ropeHandled_square.obj
211014911/plastic_cup_lid_1512.obj
214995074/tied_letter_bundle_1548.obj
207432978/hanging_rope_poster_1499.obj
209727191/packet_stack_1560.obj
124700577/stand_singleSign2.obj
212779653/slat_rack_display_1434.obj
134637986/tablet_4_3.obj

// NOTE: this ALL list is missing 1 model


** dial in preScale
** the record OBJ

* render high gloss models

*/


// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

//	NOTE: NO NERVOUS SYSTEM FOR MAC?!?!?!
//	import nervoussystem.obj.*;


//	SETTINGS

boolean recordObj = false;	//	export to OBJ, requires import nervoussystem.obj.*
Boolean lights =   true;  //  EXTRA lights
Boolean fillStyle =   true;  //  TRUE: fill w/x,y or FALSE: leave style as is
Boolean rotateGolden = true;	// Default to TRUE, not all OBJs look good on true
Boolean mouseCam = false;  // Maps camera() to mouse movement See: https://processing.org/tutorials/p3d/
int radius = 303; //222;	//24;	//	circle radius
float preScale = 2;	//	pre-scale up shapes if needed
String OBJ_NAME = "207432973/hexagonal_display_structure_1411.obj";	//	FOR META
String GROUP =  "FIXBOMB";	// "FIXBOMB", BOXES", "BRAND", "BUSINESS", "DISPLAYS", "LIQUIDS"


//	END SETTINGS



Fixlib fix = Fixlib.init(this);
ArrayList<PShape> shapes = new ArrayList<PShape>();
PShape s;
float cX, cY, x, y;
PVector vect = new PVector();
int ss = 0;	//	shape index
String SAVE_NAME = "thisShouldBeDynamic";
float GR = (sqrt(5) + 1) * 0.5;  // TWO_PI* - golden ratio

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


//  THIS SKETCH EXPECTS shapes to always be filled
    
    //  NOTE: this sketch assumes all Adobe Stock modes live in P5 root/_allmodelsP5/
    switch(GROUP){
    
      case "FIXBOMB":
      {
      	for(int ii = 1; ii <=36; ii++){
	        //  * MUST BE 36 for current STOCK.ADOBE.COM project *
	        shapes.add( loadShape( "../_allmodelsP5/"+OBJ_NAME ) );
        }

      }
      break;
      
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
    
    
    

  cX = width/2;
  cY = height/2;

	//	Generate filename containing sketch settings meta NOW
	SAVE_NAME = fix.pdeName() + "-"+ OBJ_NAME.toUpperCase().replace("/",".") + "_" + shapes.size() + "_" + lights + "_" + fillStyle + "_" + rotateGolden + "_" + radius + "_" + preScale + "-"+ fix.getTimestamp();


//  DEBUG FOR DN
println("cX, cY: "+ cX +"," +cY );
println("radius : "+ radius );

    
    
    
    
    
    
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

	//	LET'S MAKE AN OBJ!
	if (recordObj) {
		beginRecord("nervoussystem.obj.OBJExport", SAVE_NAME + ".obj");
	}

println("\n   Here we go! \n ");

}


void draw() 
{
  //  ENDER
  if( ss > shapes.size() )
  {
    println("PEACE OUT!: "+ss);
    doExit();
  }
  else
  {


  if(s!=null )
  {
    //  get the point
    vect = fix.circleXY( cX, cY, radius, ss*(360/shapes.size()) );
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

//	111
  if(lights){
  	// adding GR* spice
    ambientLight((GR*frameCount%160), x%160, y%160 );
    emissive(y%160,(GR*frameCount%160),x%160 );
    specular(x%160, y%160,(GR*frameCount%160));
  }

	translate(x,y);//,1);// ss+frameCount);

//  DEBUG FOR DN
println("translate(x,y, ss+frameCount) : " + x+","+y+","+(ss+frameCount) );

  
  pushMatrix();

	//	Keep your rotation Golden!
	if(rotateGolden){
		s.rotateX(frameCount*GR);
		s.rotateY(frameCount*GR);
		s.rotateZ(frameCount*GR);
	}else{
		s.rotate(frameCount);
	}


//  DEBUG FOR DN
println("rotate: "+ frameCount +"\n\n");  //  *(width/shapes.size())

  	if(fillStyle)
    {
    	//	STROKE DOESN'T WORK!?
  		s.disableStyle();
  		fill( color( y%210,x%210,(frameCount%210)) );
  	}
    
//	PRIMITIVES FOR DEBUGGING
// rotateX(cos(frameCount));
// rotateY(sin(frameCount));
// rotateZ(frameCount);

// box(43);
// sphereDetail((int)random(3,12));
// sphere(43);

	shape(s);

  popMatrix();

  // pick shape
  //s=null;
  ss++;

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
void doExit()
{
	if(recordObj){
		endRecord();
		recordObj=false;
	}


  String msg = OBJ_NAME;//"ericfickes.com";
  ////  stamp bottom right based on textSize
  fill(0);
  textSize(36);
  //  OG BOTTOM RIGHT STAMP
  //text(msg, width-(textWidth(msg)+textAscent())+24, height-textAscent()+24);
  //  NEW RIGHT VERTICAL STAMP
  textAlign(CENTER,BOTTOM);
  pushMatrix();
    translate(width-TWO_PI, cY);
    rotate(-HALF_PI);
    text(msg,0,0);
  popMatrix();

  //	SAVE W/META FOR RE-RUN HELP
  //	NAME-GROUP-lights_fillStyle_radius_preScale-TIMESTAMP
  save( SAVE_NAME +".png" );    //  USE .TIF IF COLOR  

  //  cleanup
  fix = null;
  shapes = null;



  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
