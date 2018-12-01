/*
[ PROFESSIONAL ]
"Your conduit to success"

*/

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import fixlib.*;

/* ------------------------------------------------------------------------- */

/* ------------------------------------------------------------------------- */
String SAVE_NAME = "thisShouldBeDynamic"; //  MC HAMMER
String SAVE_TYPE = ".png";  //".tif";

// String SRC_FILE = "S11.jpg";
// String SRC_FILE = "S10.jpg";
// String SRC_FILE = "S9.jpg";
// String SRC_FILE = "S8.jpg";
// String SRC_FILE = "S7.jpg";
// String SRC_FILE = "S6.jpg";
// String SRC_FILE = "S5.jpg";
// String SRC_FILE = "S4.jpg";
// String SRC_FILE = "S3.jpg";
// String SRC_FILE = "S2.jpg";

// String SRC_FILE = "Jelly3_fickes_YESog.png";
String SRC_FILE = "Jelly3_fickes_YES.png";

int colCt = 16;	//	MIN 2
//	2,3,5,8,13 ,21,34,55

/* ------------------------------------------------------------------------- */

float drawZ;
float sw = 0;
int rowCt = colCt;  //  Maintains even 1:1 grid
Fixlib fix = Fixlib.init(this);
HDrawablePool pool;
HGridLayout hgl;
HBox tmpB;
boolean fixNoFill = true; //  switch to make noFill() work and give the wireframe effect on HBox
boolean fixOverlap = false; // adjusts colSpacingX & Y such that cubes touch like diamonds. This will typically cut off ~ 4 visible columns from colCt
float colSpacingX,colSpacingY;
float drawW, gridX, gridY;
color sClr;
PImage srcImg, tmpImg;

//	don't let windows tell me how to size
int mainW = 1600;
int mainH = 1600;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    //  For best results, change size() to match dimensions of mainImgFile
    size( 1600, 1600, P3D);
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */
void setup() {

	background( H.CLEAR );
	noFill();

	// these hints fix HBox.noFill()
	if(fixNoFill)hint(ENABLE_DEPTH_SORT);
	//	be safe
	if(colCt<2)colCt=2;

	//  init VARIABLES
	drawW = (int) ( mainW/colCt  );

	if(fixOverlap)
	{
		colSpacingX = (drawW * 1.41);
		colSpacingY = (drawW * 1.63 );
	}
	else
	{
		colSpacingX = drawW;
		colSpacingY = drawW;
	}


	drawZ = drawW;

	//	center HGL
	gridX = (int) ( (mainW/2) - (((colCt-1)*colSpacingX)/2) );
	gridY = (int) ( (mainW/2) - (((colCt-1)*colSpacingY)/2) );

	//  Generate filename containing sketch settings meta NOW
	SAVE_NAME = SRC_FILE + ((sw>0)?"sw"+sw:"") + (fixNoFill?"":"FILL")  + (fixOverlap?"":"OVRL") + "_"+ colCt;

	if(SRC_FILE!=""){
		srcImg = loadImage(SRC_FILE);
		srcImg.resize(mainW, mainH);
		image(srcImg,0,0);
	}

	//  init HYPE
	H.init(this).background(H.WHITESMOKE).use3D(true).autoClear(true);

	pool = new HDrawablePool(colCt*colCt);
  
  	hgl = new HGridLayout()
	    .cols(colCt)
	    .rows(colCt)
	    .startLoc(gridX, gridY) 
	    .spacing( colSpacingX, colSpacingY, drawZ  );

	pool.autoAddToStage();

  //  SLICE IT UP
  if(SRC_FILE!=""){
  //  OUTER ROW LOOP ( t - b ) 
  for( int row = 0; row < rowCt; row++)
  {
    //  INNER COLUMN LOOP ( l-r )  
    for( int col = 0; col < colCt; col++)
    {
		//  create box to hold slice
		tmpB = new HBox();

		//  get image slice
		tmpImg = srcImg.get( (int)(drawW*col),  (int)(drawW*row),  (int)drawW,  (int)drawW);

		tmpImg = srcImg.get( (int)(drawW*row),  (int)(drawW*col),  (int)drawW,  (int)drawW);
		tmpB.textureBack(tmpImg);

		tmpImg = srcImg.get( (int)(drawW*col),  (int)(drawW*row),  (int)drawW,  (int)drawW);
		tmpB.textureBottom(tmpImg);

		tmpImg = srcImg.get( (int)(drawW*row),  (int)(drawW*col),  (int)drawW,  (int)drawW);		
      	tmpB.textureRight(tmpImg);

      //  drop it in the pool
      pool.add( tmpB );
    }
  }
} else {
	pool.add( new HBox().noFill() );
}
	pool
		.layout ( hgl )
		.onCreate(
			new HCallback() {
			    public void run(Object obj) 
			    {
					tmpB = (HBox) obj;

					tmpB.depth(drawW).z(drawZ).rotationX(55).rotationZ(45).width(drawW).height(drawW);

					if(sw >0 && (SRC_FILE!="") )
					{
			          //  Grab color from the current tmpImg
			          sClr = srcImg.get( (int)tmpB.x(), (int)tmpB.y() );
			          //  stroke it
			          tmpB.strokeWeight(sw).stroke( sClr );

					} 
					else 
					{
			         	tmpB.strokeWeight(sw);
			        }

// println("pool.currentIndex(): "+ pool.currentIndex() );
// if(pool.currentIndex()%2!=0){
// 	tmpB.stroke(H.ORANGE).strokeWeight(TWO_PI);
// }


			    }
		}
	);




}





