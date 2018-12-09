/*
AllCylinders - roots from DiamondMode, now with more fixes and ONLY HCylinder


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
String SAVE_TYPE = ".png";  //".tif";1
int MODE = 3; //   1 - 3
String SRC_FILE = "G26.png";  //  G1 - G26.PNG
int numSides = 4; // MIN = 3
int mxNumSides = 11;
int colCt = 6;  //  HCylinder NOTE : only follow curated from mode1 engine sizes > 5, 6, 8, 10

float sw = 0;
/* ------------------------------------------------------------------------- */
float drawZ;

int rowCt = colCt;  //  Maintains even 1:1 grid
Fixlib fix = Fixlib.init(this);
HDrawablePool pool;
HGridLayout hgl;
HCylinder tmpB;
boolean fixNoFill = true; //  switch to make noFill() work and give the wireframe effect on HCylinder
float colSpacingX,colSpacingY;
float drawW, gridX, gridY;
color sClr;
PImage srcImg, tmpImg;

//  NOTE: Processing on OSX and PC have different interpretations of dimensions
int TARGETW = 1600;
int TARGETH = 1600;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    size( 1600, 1600, P3D);
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/* ------------------------------------------------------------------------- */
void setup() {

  background(H.CLEAR );
  noFill();

  // these hints fix HCylinder.noFill()
  if(fixNoFill)hint(ENABLE_DEPTH_SORT);
  //  be safe
  if(colCt<2)colCt=2;

  //  init VARIABLES
  drawW = (int) ( TARGETW/colCt  );

  //  ROTATE MODE
      switch (MODE) {
        case 1:
          colSpacingX = drawW;  //(drawW * 1.41);
          colSpacingY = drawW;  //(drawW * 1.63 );
          drawZ = drawW;
        break;

        case 2:
          drawW = drawW * 1.25;
          colSpacingX = drawW;  //(drawW * .9 );
          colSpacingY = drawW;  //(drawW * 1.15 );
          drawZ = TARGETH/PI; //drawW;  //-420; //(drawW+colSpacing)*colCt;
        break;

        case 3:
          colSpacingX = drawW*.7;
          colSpacingY = drawW*.75;
          drawZ = H.CENTER; //drawW*colCt;
        break;

        case 4:
        break;

        case 5:
        break;

        case 6:
        break;
    
    case 7:
    break;

        default :
          println("unknown MODE: "+  MODE);

        break;  
      }

  //  center HGL
  gridX = (int) ( (TARGETW/2) - (((colCt-1)*colSpacingX)/2) );
  gridY = (int) ( (TARGETW/2) - (((colCt-1)*colSpacingY)/2) );

  //  Generate filename containing sketch settings meta NOW
  SAVE_NAME = SRC_FILE + "m"+MODE + "ns"+numSides + ((sw>0)?"sw"+sw:"") + (fixNoFill?"":"F") + "_"+ colCt;

if(srcImg==null){
  if(SRC_FILE!=""){
    try{
      srcImg = loadImage(SRC_FILE);
      srcImg.resize(TARGETW, TARGETH);
      image(srcImg,0,0);
    } catch( Exception e){
      // be safe in case SRC_FILE doens't load
      println("LOADER: "+e);
      SRC_FILE ="";
    }
  }
}

  //  init HYPE
  H.init(this).background(H.CLEAR).use3D(true).autoClear(true);

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
    for( int row = 1; row <= rowCt; row++)
    {
      //  INNER COLUMN LOOP ( l-r )  
      for( int col = 1; col <= colCt; col++)
      {
        //  get image slice
        tmpImg = srcImg.get( (int)(drawW*col),  (int)(drawW*row),  (int)drawW,  (int)drawW);
      
      //  create box to hold slice
      tmpB = new HCylinder();      
            //  same 
      tmpB.sides(numSides)
          .texture(tmpImg)
          .drawBottom(false)
          .drawTop(false)
          .topRadius(drawW/H.CENTER)
          .bottomRadius(drawZ/H.CENTER)
          .strokeSides(sw>0)
          .strokeWeight(sw);

        //  drop it in the pool
        pool.add( tmpB );
      }
    }
  } else {

      //  create box to hold slice
      tmpB = new HCylinder();
      tmpB.sides(numSides)
          .texture( get() )
          .drawBottom(true)
          .drawTop(false)
          .topRadius(drawW/H.CENTER)
          .bottomRadius(drawZ/H.CENTER)
          .strokeSides(sw>0)
          .strokeWeight(sw);
    //  just add it
    pool.add( tmpB );
  }


  tmpB = null;

  pool
    .layout ( hgl )
    .onCreate(
      new HCallback() {
          public void run(Object obj) 
          {
          tmpB = (HCylinder) obj;

        //  ROTATE MODE
        switch (MODE) {
          case 1:
            tmpB.depth(drawW).z(drawZ).rotationX(55).rotationZ(45).width(drawW).height(drawW);
          break;

          case 2:
                //  SIDE PLAID
              tmpB.depth(drawW).z(drawZ).rotationX(45).rotationZ(45).width(drawW).height(drawW);
          break;

          case 3:
            tmpB.depth(drawW/HALF_PI).z(drawZ).rotationX(90);//.rotationZ(25).width(drawW).height(drawW);
          break;

          case 4:
          break;

          case 5:
          break;

          case 6:
          break;

          case 7:
          break;

          default :
          println("unknown MODE: "+  MODE);

          break;  
        }

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
  String msg = "ERICFICKES.COM";
  HText lbl = new HText( msg, 43, createFont("Bitwise", 43) );
  lbl.fill(H.GOLD).loc(TARGETW*.72, TARGETH-(textAscent()+textDescent()), drawW+drawZ );

  H.add(lbl);

  ortho();
  H.drawStage();

  if(SRC_FILE!=""){
    //  NOTE: if image() isn't dropped here, font background is color, not image()
    // font bg hack
    image(srcImg,0,0);

    //  p5 on osx isn't masking????
    tmpImg = get();
    tmpImg.resize( TARGETW, TARGETH );
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
  translate(TARGETW/2, TARGETH/2, 0);
    scale(-1, -1);

  image(srcImg,-TARGETW/2, -TARGETH/2, TARGETW, TARGETH);


  } 

//  TODO : looking to find the perfect numSides
    if(numSides >= mxNumSides){
      doExit();
    } else {
      save( SAVE_NAME+SAVE_TYPE );
      //  MAKING ART WITH GARBAGE
      tmpB = null;
      srcImg = null;
      tmpImg = null;
      H.clearStage();
      pool.drain();
      fix = null;
      pool = null;
      hgl = null;

      background(H.CLEAR);
      
      //  incrementer
      numSides++;
      //  restar sketch
      setup();
    }

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
  //text(msg,   TARGETW-(textWidth(msg)+textAscent())+24, TARGETH-textAscent()+24);
  //  NEW RIGHT VERTICAL STAMP
  textAlign(CENTER,BOTTOM);
  pushMatrix();
    translate(  TARGETW-13, (TARGETH/2), 0 );
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


