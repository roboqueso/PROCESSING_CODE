/*
STOCK_grid  : HGridLayou STOCK OBJS
* BLOOD-DRAGON : 1920 x 1071
* size(displayWidth, displayHeight, P3D)
* HDR w, h is 2x1 EX: 2048, 1024

if(color)
  GO TIFF
  TIFF = Tagged Image File Format. This is one of the most complex image formats, and it can hold more kinds and depth of information than almost any other format. The standard is owned and maintained by Adobe.
else
  PNG


*/

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import fixlib.*;

/* ------------------------------------------------------------------------- */
Fixlib fix = Fixlib.init(this);
HDrawablePool pool;

int gridX,gridY;
int colCt = 5;
int rowCt = colCt;  //  NOTE: remember to update this value
int colSpacing = 8;
int drawW, drawH; //  HDrawable Width / Height

/* ------------------------------------------------------------------------- */
Boolean lights =  true;  //  EXTRA lights
Boolean fillStyle = true;  //  TRUE: fill w/x,y or FALSE: leave style as is
// Boolean mouseCam = false;  // Maps camera() to mouse movement See: https://processing.org/tutorials/p3d/

int ss = 0; //  shape index

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

  //  init VARIABLES
  drawW = (int)( (width-(colSpacing))/colCt)-colSpacing;
  drawH = (int)( (height-(colSpacing))/rowCt)-colSpacing;
  gridX = drawW+colSpacing;  //(drawW/2)+colSpacing;
  gridY = (drawH/2)+colSpacing;

  //  init HYPE
  H.init(this).background(-1).use3D(true);

  pool = new HDrawablePool(colCt*rowCt);
  pool.autoAddToStage()
    
//  Running batches of 25 ATM

// .add( new HShape( "../_allmodelsP5/124696601/outdoor_poleSign.obj" ) )
// .add( new HShape( "../_allmodelsP5/213242244/rectangular_chalkboard_1349.obj" ) )
// .add( new HShape( "../_allmodelsP5/208142479/tall_spray_can_1530.obj" ) )
// .add( new HShape( "../_allmodelsP5/125101917/food_cartonPour.obj" ) )
// .add( new HShape( "../_allmodelsP5/214995074/tied_letter_bundle_1548.obj" ) )
// .add( new HShape( "../_allmodelsP5/124701338/twistJar_labeled.obj" ) )
// .add( new HShape( "../_allmodelsP5/209726949/canvas_tote_bag_1488.obj" ) )
// .add( new HShape( "../_allmodelsP5/211014911/plastic_cup_lid_1512.obj" ) )
// .add( new HShape( "../_allmodelsP5/207432973/hexagonal_display_structure_1411.obj" ) )
// .add( new HShape( "../_allmodelsP5/209727135/open_tied_envelope_1558.obj" ) )
// .add( new HShape( "../_allmodelsP5/124698794/recordCover_halfOut.obj" ) )
// .add( new HShape( "../_allmodelsP5/213242160/open_magazine_back_1568.obj" ) )
// .add( new HShape( "../_allmodelsP5/124695116/led_singleSign2.obj" ) )
// .add( new HShape( "../_allmodelsP5/124693258/food_barStout.obj" ) )
// .add( new HShape( "../_allmodelsP5/209728101/tied_string_card_1546.obj" ) )
// .add( new HShape( "../_allmodelsP5/125240735/box_handledClosed.obj" ) )
// .add( new HShape( "../_allmodelsP5/205410505/bottle_with_dropper_196.obj" ) )
// .add( new HShape( "../_allmodelsP5/210882235/rolled_up_newspaper_1554.obj" ) )
// .add( new HShape( "../_allmodelsP5/190403607/button_030.obj" ) )
// .add( new HShape( "../_allmodelsP5/208142389/portable_perfume_spray_1460.obj" ) )
// .add( new HShape( "../_allmodelsP5/209726892/blank_packaging_handles_1518.obj" ) )
// .add( new HShape( "../_allmodelsP5/182469832/a_luggage_tag_231.obj" ) )
// .add( new HShape( "../_allmodelsP5/125241092/phone_4_3.obj" ) )
// .add( new HShape( "../_allmodelsP5/124824860/dvdCase_closed.obj" ) )
// .add( new HShape( "../_allmodelsP5/125101964/food_pouchZip.obj" ) )


