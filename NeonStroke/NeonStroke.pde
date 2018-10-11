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
String txtMsg;
int maxFrame = 8;

GraphicsContext ctx;

// TODO: dial in shadows first, then light, then other FX
DropShadow ds, ds1;
InnerShadow is = new InnerShadow();
InnerShadow is1 = new InnerShadow();

Blend blend = new Blend();
Blend blend1 = new Blend();
Blend blend2 = new Blend();



float cX, cY, x1, y1;

int rectW,rectH;
int rectRad = 0;  //  store rect radius / point size / 
int txtH, txtW;


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
  background(-1);

  cX = width/2;
  cY = height/2;

  //  Generate filename containing sketch settings meta NOW
  SAVE_NAME = fix.pdeName() + "-bMode-" + bMode  + "-" + fix.getTimestamp();

  //see: https://docs.oracle.com/javase/10/docs/api/javafx/scene/canvas/GraphicsContext.html
  ctx = ((Canvas) surface.getNative()).getGraphicsContext2D();

  //  BIG ASS TEXT
  txtH = (int)(width/TWO_PI);
  textSize(txtH);

  textAlign(CENTER);
  rectMode(CENTER);

  txtH = (int) (textAscent()+textDescent());

  ctx.setGlobalBlendMode(bMode);
  ctx.setFontSmoothingType( FontSmoothingType.GRAY );
  ctx.setFillRule(FillRule.EVEN_ODD); //  https://docs.oracle.com/javafx/2/api/javafx/scene/shape/FillRule.html
  ctx.setMiterLimit(1); //  default = 10.0, 1 gives nice round edge to text



}



/*****************************************************************************/
void draw() {


//  TEXT pre-calcs
x1 = random(cX);
y1 = random(height);

txtMsg = binary(frameCount, 8); //  anymore and text flies off screen
txtW = (int)textWidth(txtMsg);
rectW = txtW%width;
rectH = txtH; // (int)( textAscent() + textDescent());



//  TODO: figure out smarter way to re-use blends to alternate NEON
if(frameCount%2==0)
{
  //  GREEN
  ctx.setStroke(Color.web("#19EF75"));  //  1843EF
  
      blend = new Blend();
      blend.setMode(BlendMode.MULTIPLY);
            
      ds = new DropShadow();
      ds.setColor(Color.web("#19EF75", 0.75));
      ds.setOffsetX(5);
      ds.setOffsetY(5);
      ds.setRadius(5);
      ds.setSpread(0.2);
      
      blend.setBottomInput(ds);
      
      ds1 = new DropShadow();
      ds1.setColor(Color.web("#2018EF", 0.75));
      ds1.setRadius(20);
      ds1.setSpread(0.2);
      
      blend2 = new Blend();
      blend2.setMode(BlendMode.MULTIPLY);
      
      is = new InnerShadow();
      is.setColor(Color.web("#1975EF", 0.75)) ;
      is.setRadius(9);
      is.setChoke(0.8);
      blend2.setBottomInput(is);
      
      is1 = new InnerShadow();
      is1.setColor(Color.web("#20EF18", 0.75)) ;
      is1.setRadius(5);
      is1.setChoke(0.4);
      blend2.setTopInput(is1);
      
      blend1 = new Blend();
      blend1.setMode(BlendMode.MULTIPLY);
      blend1.setBottomInput(ds1);
      blend1.setTopInput(blend2);
      
      blend.setTopInput(blend1);
      
      ctx.setEffect(blend);
}
else
{ 
  ctx.setStroke(Color.web("#EFEF43"));

      blend = new Blend();
      blend.setMode(BlendMode.MULTIPLY);
            
      ds = new DropShadow();
      ds.setColor(Color.web("#EF1975", 0.75));
      ds.setOffsetX(5);
      ds.setOffsetY(5);
      ds.setRadius(5);
      ds.setSpread(0.2);
      
      blend.setBottomInput(ds);
      
      ds1 = new DropShadow();
      ds1.setColor(Color.web("#EF2018", 0.75));
      ds1.setRadius(20);
      ds1.setSpread(0.2);
      
      blend2 = new Blend();
      blend2.setMode(BlendMode.MULTIPLY);
      
      is = new InnerShadow();
      is.setColor(Color.web("#EF1975", 0.75));
      is.setRadius(9);
      is.setChoke(0.8);
      blend2.setBottomInput(is);
      
      is1 = new InnerShadow();
      is1.setColor(Color.web("#EF2018", 0.75));
      is1.setRadius(5);
      is1.setChoke(0.4);
      blend2.setTopInput(is1);
      
      blend1 = new Blend();
      blend1.setMode(BlendMode.MULTIPLY);
      blend1.setBottomInput(ds1);
      blend1.setTopInput(blend2);
      
      blend.setTopInput(blend1);

}


  ctx.setEffect(blend);


//  RECT
strokeWeight(TWO_PI);
noFill();
rect( x1+(txtW/2), y1-(txtH/PI)  , rectW, rectH, -rectRad );


//  TEXT
ctx.strokeText( txtMsg,  x1, y1 );


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
