/*
DiamondMode - make diamonds with a box

TODO: add other modes where BOX rotates and lines up nicely like the original mode

OG DiamondMode remnants : might be shit, validate

	//	MAGIC : resize box size after calculating grid spacing for zoomage
	switch(MODE){
		case 1:
			drawW *= 1.25;

			drawZ = drawW/2;
		break;
		
		case 2:
			drawW = drawW * 1.25;
			drawZ = height/PI;	//drawW;	//-420;	//(drawW+colSpacing)*colCt;
		break;
		
		case 3:
			drawW = drawW * HALF_PI;	//1.5;
			drawZ = height/PI ;	//drawW;	//-420;	//(drawW+colSpacing)*colCt;
		break;

		case 4:
			colSpacingX *= .75;
			colSpacingY *= .75;
			drawZ = 0;
		break;

		case 5:
			// drawW = drawW * .85;	//HALF_PI;	//1.125;	//1.5;
			drawZ = height/2 ;	//drawW;	//-420;	//(drawW+colSpacing)*colCt;
		break;

		//  RECODE THE ONLINE SAMPLES
		case 6:
			drawW = drawW * .5;	//HALF_PI;	//1.125;	//1.5;
			drawZ = height/2 ;	//drawW;	//-420;	//(drawW+colSpacing)*colCt;

		break;

		case 7:

			colSpacingX = (drawW * 1.42);
			colSpacingY = (drawW * 1.63 );

			drawZ = 0;//drawW*1.25;

		break;

		default:


		break;
	}
	

      //  ROTATE COMBOs


	/*
	- // equation 2
	if you look at the Front Ortho of the image there is the triangle ABC. 
	Length B is the side of the cube L, 
	length A is the length of a faces diagonal L * sqrt(2) (basic pythagoras). 

	The tangent of angle alpha will be L / (L * sqrt(2)) or 
	1 / sqrt(2) atan of which equates to 35.2644 degrees. 

	The rotation_euler XYZ (45, 35.264, 0)

	The length of the longest diagonal C is L * sqrt(3), Once again from pythagoras. 

	If the origin is in the middle of the cube translate the cube L * sqrt(3) / 2 to put it on its point.

	Interestinglythe volume can be calculated using C**3 / (3*sqrt(3))

	- see: http://petercollingridge.appspot.com/3D-tutorial/rotating-objects




	//	ROTATE MODE
      switch (MODE) {
        case 1:
          //  3D SQUARES
          tmpB.rotateX(90);
        break;

        case 2:
          //  SIDE PLAID
          tmpB.rotateX(45);
          tmpB.rotateZ(90);
        break;

        case 3:
          // equation 1
          // To perform this rotation type in 3D view: ry=atan(1/sqrt(2))*180/pi. This will give you a perfectly oriented cube.
          tmpB.rotateY( atan(1/sqrt(2))*180/PI );
        break;

        case 4:
          tmpB.rotationX( 45 );
          tmpB.rotationY( 36 );
          tmpB.rotationZ( 0 );

        break;

        case 5:
          //  HOT DIAMONDS "snowflakes"
          tmpB.rotation(45);
        break;

        case 6:
          	//  RECODE THE ONLINE SAMPLES
          	tmpB.rotateX(45);
			tmpB.rotateY(45);
        break;
		
		case 7:

          // TODO: case 7 = PROFESSIONAL
          tmpB.rotationX(55);
          tmpB.rotationZ(45);
          ortho();

		break;

        default :
          println("unknown MODE: "+  MODE);

        break;  
      }


*/

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
String SRC_FILE = "S1g.png";

int colCt = 24;	//	MIN 2
//	2,3,5,8,13 ,21,34,55

/* ------------------------------------------------------------------------- */

float drawZ;
float sw = 0;	//0;
int rowCt = colCt;  //  Maintains even 1:1 grid
Fixlib fix = Fixlib.init(this);
HDrawablePool pool;
HGridLayout hgl;
HBox tmpB;
boolean fixNoFill = true; //  switch to make noFill() work and give the wireframe effect on HBox
float colSpacingX,colSpacingY;
float drawW, gridX, gridY;
color sClr;
PImage srcImg, tmpImg;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    //  For best results, change size() to match dimensions of mainImgFile
    size( 1600, 1600, P3D);
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */
void setup() {

	background(H.CLEAR );
	noFill();

	// these hints fix HBox.noFill()
	if(fixNoFill)hint(ENABLE_DEPTH_SORT);
	//	be safe
	if(colCt<2)colCt=2;

	//  init VARIABLES
	drawW = (int) ( width/colCt  );
	colSpacingX = (drawW * 1.41);
	colSpacingY = (drawW * 1.63 );

	drawZ = drawW;

	//	center HGL
	gridX = (int) ( (width/2) - (((colCt-1)*colSpacingX)/2) );
	gridY = (int) ( (width/2) - (((colCt-1)*colSpacingY)/2) );

	//  Generate filename containing sketch settings meta NOW
	SAVE_NAME = SRC_FILE + ((sw>0)?"SW"+sw:"") + (fixNoFill?"":"FILL") + "_"+ colCt;

	if(SRC_FILE!=""){
		try{
			srcImg = loadImage(SRC_FILE);
			srcImg.resize(width, height);
			image(srcImg,0,0);
		} catch( Exception e){
			// be safe in case SRC_FILE doens't load
			println("e: "+e);
			SRC_FILE ="";
		}
	}

	//  init HYPE
	H.init(this).background(H.CHOCOLATE).use3D(true).autoClear(true);

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
		//  get image slice
		tmpImg = srcImg.get( (int)(drawW*col),  (int)(drawW*row),  (int)drawW,  (int)drawW);

		//  create box to hold slice
		tmpB = new HBox();

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
			    }
		}
	);




}





/* ------------------------------------------------------------------------- */
void draw() {

	pool.requestAll();
	// EF stamp
	HText lbl = new HText( "ERICFICKES.COM", 24, createFont("Bitwise", 24) );
	lbl.fill(H.WHITESMOKE).loc(width*.875, height-(textAscent()+textDescent()), drawW+drawZ );
	H.add(lbl);

	ortho();
	H.drawStage();

	if(SRC_FILE!=""){
		//	NOTE: if image() isn't dropped here, font background is color, not image()
		// font bg hack
		image(srcImg,0,0);

		//	p5 on osx isn't masking????
		tmpImg = get();
		tmpImg.resize( srcImg.width, srcImg.height);
		tmpImg.filter(GRAY);

		try{
			srcImg.mask(tmpImg);	
			tmpImg.mask(srcImg);
		} catch(Exception e){

			println("e: "+e);
			println("tmpImg.width : " + tmpImg.width +", "+ tmpImg.height );
			println("srcImg.width : " + srcImg.width +", "+ srcImg.height );
		}

 	// FLIP THE SCRIPT
	translate(width/2, height/2, 0);
  	scale(-1, -1);

	image(srcImg,-width/2, -height/2, width, height);


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