/* ------------------------------------------------------------------------- */
void draw() {

	pool.requestAll();
	// EF stamp
	// HText lbl = new HText( "ERICFICKES.COM", 24, createFont("Bitwise", 24) );
	HText lbl = new HText( "ERICFICKES.COM", 24, createFont("Impact", 24) );
	lbl.fill(H.RED).loc(mainW*.9, height-(textAscent()+textDescent()), drawW+drawZ );
	H.add(lbl);

	ortho();
	H.drawStage();

	if(SRC_FILE!=""){
		//	NOTE: if image() isn't dropped here, font background is color, not image()
		// font bg hack
		image(srcImg,0,0);

		//	p5 on osx isn't masking????
		tmpImg = get();
		tmpImg.resize( mainW, mainH );
		tmpImg.filter(INVERT);

		try{
			srcImg.mask(tmpImg);	

		} catch(Exception e){

			println("e: "+e);
			println("tmpImg.width : " + tmpImg.width +", "+ tmpImg.height );
			println("srcImg.width : " + srcImg.width +", "+ srcImg.height );
		}

 	// FLIP THE SCRIPT
	translate(mainW/2, mainH/2, 0);
  	scale(-1, -1);

	image(srcImg,-mainW/2, -mainH/2, mainW, mainH );


	}	

  	doExit();

}







/* ------------------------------------------------------------------------- */
/*  NON - P5 BELOW  */
/* ------------------------------------------------------------------------- */

/**
  End of sketch closer
*/
void doExit(){

/*

  String msg = "ERICFICKES.COM";

  textFont( createFont("Bitwise", 43));
  fill( #242424 );

  textSize(36);
  //  OG BOTTOM RIGHT STAMP
  //text(msg, width-(textWidth(msg)+textAscent())+24, height-textAscent()+24);
  //  NEW RIGHT VERTICAL STAMP
  textAlign(CENTER,BOTTOM);
  pushMatrix();
    translate(width-13, (height/2), 0 );
    rotate(-HALF_PI);
    text(msg,0,0);
  popMatrix();
*/
  save( SAVE_NAME+SAVE_TYPE );    //  USE .TIF IF COLOR  

    //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
