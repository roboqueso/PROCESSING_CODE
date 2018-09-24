/**
DSHOrangeJuice.pde - DEVASKATION flavored HGoldenJuice

TODO:
- colors
- fonts
- assets load shapes
*/
import javafx.scene.canvas.*;
import javafx.scene.effect.*;
import javafx.scene.paint.*;
import javafx.scene.shape.*;

import fixlib.*;

import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.behavior.*;


HShape tmpShp;
HImage tmpImg;
//	this sketch is all about point() used w/strokeWeight() to add the magic
float strokeWt = .69;
//	control JFX global Blend mode

//	NOTE: blendDark = true IS SLOW AF!!!!
//	all output is solid black
boolean blendDark = false;	//	TRUE : DARK, FALSE : COLOR - mix of 3 blend modes each option
boolean displace = false;	//	Apply displacementMap

Fixlib fix = Fixlib.init(this);
float GR = (sqrt(5) + 1) * 0.5;  // TWO_PI* - golden ratio
String SAVE_NAME = "thisShouldBeDynamic";
GraphicsContext ctx;
Light.Distant light;
Lighting lighting = new Lighting();
BlendMode bMode;
Glow fxGlow;
Bloom fxBloom;
InnerShadow fxInnerShadow;
ColorAdjust fxColorAdjust;

DropShadow fxDropShadow;
float cX, cY;
float gX,gY;

