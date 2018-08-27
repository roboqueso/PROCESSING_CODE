/**
stock_ModelSpiral
*/


// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);

ArrayList<PShape> shapes = new ArrayList<PShape>();
PShape s;
float x, y;
PVector vect = new PVector();
Boolean fillStyle = false;	//	TRUE: fill w/x,y or FALSE: leave style as is
int radius = 43;	//	circle radius
int getRad = (int)(width/4);	//	Radius increaser
int frameMod = getRad;	//8;	// % frameCount to control how many shapes get laid down
int ss = 0;	//	shape index

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

// TODO: get modesl into ROOT P5 folder on both machine
//  NOT: in each sketch data

shapes.add( loadShape( "../_allmodelsP5/124696601/outdoor_poleSign.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/213242244/rectangular_chalkboard_1349.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/208142479/tall_spray_can_1530.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/125101917/food_cartonPour.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/214995074/tied_letter_bundle_1548.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/124701338/twistJar_labeled.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/209726949/canvas_tote_bag_1488.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/211014911/plastic_cup_lid_1512.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/207432973/hexagonal_display_structure_1411.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/209727135/open_tied_envelope_1558.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/124698794/recordCover_halfOut.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/213242160/open_magazine_back_1568.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/124695116/led_singleSign2.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/124693258/food_barStout.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/209728101/tied_string_card_1546.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/125240735/box_handledClosed.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/205410505/bottle_with_dropper_196.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/210882235/rolled_up_newspaper_1554.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/190403607/button_030.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/208142389/portable_perfume_spray_1460.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/209726892/blank_packaging_handles_1518.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/182469832/a_luggage_tag_231.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/125241092/phone_4_3.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/124824860/dvdCase_closed.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/125101964/food_pouchZip.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/124821335/bag_ropeHandled_square.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/124701290/tube_flipTop.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/208142394/round_display_table_1375.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/124822996/box_tallClosed.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/212779478/long_tied_envelope_1557.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/209727034/open_envelope_card_1572.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/214005530/woven_basket_display_1438.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/213241878/business_card_fan_1579.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/178262537/lanyard_022.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/209727191/packet_stack_1560.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/207432978/hanging_rope_poster_1499.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/214005311/two_business_cards_1581.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/212779386/clamp_top_bottle_1531.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/190403568/a_business_cards_002.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/207431342/open_folder_1582.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/207433028/male_mannequin_head_1325.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/212779475/modern_jar_1473.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/172516460/business_cards_002b.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/207432898/closed_wide_envelope_1566.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/208142303/neck_jewelry_display_1418.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/207431140/business_card_pile_1580.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/209727496/two_envelopes_1562.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/212779366/boxes_wall_display_1391.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/212779768/tiered_corner_table_1386.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/213242412/small_cardboard_tube_1555.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/210882136/pos_big_booth_1455.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/209728013/stack_envelopes_1574.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/213242116/matte_coffee_bag_1509.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/207431046/assorted_display_cubes_1433.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/209727335/tied_string_box_1547.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/209726889/box_dispenser_1487.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/190403630/juice_box_a_082.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/134637986/tablet_4_3.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/184479727/business_cards_001.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/209727994/promotional_booth_1496.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/124690437/bottle_sprayLid.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/207432882/closed_long_envelope_1565.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/177154561/id_card_021.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/172516644/key_chain_031.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/212779421/cube_display_box_1367.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/201384220/thermos_289.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/124700577/stand_singleSign2.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/172516539/gift_box_192b.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/182473223/a_pill_bottle_1_204.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/207431428/pos_store_steps_1447.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/184479554/b_decorative_box_175.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/172516642/stationary_003.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/199461298/can_insulator_128.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/134633983/can_drink.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/213242425/takeaway_box_handles_1507.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/208142166/composition_notebook_1529.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/212779653/slat_rack_display_1434.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/210882332/stationary_papers_1544.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/124700429/stand_doubleSigns.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/218401617/product_package_box_1286.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/210882383/tall_jewelry_display_1427.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/213242292/resealable_packaging_1523.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/212779556/pos_store_shelves_1441.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/125240811/cdSleeve_halfOut.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/123690361/bag_cutoutHandled_wide.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/124822938/box_drawerOpened.obj" ) );
shapes.add( loadShape( "../_allmodelsP5/209727039/open_envelope_letter_1571.obj" ) );


delay(666);	//	just cause
println("Here we go!");

}


void draw() 
{
  // pick random shape
  s = shapes.get( ss );
  // s = shapes.get( frameCount%shapes.size() );

// debug
println(frameCount%shapes.size());

  if(s!=null )
  {
//  get the point
  x = width/2;  // random(frameCount,width);
  y = height/2;  // random(frameCount,height);

  vect = fix.circleXY( x, y, radius, frameCount%360 );

 if(frameCount%frameMod==0){
  // reset X/Y to circle coordinates
  x = vect.x;
  y = vect.y;

  // SAVE THE SHINY STUFF FOR ONCE THE CONCEPT IS PROVEN
  // hint(DISABLE_DEPTH_TEST);
  // camera();
  // lights(); //    because P3D
  // ambientLight(x%255, y%255,(frameCount%255));
  // emissive(x%255, y%255,(frameCount%255) );
  // specular(x%255, y%255,(frameCount%255) );

	translate(x,y,1);//frameCount%y);
  
    pushMatrix();

//	USING box(43) FOR DEBUG PURPOSES
//	box(43);

	s.rotateX(frameCount);
	s.rotateY(frameCount);
	s.rotateZ(frameCount);


	if(fillStyle){
		s.disableStyle();
		//	TODO: you can't stroke shapes?
		s.setStroke( color((frameCount%255)) );
		stroke((frameCount%255) );
		fill(x%255, y%255,(frameCount%255) );
	}

	shape(s);

    popMatrix();


}	// end frameChecker

    //  increase radius every full circle
    if( frameCount % 360==0 )
    {
      radius += getRad;

      // increase shape counter to next one
      ss = (ss+1)%shapes.size();
    }

  } 
  else 
  {
    delay(666); // maybe just chill for a bit
    println("no S? " + shapes.size() );
  }

  if( radius > height)
  {
    save(fix.pdeName()+fix.getTimestamp()+".png");
    noLoop();
    exit();
  } else {
    //  debug
    println("radius: ["+frameCount+"]" + radius);
  }
  
}