// .add( new HShape( "../_allmodelsP5/124821335/bag_ropeHandled_square.obj" ) )
// .add( new HShape( "../_allmodelsP5/124701290/tube_flipTop.obj" ) )
// .add( new HShape( "../_allmodelsP5/208142394/round_display_table_1375.obj" ) )
// .add( new HShape( "../_allmodelsP5/124822996/box_tallClosed.obj" ) )
// .add( new HShape( "../_allmodelsP5/212779478/long_tied_envelope_1557.obj" ) )
// .add( new HShape( "../_allmodelsP5/209727034/open_envelope_card_1572.obj" ) )
// .add( new HShape( "../_allmodelsP5/214005530/woven_basket_display_1438.obj" ) )
// .add( new HShape( "../_allmodelsP5/213241878/business_card_fan_1579.obj" ) )
// .add( new HShape( "../_allmodelsP5/178262537/lanyard_022.obj" ) )
// .add( new HShape( "../_allmodelsP5/209727191/packet_stack_1560.obj" ) )
// .add( new HShape( "../_allmodelsP5/207432978/hanging_rope_poster_1499.obj" ) )
// .add( new HShape( "../_allmodelsP5/214005311/two_business_cards_1581.obj" ) )


.add( new HShape( "../_allmodelsP5/212779386/clamp_top_bottle_1531.obj" ) )
.add( new HShape( "../_allmodelsP5/190403568/a_business_cards_002.obj" ) )
.add( new HShape( "../_allmodelsP5/207431342/open_folder_1582.obj" ) )
.add( new HShape( "../_allmodelsP5/207433028/male_mannequin_head_1325.obj" ) )
.add( new HShape( "../_allmodelsP5/212779475/modern_jar_1473.obj" ) )
.add( new HShape( "../_allmodelsP5/172516460/business_cards_002b.obj" ) )
.add( new HShape( "../_allmodelsP5/207432898/closed_wide_envelope_1566.obj" ) )
.add( new HShape( "../_allmodelsP5/208142303/neck_jewelry_display_1418.obj" ) )
.add( new HShape( "../_allmodelsP5/207431140/business_card_pile_1580.obj" ) )
.add( new HShape( "../_allmodelsP5/209727496/two_envelopes_1562.obj" ) )
.add( new HShape( "../_allmodelsP5/212779366/boxes_wall_display_1391.obj" ) )
.add( new HShape( "../_allmodelsP5/212779768/tiered_corner_table_1386.obj" ) )
.add( new HShape( "../_allmodelsP5/213242412/small_cardboard_tube_1555.obj" ) )
.add( new HShape( "../_allmodelsP5/210882136/pos_big_booth_1455.obj" ) )
.add( new HShape( "../_allmodelsP5/209728013/stack_envelopes_1574.obj" ) )
.add( new HShape( "../_allmodelsP5/213242116/matte_coffee_bag_1509.obj" ) )
.add( new HShape( "../_allmodelsP5/207431046/assorted_display_cubes_1433.obj" ) )
.add( new HShape( "../_allmodelsP5/209727335/tied_string_box_1547.obj" ) )
.add( new HShape( "../_allmodelsP5/209726889/box_dispenser_1487.obj" ) )
.add( new HShape( "../_allmodelsP5/190403630/juice_box_a_082.obj" ) )
.add( new HShape( "../_allmodelsP5/134637986/tablet_4_3.obj" ) )
.add( new HShape( "../_allmodelsP5/184479727/business_cards_001.obj" ) )
.add( new HShape( "../_allmodelsP5/209727994/promotional_booth_1496.obj" ) )
.add( new HShape( "../_allmodelsP5/124690437/bottle_sprayLid.obj" ) )
.add( new HShape( "../_allmodelsP5/207432882/closed_long_envelope_1565.obj" ) )