HColorPool colors = new HColorPool(#000000, #FFFFFF, #ED7100, #315D15, #3D107B, #E35205);

//	run a dark and NOT for each asset
// String[]        texNames         = {"skateboard.svg"};
// String[]        texNames         = {"shield-noskaters.svg"};
// String[]        texNames         = {"derby.svg"};
// String[]        texNames         = {"devaskation.svg"};
// String[]        texNames         = {"hockey.svg"};
// String[]        texNames         = {"inline.svg"};

String[]        texNames         = {"shield-noskaters.svg","derby.svg", "devaskation.svg", "hockey.svg", "inline.svg", "skateboard.svg" };

// String[]        texNames         = {"shield-noskaters.png","derby.png", "devaskation.png", "hockey.png", "inline.png", "skateboard.png" };
int             texNamesLen      = texNames.length;
// PImage[]        texLoaded        = new PImage[texNamesLen];
PShape[]        texLoaded        = new PShape[texNamesLen];





//	TEST : Displacement Map?
 FloatMap floatMap = new FloatMap();
 DisplacementMap displacementMap = new DisplacementMap();


/*****************************************************************************/
void  settings ()  {
    size(1920, 1080, FX2D);//, P3D, P2D, FX2D	NOTE: P2D throwing tesselation errors
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}



/*****************************************************************************/
void setup() 
{
  background(0);	

	// GET NATIVE context for JFX effects
	ctx = ((Canvas) surface.getNative()).getGraphicsContext2D();


//	TODO: is this the best way for HYPE?
	// LOAD IMAGES
	/*
	for (int i = 0; i < texNamesLen; ++i) {
		texLoaded[i] = loadImage(texNames[i]);
	}
*/

	//	LOAD SHAPES
	for (int i = 0; i < texNamesLen; ++i) {
		texLoaded[i] = loadShape(texNames[i]);
	}


  	//	GET HYPE
  	//	//	#000000, #FFFFFF, #ED7100, #315D15, #3D107B, #E35205
	H.init(this).background(0);	//	JFX no worky w/3D
	

  //  Generate filename containing sketch settings meta NOW
  SAVE_NAME = fix.pdeName() + "-"+ fix.getTimestamp();

  cX = width/2;
  cY = height/2;

  // JAVAFX!


  //	DISPLACEMENT MAP
  if(displace){

	floatMap.setWidth(width);
	floatMap.setHeight(height);

	for (int i = 0; i < width; i+=HALF_PI) 
	{
		// double v = (Math.sin(i / 20.0 * TWO_PI) - 0.5) / 40.0;
		double v = (Math.sin(i / 20.0 * TWO_PI) - GR ) / 40.0;
		
		for (int j = 0; j < height; j+=HALF_PI) 
		{
			floatMap.setSamples(i, j, 0.0f, (float) v);
		}
	}

	displacementMap.setMapData(floatMap);

  }

  fxColorAdjust = new ColorAdjust();
  fxGlow = new Glow();
  fxBloom = new Bloom();
  fxInnerShadow = new InnerShadow();
  fxDropShadow = new DropShadow();  //2d, 4d, 6d, Color.gray(0, 1));


//  BLOOM
fxBloom.setThreshold(.8);//frameCount/10 % 1.0);


//  COLOR ADJUST

  fxColorAdjust.setSaturation(1.0);  //frameCount/10 % 1.0);
  fxColorAdjust.setHue(1.0);  //frameCount/10 % 1.0);
  fxColorAdjust.setBrightness(1.0);  //frameCount/10 % 1.0);



//  GLOW
fxGlow.setLevel(.8);  // 1.0


//  LIGHTING
  //  NOTE: Light works differently depending on how you set Inputs and combinations of when and where
  light = new Light.Distant();//cX, cY, frameCount%69, Color.rgb( 255, 255, 255 )  );
  light.setAzimuth(-135.0);
  lighting.setLight(light);
  lighting.setSurfaceScale(10); //10);  //5.0);

//  TODO: Add a Blur here?
  lighting.setBumpInput(fxGlow);
  lighting.setContentInput(fxBloom);  //  fxBloom UNSHARPENS?
  lighting.setDiffuseConstant(.96); //frameCount/10%2.0f);  //  2.0

//  these two are cool, but kind of wash out the others.  VERY B&W
  lighting.setSpecularConstant(.69);  //frameCount/10% 2.0f);  //  2.0
  lighting.setSpecularExponent(4.20);//(frameCount*.1)% 13.0f);  //  40.0
  

//  STROKE
strokeWeight(strokeWt);


//  TODO: does this ever make a difference?
ctx.setFillRule(FillRule.EVEN_ODD);	//default is FillRule.NON_ZERO);
//  APPLY EFFECTS - order matters
ctx.setEffect(lighting);
ctx.setEffect(fxColorAdjust);


//	LOOP STARTS HERE 

  for (int rr = 0; rr < height; rr++) 
  {
    //  get the point
    gX = cX + ( cos(GR*rr)*rr );
    gY = cY + ( sin(GR*rr)*rr );

    //  think locally, blend Globally
    if(blendDark)
    {
// println("stroke() removed from blendDark - does this matter?");
		//  NOTE: stroke changes the effectiveness of bMode logic ( good or bad )
		// stroke( rr%2==0?0:255);
		stroke( rr%255 );



      //  SET 1 - BLACK SUNSHINE
    if(rr%3==0)
      bMode = BlendMode.DARKEN;
    else if(rr%4==0)
      bMode = BlendMode.HARD_LIGHT;
    else
      bMode = BlendMode.DIFFERENCE;


  } else {

    //  color pool mode
    bMode = BlendMode.SRC_OVER;

    //  NOTE: renderer is using JFX, HYPE's shape.stroke() appears to get overwritten
    // ctx.setFill( Color.web( Integer.toHexString(colors.getColor())) );
    // ctx.setStroke( Color.web( Integer.toHexString(colors.getColor())) );
    //  WHY DOESN'T THIS WORK?!?!?

    //HACK : the only way to get custom color stroke working?!?!
    // fill( colors.getColor() );
    stroke( colors.getColor() );
    tint ( colors.getColor() );

  }

  ctx.setGlobalBlendMode(bMode);



	//  SHADOWS
	if(blendDark)
	{
		//	override background color to be white 
		background(255);
		H.background(255);

		fxDropShadow.setColor(Color.rgb(rr%255, rr%255, rr%255) );
		fxInnerShadow.setColor(Color.rgb(rr%255, rr%255, rr%255) );
		// fxInnerShadow.setColor(Color.web( Integer.toHexString(colors.getColor())));
	}
	else
	{
		background(colors.getColor());
		H.background(colors.getColor());

		//	HYPE COLORS
	    fxDropShadow.setColor(Color.web( Integer.toHexString(colors.getColor())));
	    fxInnerShadow.setColor(Color.web( Integer.toHexString(colors.getColor())));
	}

  fxDropShadow.setOffsetX(4f);
  fxDropShadow.setOffsetY(4f);
  fxDropShadow.setInput(fxGlow);

  fxInnerShadow.setOffsetX(2f);
  fxInnerShadow.setOffsetY(2f);
  fxInnerShadow.setInput(fxBloom);
  
  ctx.setEffect(fxInnerShadow);
  ctx.setEffect(fxDropShadow);



/*
   //	IMAGE
   tmpImg = new HImage( texLoaded[(int)random(texNamesLen)] );
   tmpImg
   	.scale( (rr/10)%0.6 )
   	.rotation(rr)
   	.loc(gX, gY);

   H.add(tmpImg);
*/
//	TODO: re-visit strokeWeight with SHAPES, not IMAGES
//  TODO: need gradual incrementor code, or "TWEEN" logic applies ( HOscillator? )
    // strokeWeight((r*GR)%(int)sqrt(width));   //  cool sprinklery

    // strokeWeight((r*GR)%cX); //  crazy spiderman face
  // strokeWeight((r/GR)%width);  //  crazy spiderman face
  // strokeWeight((r*GR)%(r/GR)); //  interesting cloud spiral
  // strokeWeight( 1+(r/TWO_PI)%sqrt(width) );  // More open DOT spiral
  // strokeWeight( HALF_PI+(r/GR)%sqrt(width) );  // More open DOT spiral
  // strokeWeight( noise(r)+(r/GR) ); // smooth tight spiral
  // strokeWeight( random(r)+(r/GR) );  // kinda wu-tangish
    
    //  NOTE: r%{loop number} would make for great GIF frames
    // if(r%43==0){
    //  // strokeWt = (strokeWt*GR)%sqrt(height);
    //  strokeWt = (strokeWt*GR)%sqrt(height);
    //  strokeWeight(strokeWt);
    // }


  // SHAPEJOUS
  // tmpShp = new HShape( fix.shapeJous( gX, gY, rr%43, (int)strokeWt ) );


	//	SVG
	tmpShp = new HShape(  texLoaded[rr%texNamesLen]  );


// debug
// println("(height/rr) ): "+(height/rr) );

	//	TODO: get scale() and rotation() dialed in
	//		   	.scale( (rr/20)%0.88 )
	//	Use HOscillator for scaling?
	tmpShp.loc(gX, gY);

//	TODO: does this work?
new HOscillator()
	.target(tmpShp)
	.property(H.SCALE)
	.range(.24, 2.40)
	.speed(0.8)
	.freq(3)
	.currentStep(rr);


	if(blendDark)
	{
		tmpShp.enableStyle(false);
	}
	else
	{
		tmpShp.randomColors(colors);
	}

	H.add( tmpShp );

  } 

}



/*****************************************************************************/
void draw() 
{

	if(displace)
	{
		ctx.setEffect(displacementMap);
	}

	//  HYPE IT ALL
	H.drawStage();


  //if(frameCount>PI){

    noLoop();
    doExit();
  //}
  
}


void doExit(){

	save(SAVE_NAME+".png");
	// noLoop();
	// System.gc();
	super.exit();

}
