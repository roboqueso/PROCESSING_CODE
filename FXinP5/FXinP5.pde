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

/*****************************************************************************/
void setup() 
{
	size(1920, 1080, FX2D); // FX2D required

	background(#242424);

	smooth(8);
	pixelDensity(displayDensity());

	// ellipseMode(CENTER);
	// rectMode(CENTER);

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
	gradient = LinearGradient.valueOf("linear-gradient(from 0px 0px to "+width+"px "+height+"px, #EF0753 24%, 0x07EF53 43%, 0x0753EF 75%)");
	gradStroke = LinearGradient.valueOf("linear-gradient(from 0px 0px to "+width+"px "+height+"px, #EF2018 24%, 18EF20 43%, 0x2018EF 75%)");

}



/*****************************************************************************/
void draw() {

	//  1 = MAX
	fxBloom.setThreshold(frameCount/10 % 1.0);
	fxGlow.setLevel(frameCount/10 % 1.0);

	fxDropShadow.setOffsetX(frameCount%7);
	fxDropShadow.setOffsetY(frameCount%7);
	
	fxInnerShadow.setOffsetX(frameCount%7);
	fxInnerShadow.setOffsetY(frameCount%7);
	
	fxColorAdjust.setSaturation(frameCount/10 % 1.0);
	fxColorAdjust.setHue(frameCount/10 % 1.0);
	fxColorAdjust.setBrightness(frameCount/10 % 1.0);

  //  Light
	// light.setAzimuth(0);  //  -135.0
	lighting.setLight(light);

	//	can't tell how to utilize these
	lighting.setBumpInput(fxColorAdjust);
	lighting.setContentInput(fxColorAdjust);
	lighting.setDiffuseConstant(frameCount/10%.69);  //  2.0
	lighting.setSurfaceScale(frameCount/10%2);	//	10.0
	lighting.setSpecularConstant(frameCount/10%.69);  //  2.0
	lighting.setSpecularExponent(frameCount/10%.69);	//	40.0

	// to disable the effect, just set it to `null`
	//ctx.setEffect(null);



	//	mix up inner shadow color
	if(frameCount%13==0)
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
		fxDropShadow.setColor(Color.rgb(frameCount%24,frameCount%24,frameCount%24));
		fxInnerShadow.setColor(Color.rgb(frameCount%255, frameCount%255, frameCount%255));
	}
	


	//	APPLY EFFECTS
	ctx.setEffect(lighting);
	ctx.setEffect(fxBloom);
	ctx.setEffect(fxGlow);
	ctx.setEffect(fxColorAdjust);
	ctx.setEffect(fxInnerShadow);
	ctx.setEffect(fxDropShadow);

	
	//	STROKE
	if(frameCount%13==0)
		ctx.setStroke(gradient);
	else
		ctx.setStroke(gradStroke);

	//	FILL
	if(frameCount<cY)
		ctx.setFill(gradient);
	else
		noFill();

  
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

  if(frameCount>width){
    doExit();
  }
  
}


void doExit(){

   save(this+""+second()+millis()+".png");
    // noLoop();
    // System.gc();
    super.exit();

}