// .add( new HShape( "../_allmodelsP5/177154561/id_card_021.obj" ) )
// .add( new HShape( "../_allmodelsP5/172516644/key_chain_031.obj" ) )
// .add( new HShape( "../_allmodelsP5/212779421/cube_display_box_1367.obj" ) )
// .add( new HShape( "../_allmodelsP5/201384220/thermos_289.obj" ) )
// .add( new HShape( "../_allmodelsP5/124700577/stand_singleSign2.obj" ) )
// .add( new HShape( "../_allmodelsP5/172516539/gift_box_192b.obj" ) )
// .add( new HShape( "../_allmodelsP5/182473223/a_pill_bottle_1_204.obj" ) )
// .add( new HShape( "../_allmodelsP5/207431428/pos_store_steps_1447.obj" ) )
// .add( new HShape( "../_allmodelsP5/184479554/b_decorative_box_175.obj" ) )
// .add( new HShape( "../_allmodelsP5/172516642/stationary_003.obj" ) )
// .add( new HShape( "../_allmodelsP5/199461298/can_insulator_128.obj" ) )
// .add( new HShape( "../_allmodelsP5/134633983/can_drink.obj" ) )
// .add( new HShape( "../_allmodelsP5/213242425/takeaway_box_handles_1507.obj" ) )
// .add( new HShape( "../_allmodelsP5/208142166/composition_notebook_1529.obj" ) )
// .add( new HShape( "../_allmodelsP5/212779653/slat_rack_display_1434.obj" ) )
// .add( new HShape( "../_allmodelsP5/210882332/stationary_papers_1544.obj" ) )
// .add( new HShape( "../_allmodelsP5/124700429/stand_doubleSigns.obj" ) )
// .add( new HShape( "../_allmodelsP5/218401617/product_package_box_1286.obj" ) )
// .add( new HShape( "../_allmodelsP5/210882383/tall_jewelry_display_1427.obj" ) )
// .add( new HShape( "../_allmodelsP5/213242292/resealable_packaging_1523.obj" ) )
// .add( new HShape( "../_allmodelsP5/212779556/pos_store_shelves_1441.obj" ) )
// .add( new HShape( "../_allmodelsP5/125240811/cdSleeve_halfOut.obj" ) )
// .add( new HShape( "../_allmodelsP5/123690361/bag_cutoutHandled_wide.obj" ) )
// .add( new HShape( "../_allmodelsP5/124822938/box_drawerOpened.obj" ) )
// .add( new HShape( "../_allmodelsP5/209727039/open_envelope_letter_1571.obj" ) )


    .layout (
      new HGridLayout()
      .startLoc(gridX, gridY)
      .spacing( drawW+colSpacing, drawH+colSpacing, colSpacing )
      .cols(colCt)
      .rows(rowCt)
    )

    .onCreate (
       new HCallback() {
        public void run(Object obj) {

  //  DO STUFF HERE
          HDrawable d = (HDrawable) obj;

          lights(); //    because P3D


          if(lights){
            hint(DISABLE_DEPTH_TEST);  //  TODO: does this really help?
            ambientLight(d.x()%255, d.y()%255,(frameCount%255));
            emissive(d.y()%255,(frameCount%255),d.x()%255 );
            specular((frameCount%255), d.x()%255, d.y()%255 );
          }
    
          if(fillStyle)
          {
              d
              .stroke((frameCount%255), (int)d.x()%255, (int)d.y()%255  )
              .fill((frameCount%255), (int)d.x()%255, (int)d.y()%255 );
          }

          d
            .size( drawW, drawH )
            .stroke( (int) d.x()%255, (int) d.y()%255, (int) d.z()%255 )
            .anchorAt(H.CENTER)
          ;
        


        }
      }
    )

    .requestAll()
  ;

  H.drawStage();
  doExit();
}





/* ------------------------------------------------------------------------- */
void draw() {
}







/* ------------------------------------------------------------------------- */
/*  NON - P5 BELOW  */
/* ------------------------------------------------------------------------- */

/**
  End of sketch closer
*/
void doExit(){
  String msg = "ericfickes.com";
  //  stamp bottom right based on textSize
  fill(0);
  textSize(16);
  text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());

  save( fix.pdeName() + "-" + fix.getTimestamp()+"_FINAL.png" );    //  USE .TIF IF COLOR  
  
  //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
