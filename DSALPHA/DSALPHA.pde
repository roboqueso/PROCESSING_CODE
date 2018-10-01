/*
HAVATARS  : square one starting point P5/HYPE template sketch
* BLOOD-DRAGON : 1920 x 1071
* size(displayWidth, displayHeight, P3D)
* HDR w, h is 2x1 EX: 2048, 1096

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
HColorPool    colors;

PFont font1, font2, font3;
HText lbl;

int gridX,gridY;
int colCt = 11;
int rowCt = 11;  //  NOTE: remember to update this value
int colSpacing = 1;
int drawW, drawH; //  HDrawable Width / Height
String[] dsletters = {"D","E","V","A","S","K","A","T","I","O","N"};

PImage imgDerby, imgDevaskation, imgHockey, imgInline, imgSheildNoSk8, imgSkateboard;

// TODO: get all 6 DS fonts into /data
String[] fontNames = { "AMCAP Eternal.ttf", "Cardo-Regular.ttf", "Myriad Pro Regular.ttf"};
PFont[] fontList =  new PFont[fontNames.length];



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
	gridX = (drawW/2)+(colSpacing*5);
	gridY = (drawH/2)+colSpacing;

	//	load avatar images
	imgDerby = loadImage("derby.png");
	imgDevaskation = loadImage("devaskation.png");
	imgHockey = loadImage("hockey.png");
	imgInline = loadImage("inline.png");
	imgSheildNoSk8 = loadImage("shield-noskaters.png");
	imgSkateboard = loadImage("skateboard.png");


	//	pre-load fonts
	for(int ff = 0; ff < fontNames.length; ff++){
		fontList[ff] = createFont( fontNames[ff], 24);
	}

  //  init HYPE
  H.init(this);

	colors = new HColorPool(#000000, #ED7100, #315D15, #3D107B, #E35205);

	background(colors.getColor());
	H.background(colors.getColor());

  pool = new HDrawablePool(colCt*rowCt);
  
  pool.autoAddToStage()
    .add ( new HImage( imgDerby ).anchorAt(H.CENTER) )
    // .add ( new HImage( imgDevaskation ).anchorAt(H.CENTER) )
    .add ( new HImage( imgHockey ).anchorAt(H.CENTER) )
    .add ( new HImage( imgInline ).anchorAt(H.CENTER) )
    // .add ( new HImage( imgSheildNoSk8 ).anchorAt(H.CENTER) )
    .add ( new HImage( imgSkateboard ).anchorAt(H.CENTER) )

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


	// TODO: rotate all 6 DS fonts in a smarter manner
	// if(pool.currentIndex()%2==0)
	// 	lbl = new HText( dsletters[pool.currentIndex()%dsletters.length], 69, font2);
	// else if(pool.currentIndex()%3==0)
	// 	lbl = new HText( dsletters[pool.currentIndex()%dsletters.length], 69, font3);
	// else 
		lbl = new HText( dsletters[pool.currentIndex()%dsletters.length], 69, fontList[pool.currentIndex()%fontList.length]);

	// debug
	// println("pool.currentIndex(): "+pool.currentIndex() );




		lbl.fill(#FFFFFF);	//colors.getColor());
		lbl.anchorAt(H.CENTER);

	  d.add(lbl);

		// d.strokeWeight(1).stroke(#FFFFFF);
		// d.tint(colors.getColor());
        d.width(drawW);
        d.height(drawH);
		d.stroke(colors.getColor());
		d.fill(colors.getColor());
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
  if(frameCount>96)doExit();
  */
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
  fill(colors.getColor());
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
