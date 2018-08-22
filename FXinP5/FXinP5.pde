/**

Inspired by https://discourse.processing.org/t/a-way-to-add-fancy-effects-to-your-sketches/2073

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
//import javafx.scene.paint.Color; // JavaFX uses different colors than Processing
import javafx.scene.paint.*;

import fixlib.*;

Fixlib fix = Fixlib.init(this);

GraphicsContext ctx;

LinearGradient gradient, gradStroke;

//GaussianBlur fxGaussianBlur = new GaussianBlur(20d); // the 'd' stands for 'double'
DropShadow fxDropShadow;

Glow fxGlow;
Bloom fxBloom;
InnerShadow fxInnerShadow;
ColorAdjust fxColorAdjust;
FloatMap floatMap;
DisplacementMap displacementMap;

Light.Distant light = new Light.Distant();
Lighting lighting = new Lighting();

float cX, cY;

BlendMode bMode = BlendMode.ADD;

/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(1920, 1080, FX2D); // FX2D required
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
	background(#242424);

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
	gradient = LinearGradient.valueOf("linear-gradient(from 0px 0px to "+width+"px "+height+"px, #EF0000 33%, 0x00EF00 55%, 0x0000EF 88%)");
	//	stroke
	gradStroke = LinearGradient.valueOf("linear-gradient(from 0px 0px to "+width+"px "+height+"px, #EF2018 24%, 18EF20 43%, 0x2018EF 75%)");

}



/*****************************************************************************/
void draw() {

// does this help?



	//  1 = MAX
	fxBloom.setThreshold(frameCount/10 % 0.9);

	fxGlow.setLevel(frameCount/10 % 1.0);

	fxDropShadow.setOffsetX(-frameCount%-8f);
	fxDropShadow.setOffsetY(frameCount%8f);
	fxDropShadow.setInput(fxBloom);

	fxInnerShadow.setOffsetX(frameCount%8f);
	fxInnerShadow.setOffsetY(frameCount%8f);
	fxInnerShadow.setInput(fxGlow);
	
	fxColorAdjust.setSaturation(1.0);	//frameCount/10 % 1.0);
	fxColorAdjust.setHue(1.0);	//frameCount/10 % 1.0);
	fxColorAdjust.setBrightness(1.0);	//frameCount/10 % 1.0);

  //  Light
	light.setAzimuth(-frameCount%-175.0);  //  -135.0
	lighting.setLight(light);

	//	can't tell how to utilize these
	lighting.setBumpInput(fxBloom);
	lighting.setContentInput(fxGlow);
	lighting.setDiffuseConstant(frameCount/10%.69);  //  2.0
	lighting.setSurfaceScale(frameCount/10%9.9);	//	10.0
	lighting.setSpecularConstant(frameCount/10%.69);  //  2.0
	lighting.setSpecularExponent(frameCount/10%.69);	//	40.0

	// to disable the effect, just set it to `null`
	//ctx.setEffect(null);




	//	mix up inner shadow color
	if(frameCount%7==0){

		fxDropShadow.setInput(fxBloom);
		fxInnerShadow.setInput(fxGlow);

		fxDropShadow.setColor(Color.rgb(frameCount%242, (int)random(frameCount%242), frameCount%242) );
		fxInnerShadow.setColor(Color.rgb(frameCount%242, (int)random(frameCount%242), frameCount%242) );



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
		fxDropShadow.setColor(Color.rgb(frameCount%69,frameCount%69,frameCount%69));
		fxInnerShadow.setColor(Color.rgb(frameCount%255, frameCount%255, frameCount%255));

	}
	
	//	TODO: work with BlendMode
	ctx.setGlobalBlendMode(bMode);


// TODO: look into chaining effects via setInput( effect )
//	this might prove more effective than special positioning

	//	APPLY EFFECTS
	ctx.setEffect(lighting);
	ctx.setEffect(fxBloom);
	ctx.setEffect(fxGlow);
	ctx.setEffect(fxColorAdjust);
	ctx.setEffect(fxInnerShadow);
	ctx.setEffect(fxDropShadow);

	
	//	STROKE
	if(frameCount%8==0)
		ctx.setStroke(gradient);
	else
		ctx.setStroke(gradStroke);

	//	FILL
	if(frameCount < cX)
		ctx.setFill(gradient);
	else
	{
		noFill();
		ctx.setFill(null);
	}

  
  if(frameCount%42==0){
	strokeWeight(8);
    ellipse(frameCount%width,random(43, cX), 24,24 );	//	height*.75
    // ellipse(random(frameCount),random(frameCount)%height, 43,43 );
  } 
  else if(frameCount%24==0){
  	strokeWeight(6);
	rect(frameCount%width,random(height*.75), random(8,16), random(43,cX) );
  }
  else
 {
  	strokeWeight(2);
  //Y - random(frameCount%69, cX)
    rect(	frameCount+(frameCount*noise(frameCount))%width, 
    		random(cY-240, cY+240), 
    		random(43,cY), 
    		random(43,49), 
    		frameCount/160%cX
    		);
  
 }


//	TODO: does cycling effects improve output?  seems like each frame is just duplicating
//ctx.setEffect(null);




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
