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

BlendMode bMode = BlendMode.SRC_ATOP;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(1920, 1080, FX2D); // FX2D required
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
	background(255);//#242424);

	ellipseMode(CENTER);
	rectMode(CENTER);

	cX = width/2;
	cY = height/2;

	// JAVAFX!
	fxColorAdjust = new ColorAdjust();

	fxGlow = new Glow();
	fxBloom = new Bloom();
	fxInnerShadow = new InnerShadow();
	fxDropShadow = new DropShadow();	//2d, 4d, 6d, Color.gray(0, 1));


	// in order to apply effects we need to get the 'native' graphics context of our canvas
	ctx = ((Canvas) surface.getNative()).getGraphicsContext2D();

	//	fill
	gradient = LinearGradient.valueOf("linear-gradient(from 0px 0px to "+width+"px 0px, #EF1975 20%, #13EF13 50%, #8833EF 80% )");

	//	stroke
	gradStroke = LinearGradient.valueOf("linear-gradient(from 0px 0px to "+width+"px 0px, #EF8833 30%, #18ef20 50%, #1975EF 80%)");

}



/*****************************************************************************/
void draw() {


	//  1 = MAX
	fxBloom.setThreshold(.9);	//	frameCount/10 % 1.0);
	fxGlow.setLevel(.9);	//	frameCount/10 % 1.0);

	fxDropShadow.setOffsetX(frameCount%8f);
	fxDropShadow.setOffsetY(frameCount%8f);
	fxDropShadow.setInput(fxGlow);

	fxInnerShadow.setOffsetX(frameCount%8f);
	fxInnerShadow.setOffsetY(frameCount%8f);
	fxInnerShadow.setInput(fxBloom);
	
	//	mix up inner shadow color
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
		fxDropShadow.setColor(Color.rgb(frameCount%8,frameCount%8,frameCount%8));
		fxInnerShadow.setColor(Color.rgb(frameCount%8, frameCount%8, frameCount%8));
	}

	fxColorAdjust.setInput(fxBloom);
	
	fxColorAdjust.setSaturation(0.9);	//	frameCount/10 % 
	fxColorAdjust.setHue(0.9);	//	frameCount/10 % 
	fxColorAdjust.setBrightness(0.9);	//	frameCount/10 % 

//	NOTE: Light doesn't seem to make any difference
  //  Light

	light = new Light.Point(frameCount, cY, frameCount%13, Color.rgb( (int)random(43,255), (int)random(16,255), (int)random(8,255) )  );
	lighting.setLight(light);

	// // //	can't tell how to utilize these
	lighting.setBumpInput(fxBloom);
	lighting.setContentInput(fxGlow);

	lighting.setDiffuseConstant(frameCount/10%2.0f);  //  2.0
	lighting.setSurfaceScale(frameCount/10%10.0f);	//	10.0
	lighting.setSpecularConstant(frameCount/10% 2.0f);  //  2.0
	lighting.setSpecularExponent(frameCount/10% 40.0f);	//	40.0


	//	APPLY EFFECTS
	ctx.setEffect(lighting);
	ctx.setEffect(fxColorAdjust);
	ctx.setEffect(fxBloom);
	ctx.setEffect(fxGlow);
	ctx.setEffect(fxInnerShadow);
	ctx.setEffect(fxDropShadow);
	
	//	TODO: work with BlendMode
	ctx.setGlobalBlendMode(bMode);
	ctx.setFillRule(FillRule.NON_ZERO);

// ctx.setEffect(displacementMap)	
	//	STROKE
	//	FILL
	if(frameCount < cX)
	{
		ctx.setStroke(gradStroke);
		ctx.setFill(gradient);
	}
	else
	{
		noFill();
		ctx.setFill(null);
	}

  

	if(frameCount%42==0)
	{
		strokeWeight(8);
		ellipse(frameCount%width,random(43, cX), 24,24 );	//	height*.75
	} 
	else if(frameCount%24==0)
	{
		strokeWeight(6);
		rect(frameCount%width,random(height*.75), random(8,16), random(43,cX) );
	}
	else if(frameCount%5==0)
	{
		strokeWeight(2);
		//Y - random(frameCount%69, cX)
		rect(	frameCount+(frameCount*noise(frameCount))%width, 
			random(cY-255, cY+255), 
			random(43,cY), 
			random(43,49), 
			frameCount/100%cX
		);

	}


//	TODO: does cycling effects improve output?  seems like each frame is just duplicating
// does this help?
ctx.clearRect(0,0, width, height);
ctx.setEffect(null);
ctx.setFill(null);
ctx.setStroke(null);


  if(frameCount>width){
  	noLoop();
    doExit();
  }
  
}


void doExit(){

   save(fix.pdeName()+""+fix.getTimestamp()+"-"+bMode+".png");
    // noLoop();
    // System.gc();
    super.exit();

}
