/*
DSALPHA
- DEVASKATION on top of DS ASSETS in simple 11x11 gridlayou
- DS colors
- DS assets ( need shinier ones )


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
String SAVE_NAME = "thisShouldBeDynamic";
boolean oneFont = true; //  TRUE: use oneFont for all squares, FALSE: rotate through fonts for each square
boolean oneColor = false; //  TRUE: use one color for font, FALSE: rotate through colors for each square

int bgColor;

PFont theFont;
HText lbl;

int gridX,gridY;
int colCt = 11;
int rowCt = 11;  //  NOTE: remember to update this value
int colSpacing = 1;
int drawW, drawH; //  HDrawable Width / Height
String[] dsletters = {"D","E","V","A","S","K","A","T","I","O","N"};

PImage imgDerby, imgDevaskation, imgHockey, imgInline, imgSheildNoSk8, imgSkateboard;

// TODO: get all 6 DS fonts into /data
String[] fontNames = { "MyriadPro-Bold.otf", "Myriad Pro Regular.ttf", "AMCAP Eternal.ttf", "Helvetica-Normal.ttf", "Cardo-Regular.ttf"};
PFont[] fontList =  new PFont[fontNames.length];



/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(1920,1080, P3D); //"processing.opengl.PGraphics3D");
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

  if(oneFont)
  {
    //  RANDOMLY pick one font for entire grid
    theFont = createFont( fontNames[(int)random(fontNames.length)], 24);
  }
  else
  {
    //  pre-load all fonts
    for(int ff = 0; ff < fontNames.length; ff++){
      fontList[ff] = createFont( fontNames[ff], 24);
    }
  }

  //  Generate filename containing sketch settings meta NOW
  SAVE_NAME = fix.pdeName() + "-1FONT_"+ oneFont + "-1COLOR_"+ oneColor + "-"+ fix.getTimestamp();

  //  init HYPE
  H.init(this);

	colors = new HColorPool(#000000, #ED7100, #315D15, #3D107B, #E35205, #FFFFFF);

  //  pick random bgColor
  bgColor = colors.getColor();

// bgColor = #000000;
// bgColor = #ED7100;
// bgColor = #315D15;
// bgColor = #3D107B;
// bgColor = #E35205;
// bgColor = #FFFFFF;

	background(bgColor);
	H.background(bgColor);

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
        public void run(Object obj) 
        {

          //  DO HYPE STUFF HERE
          HDrawable d = (HDrawable) obj;



          //  ONE font or roll through all of them?
          if(oneFont)
            lbl = new HText( dsletters[pool.currentIndex()%dsletters.length], 69, theFont);
          else
            lbl = new HText( dsletters[pool.currentIndex()%dsletters.length], 69, fontList[pool.currentIndex()%fontList.length]);

          //  white text or rando?
          if(oneColor)
            lbl.fill(#FFFFFF);  //colors.getColor());
          else
            lbl.fill(colors.getColor());
            //  lbl.fill(bgColor);  //colors.getColor());

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
  String msg = "DEVASKATION x ERICFICKES";
  //  stamp bottom right based on textSize
  fill(#EF1975);  //colors.getColor());

  textFont( createFont("AMCAP Eternal.ttf", 24));
  textSize(13);
  text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());

  save(SAVE_NAME+".png"); //  USE .TIF IF COLOR  
  
  //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
