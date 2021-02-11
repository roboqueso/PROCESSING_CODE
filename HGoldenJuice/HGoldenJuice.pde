/**
HGoldenJuice = Draw fix.shapeJous() around the Golden Ratio

GoldenJuice ported to using HYPE framework


  InnerShadow
  https://docs.oracle.com/javafx/2/api/javafx/scene/effect/InnerShadow.html

  DropShadow
  https://docs.oracle.com/javafx/2/api/javafx/scene/effect/DropShadow.html

  JavaFX GLOW
  https://docs.oracle.com/javafx/2/api/javafx/scene/effect/Glow.html

  JavaFX LinearGradient
  https://docs.oracle.com/javafx/2/api/javafx/scene/paint/LinearGradient.html

  Bloom
  https://docs.oracle.com/javafx/2/api/javafx/scene/effect/Bloom.html

  BlendMode
  https://docs.oracle.com/javafx/2/api/javafx/scene/effect/BlendMode.html

  DisplacementMap
  https://docs.oracle.com/javafx/2/api/javafx/scene/effect/DisplacementMap.html

*/
import javafx.scene.canvas.*;
import javafx.scene.effect.*;
import javafx.scene.paint.*;
import javafx.scene.shape.*;

import hype.*;
import hype.extended.colorist.HColorPool;

//  SEE:   
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);



HColorPool colors;
HShape tmpShp;
//	this sketch is all about point() used w/strokeWeight() to add the magic
float strokeWt = .69;
//	control JFX global Blend mode
boolean blendDark = true;	//	TRUE : DARK, FALSE : COLOR - mix of 3 blend modes each option
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
LinearGradient gradient, gradStroke;
DropShadow fxDropShadow;
float cX, cY;
float gX,gY;


RadialGradient radGrad;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(1920, 1080, FX2D);//, P3D, P2D, FX2D	NOTE: P2D throwing tesselation errors
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
  background(-1);	//	EF2018


// init JFX first?
// in order to apply effects we need to get the 'native' graphics context of our canvas
// ctx = ((Canvas) surface.getNative()).getGraphicsContext2D();
ctx = ((Canvas) this.surface.getNative()).getGraphicsContext2D();

  	//	GET HYPED
	//  init HYPE
	H.init(this).background(-1).use3D(false);	//	JFX no worky w/3D
	colors = new HColorPool(#000000, #FFFFFF, #ED7100, #315D15, #3D107B, #E35205);

  //  Generate filename containing sketch settings meta NOW
  SAVE_NAME = fix.pdeName() + "-"+ fix.getTimestamp();

  cX = width/2;
  cY = height/2;

  // JAVAFX!

  fxColorAdjust = new ColorAdjust();
  fxGlow = new Glow();
  fxBloom = new Bloom();
  fxInnerShadow = new InnerShadow();
  fxDropShadow = new DropShadow();  //2d, 4d, 6d, Color.gray(0, 1));

//  TODO: determine DARK + Gold color themes from StarWars Darth Vaders
//  revisit these gradients
//  TODO: come back and run DS gradients
//  NOTE: these don't work with HYPE
gradient = LinearGradient.valueOf("linear-gradient(from 0px 0px to "+width+"px 0px, #080808 30%, #EF2424 60%, #C0C0C0 80% )");
gradStroke = LinearGradient.valueOf("linear-gradient(from 0px 0px to "+width+"px 0px, #EF2018 30%, #EF4308 60%, #1975EF 80%)");


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
  
  //  TODO: does this ever make a difference?
  ctx.setFillRule(FillRule.NON_ZERO);

  //  APPLY EFFECTS - order matters
  ctx.setEffect(lighting);
  ctx.setEffect(fxColorAdjust);
  
//  TODO: come back to displacementMap
// ctx.setEffect(displacementMap);


  

//  DO DRAWING HERE
//  NOTE: doing "translate" in calculation of gX,gY so the coords translate for HYPE
// translate(cX, cY);

//  STROKE
strokeWeight(strokeWt);




  for (int rr = 0; rr < height; rr++) 
  {
    //  get the point
    gX = cX + ( cos(GR*rr)*rr );
    gY = cY + ( sin(GR*rr)*rr );

    //  think locally, blend Globally
    if(blendDark)
    {


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
    // ctx.setStroke( Color.web( Integer.toHexString(colors.getColor())) );
    //  WHY DOESN'T THIS WORK?!?!?

    //HACK : the only way to get custom color stroke working?!?!
    stroke( colors.getColor() );

  }

  ctx.setGlobalBlendMode(bMode);


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


//  SHADOWS

  //  mix up inner shadow color
  if(rr%7==0)
  {
    fxDropShadow.setColor(Color.rgb(rr%242, (int)random(rr%242), rr%242) );
    fxDropShadow.setInput(fxBloom);
    fxInnerShadow.setColor(Color.rgb(rr%242, (int)random(rr%242), rr%242) );
    fxInnerShadow.setInput(fxGlow);
  }
  else if(rr%13==0)
  {
    fxDropShadow.setColor(Color.rgb(rr%255, (int)random(rr%255), rr%255) );
    fxInnerShadow.setColor(Color.rgb(rr%255, (int)random(rr%255), rr%255) );
  }
  else if(rr%24==0)
  {
    fxDropShadow.setColor(Color.rgb((int)random(rr%255), (int)random(rr%255), (int)random(rr%255) ) );
    fxInnerShadow.setColor(Color.rgb((int)random(rr%255), (int)random(rr%255), (int)random(rr%255) ) );
  }
  else
  {
    fxDropShadow.setColor(Color.rgb(rr%3,rr%3,rr%3));
    fxInnerShadow.setColor(Color.rgb(rr%3, rr%3, rr%3));
  }

  fxDropShadow.setOffsetX(rr%3f);
  fxDropShadow.setOffsetY(rr%3f);
  fxDropShadow.setInput(fxGlow);

  fxInnerShadow.setOffsetX(rr%3f);
  fxInnerShadow.setOffsetY(rr%3f);
  fxInnerShadow.setInput(fxBloom);
  ctx.setEffect(fxInnerShadow);
  ctx.setEffect(fxDropShadow);


  // make new shape
  tmpShp = new HShape( fix.shapeJous( gX, gY, rr%43, (int)strokeWt ) );

//  TODO: why doesn't this work?  Is JFX interfering?
  // tmpShp.fill(colors.getColor());
  // tmpShp.stroke(colors.getColor());

  // ctx.setFill(  Color.web( Integer.toHexString(colors.getColor()))  );
  // ctx.setStroke(  Color.web( Integer.toHexString(colors.getColor()))  );


   H.add( tmpShp );
  } 

}



/*****************************************************************************/
void draw() 
{


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
