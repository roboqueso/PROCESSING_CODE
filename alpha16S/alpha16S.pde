//  SEE:   https://ello.co/ericfickes/post/k2qmabtoy5mexstcpibc2g
//  GOTO:  https://github.com/ericfickes/FIXLIB

//  2.
//  alpha16S is the ALPHA reference sketch for all legacy sketches being ported to 16S_{legacySketchName}
//  * 16S_ prefix groups new work
//  * dial in Shadows
//  *   add 1 at a time, easy to port to FIXLIB.FX.shadows(inner, outer, [settings])?
//  * Add additional FX / CSS

//  3.
//  


/**
  InnerShadow
  https://docs.oracle.com/javafx/2/api/javafx/scene/effect/InnerShadow.html

  DropShadow
  https://docs.oracle.com/javafx/2/api/javafx/scene/effect/DropShadow.html

  JavaFX LinearGradient
  https://docs.oracle.com/javafx/2/api/javafx/scene/paint/LinearGradient.html
*/
import javafx.scene.canvas.*;
import javafx.scene.effect.*;
import javafx.scene.paint.*;
import javafx.scene.shape.*;
import javafx.scene.text.*;

import fixlib.*;


Fixlib fix = Fixlib.init(this);
String SAVE_NAME = "thisShouldBeDynamic";
int maxFrame = 45;

GraphicsContext ctx;

// TODO: dial in shadows first, then light, then other FX
DropShadow fxDropShadow;
InnerShadow fxInnerShadow;


float cX, cY;

//  NOTE: some of these BlendModes cause the sketch to only show a blank white screen, SRC_OVER

//  A value of null is treated as pass-though this means no effect on a parent such as a Group and the equivalent of SRC_OVER for a single Node.
//  SRC_OVER = DEFAULT, use while concepting


//  16 BlendModes : 
//  ADD, BLUE, COLOR_BURN, COLOR_DODGE, DARKEN, DIFFERENCE, EXCLUSION, GREEN, 
//  HARD_LIGHT, LIGHTEN, MULTIPLY, OVERLAY, RED, SCREEN, SOFT_LIGHT, SRC_ATOP
BlendMode bMode = BlendMode.SRC_ATOP;



void settings(){
  size(displayWidth, displayHeight, FX2D);
  smooth(8);  //  smooth() can only be used in settings();
  pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
  background(255);

  ellipseMode(CENTER);
  rectMode(CENTER);

  cX = width/2;
  cY = height/2;

  
  fxInnerShadow = new InnerShadow();
  fxDropShadow = new DropShadow();

  //  Generate filename containing sketch settings meta NOW
  SAVE_NAME = fix.pdeName() + "-bMode-" + bMode  + "-" + fix.getTimestamp();

  //see: https://docs.oracle.com/javase/10/docs/api/javafx/scene/canvas/GraphicsContext.html
  ctx = ((Canvas) surface.getNative()).getGraphicsContext2D();


// JAVAFX CSS: https://docs.oracle.com/javafx/2/api/javafx/scene/doc-files/cssref.html

//  TODO: work with BlendMode
ctx.setGlobalBlendMode(bMode);
ctx.setFillRule(FillRule.NON_ZERO);    
ctx.setMiterLimit(1.0); //  default = 10.0
ctx.setFontSmoothingType( FontSmoothingType.LCD );


}



/*****************************************************************************/
void draw() {
    
  //  JAVAFX HERE
  fxDropShadow.setOffsetX(frameCount%8f);
  fxDropShadow.setOffsetY(frameCount%8f);

  fxInnerShadow.setOffsetX(frameCount%8f);
  fxInnerShadow.setOffsetY(frameCount%8f);

  //  mix up inner shadow color
  fxDropShadow.setColor(Color.rgb((frameCount%255), (frameCount%255), (frameCount%255) ) );
  fxInnerShadow.setColor(Color.rgb((frameCount%255), (frameCount%255), (frameCount%255) ) );


    
    
  //  APPLY EFFECTS - order matters
  ctx.setEffect(fxInnerShadow);
  ctx.setEffect(fxDropShadow);






//  SKETCH HERE

strokeWeight(random(PI,maxFrame));
textSize(random(PI,maxFrame));

point( random(width), random(height) );

strokeWeight(random( 1, HALF_PI ));

line( random(width), random(height), random(width), random(height) );
rect( random(width), random(height), 75, 75, random(-frameCount, frameCount) );

strokeWeight(random(.8, 1.6));
ellipse( random(width), random(height), 75, 75 );


//  TEXT - are differences noticeable?
if(frameCount%2==0)
{
  text( binary(frameCount),  random(maxFrame, cY), (frameCount*random(maxFrame))%height );
}
else
{ 
  //ctx.fillText( "JFX fillText "+ frameCount, random(width), random(height) );
  //ctx.strokeText( "JFX strokeText "+ frameCount, random(width), random(height) );
  ctx.fillText( this+""+ frameCount, random(width), random(height) );
  ctx.strokeText( this+""+ frameCount, random(width), random(height) );

}







  //  STOPPER
  if(frameCount>maxFrame){
    noLoop();
    doExit();
  }
  
}



/* ------------------------------------------------------------------------- */
/*  NON - P5 BELOW  */
/* ------------------------------------------------------------------------- */

/**
  End of sketch closer
*/
void doExit(){
  String msg = "ERICFICKES.com ";
  //  stamp bottom right based on textSize
  fill(#EF2020);
  textSize(13);
  text(msg, width-(textWidth(msg)+textAscent()), height-textAscent());
  
  save(SAVE_NAME+".png"); //  USE .TIF IF COLOR  
  
  //  cleanup
  fix = null;
  
  noLoop();
  exit();
  System.gc();
  System.exit(1);
}
