/**
GoldenJuice = Draw fix.shapeJous() around the Golden Ratio



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


//	this sketch is all about point() used w/strokeWeight() to add the magic
float strokeWt = 1.5;
//	control JFX global Blend mode
boolean blendDark = true;	//	TRUE : DARK, FALSE : COLOR - mix of 3 blend modes each option

Fixlib fix = Fixlib.init(this);
float GR = (sqrt(5) + 1) * TWO_PI;  // TWO_PI* - golden ratio
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


/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(displayWidth, displayHeight, FX2D);//, P3D, P2D, FX2D	NOTE: P2D throwing tesselation errors
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
  background(-1);	//	EF2018

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

gradient = LinearGradient.valueOf("linear-gradient(from 0px 0px to "+width+"px 0px, #1975EF 24%, #19EF75 69%, #EF1975 93% )");
gradStroke = LinearGradient.valueOf("linear-gradient(from 0px 0px to "+width+"px 0px, #EF2020 24%, #20EF20 69%, #2020EF 93%)");

}



/*****************************************************************************/
void draw() {


//  SHADOWS

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



//  BLOOM
fxBloom.setThreshold(.8);//frameCount/10 % 1.0);


//  COLOR ADJUST

  fxColorAdjust.setSaturation(1.0);  //frameCount/10 % 1.0);
  fxColorAdjust.setHue(1.0);  //frameCount/10 % 1.0);
  fxColorAdjust.setBrightness(1.0);  //frameCount/10 % 1.0);



//  GLOW
fxGlow.setLevel(.8);	// 1.0
//  see:  https://ello.co/ericfickes/post/4dqpze_yd1iyi1uwdojdlw
//  LIGHTING
  //  NOTE: Light works differently depending on how you set Inputs and combinations of when and where
  light = new Light.Distant();//cX, cY, frameCount%69, Color.rgb( 255, 255, 255 )  );
  light.setAzimuth(-135.0);
  lighting.setLight(light);
  lighting.setSurfaceScale(10);	//10);	//5.0);

//  TODO: Add a Blur here?
  lighting.setBumpInput(fxGlow);
  lighting.setContentInput(fxBloom);	//	fxBloom UNSHARPENS?
  lighting.setDiffuseConstant(.96);	//frameCount/10%2.0f);  //  2.0

//	these two are cool, but kind of wash out the others.  VERY B&W
  lighting.setSpecularConstant(.69);	//frameCount/10% 2.0f);  //  2.0
  lighting.setSpecularExponent(4.20);//(frameCount*.1)% 13.0f);  //  40.0
  
  //  TODO: does this ever make a difference?
  ctx.setFillRule(FillRule.NON_ZERO);

  //  APPLY EFFECTS - order matters
  ctx.setEffect(lighting);
  ctx.setEffect(fxColorAdjust);
  ctx.setEffect(fxInnerShadow);
  ctx.setEffect(fxDropShadow);
  
//	TODO: come back to displacementMap
// ctx.setEffect(displacementMap);


  

//  DO DRAWING HERE
translate(cX, cY);

//  STROKE
strokeWeight(strokeWt);

  for (int r = 0; r < height; r++) 
  {
  	//	get the point
    gX = cos(GR*r)*r;
    gY = sin(GR*r)*r;

    //	think locally, blend Globally
    if(blendDark){
	    //	SET 1 - BLACK SUNSHINE
		if(r%3==0)
			bMode = BlendMode.DARKEN;
		else if(r%4==0)
			bMode = BlendMode.HARD_LIGHT;
		else
			bMode = BlendMode.DIFFERENCE;
	} else {
	    //	SET 2 - RGB 3D GLASSES VIBE
	    //	NOTE: TBD what the best color combo is here
	    //	ALL 3 colors work well in each r% position
		if(r%3==0)
			bMode = BlendMode.BLUE;
		else if(r%4==0)
			bMode = BlendMode.RED;
		else
			bMode = BlendMode.GREEN;
	}
	ctx.setGlobalBlendMode(bMode);

//	NOTE: stroke changes the effectiveness of bMode logic ( good or bad )
// stroke( r%2==0?0:255);	//	rings of color
// stroke( r%255 );	//	rings of color
stroke( gX%255 );//, gY%255, r%255 );	//	rings of color


 	//	JFX STROKE
	if(r%2==0)
		ctx.setStroke(gradStroke);
	else
		ctx.setStroke(gradient);
    // NOTE: big variable in the resulting circle pattern
    if(r%24==0){
    	strokeWt = (strokeWt*GR)%2.1;	//sqrt(height);
    	strokeWeight(strokeWt);
    }

//	TODO: need gradual incrementor code, or "TWEEN" logic applies ( HOscillator? )
    // strokeWeight((r*GR)%(int)sqrt(width));		//	cool sprinklery

    // strokeWeight((r*GR)%cX);	//	crazy spiderman face
	// strokeWeight((r/GR)%width);	//	crazy spiderman face
	// strokeWeight((r*GR)%(r/GR));	//	interesting cloud spiral
	// strokeWeight( 1+(r/TWO_PI)%sqrt(width) );	// More open DOT spiral
	// strokeWeight( HALF_PI+(r/GR)%sqrt(width) );	// More open DOT spiral
	// strokeWeight( noise(r)+(r/GR) );	// smooth tight spiral
	// strokeWeight( random(r)+(r/GR) );	// kinda wu-tangish
    
    //	NOTE: r%{loop number} would make for great GIF frames
    // if(r%43==0){
    // 	// strokeWt = (strokeWt*GR)%sqrt(height);
    // 	strokeWt = (strokeWt*GR)%sqrt(height);
    // 	strokeWeight(strokeWt);
    // }





    // point(gX, gY);
	shape( fix.shapeJous( gX, gY, 42, (int)strokeWt ) );	//	

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
