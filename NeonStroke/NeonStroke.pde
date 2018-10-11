/**
NeonStroke - Use JFX text effects & strokeText("message") to create NEON SIGN text & shapes

see : https://docs.oracle.com/javafx/2/text/jfxpub-text.htm

TODO:

- coordinate rect -radius & point() strokeWeight
  -- create alternating RECT() POINT() RECT() POINT() grid patterns
  -- rect w/-radius creates pocket for big point()

- tune in color(s), text size and font
- re-visit https://docs.oracle.com/javafx/2/text/jfxpub-text.htm for additional magic

*/
import javafx.scene.canvas.*;
import javafx.scene.effect.*;
import javafx.scene.paint.*;
import javafx.scene.shape.*;
import javafx.scene.text.*;

import fixlib.*;


Fixlib fix = Fixlib.init(this);
String SAVE_NAME = "thisShouldBeDynamic";
int maxFrame = 69;

GraphicsContext ctx;

// TODO: dial in shadows first, then light, then other FX
DropShadow ds, ds1;
InnerShadow is, is1;
Blend blend, blend1, blend2;


float cX, cY;

//  A value of null is treated as pass-though this means no effect on a parent such as a Group and the equivalent of SRC_OVER for a single Node.
//  SRC_OVER = DEFAULT, use while concepting
BlendMode bMode = BlendMode.SRC_OVER;

//  16 BlendModes : Run final sketch through all 16 BlendModes
//  ADD, BLUE, COLOR_BURN, COLOR_DODGE, DARKEN, DIFFERENCE, EXCLUSION, GREEN, 
//  HARD_LIGHT, LIGHTEN, MULTIPLY, OVERLAY, RED, SCREEN, SOFT_LIGHT, SRC_ATOP
// BlendMode bMode = BlendMode.MULTIPLY;


/* ------------------------------------------------------------------------- */

void  settings ()  {
    size(1920, 1080, FX2D); // FX2D required
    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}

/*****************************************************************************/
void setup() 
{
  background(#EFEFEF);

  cX = width/2;
  cY = height/2;

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


//  inspired by neon sign
        
        blend = new Blend();
        blend.setMode(BlendMode.MULTIPLY);
  
        ds = new DropShadow();
        ds.setColor(Color.rgb(254, 235, 66, 0.3));
        ds.setOffsetX(5);
        ds.setOffsetY(5);
        ds.setRadius(5);
        ds.setSpread(0.2);
        
        blend.setBottomInput(ds);
        
        ds1 = new DropShadow();
        ds1.setColor(Color.web("#EF4318")); //  #f13a00
        ds1.setRadius(20);
        ds1.setSpread(0.2);
        
        blend2 = new Blend();
        blend2.setMode(BlendMode.MULTIPLY);
        
        is = new InnerShadow();
        is.setColor(Color.web("#EF1975"));  //  #feeb42
        is.setRadius(9);
        is.setChoke(0.8);
        blend2.setBottomInput(is);
        
        is1 = new InnerShadow();
        is1.setColor(Color.web("#EF2018")); //  #f13a00
        is1.setRadius(5);
        is1.setChoke(0.4);
        blend2.setTopInput(is1);
        
        blend1 = new Blend();
        blend1.setMode(BlendMode.MULTIPLY);
        blend1.setBottomInput(ds1);
        blend1.setTopInput(blend2);
        
        blend.setTopInput(blend1);
         
        // text.setEffect(blend);
        ctx.setEffect(blend);

}



/*****************************************************************************/
void draw() {



//  SKETCH HERE

strokeWeight(random(HALF_PI,maxFrame));
point( random(width), random(height) );

strokeWeight(random( 1, HALF_PI ));
line( random(width), random(height), random(width), random(height) );

noFill();
rect( random(width), random(height), 69, 69, random(-frameCount, -maxFrame) );


textSize(random(TWO_PI,maxFrame));


//  STROKE or FILL
if(frameCount%2==0)
{
  ctx.setStroke(Color.web("#19EF75"));
  ctx.setFill(Color.web("#EF4318"));
  // fill(0xEFEFEF);

  ctx.strokeText( binary(frameCount),  random(maxFrame, cY), (frameCount*random(maxFrame))%height );
}
else
{ 
  ctx.setStroke(Color.web("#1975EF"));
  ctx.setFill(Color.web("#EF4318"));
  // fill(0xEF4318);
  
  ctx.fillText( binary(frameCount),  random(maxFrame, cY), (frameCount*random(maxFrame))%height );
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
  fill(#EF1975);
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
