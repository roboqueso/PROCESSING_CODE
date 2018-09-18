/*
HAVATARS  : square one starting point P5/HYPE template sketch
* BLOOD-DRAGON : 1920 x 1071
* size(displayWidth, displayHeight, P3D)
* HDR w, h is 2x1 EX: 2048, 1024

NOTE: this loads HImages into HGridLayout
Figure out cool ways to 3D, shape, image texture

TODO:
- P5 your AVATARS
- bring in self photo for base
- HGridLayout
- Use PixelColorist

Create sketch with a block for each site avatar promoted on EF.com
Render P5 versions of avatar ( shape texture, HYPE etc... )
set 360 x 360 as default for all : TEST and tweak dimensions

networks
ELLO : 360 X 360 ( GIFs ok )
Behance : 200 x 200 ?
Google+ : 680 x 680 ?
Instagram : 312 x 312 ?
LinkedIn : 200 x 200 ?
Twitter : 520 x 520 ?

behance_ericfickes.png
ello_ericfickes.png
google+_ericfickes.png
instagram_ericfickes.png
linkedin_ericfickes.png
twitter_ericfickes.png



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
PFont font1;
HText lbl;

int gridX,gridY;
int colCt = 2;
int rowCt = 3;  //  NOTE: remember to update this value
int colSpacing = 8;
int drawW, drawH; //  HDrawable Width / Height


PImage imgBehance, imgEllo, imgGoogle, imgInstagram, imgLinkedin, imgTwitter;


/*
TODO: setup Devaskation color palette for HYPE

#000000, #ED7100, #315D15, #3D107B, #E35205, #FFFFFF

*/



/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(displayWidth, displayHeight, P3D); //"processing.opengl.PGraphics3D");
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */

void setup() {

	//  init VARIABLES
	drawW = (int)( (width-(colSpacing))/colCt)-colSpacing;
	drawH = (int)( (height-(colSpacing))/rowCt)-colSpacing;
	gridX = (drawW/2)+colSpacing;
	gridY = (drawH/2)+colSpacing;

	//	load avatar images
	imgBehance = loadImage("behance_ericfickes.png");
	imgEllo = loadImage("ello_ericfickes.png");
	imgGoogle = loadImage("google+_ericfickes.png");
	imgInstagram = loadImage("instagram_ericfickes.png");
	imgLinkedin = loadImage("linkedin_ericfickes.png");
	imgTwitter = loadImage("twitter_ericfickes.png");

font1 = createFont("AMCAP_Eternal.ttf", 24);

  //  init HYPE
  H.init(this).background(-1).use3D(true);

  pool = new HDrawablePool(colCt*rowCt);
  pool.autoAddToStage()
    .add ( new HImage( imgBehance ) )
    .add ( new HImage( imgEllo ) )
    .add ( new HImage( imgGoogle ) )
    .add ( new HImage( imgInstagram ) )
    .add ( new HImage( imgLinkedin ) )
    .add ( new HImage( imgTwitter ) )

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


// TODO: can you dynamically re-use HText lbl?
lbl = new HText( obj.toString(), 24, font1);
//lbl.fill( (int) d.x()%255, (int) d.y()%255, (int) d.z()%255).anchorAt(H.CENTER);	//.loc( d.x(), d.y());
lbl.fill(#000000);

/*
TODO: create 6 assets from DEVASKATION LOGO ( players, title, full crest )
* load in DS assets instead of EF social meedz

TODO: get colorPixelist or colorPool working with fill ( fill each asset label with each DS color )
#000000
#ED7100
#315D15
#3D107B
#E35205
#FFFFFF
*/
  d
            .anchorAt(H.CENTER)
            .scale(.69)
            .add(lbl)
          ;

// H.add(lbl);

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

  /*
  // 3D code
  hint(DISABLE_DEPTH_TEST);
  camera();
  lights(); //    because P3D

  ambientLight(ct,ct,ct);
  emissive(ct,ct,ct);
  specular(ct,ct,ct);
  */
  
  /*
  //  save frame
  if(save_frame){
    saveFrame( fix.pdeName() + "-" + fix.getTimestamp() + "_##.png");  //  USE .TIF IF COLOR
  }
  */

  if(frameCount>43)doExit();

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
