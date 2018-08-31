/**
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

import fixlib.*;

Fixlib fix = Fixlib.init(this);
float GR = (sqrt(5) + 1) * 0.5;  // TWO_PI* - golden ratio


String SAVE_NAME = "thisShouldBeDynamic";

GraphicsContext ctx;

LinearGradient gradient, gradStroke;
DropShadow fxDropShadow;
Glow fxGlow;
Bloom fxBloom;
InnerShadow fxInnerShadow;
ColorAdjust fxColorAdjust;

Light.Point light;
Lighting lighting = new Lighting();

float cX, cY;
float gX,gY;
float strokeWt = .69;

//  NOTE: some of these BlendModes cause the sketch to only show a blank white screen
//  ADD, BLUE, COLOR_BURN, COLOR_DODGE, DARKEN, DIFFERENCE, EXCLUSION, GREEN, 
//  HARD_LIGHT, LIGHTEN, MULTIPLY, OVERLAY, RED, SCREEN, SOFT_LIGHT, SRC_ATOP, SRC_OVER
BlendMode bMode = BlendMode.SRC_OVER;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(1920, 1080, FX2D); // FX2D required
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
  background(-1);

  ellipseMode(CENTER);
  rectMode(CENTER);

  noFill();


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


  // in order to apply effects we need to get the 'native' graphics context of our canvas
  ctx = ((Canvas) surface.getNative()).getGraphicsContext2D();


//  TODO: determine DARK + Gold color themes from StarWars Darth Vaders
//  revisit these gradients
  
  gradient = LinearGradient.valueOf("linear-gradient(from 0px 0px to "+width+"px 0px, #080808 30%, #EF2424 60%, #C0C0C0 80% )");
  gradStroke = LinearGradient.valueOf("linear-gradient(from 0px 0px to "+width+"px 0px, #EF2018 30%, #EF4308 60%, #1975EF 80%)");

}



/*****************************************************************************/
void draw() {


//  SHADOWS
/*
  //  mix up inner shadow color
  if(frameCount%7==0)
  {
    fxDropShadow.setColor(Color.rgb(frameCount%242, (int)random(frameCount%242), frameCount%242) );
    fxDropShadow.setInput(fxBloom);
    fxInnerShadow.setColor(Color.rgb(frameCount%242, (int)random(frameCount%242), frameCount%242) );
    fxInnerShadow.setInput(fxGlow);
  }
  else if(frameCount%13==0)
  {
    fxDropShadow.setColor(Color.rgb(frameCount%255, (int)random(frameCount%255), frameCount%255) );
    fxInnerShadow.setColor(Color.rgb(frameCount%255, (int)random(frameCount%255), frameCount%255) );
  }
  else if(frameCount%24==0)
  {
    fxDropShadow.setColor(Color.rgb((int)random(frameCount%255), (int)random(frameCount%255), (int)random(frameCount%255) ) );
    fxInnerShadow.setColor(Color.rgb((int)random(frameCount%255), (int)random(frameCount%255), (int)random(frameCount%255) ) );
  }
  else
  {
    fxDropShadow.setColor(Color.rgb(frameCount%3,frameCount%3,frameCount%3));
    fxInnerShadow.setColor(Color.rgb(frameCount%3, frameCount%3, frameCount%3));
  }

  fxDropShadow.setOffsetX(frameCount%3f);
  fxDropShadow.setOffsetY(frameCount%3f);
  fxDropShadow.setInput(fxGlow);

  fxInnerShadow.setOffsetX(frameCount%3f);
  fxInnerShadow.setOffsetY(frameCount%3f);
  fxInnerShadow.setInput(fxBloom);
*/


//  BLOOM
//  fxBloom.setThreshold(frameCount/10 % 1.0);


//  COLOR ADJUST
/*
  fxColorAdjust.setSaturation(1.0);  //frameCount/10 % 1.0);
  fxColorAdjust.setHue(1.0);  //frameCount/10 % 1.0);
  fxColorAdjust.setBrightness(1.0);  //frameCount/10 % 1.0);
*/


//  GLOW
//  fxGlow.setLevel(1.0);  //frameCount/10 % 1.0);


//  LIGHTING
  //  NOTE: Light works differently depending on how you set Inputs and combinations of when and where
  // light = new Light.Point(cX, cY, frameCount%69, Color.rgb( 255, 255, 255 )  );
  // lighting.setLight(light);
//  TODO: Add a Blur here?
  // lighting.setBumpInput(fxBloom);
  // lighting.setContentInput(fxBloom);
  // lighting.setDiffuseConstant(frameCount/10%2.0f);  //  2.0
  // lighting.setSurfaceScale(frameCount/10%10.0f);  //  10.0
  // lighting.setSpecularConstant(frameCount/10% 2.0f);  //  2.0
  // lighting.setSpecularExponent(frameCount% 40.0f);  //  40.0
  

  //  TODO: work with BlendMode
  // ctx.setGlobalBlendMode(bMode);
  //  TODO: does this ever make a difference?
  // ctx.setFillRule(FillRule.NON_ZERO);

  //  APPLY EFFECTS - order matters
  // ctx.setEffect(fxColorAdjust);
  // ctx.setEffect(fxBloom);
  // ctx.setEffect(fxGlow);
  // ctx.setEffect(fxInnerShadow);
  // ctx.setEffect(fxDropShadow);
  // ctx.setEffect(lighting);

// ctx.setEffect(displacementMap)  


  

//  DO DRAWING HERE
translate(cX, cY);

//  STROKE
strokeWeight(strokeWt);

  for (int r = 0; r < height; r++) 
  {



/*    
    // colors
    if(r%2==0)
     stroke(f*r%255, f%255, r%255); 
    else if(r%3==0)
     stroke(r%255, f*r%255, f%255); 
    else if(r%5==0)
     stroke(f%255, r%255, f*r%255); 
    else
     stroke( f*r%255,f*r%255, f*r%255);
*/
	// if(r%2==0)
		ctx.setStroke(gradStroke);
	// else
	// 	ctx.setStroke(gradient);

    //  NOTE: big variable in the resulting circle pattern
    // if(r%24==0){
    // 	strokeWt = (strokeWt*GR)%sqrt(height);
    // 	strokeWeight(strokeWt);
    // }
    
    //	NOTE: r%{loop number} would make for great GIF frames
    if(r%43==0){
    	strokeWt = (strokeWt*GR)%sqrt(height);
    	strokeWeight(strokeWt);
    }

//	TODO: need gradual incrementor code, or "TWEEN" logic applies ( HOscillator? )
    // strokeWeight((r*GR)%(int)sqrt(width));		//	cool sprinklery
    // strokeWeight((r*GR)%cX);	//	crazy spiderman face
	// strokeWeight((r*GR)%(r/GR));	//	interesting cloud spiral
	// strokeWeight( 1+(r/TWO_PI)%sqrt(width) );	// More open DOT spiral
	// strokeWeight( HALF_PI+(r/GR)%sqrt(width) );	// More open DOT spiral
	// strokeWeight( noise(r)+(r/GR) );	// smooth tight spiral
	// strokeWeight( random(r)+(r/GR) );	// kinda wu-tangish
// strokeWeight( random(r)+(r/GR) );	// kinda wu-tangish


    gX = cos(GR*r)*r;
    gY = sin(GR*r)*r;

    point(gX, gY);    
    
    //	TODO: Get point & strokeWeight + FX figured out, then visit the other primitives
    // rect(cos(GR*r)*r, sin(GR*r)*r, sqrt(width), sqrt(width));
    // ellipse(cos(GR*r)*r, sin(GR*r)*r, (GR*r)%180, (GR*r)%180 );
  } 





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
